Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA5C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D3A20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="HIjadFGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfFRTwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:52:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42856 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:52:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so16923282qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKlvb5xlV7AjdrT+ymSYk12cKDt0ZQUtMF2LTHfZOts=;
        b=HIjadFGFGEXpbxE64Z3ryg2YKt6x7P7r8lG5rpQv4JTlECfohUBliyZGbXhgixpAAu
         Jh5lrATzJzvIM0sM1dMb2n4ed8dlnUBxyR3JldHddNTi1HNu3GGNWGWrewNBWI4ZynHz
         YEC5el4Ts3kwt+UHyvyrsGzBVXkA1G+8HhuIwVSOhXc++BMwQtb8uOJHt2VFgvCtJjvJ
         6a6x1rdEedYxVsntJDH2goukZi4FiHMQS5/zlqPjzn8Y2lXqybGFxntfiLAcnPH0BJub
         FwYwbC21szO0RkUWcuBWOEGq6+bVY7Z1y0PMyZDQZMqwEtoXnIEjplUs24QR6Wh2wXCa
         NS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKlvb5xlV7AjdrT+ymSYk12cKDt0ZQUtMF2LTHfZOts=;
        b=VIs98p8oS5hvzLbnm90hXwPMLQT/gN1WW6zgW7VsWu5J0p3ojIN2YWMWfaxZwtV2IX
         AKZIC/23QcQ5QCosMSTFErAope/VvmWmR1SXKYfcCBWK9Nq8ZkD3h2KhhcTxCloyAm5E
         hhsW5gNKXQ8ult2C4tPYoO/d19l4+qtHGCCUmpGcWccE53BixYmDJVzyHwoKZ1PAx2rr
         vRnsev6yk7FCTTLc1OS/7zXjlKO4B0DBH3/XWl8raL6jgqMRJ2xZMC+7zMaCkYyPL/8Z
         gnVOqiYRu5btexciBt5Kvt2LT3uiBwBWoqfU980TM7eu8tmd2OzR8Ou3KQcPuxt/HPm/
         rMuw==
X-Gm-Message-State: APjAAAUdRH1fsAZZEZg5WKlJ2flXFBh6OUMFCHCdz5sVemR9onEGbByk
        1KJeCOxJqatMLDRpsXOpMtHneg==
X-Google-Smtp-Source: APXvYqznfGGft1O/1HHlt55I6UyugR1Pndtb6Tm/zxXNwqMH2bv3sqw1e3e2bE9n7RoCnchsRnMmCw==
X-Received: by 2002:ac8:3132:: with SMTP id g47mr48006861qtb.155.1560887525765;
        Tue, 18 Jun 2019 12:52:05 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 102sm7628154qte.52.2019.06.18.12.52.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 12:52:05 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:52:04 -0400
From:   Sean Paul <sean@poorly.run>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Vadim V . Vlasov" <vadim.vlasov@t-platforms.ru>
Subject: Re: [PATCH] drm: Permit video-buffers writecombine mapping for MIPS
Message-ID: <20190618195204.GC25413@art_vandelay>
References: <20190423123122.32573-1-fancer.lancer@gmail.com>
 <20190617134729.pd24boyqe2viyihm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617134729.pd24boyqe2viyihm@mobilestation>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 04:47:30PM +0300, Serge Semin wrote:
> Hello folks,
> 
> Any updates of this patch status? It has been here for about two months.
> 

Sorry for the mixup, looks like this one just fell through the cracks. I've
applied it to drm-misc-next with the attached Ack and Review.

Sean


> Regards,
> -Sergey
> 
> On Tue, Apr 23, 2019 at 03:31:22PM +0300, Serge Semin wrote:
> > Since commit 4b050ba7a66c ("MIPS: pgtable.h: Implement the
> > pgprot_writecombine function for MIPS") and commit c4687b15a848 ("MIPS: Fix
> > definition of pgprot_writecombine()") write-combine vma mapping is
> > available to be used by kernel subsystems for MIPS. In particular the
> > uncached accelerated attribute is requested to be set by ioremap_wc()
> > method and by generic PCI memory pages/ranges mapping methods. The same
> > is done by the drm_io_prot()/ttm_io_prot() functions in case if
> > write-combine flag is set for vma's passed for mapping. But for some
> > reason the pgprot_writecombine() method calling is ifdefed to be a
> > platform-specific with MIPS system being marked as lacking of one. At the
> > very least it doesn't reflect the current MIPS platform implementation.
> > So in order to improve the DRM subsystem performance on MIPS with UCA
> > mapping enabled, we need to have pgprot_writecombine() called for buffers,
> > which need store operations being combined. In case if particular MIPS
> > chip doesn't support the UCA attribute, the mapping will fall back to
> > noncached.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Signed-off-by: Vadim V. Vlasov <vadim.vlasov@t-platforms.ru>
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_vm.c          | 5 +++--
> >  drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++--
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> > index c3301046dfaa..50178dc64060 100644
> > --- a/drivers/gpu/drm/drm_vm.c
> > +++ b/drivers/gpu/drm/drm_vm.c
> > @@ -62,7 +62,8 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
> >  	/* We don't want graphics memory to be mapped encrypted */
> >  	tmp = pgprot_decrypted(tmp);
> >  
> > -#if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__)
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || \
> > +    defined(__mips__)
> >  	if (map->type == _DRM_REGISTERS && !(map->flags & _DRM_WRITE_COMBINING))
> >  		tmp = pgprot_noncached(tmp);
> >  	else
> > @@ -73,7 +74,7 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
> >  		tmp = pgprot_writecombine(tmp);
> >  	else
> >  		tmp = pgprot_noncached(tmp);
> > -#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
> > +#elif defined(__sparc__) || defined(__arm__)
> >  	tmp = pgprot_noncached(tmp);
> >  #endif
> >  	return tmp;
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index 895d77d799e4..9f918b992f7e 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -539,13 +539,13 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
> >  		tmp = pgprot_noncached(tmp);
> >  #endif
> >  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> > -    defined(__powerpc__)
> > +    defined(__powerpc__) || defined(__mips__)
> >  	if (caching_flags & TTM_PL_FLAG_WC)
> >  		tmp = pgprot_writecombine(tmp);
> >  	else
> >  		tmp = pgprot_noncached(tmp);
> >  #endif
> > -#if defined(__sparc__) || defined(__mips__)
> > +#if defined(__sparc__)
> >  	tmp = pgprot_noncached(tmp);
> >  #endif
> >  	return tmp;
> > -- 
> > 2.21.0
> > 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
