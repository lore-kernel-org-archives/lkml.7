Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E59218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JO1/Obzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfB1KOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:14:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44861 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfB1KOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:14:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so16461118edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gCwEG5Qw1ccgI6HpiauzyQS+XMK7jgihtOlWC+PANvI=;
        b=JO1/ObzzmS79os6x2fmuFfbwjkH4zpYwlwNKN7Mg/CyBgSeToP05g+kEM7vYvljKDE
         uD8EpURcVBoDg5kq/yQoI+88E8EVqJdh02BjVRly4LlZR8O3CUOX8qQIb7+AhV9vVY8d
         L3XGO+QPUGmeOI++shPkEMC3bAd1HFt3J0Rv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gCwEG5Qw1ccgI6HpiauzyQS+XMK7jgihtOlWC+PANvI=;
        b=PBHdtXKS01jTgVeveQKZ+sLc3yuMdiWLbREFDHobn8M8xiHV91DnRo45sZ1jNQZm45
         8XQrG91v9MYlm18mtmaMc4t62l+o66FmgX11tnqMS218VuQkl1gMFJL1O10Hv389FpeN
         FJBmYbeB2BURxFy+Fthjc89tJNoq0zzKp8/GOHpg+PDUYdJr3W2ci2BsXrt/d6j4NZGI
         4i5Xxq1TsoKJOAECcqjTuUcjMsOTHBCHULf+4c6Fn2Qyn6dagYTHhTYrPgtY+z6y4Xjx
         3SA8W1ZjxsICwEs5rq4/Jq52MLE8ynsxDAhK/dEskwXvkuONEGI7KVatbI7qe4JrvLum
         nuBg==
X-Gm-Message-State: AHQUAuY+/kGv3Ro5eBn8pRkzt7Hh+54+IsPixKFMwd3gB0u5amDh7pp4
        meoG9ZKmT+cuI44nKpxMeq4rRQ==
X-Google-Smtp-Source: AHgI3IYzz7gIs3SBNDITKZpaFddr5wVnJ2cWaIJiJORA9X91YQjdejWbsdcK9Xkbgj/rOKiuEPlrFA==
X-Received: by 2002:a50:eb4a:: with SMTP id z10mr6130976edp.284.1551348855560;
        Thu, 28 Feb 2019 02:14:15 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t9sm5029530edb.13.2019.02.28.02.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 02:14:14 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:14:12 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190228101412.GM2665@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228101107.GL2665@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> > vkms_crc_work_handle needs the value of the actual frame to
> > schedule the workqueue that calls periodically the vblank
> > handler and the destroy state functions. However, the frame
> > value returned from vkms_vblank_simulate is updated and
> > diminished in vblank_get_timestamp because it is not in a
> > vblank interrupt, and return an inaccurate value.
> > 
> > Solve this getting the actual vblank frame directly from the
> > vblank->count inside the `struct drm_crtc`, instead of using
> > the `drm_accurate_vblank_count` function.
> > 
> > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> 
> Sorry for the delay, I'm a bit swamped right now :-/
> 
> Debug work you're doing here is really impressive! But I have no idea
> what's going on. It doesn't look like it's just papering over a bug (like
> the in_vblank_irq check we've discussed on irc), but I also have no idea
> why it works.
> 
> I'll pull in Ville, he understands this better than me.

Works better if I actually add Ville ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
