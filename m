Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A03AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E378B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMQQIWP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfDBLVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:21:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBLVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X2dChE4QglhwVq/xflqtnQGug6tzO5Z4dH2nW7lbNtw=; b=ZMQQIWP7svG0HEiWdyZfkgNDf
        3EZs4yVOQvOYKkqPfwMOky7psNcRH/pM60Tw4/TA+EcU9ct4VQUCGGS7daCB/uhCHJJLvCZvUkvDr
        5gNeHhCu50Mu2ACos74BzHipXDWA/zZhGvTiPT/ckK782y8hunJItNkmgdEnzTASFFgzTQI+r9GFJ
        iYUr4Sxrw2J5qCoEWKp7315S1nk8Fq+PC5IJszzp3NP3qgTEfXe2jnols+C7q94ISYHj1evpujtIJ
        /8Gs39jZR77piQnRdSPdBa/eYTz5CEvef2w7rKPwOzPA4Wbh0P3sYplnSsIEWAh051Dhpnfjl8PCx
        Xzx/KaNXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBHTd-0004a9-P2; Tue, 02 Apr 2019 11:21:13 +0000
Date:   Tue, 2 Apr 2019 04:21:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190402112113.GD22763@bombadil.infradead.org>
References: <20190402105006.48f93e53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402105006.48f93e53@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:50:06AM +1100, Stephen Rothwell wrote:
> +++ b/drivers/gpu/drm/lima/lima_ctx.c
> @@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
>  			goto err_out0;
>  	}
>  
> -	err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> +	err = xa_alloc(&mgr->handles, id, ctx, XA_LIMIT(*id, UINT_MAX), GFP_KERNEL);
>  	if (err < 0)
>  		goto err_out0;

I agree that this is an exact translation of what the code was doing,
but I don't think it's what the author intended the code to do.
They almost certainly meant:

	err = xa_alloc(&mgr->handles, id, ctx, xa_limit_32b, GFP_KERNEL);

I'm basing this on:

+struct drm_lima_ctx_create {
+       __u32 id;          /* out, context handle */
+       __u32 _pad;        /* pad, must be zero */
+};

(and this confusion is exactly why I changed the API ...)
