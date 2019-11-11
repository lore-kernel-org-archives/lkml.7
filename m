Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14F320679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:25:18 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:25:18 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOiYD-1iGFr137Dr-00QDpb for <linux-kernel@vger.kernel.org>; Mon, 11 Nov
 2019 17:25:16 +0100
Received: by mail-qt1-f179.google.com with SMTP id g50so16253889qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:25:16 -0800 (PST)
X-Gm-Message-State: APjAAAXu8KhZYr9sGDPSRQgqVrLJ2lBtXvxM6xwtYZ2xvnvKIT6l293y
        uHa+LK2QXAS/GUJf2WDgeFdcSnl5x3cAI/OJkl0=
X-Google-Smtp-Source: APXvYqzhEX+Ry63FPgxImqPVdNg3+01We4bix3tpiOsVLV3c4EpCOOaUFn43GI00Tsjcb2HTxmGTLXXXT8IHHLMKa0E=
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr26604573qtk.304.1573489515656;
 Mon, 11 Nov 2019 08:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20191108213257.3097633-1-arnd@arndb.de> <20191108213257.3097633-16-arnd@arndb.de>
 <3a0cfce79620152facfe31b442a735db1dcda436.camel@pengutronix.de>
 <CAK8P3a13jSRqzZ-aDETdxk-BKgfXaAhdWiSn7aW+u3MFf06fWw@mail.gmail.com> <7379bfe6c530132caab4cd930cd94f0e28c935ff.camel@pengutronix.de>
In-Reply-To: <7379bfe6c530132caab4cd930cd94f0e28c935ff.camel@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 17:24:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0SA+LbVCnm8qhc-Xk1kboGhkRQsK0XAuMya8TmaD4+TA@mail.gmail.com>
Message-ID: <CAK8P3a0SA+LbVCnm8qhc-Xk1kboGhkRQsK0XAuMya8TmaD4+TA@mail.gmail.com>
Subject: Re: [PATCH 15/16] drm/etnaviv: use ktime_t for timeouts
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JHnu4qBIDr0AeRGo2cjWt8VCwhOw5IiHIztxB1kU5f7R5MHak0b
 MUhl14MFo3fS2u3qB6cwVV33jE07KSe979aZ8K5PmFEMMOJL4b2T0l2gnPOKx6lcxsD2fDq
 9XnWN2B4fBlWpV0HfeteryhY78xhDjNQ0mQNLV6GYtVlUz7reGx9QmA4aSAPZZ7iP/Ezb7X
 ELy6MxULVkSG8blbPxWjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WJQ11S94CGw=:RutZ7RQyzb5LCYyWCXrCdg
 RH0Ew62Ok670uFYGEARvFFMPRKx+hyo/MYHh51VvgWm0Wg9SrjzbvS7DtG8lyXnyj+lRXGvRi
 mtrG7yrlaHuCfQWLpuMI7FDNMeEuWQy/429+zcmda6jn4BgfLctLAw8AxZUvQbZOA2L9VtuUt
 6GH16g4JmkuokrDTIaokCEqOQPJY3pIQbApgOkfvRIK3ITqptGJywimY/navkIWbgz9LahCB7
 v2GWL8F1KMzhJ532wBvPmboO+2rYYW6jjPaPuTaoVymRiwIG3rd0SIFxvHOze6Dkb7AGS1d0m
 onjGU0h24kamjW98HG0syPjW5UEkvjHwclqiHvrZfrKcrOj1caM6xdZ+vwXz4aldTLp8Novrx
 RFEL662SNMVtcz3CzM+FGtqVJNRhHmbFGcoRh+RozIAYq2utWcX/uKBJ4p9r3sfgJD4qdcjxR
 SKWwaSlJYTlyLej+Am2aUaeKkxHV1ZZFkdWqroLccda3DWbINouYbop2lixk46+VDxc92Qcrf
 rLptY9j7K0FLMPMELlEYh0Aa5C5stSpQJhO/0P4y3sMCuR3Yw1hFTFd3p/QfRCKgkf3cVXW/4
 6RhH5Lnx3h8DdwSCSMr68gHCPodUtyNIJnrY51OZuzqld7vLa2dSqssb+ZEfsr3bVbaZRvDsT
 l4g3cJYQwoyHITz70qenAafTXb/t9WRAYtTo5lg5bMkyJPcB89hfgUT5PMGnm/7w1WbWVgiIP
 osEKtc/2rRFCbS0bisXXivKy1n7T5z1tpPWkhcTEJqNu+z1IA+N7bFzfONgN2uJxOyLhUC7Gk
 kOG0GfcwlVCWDAmVqQ7UpPq89QzWGC0M/vou1C/hr5H7N4XIXlOzhhc+4tEBF+v86+WpsHgm/
 /tH2zu/6pORxCMK83yWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:55 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > > If that's the case then we should never encounter a genuine 0 timeout
> > > and this change would be okay.
> >
> > That's quite likely, I'd say any program passing {0,0} as a timeout without
> > ETNA_WAIT_NONBLOCK is already broken, but if we leave it like that,
> > it would be best to describe the reasoning in the changelog.
> >
> > Should I change the changelog, or change the patch to restore the
> > current behavior instead?
> >
> > I guess I could fold the change below into my patch to make it transparent
> > to the application again.
>
> If we assume 0 to never be a valid timeout, due to monotonic clock
> starting at 0 and never wrapping then I think we shouldn't introduce
> any additional code complexity to fix up the return value for this
> specific case. I'm not aware of any etnaviv userspace being broken in
> this way to rely on the return value for an invalid timeout input.
>
> Please just amend the commit message to mention the change in behavior
> and why we think it is safe to do.

Russell had some additional concerns that he raised on IRC,
and I did a new simpler implementation of the patch, plus a related
bugfix.

Please have a look at those.

       Arnd
