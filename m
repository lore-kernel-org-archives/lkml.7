Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A99D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0WyrBjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfHMPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:47:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfHMPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ckOuIy1ZaNf+wRY3GrPXdDHjbkqdtSLWeZLMyJVN8FQ=; b=s0WyrBjtDASPRwJOuoBy/JIbT
        z+EGQsNkqhniSiOj/wln3YVwzEkUqqJkJu+uug/w/FblIEKYkz3gcWe6cNfc/h8dXir+2hCzeQvXa
        mI/YlyBoEO8ZK9i2jxaCmctp7O7Xn8TCCTe//4D+Re+nj/YgFC8NDpnCB3nscrUxCPXhqyfJ3xCve
        8wkQiPRq4V1B5XIwPkfkr2kw3EZxz2Iy/IAF7+ZAFNKSCwtLG1f6PWcF57yZDUXtPQTPwQnW/gt0T
        UORxnKoRbh7cLN2R3sdjNr6owKLrijo8tmhBF2Gfi9I+OypLyaIGb9Gr01rokXD04ZVfA2c39ORZh
        oMpb7I4EA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ1Z-0004hr-Fi; Tue, 13 Aug 2019 15:47:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: RISC-V nommu support v3
Date:   Tue, 13 Aug 2019 17:47:32 +0200
Message-Id: <20190813154747.24256-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

below is a series to support nommu mode on RISC-V.  For now this series
just works under qemu with the qemu-virt platform, but Damien has also
been able to get kernel based on this tree with additional driver hacks
to work on the Kendryte KD210, but that will take a while to cleanup
an upstream.

A git tree is available here:

    git://git.infradead.org/users/hch/riscv.git riscv-nommu.3

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.3

I've also pushed out a builtroot branch that can build a RISC-V nommu
root filesystem here:

   git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2

Gitweb:

   http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2

Changes since v2:
 - rebased to 5.3-rc
 - remove the EFI image header for nommu builds
 - set ARCH_SLAB_MINALIGN to ensure stack alignment in the flat binary
   loader
 - minor comment improvement
 - use #defines for more CSRs

Changes since v1:
 - fixes so that a kernel with this series still work on builds with an
   IOMMU
 - small clint cleanups
 - the binfmt_flat base and buildroot now don't put arguments on the stack
