Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA4C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04E32147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fC6pguVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfHFGtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:49:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbfHFGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rm0+00l4g4M8Jlarfzp2TnutmOwlpDyDflb61FCcaPo=; b=fC6pguVAZjLWVOsBGk2/l01Tu
        RnLqIFg8yf6SaSMKdg4uG55HM8B0OvLZBCvpRN7cmsGFWOdOCMGEFt9k3Fz6HY36/nULry5COEIFq
        GpjzwCF7PlP5U7MtrvNlfoksXQXGvbnJ5UHRDQd5G1TvOk7DAW83a/ulQpwlKjv8rK6/2QlDjYqlw
        2LhGom7pCsGIAZwoqnPR6jg5YJ4SFsLTyL8RHG41ui0ozUtu++TJ14eGmmL4wWewIY0vAafeKi9/l
        1KRquVK/3j/7Gk7QzgAOtq5FWnKY3pIUbSuz7C9l8OMXQIsw6Uz/5U7fyQ5k5Wfdiy/v3xQgMIZtr
        aBkJjcyzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hutHp-000239-Da; Tue, 06 Aug 2019 06:49:33 +0000
Date:   Mon, 5 Aug 2019 23:49:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com,
        zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory
 ZONEs
Message-ID: <20190806064933.GA2508@infradead.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564488945-20149-3-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:15:44PM +0800, guoren@kernel.org wrote:
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 80783bb..3f1ff9d 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
>  {
>  	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
>  }
> -postcore_initcall(atomic_pool_init);

Please keep the postcore_initcall next to the function it calls.

In this particular case I also plan to remove the function for 5.4 by
moving it to the common dma code, so it is more important than just style.
