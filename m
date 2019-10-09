Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFE8ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F8020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gYe64hQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfJIPCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:02:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46605 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbfJIPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:02:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3so2298400edw.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yyvcYwcZMjLvzOg82pdsNDaaC7kmo5LxgAiQA0bNidE=;
        b=gYe64hQiSH9s0AJCdM7d1Bpyt8JKFCNdMMrjjOcAJi8DHx8XJgIrh57L+Ua+aOEDF3
         tDEDdsqQtlX72bjr6UtMaozSyJBPTTbaEmX2NDhel45HJY+/8NLQeeGyBEW28ALnz25W
         IzDdms1jqdIXYegTRSGBxksi1VQ7WtffxRg+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yyvcYwcZMjLvzOg82pdsNDaaC7kmo5LxgAiQA0bNidE=;
        b=WwTcR5DbqBdgZ35my57R3XKED+JELAs/s4rcMvlksaoOXDPjaKCvAlDS/JNljbi2H3
         ckmtrFE+yy3ITwd/E7oFOu9ox9Ujm+udarvXxwBZ8LKwPvstNeB8LemkTUtB1pQEostX
         7f/FNNLMLvBWrkjR9ddMZtI45fX2uYSYtJw+sv3Rgdkt/jzBPtr/lh/XJSPNC3/Dfa/3
         H22+b4Gtbvf7Dn7js93gdNp9PPUD1PK3qo7xwzYnlHFlurDQD3fQ4Wgj9Hvc31ZnFmpJ
         QEI6QeYtRu38A5fdbTb3tLNiWQ+qPftf3VKC76fgPMV/exC83QC0R6CM5KbZeFQ9ZDei
         R4MA==
X-Gm-Message-State: APjAAAVif+0TZnjS9sBbxQ99I/nz0OyBEfsadp1FQPxGAl9PSYNfHDN3
        Ub+ea47uPrgYmqgW5M23sc1rpQ==
X-Google-Smtp-Source: APXvYqzkvG0y4CciW6y1869o9q6BjLYLBuhrjR2c8HeHPYa3utK2/23Gs+BF00yuGt+GrnN38hw7bQ==
X-Received: by 2002:a05:6402:3c5:: with SMTP id t5mr3299252edw.125.1570633320982;
        Wed, 09 Oct 2019 08:02:00 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id fx25sm279855ejb.19.2019.10.09.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:01:59 -0700 (PDT)
Date:   Wed, 9 Oct 2019 17:01:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/amdgpu/dm/mst: Report possible_crtcs
 incorrectly, for now
Message-ID: <20191009150155.GD16989@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190926225122.31455-1-lyude@redhat.com>
 <20190926225122.31455-6-lyude@redhat.com>
 <20190927152741.GU218215@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927152741.GU218215@art_vandelay>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:27:41AM -0400, Sean Paul wrote:
> On Thu, Sep 26, 2019 at 06:51:07PM -0400, Lyude Paul wrote:
> > This commit is seperate from the previous one to make it easier to
> > revert in the future. Basically, there's multiple userspace applications
> > that interpret possible_crtcs very wrong:
> > 
> > https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> > https://gitlab.gnome.org/GNOME/mutter/issues/759
> > 
> > While work is ongoing to fix these issues in userspace, we need to
> > report ->possible_crtcs incorrectly for now in order to avoid
> > introducing a regression in in userspace. Once these issues get fixed,
> > this commit should be reverted.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b404f1ae6df7..fe8ac801d7a5 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4807,6 +4807,17 @@ static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
> >  	if (!acrtc->mst_encoder)
> >  		goto fail;
> >  
> > +	/*
> > +	 * FIXME: This is a hack to workaround the following issues:
> > +	 *
> > +	 * https://gitlab.gnome.org/GNOME/mutter/issues/759
> > +	 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> > +	 *
> > +	 * One these issues are closed, this should be removed
> 
> Even when these issues are closed, we'll still be introducing a regression if we
> revert this change. Time for actually_possible_crtcs? :)
> 
> You also might want to briefly explain the u/s bug in case the links go sour.
> 
> > +	 */
> > +	acrtc->mst_encoder->base.possible_crtcs =
> > +		amdgpu_dm_get_encoder_crtc_mask(dm->adev);
> 
> Why don't we put this hack in amdgpu_dm_dp_create_fake_mst_encoder()?

If we don't have the same hack for i915 mst I think we shouldn't merge
this ... broken userspace is broken.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
