Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91412086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="BZyB9leZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfITUJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:09:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33993 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfITUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:09:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id p10so7587596edq.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Liy99NbfBPKnCLL5pI97ZdCbqOlNrE+8AE8B3qqiLLk=;
        b=BZyB9leZy0o8BDwc4dpNHtln9sYHsI2MCbOSfmRGUGn35V2zNXwRBAEX+8CTMWS/KO
         JbR0CMvf6eYH71IuCq1KUXVRO6QJMLNr5DDBWlLvcn6KMHAGuQn7oiGF0ofNNZ7gA16f
         GiYGb/OkduiejdPeZtlVNxN3jSG7PD3+CKt77vUbyB//K5bbVqSQQa8dJ5ua0LDE2bN7
         A2gprl4a9Y5zU6Zx0rbf3WB22Mi8RiPG/gZnhKi1/VL2+6gxkTzk46VWeB8x3xs7lAxc
         BFlzANjDARm8aoSD06T25RZc8hkJGDWBFAhEHI68xSyzvycMgpPRqboXkOLW4as7my2t
         NRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Liy99NbfBPKnCLL5pI97ZdCbqOlNrE+8AE8B3qqiLLk=;
        b=aghWHeJbSP1xX+Yt9n+PW4K42XemH2YN96hcUbSChU6le2aNozFgWLTYY0q1ZScqjb
         bwXzZXc69mXG2ZBgMQhK/e4RJByK7uDQvpU32AxLwwrt2mkrRxGManxVQ/OaPM5H+Op8
         tDy0mQqG3m3fagesANroY/7dDZ7p9mBRT8eEXPrd2e45s4lGyWR7mFa+x6NY0JDW3g5a
         SmAYALbETbVW4lYiMEKYkAUvcqh/lG2714kMGg894Qv/o5aGXnxhhIRjamZt0Ia464sH
         fyeiGd5LVpgDM7mAcDZOPYMmS1m3WuLjR83LBMBFLLwzUQvfTzsPJFW+rw21CX8920p2
         F2qg==
X-Gm-Message-State: APjAAAVOSbkevd82wKKKCfg6jZx4LL3rs/2sP+i0WpOFaqDjHp5Md1Le
        0r4scV8nO9x8ZDNu1ZJm2VHmsf+uDRzAbpBKfpr4ZA==
X-Google-Smtp-Source: APXvYqx9L9yJGIjWkbUpHUhfQrO13iJtlPQ5sEGBpIdtMQYiiHr/3ySgCyO4aVXb9xPojgQmlY/tbDb8c7PfxfUUvpY=
X-Received: by 2002:a17:906:6c98:: with SMTP id s24mr11317157ejr.28.1569010190869;
 Fri, 20 Sep 2019 13:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
 <20190919171754.x6lq73cctnqsjr4v@gilmour> <104595190.vWb6g8xIPX@jernej-laptop>
 <CAODwZ7sPG+_YvnLBU11uYaNpDFthLOkcYXsd=ZQtM+88+cPi9A@mail.gmail.com> <20190920061800.65sm6jth2afatsvl@gilmour>
In-Reply-To: <20190920061800.65sm6jth2afatsvl@gilmour>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Fri, 20 Sep 2019 23:09:39 +0300
Message-ID: <CAODwZ7vmiBQ87FeGVwxkcZ3DFaGHk8iDCOavNNRw=MO1hFNruA@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: Use vi plane as primary
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Jernej =C5=A0krabec @Maxime Ripard

Thanks for your time and valuable suggestions.

Currently I would have to go away from mainline KMS to solve my
(Android) issues, and I hope to get back when I
find mainline-friendly solution for it.

Having no primary layer or zero-buffer primary layer and 4 overlays
could be a universal solution, but  I have not sufficient knowledge in
KMS to bring-up this idea.

On Fri, Sep 20, 2019 at 9:18 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Thu, Sep 19, 2019 at 11:03:26PM +0300, Roman Stratiienko wrote:
> > Actually, I beleive this is True solution, and current one is wrong.  L=
et
> > me explain why.
> >
> > De2. 0 was designed to match Android hwcomposer hal requirements IMO.
> > You can easily agree with this conclusion by comparing Composer HAL and
> > De2. 0 hardware manuals.
> >
> > I faced at least 4 issues when try to run Android using the mainline ke=
rnel
> > sun8i mixer implementation. Current one, missing pixel formats (my prev=
ious
> > patch), missing plane alpha and rotation properties. I plan to fix it a=
nd
> > also send appropriate solution to the upstream.
> >
> > To achieve optimal UI performance Android requires at least 4 ui layers=
 to
> > make screen composition. Current patch enables 4th plane usable.
>
> Note that you can also get 4 UI planes by enabling more than one UI
> layer per channel. You wouldn't be able to use alpha between each
> plane of a given channel, but we can use a similar trick than what we
> did for the pipes in the sun4i backend.
>
> Maxime



--=20
Best regards,
Roman Stratiienko
Global Logic Inc.
