Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B46DC49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE220678
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KE6LHdW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfILCjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:39:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfILCjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:39:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id l16so26595951wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrP39eh2tbg2zaFOB64oY1gm4vOgwRLVKmpoX2YX7FU=;
        b=KE6LHdW4ZTuj4bvCJMtx+uM0Rb3HlKs6OrX55Tnau/FBW4gDZGaUPwnBTYJlReNGXi
         BE/+/1ZEEIwMcHYkgtZvQp1k9XOh8YsjhKGPwOqpD5hXMDnK6YJh6eBYZTAZrJsmy0Rw
         AqHgpH/mwPIe2ejnf6iSHuSUj9sqhzGoxaSQTmMB401IvgXUqRJ+3aMwREnWt8kq2B9C
         /l6zabO2bDa7QConQ0YCLq1PW0/CZ3mnHmnmc9X5YKe7giiLZu09AJhep8acXz8y7vYY
         o8IjNz5/QpI9hSBNq2FS4rhj39DhI4ZiYJyEd4WeaIhZa+FOYmm1zu7vIOVXsbxGAwQz
         N4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrP39eh2tbg2zaFOB64oY1gm4vOgwRLVKmpoX2YX7FU=;
        b=XqQxNjCxq2zBimVCMvOgB5n7tYLqdJqYa7f6/LWXO+qVfhjh9LL5luXFKWv678uTIw
         jM8BYBqgGod3j7d6co5iZvvOr2EQG3uxjjcXbdn8PCnts/JZLd8OQUYKUW81rT79x3EV
         EvwyDcVBr06wIu4/iKVI0z44PcQLUcYpL+uD/jVwLu/9AjMu7O8d0SKaWrMww5b4roch
         IkbwRAiTKuiGyDIxNWuy4fms8IphJzDVJIEG/dsBVxQatqAiHEuWJG5Tb08YcKMFzvoB
         egKTFizguJcvVyQWZnSiqiVjTK9tn+JCsVPj65ex/n9ZKpA3ZGDMYl9BgyHeHxrAg34C
         kf8Q==
X-Gm-Message-State: APjAAAWIFf20MNuc9TL+d3fsU9QdtiOpfYwnQv3Waae2zxLNTqLgpso3
        vLSHDxBJk5XqtClRrSqoqSYM6TNOK/4KSqz8NZ99nw==
X-Google-Smtp-Source: APXvYqwzKJU1Cuvg5D1uPvbs+D7lcEhLXHP5b5fAhTci7k2EsFsUuU4QBxWKaKEWTfQ8aOt1qSnM1Geuc0dvJUUt4AA=
X-Received: by 2002:a5d:6943:: with SMTP id r3mr4535370wrw.21.1568255942965;
 Wed, 11 Sep 2019 19:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
 <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
 <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
 <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com> <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
 <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com> <CALAqxLU5Ov+__b5gxnuMxQP1RLjndXkB4jAiGgmb-OMdaKePug@mail.gmail.com>
 <9d31af23-8a65-d8e8-b73d-b2eb815fcd6f@samsung.com>
In-Reply-To: <9d31af23-8a65-d8e8-b73d-b2eb815fcd6f@samsung.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 11 Sep 2019 19:38:50 -0700
Message-ID: <CALAqxLVP=x9+p9scGyfgFUMN2di+ngOz9-fWW=A1YCM4aN7JRA@mail.gmail.com>
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 3:26 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 03.09.2019 18:18, John Stultz wrote:
> > On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> On 30.08.2019 19:00, Rob Clark wrote:
> >>> On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>>> Of course it seems you have different opinion what is the right thing in
> >>>> this case, so if you convince us that your approach is better one can
> >>>> revert the patch.
> >>> I guess my strongest / most immediate opinion is to not break other
> >>> existing adv75xx bridge users.
> >>
> >> It is pity that breakage happened, and next time we should be more
> >> strict about testing other platforms, before patch acceptance.
> >>
> >> But reverting it now will break also platform which depend on it.
> > I'm really of no opinion of which approach is better here, but I will
> > say that when a patch breaks previously working boards, that's a
> > regression and justifying that some other board is now enabled that
> > would be broken by the revert (of a patch that is not yet upstream)
> > isn't really a strong argument.
> >
> > I'm happy to work with folks to try to fixup the kirin driver if this
> > patch really is the right approach, but we need someone to do the same
> > for the db410c, and I don't think its fair to just dump that work onto
> > folks under the threat of the board breaking.
>
>
> These drivers should be fixed anyway - assumption that
> drm_bridge/drm_panel will be registered before the bus it is attached to
> is just incorrect.
>
> So instead of reverting, fixing and then re-applying the patch I have
> gently proposed shorter path. If you prefer long path we can try to go
> this way.
>
> Matt, is the pure revert OK for you or is it possible to prepare some
> workaround allowing cooperation with both approaches?

Rob/Andrzej: What's the call here?

Should I resubmit the kirin fix for the adv7511 regression here?
Or do we revert the adv7511 patch? I believe db410c still needs a fix.

I'd just like to keep the HiKey board from breaking, so let me know so
I can get the fix submitted if needed.

thanks
-john
