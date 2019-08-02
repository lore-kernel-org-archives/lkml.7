Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFFC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5607020578
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYjtG7zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404122AbfHBNKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:10:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42756 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389781AbfHBNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:10:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so36019231pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XbUxMY+radp8eo+hzS4Ig8it6rorCi9bzOQPywSdVAs=;
        b=kYjtG7zLaGULpxcdiBGXSs4vwutKA/rWEos6ytuddi7eh2JaDuw1cg6O1TCEtS2BbR
         UwPA9X9pcMa45kjSHSkhkSdLpyg6jiDUXTANUEF2ZsqndJqAfPtuvKk8vP+9d11pmc6n
         puiPGhAqXIu6LVVxB3WbME+rkhTZ53dB7Q1jT0ju6FkjuPYCxKGd+ItC+fMP1Md7vynE
         v1bi/LsP/rKAux7G8aIj62fDiKPx19Gq4IPjI8TCWILl8JSWG5dWwiuDMVoAexHV+GNa
         lteSV/dXS5AjaIXRdQl57NlnWqZxb1HzB5LaU1fUgp7u4v7PKVimz126lsuz57gU7z4A
         YQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XbUxMY+radp8eo+hzS4Ig8it6rorCi9bzOQPywSdVAs=;
        b=LGFDo3BXN1rSM+3285iWqcpvGE5txL+1yznHsQPZMVttJi9vU4LLGXJQGc03kxrvu9
         vPPArLqCu5mEi6YGbek8sgc4qFt0IwRdtQ8vH1nwvF/V6lSMMKQ2Gs8Jj88SaytWhAvz
         PSnh91Vt0PnYNCCK8DeoOmQXrYNgje+iMWJA9KRAG9Vl6l4jbAq/VpXoipVtsD6TB1qZ
         luhvQ2QRXfv99WckGzqWmRzByjPVakKnDCAkztk3OjAUCl9ITpE1CuzW3o1p60lFF6vf
         Q6FP5FeIRLGf7N9lYZOtT+yXJnESash3Vg4FGOrbyygeG40/01UyUk2U6rLDEcB59cIo
         FKTQ==
X-Gm-Message-State: APjAAAUGdk7SrW7YI4T9Iaey8IEnMyRh9C9NOaZ4DeGI008amWbPYqw9
        atgJ39NJa/cQhomVjM3WqoXRZfqj
X-Google-Smtp-Source: APXvYqw3yX23z9WQPbZceAFXCw+ZNQHWkzUno80U33FlW4KnxdfGmoluqj/SSReDS77iakJJxRWzTw==
X-Received: by 2002:a63:b10f:: with SMTP id r15mr54143605pgf.230.1564751440748;
        Fri, 02 Aug 2019 06:10:40 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id m11sm60228796pgl.8.2019.08.02.06.10.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:10:40 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 2 Aug 2019 22:10:37 +0900
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i915: convert to new mount API
Message-ID: <20190802131037.GA466@tigerII.localdomain>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <156475048333.6598.10268421599352645066@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156475048333.6598.10268421599352645066@skylake-alporthouse-com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/02/19 13:54), Chris Wilson wrote:
[..]
> >  int i915_gemfs_init(struct drm_i915_private *i915)
> >  {
> > +       struct fs_context *fc = NULL;
> >         struct file_system_type *type;
> >         struct vfsmount *gemfs;
> > +       bool ok = true;
> 
> Start with ok = false, we only need to set to true if we succeed in
> reconfiguring.

OK, makes sense.

> >         type = get_fs_type("tmpfs");
> >         if (!type)
> > @@ -36,18 +39,29 @@ int i915_gemfs_init(struct drm_i915_private *i915)
> >                 struct super_block *sb = gemfs->mnt_sb;
> >                 /* FIXME: Disabled until we get W/A for read BW issue. */
> >                 char options[] = "huge=never";
> > -               int flags = 0;
> > -               int err;
> 
> Hmm, we could avoid this if we used vfs_kernel_mount() directly rather
> than the kern_mount wrapper, as then we pass options through to
> parse_monotithic_mount_data(). Or am I barking up the wrong tree?

Hmm.
Wouldn't this error on !TRANSPARENT_HUGE_PAGECACHE systems?
"huge=never" should be an invalid option when system does
not know about THP.

[..]
> > +               if (!fc->ops->parse_monolithic ||
> > +                               fc->ops->parse_monolithic(fc, options)) {
> 
> checkpatch.pl will complain that this should line up with the '('

It doesn't.

-------------------------------------------------
outgoing/0001-i915-convert-to-new-mount-API.patch
-------------------------------------------------
total: 0 errors, 0 warnings, 53 lines checked

outgoing/0001-i915-convert-to-new-mount-API.patch has no obvious style problems and is ready for submission.

-------------------------------------------------------
outgoing/0002-i915-do-not-leak-module-ref-counter.patch
-------------------------------------------------------
total: 0 errors, 0 warnings, 11 lines checked

outgoing/0002-i915-do-not-leak-module-ref-counter.patch has no obvious style problems and is ready for submission.

[..]
> > +       if (!ok)
> > +               pr_err("i915 gemfs reconfiguration failed\n");
> 
> Let's make it a bit more user friendly,
> 
> dev_err(i915->drm.dev,
> 	"Unable to reconfigure internal shmemfs for preferred"
> 	" allocation strategy; continuing, but performance may suffer.\n");

I guess now checkpatch will complain :)

> Assuming that we can't just use vfs_kern_mount() instead, with the nits
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks.

I'll sit on it for several days, just to see if more feedback will come.

	-ss
