Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F7ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C00D21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KYnHXZAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440678AbfJQRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:37:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436664AbfJQRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rk6dzMYH9N8C7Ai+Ydb6Qx7fh86MnYyKaaYlbtkOR7E=; b=KYnHXZAK2km2GA/S7qv97Q+Ht
        ZcJKxn+cc6M3skxzzrAJ5+1XBkG3Fji1AERJ/6GofyxB7Z0fnlUNbWDkZlMfs5VZEf0eWVqWmpJTw
        zLMmvj5icT7we8Qwy3ItQ6RcTnKY7ztwG2pHtWSiQdPxjeN+v1IwIWEMdxM7JmE3kPA76cbzBdKbI
        pxNUAFHL64DN7GaudqFSN06txJJh+GeR05zuhjhtEnl1u20Lgn57VplrQY9xKkSYJszHf2uXyukxd
        VDi0WuF6JT11lBz+sP26Xqf64uEhGTTdFadWxz3u4DdxaXBkvMOnD2mLAA4UbK1xjq2bFF1Hhh7k/
        nM7SoVGug==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9ib-0007FG-Do; Thu, 17 Oct 2019 17:37:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: RISC-V nommu support v5
Date:   Thu, 17 Oct 2019 19:37:28 +0200
Message-Id: <20191017173743.5430-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/riscv.git riscv-nommu.5

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.5

I've also pushed out a builtroot branch that can build a RISC-V nommu
root filesystem here:

   git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2

Gitweb:

   http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2


Changes since v4:
 - rebased to 5.4-rc + latest riscv fixes
 - clean up do_trap_break
 - fix an SR_XPIE issue (Paul Walmsley)
 - use the symbolic PAGE_OFFSET value in the flat loader
   (Aurabindo Jayamohanan)

Changes since v3:
 - improve a few commit message
 - cleanup riscv_cpuid_to_hartid_mask
 - cleanup the timer handling
 - cleanup the IPI handling a little more
 - renamed CONFIG_M_MODE to CONFIG_RISCV_M_MODE
 - split out CONFIG_RISCV_SBI to make some of the ifdefs more obbious
 - use IS_ENABLED wherever possible instead of if ifdefs to make the
   code more readable

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
