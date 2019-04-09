Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E915320883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIcbaCLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfDIHdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:33:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46588 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:33:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so1787086ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnV+9CXC0+sA6oNQXVlMQkZ40tytOdYvLPzBbhhmi1g=;
        b=XIcbaCLm9sUwmj58d/WG0ccyoKoyhlds+a0nDXMD3qCt+sLFdI2b0U5fEN8XrggSoD
         VL1ilwoEYlSY0BeX0n2KcVvEmp3K0BJYBHklc0fLpTenZUHj8o8/qweAu/yAMkND03EK
         2zdN8CChI6EN0aVsKynFpijXWgC2g7SPr6uH0yh+qa2arY7ZYUaqLF99KoVGxj5n23VB
         BR296GLi/AqLPH2WXGdUza2EnmKFEHm+dYsmANkqoyyW9HuO+6Euf+Wkxq2k6EQDr2IQ
         y0BuVJeKilJ2T/S6+wwKIBCs/STqMG3GlnFAAyNuO2zojNpYdScFmFw2tcS9+jYOdVQ1
         7PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnV+9CXC0+sA6oNQXVlMQkZ40tytOdYvLPzBbhhmi1g=;
        b=KDgUxuPMvrA/hcKWCsSLatzH1nDMBdrvFq3hJ86OuYpg/ARebaOh4AiIWLIjCnKqDb
         ZzEy200QdkRYRosq3FAz1F79TEjMs+PpUjPoK53WjQ4ZmnYRAMXEZUn5LyakspY8rdfS
         Yyq0LIQvmFU/de55jsIx8k3jzyrffuXpM7PolKydU7isQIarqPdM8jyBEZeMdV0Akyhp
         RDYlECG//zp+7NkR+WRB342O/Cze28+H+9HGP2cplnQRg67HYYN51HwwirQfT8FhyY/1
         jlrBHGWHRyAtGACmOxPTRPHkXcz21o6vc71M4Oiw4Sf3NEGmFOcjbqnPae7mYhplMB9x
         SGvw==
X-Gm-Message-State: APjAAAVmXCvN3lmVsdtK92R9JFacWAZ0s1om9znB0SXTM6j8dkvespIr
        w9QoSGD5eoKgLJbre4MUAwxHvtIWny0if/g7eKtRDA==
X-Google-Smtp-Source: APXvYqwbRgcynuUkukOgFx5zwI4bkKlmiLJhOs7t48XTZdvZ2WV04fRmustM/NsQFKY14xHfSnCfM9MYr07OUpbDyWI=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr18385047ljj.54.1554795197719;
 Tue, 09 Apr 2019 00:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190404073005.35474-1-darekm@google.com> <c1b7d461-d0b1-e3a4-f8fd-7c757a5e38f6@xs4all.nl>
In-Reply-To: <c1b7d461-d0b1-e3a4-f8fd-7c757a5e38f6@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Tue, 9 Apr 2019 09:33:06 +0200
Message-ID: <CALFZZQHjtToO_gmUQUZUsdb84LarsfTsvuoQTws6h_2ypOGhbg@mail.gmail.com>
Subject: Re: [RFC PATCH] media: cec: DRM connector to CEC dev mapping
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans.

On Thu, Apr 4, 2019 at 2:23 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
...
> > Notes:
> >     Sending the patch in its current form the get feedback if that is
> >     considered a right approach or if some other way of learning
> >     the mapping in userland is preferred.
>
> Thank you for this patch. It's interesting, but I think it should be
> redesigned a bit.
>
> Basically what you want to do is to provide a way for userspace to associate
> the CEC device with the HDMI connector it is associated with.
>
> But this information is known the moment the cec adapter is allocated or the
> cec_notifier is registered for a connector. So I would provide this information
> at that time, rather than through separate functions. This makes everything
> nicely atomic. This also avoids the need of a connector_info event, since the
> connector info is known from the very beginning. You still need the ioctl to
> obtain this information, though.
>
Great, good to know that the event can be removed. I wasn't 100% sure
if in all cases it can be assumed that connector info will be set on
the notifier before the CEC adapter is created, hence the event.
Sending an updated patch with the event no longer there.

> There are also two related issues.
>
> Firstly, CEC is used not only for DRM, but also for V4L2, and it makes sense
> to provide connector info there as well. For V4L2 this would probably look
> like this (tentative as I am not completely sure about the major/minor numbers):
>
>         struct v4l2_connector_info {
>                 __u32 major;
>                 __u32 minor;
>                 __u16 connector_mask;
>         }
>
> Where the major/minor numbers determine the video or v4l-subdev device that controls
> the HDMI connector(s). Since a CEC device for HDMI receivers can be responsible for
> multiple HDMI inputs we need the connector_mask to indicate which HDMI inputs it is
> associated with.
Would simply allowing for multiple connector types to be hooked up
with cec adapters be sufficient to cover this? Please take a look at
the follow up patch.

>
> Secondly, there are USB-CEC dongles that are not directly associated with an HDMI
> connector since the driver simply doesn't know. But it would be nice if the user
> can provide that information. I did a proof-of-concept here:
>
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=pulse8-notifier
>
> and it works fine. But the problem is that the connector name is currently only
> available on the i915 via port_identifier(port), and that that port identifier
> string is not visible to the end-user. I had to try various port names ("Port A",
> "Port B", etc) before I hit the right one.
>
Is there something extra needed for the proposed approach to work in
this case? Looking at the above change - since a notifier is going to
be used to pass the connector info, it should work there as well. And
not being a DRM specialist myself, I don't know what would be the
better way (that wouldn't rely on port identifier) of pairing up a
connector with an adapter.

Thank you very much for your comments and apologies for delayed response.
