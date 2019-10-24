Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1664CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751D920856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DjwKgdzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439622AbfJXMMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:12:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436560AbfJXMMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:12:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so25788913wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fc53k7B5F6NLESUV742hYt2msCMxd7JzKfAjx90Oa0A=;
        b=DjwKgdzIp56RgNcD65/nmLFKaNV7MqWG0ZJMX0u8Sh/CqLeGAPEsZKygrx9XDDwz0v
         9BlKYvuRacw322e0u4tDq3lT6nmgdzgBNktPjnTyfvxIyjoutcLqGnFfQMWd8eaHbE2z
         jxkLCbNetvnHJ7Ein19DIR7Hp2l7N1S5cyd3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fc53k7B5F6NLESUV742hYt2msCMxd7JzKfAjx90Oa0A=;
        b=cQEoNwR+8/fro7UPyhJnh1AxgjW7kJ0ovIOtUMAn9fDdLzhuNvBse48RjXGNuxN7fe
         Z/vNdN+EFegTXX7+W7KyUiO5CLYmTl69JeuIJ8sl6IV/hVgV3sbKjD6ArPGXHtt1vhsu
         8+0WbjfaK7TjI1oKiUvzryNraFoQahJKrI04aa22VhY1rx8Dc5LuvgkwO/SS5H56UQc1
         nqeEl+nxCJuvU5kZVb80QOsyZANa7Shvhz5SWaRytf55wi/puS7u9PrZxdEM+jaB/4lO
         bYZSM4+Np2mWtrGmnpEe+93SYmd+s3Xil2j2B+DZmj8tbsIPDPSfMXRyhEDWocRoiViZ
         f1vA==
X-Gm-Message-State: APjAAAUwyRqQx0glgM0xxOn0rvjfR6p5VaGnCPi/BSoP68QSpcvsC739
        5SlbvgtaH99ApZEgwUgY/F8ZYw==
X-Google-Smtp-Source: APXvYqyInOM2B8sEpcOlgWCcHvh8/lrRHJhKiTZfomB/Eaa8D0QdEDVAJw76ekONB1Yy6OlI8NMz0w==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr3468437wrr.165.1571919158048;
        Thu, 24 Oct 2019 05:12:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id h17sm3521290wme.6.2019.10.24.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 05:12:37 -0700 (PDT)
Date:   Thu, 24 Oct 2019 14:12:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch
Subject: Re: [Outreachy][PATCH] drm/mediatek: remove cast to pointers passed
 to kfree
Message-ID: <20191024121235.GC11828@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie
References: <20191023111107.9972-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023111107.9972-1-wambui.karugax@gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:11:07PM +0300, Wambui Karuga wrote:
> Remove unnecessary casts to pointer types passed to kfree.
> Issue detected by coccinelle:
> @@
> type t1;
> expression *e;
> @@
> 
> -kfree((t1 *)e);
> +kfree(e);
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index ca672f1d140d..b04a3c2b111e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -271,7 +271,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
>  			       pgprot_writecombine(PAGE_KERNEL));
>  
>  out:
> -	kfree((void *)sgt);
> +	kfree(sgt);
>  
>  	return mtk_gem->kvaddr;
>  }
> @@ -285,5 +285,5 @@ void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>  
>  	vunmap(vaddr);
>  	mtk_gem->kvaddr = 0;
> -	kfree((void *)mtk_gem->pages);
> +	kfree(mtk_gem->pages);
>  }
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
