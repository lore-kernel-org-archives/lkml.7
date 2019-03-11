Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B47C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07097206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kcTQJczS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfCKSso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:48:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33303 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:48:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id d12so211756edp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f98+g+RT3l3DxvAAheGVVm6ONRnaMiYAzNdjej9J/g8=;
        b=kcTQJczSTaR5y45g5ENDYA5LjB94XNW9kGMcTV3SR/lSqgqzaz8wMqoSqD1kJpVSIW
         IaeJIjyRA2cf+hMSrrMGpNwQItRTXZqX/E69nTh8HMWt/n8Tm9vH/ROibLtPLVGcRWkk
         1YK7vuh1NdCaglMOTN+RbYe8TZe54ky5kq6l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f98+g+RT3l3DxvAAheGVVm6ONRnaMiYAzNdjej9J/g8=;
        b=pMb7/17cpg7wqHR9CYs3/RapB11xjIOz56VMYr34/pGA+15ciQAWEClgkQoRWgVxTB
         np66DCjm0+ujunXzzrGQPKx96s3j9wTwTQNHbLMfg/BPs8PWGxnHl9EpBGcznPIKvLo2
         IVEz3oY4RpY01LGp3JSQh9FkmVHt5UcJdQ0JTbxfb5v4ZapCVC8GLQ/n0stP6ozv4TP7
         zw18bjpeWkemedLAfnvIzNyoFm6HzVOtoNpMIkKjZtK83Adnsn2bL7aXoZdEZ0zqhjeK
         G24o/WFqobcbLlQY2YdiT5p6a8Tw8WtQ+5bLUqAGszlhocTOeujkd9wtTR0VyOb3zeUU
         zyyg==
X-Gm-Message-State: APjAAAX0xTLBCgsFX4TAifVG3V+LEpnh1KjZEDvPFDg8oe6jriMHbDT4
        WyvzWKnncTy4z6uagcp2DSw6lw==
X-Google-Smtp-Source: APXvYqwujuAK5pq1B7bcSwZbNHECxMO+qRZwmgjMJkdKMqX3cV7GYWMWfMT5y8i9G4LAHD7dW8yV7A==
X-Received: by 2002:a17:906:482:: with SMTP id f2mr22873401eja.68.1552330121958;
        Mon, 11 Mar 2019 11:48:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s6sm4881237eda.90.2019.03.11.11.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:48:41 -0700 (PDT)
Date:   Mon, 11 Mar 2019 19:48:39 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190311184839.GO2665@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
 <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
 <20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
 <20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
 <20190311132358.GF2665@phenom.ffwll.local>
 <20190311133919.azyhtioxf23duf3g@sirius.home.kraxel.org>
 <20190311174958.xdw4lrvf6ydeplvc@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311174958.xdw4lrvf6ydeplvc@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 02:49:58PM -0300, Rodrigo Siqueira wrote:
> On 03/11, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > > IIRC the drm code checks for the atomic_enable callback presence to
> > > > figure whenever it should take the atomic or legacy code paths.
> > > 
> > > It should check for drm_driver->mode_config.funcs.atomic_commit for that,
> > > see drm_drv_uses_atomic_modeset(). Anything else should be a bug.
> > > 
> > > Or do you mean the fallback to the old crtc helper prepare/commit
> > > callbacks?
> > 
> > Probably the later.  There was some reason why I've left in the empty
> > bochs_crtc_atomic_enable() callback ...
> 
> Just for checking before I start to work in this patch:
> The correct solution should be made atomic_enable and atomic_disable
> optional, right? I should do it, and check if Bochs driver really needs
> bochs_crtc_atomic_enable after my change, right?

Yup. I just tried to remember why we haven't done this yet, but I think
that was a patch to make crtc->helper_funcs optional. And that doesn't
make sense imo, since if your crtc doesn't do anything then you don't
really have an atomic driver :-) And if there's ever a legit use case for
this, then that drive probably shouldn't use the atomic helpers ...

But making crtc_helper_funcs->atomic_enable/disable optional sounds like a
good idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
