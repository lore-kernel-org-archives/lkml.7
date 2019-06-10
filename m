Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9D9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73972086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DvPiad/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390036AbfFJWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:16:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbfFJWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zx6pM5Q0d935TOPq+RPAUxBXf7tdWkzo4n4yneWvKE8=; b=DvPiad/RAZ1jFjbOhh4OEG9L9
        5UO5ZRLO74edX8/NV9+fgHjUJ4NNc/20IQ8WfZWSGzLWJC8SB065dr5G1bvJ/HTR4OyNtcY9SpW9C
        ceRkOdw117OTWdgYCTqcbgjsMKjU2eKkdpn9952jH1WprdazNhfvH2C5Z5h1OOakjGm4bnNCcD0Bx
        qimmIoJ2fYxPikvj12CQwyIKcUpgz+jxPF/vb0/IvOKmmhv9d52PgOfIHCKW8f5rl9LLHlEylbltq
        2SbAHhXMmSvgiHWKD1FnEXdyDPEqAxd6CVVC6GLRGwW9ySlca1WHv7jxPMfYs6jXj3tWh/Tq0vaVS
        yVPWh+9/g==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSaV-0002kS-NG; Mon, 10 Jun 2019 22:16:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: RISC-V nommu support
Date:   Tue, 11 Jun 2019 00:16:04 +0200
Message-Id: <20190610221621.10938-1-hch@lst.de>
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

To be useful this series also require the RISC-V binfmt_flat support,
which I've sent out separately.

A branch that includes this series and the binfmt_flat support is
available here:

    git://git.infradead.org/users/hch/riscv.git riscv-nommu

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu

I've also pushed out a builtroot branch that can build a RISC-V nommu
root filesystem here:

   git://git.infradead.org/users/hch/buildroot.git riscv-nommu

Gitweb:

   http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu

