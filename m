Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05656C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB0320657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMntMBRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbfHBIoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:44:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfHBIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v00Ip7tFTxfOW7ci2f67H952n7pZPTilSNtqWzGu0Kc=; b=QMntMBRpF4JmUY3VNLhxAr9gu
        9J7x8c1UZJylRbJCbHSbhFuOCugKaSW/zMuZ0MKqz3y9tQ7LCKVDIVgkb7mNgNgtBHuttyvui9yFC
        10dYHUbbA2H8or9294FPrr9iobMHCelDY/LmJxnT7JH11SpB9uSMxJi7cpoOCbdHhzp1Dra+R9gfk
        6BL2aH04Qh5ls+AZ1N9Xo5gxGTOBystLL95Khj4l99Qk1jH/VzMlPx1115zqRMBx5fHuDFXB6w263
        T6BWWDcHTWE0XuYw6Lghmff+d9Kg6tDfMN0kHuGp/d1Uec+uQtYmgrAVOIf8FTEx+CwbvQmwEPr1C
        v/TQhHBfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htTBF-0000mV-5w; Fri, 02 Aug 2019 08:44:53 +0000
Date:   Fri, 2 Aug 2019 01:44:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
Message-ID: <20190802084453.GA1410@infradead.org>
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:00:49PM -0700, Paul Walmsley wrote:
> 
> The RISC-V specifications currently define three virtual memory
> translation systems: Sv32, Sv39, and Sv48.  Sv32 is currently specific
> to 32-bit systems; Sv39 and Sv48 are currently specific to 64-bit
> systems.  The current kernel only supports Sv32 and Sv39, but we'd
> like to start preparing for Sv48.  As an initial step, allow the
> virtual memory translation system to be selected via kbuild, and stop
> the build if an option is selected that the kernel doen't currently
> support.
> 
> This patch currently has no functional impact.

It cause the user to be able to select a config which thus won't build.
So it is not just useless, which already is a reason not to merge it,
but actively harmful, which is even worse.

Even if we assume we want to implement Sv48 eventually (which seems
to be a bit off), we need to make this a runtime choice and not a
compile time one to not balloon the number of configs that distributions
(and kernel developers) need to support.
