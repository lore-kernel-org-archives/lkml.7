Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB313C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA97207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2bS6Mx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfIRPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:53:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40022 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfIRPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:53:53 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so337504iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQ45BCpmBEKnvHqL4KeZ85PzFZcYZhlr4Gvwwx3a9LE=;
        b=j2bS6Mx9kJZxs5QQ/AlKQfbUAJAopRKCyfWwar9orN24zdcVYndxvCB5AKm4Xw9Iy3
         mkYKHguyY0lxca6Paj1/bv2TbuAUVjkO3Cct9gNV1gKXQnbdLJVMsvdhSLqB/5Uzqa2J
         9eM3gTS2OK1kbrI50Z34hKXMl6OadhAbrdNWjtdRBv3KEAEPPNx3xISZodzOqihnl9i2
         pWJEuFZ2v+3aOuiU15uiX3/ejzcYXoNsFi2wRBv8L7Xm4TZH9BDV/ylYz8bgZLZrI2TP
         jyWyqr8dEfMzXv2ocZu9qw9ynx/+OhhdaxjQQez0J48xng6b+dbXMBccljkJDt/mGMXk
         NOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQ45BCpmBEKnvHqL4KeZ85PzFZcYZhlr4Gvwwx3a9LE=;
        b=JRNyY0umjGPOyTZ0GTx7Koa071HPU6vabTIaFrQlSm9gG54McQm+ns5VANliUEaRI9
         j1X+4JRlZ+enU3NYs8lcaM5+EzERotaadCj1V2r0DAG8JuGeDZR1SUsy/mRKAuoM4LfH
         dRpKgWMyRMUo/nAbAH3oOlwdHWnhX4zcX+ZhEcwCX0zcNTgHjAvj2SdZfV+ikamMLaWJ
         WwyGrXqsdrS5/84ngQ4knJSZZdyb5Z6MbeV/HJVRTKwbHyZlQaehpuc+3fbeMdBzpQYQ
         TDVChiCq7iz9J6jxwwQTwYxw1P/yjbs1lHVmiOmNvuQSZXssOOneW/R2bJVm9eZMjSas
         Dfrw==
X-Gm-Message-State: APjAAAV84H5gWvzFcJYK29rSlBrptDt+ACRZIu0n3wVdAjWAn4A0aL5p
        fX/B49XU72V3VYw7bR9zaKzbf5L1HxWZI2l6Irs=
X-Google-Smtp-Source: APXvYqzWWtP7F3fhmYl9ngvjNxdw3ntiC8EMP+BaJfsXqc8gnQIUrrrgG1lqoXIvvsa4AUuT0Qb0x4xEk0eT5KqrDDw=
X-Received: by 2002:a02:69cd:: with SMTP id e196mr5969184jac.84.1568822032590;
 Wed, 18 Sep 2019 08:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-4-m.felsch@pengutronix.de> <CAKdAkRSi+d0AXwXaxc4wx+p2kAf=+_P8HZnq-sJAKmbwuuKH4Q@mail.gmail.com>
 <20190918081807.yl4lkjgosq5bhow3@pengutronix.de>
In-Reply-To: <20190918081807.yl4lkjgosq5bhow3@pengutronix.de>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 18 Sep 2019 08:53:40 -0700
Message-ID: <CAKdAkRSneYYjcVe--P=m037aA1DaD+efbEcRGGKVk1hDeEw70A@mail.gmail.com>
Subject: Re: [PATCH 3/3] regulator: core: make regulator_register()
 EPROBE_DEFER aware
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     zhang.chunyan@linaro.org, Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, ckeepax@opensource.cirrus.com,
        lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 1:18 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 19-09-17 17:57, Dmitry Torokhov wrote:
> > On Tue, Sep 17, 2019 at 4:42 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >
> > > Sometimes it can happen that the regulator_of_get_init_data() can't
> > > retrieve the config due to a not probed device the regulator depends on.
> > > Fix that by checking the return value of of_parse_cb() and return
> > > EPROBE_DEFER in such cases.
> >
> > Treating EPROBE_DEFER in a special way is usually wrong.
> > regulator_of_get_init_data() may fail for multiple reasons (no memory,
> > invalid DT, etc, etc). All of them should abort instantiating
> > regulator.
>
> Those errors are handled but the behaviour of this funciton is to return
> NULL in such errors which is fine for the caller of this function. I
> only want to handle EPROBE_DEFER special..

And I am saying it is wrong to handle only EPROBE_DEFER.
regulator_of_get_init_data() should always return ERR_PTR()-encoded
error code when parsing callback returns error, so that regulator core
does not mistakenly believe that there is no configuration/init data
when in fact there is, but we failed to handle it properly.

IOW I'm advocating for extending you patch so that it reads:

+               ret = desc->of_parse_cb(child, desc, config);
+               if (ret) {
+                       of_node_put(child);
+                       return ERR_PTR(ret);
+               }

Thanks.

-- 
Dmitry
