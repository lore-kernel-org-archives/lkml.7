Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE5022CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjgQiyjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfICQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:18:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50235 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:18:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id c10so146665wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMuj3lFzJDWtavcpi24jefzT+zvsqLDDbpsF6XRsTu0=;
        b=LjgQiyjJt874qQEMVACZLuLXWgH0h1CPNZgTJGRSAsFz7dOyy4otRrKvPnbUGiX/6u
         r2uwm6uQOXyS4Uy8I2Rzdj6hmje4idltDWDYxhsq2zaev2Nm6i03RCtyl5FWpezoyOoz
         mu7EyelyLNWaCPI9StcMwoWnV9wU77iTM2z1GdGn31/rukOJi3q1ECuFb4bBXe5YyV1c
         S1Mm3LVEqEY/snswn8gflBX7uBuJOIxcIqHCAH/Dhk2737W1zEzGa5IaEdlx4rQ0zIaU
         5vvJV5PGHz5c2SdsGcHbWXNXA6mF8VGK1FVHrj9rr/mcScwZflCmyIcpiy7vxa7jWOq8
         CIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMuj3lFzJDWtavcpi24jefzT+zvsqLDDbpsF6XRsTu0=;
        b=JSO1WwdpQweX+JKkTbVLooWU45Jwj3Sbic/Lmgyl9pz1QJ9EYX5ehQdqALB92QIEdL
         YSKPm0fiHhTIlO9mZcLicmUAe38bG/VXTN1FnzJITXra4VqS0UGmaTjVQDtsJxtYIau5
         om5wVOV/HV1al4Tlcw3KBsZaJhpNsAE2iMMLWtPMM8CDCP0O7Q0xzbVwcBnjhGjywlh7
         Z3FMMbofJyeR06UuSzXQkBCAkQNjJfbnJOdNboK1O+NeVxjhhFWZrdu7OXLCZD84ot2h
         mUYcH6jZRWc0Iq0nAzukL0JJGot7+vcrSut8whotD/RtsvUa+VxlD5gzsn9eqoRLVklZ
         w83g==
X-Gm-Message-State: APjAAAWobdH3oT/3k+Xa6M7zm9zCtFlI67Bf/sH7z6DZq+3891QbhSGZ
        K1WJfTnFCNuMvtQ44wdJEbLEMe8v0sYvnGbTlRLl/g==
X-Google-Smtp-Source: APXvYqx5VExSHiCv9ahZNo4EZC6hNa48Mc2gIFoxrZJw+iuRJtwxjb7xHPC9NF6neLHfLLi9w6sv5MHQTKfGdPISbes=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr114167wmc.152.1567527504112;
 Tue, 03 Sep 2019 09:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
 <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
 <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
 <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com> <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
 <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com>
In-Reply-To: <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 3 Sep 2019 09:18:12 -0700
Message-ID: <CALAqxLU5Ov+__b5gxnuMxQP1RLjndXkB4jAiGgmb-OMdaKePug@mail.gmail.com>
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
        Matt Redfearn <matt.redfearn@thinci.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 30.08.2019 19:00, Rob Clark wrote:
> > On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> Of course it seems you have different opinion what is the right thing in
> >> this case, so if you convince us that your approach is better one can
> >> revert the patch.
> > I guess my strongest / most immediate opinion is to not break other
> > existing adv75xx bridge users.
>
>
> It is pity that breakage happened, and next time we should be more
> strict about testing other platforms, before patch acceptance.
>
> But reverting it now will break also platform which depend on it.

I'm really of no opinion of which approach is better here, but I will
say that when a patch breaks previously working boards, that's a
regression and justifying that some other board is now enabled that
would be broken by the revert (of a patch that is not yet upstream)
isn't really a strong argument.

I'm happy to work with folks to try to fixup the kirin driver if this
patch really is the right approach, but we need someone to do the same
for the db410c, and I don't think its fair to just dump that work onto
folks under the threat of the board breaking.

thanks
-john
