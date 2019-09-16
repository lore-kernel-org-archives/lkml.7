Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17C7206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kH85YD9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfIPDgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 23:36:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45860 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfIPDgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:36:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id r134so26215190lff.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkbeehaenRMFwzD4RtVp+gl3t0RfSIKxixqD4Aaof8w=;
        b=kH85YD9mPyeTRuGwGOZ1gN4kMOj11Zq/GXQMmWR6A9mvIB57pXuEsJUkOWhgCDntu/
         zZsZLHAYPVDyBgmEgGs6sXQEzdfRO5afswIBdAmD+aQ6DihFvfONfjBtwcMRHSHhmlj7
         edK0TPpN3gGA2HbhltGv127JrqmtCt7Hb1tgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkbeehaenRMFwzD4RtVp+gl3t0RfSIKxixqD4Aaof8w=;
        b=hocBmD6v3bnx8Z98OWixiTx16f3SdGURm1g3R7giSTZMquNGkldMwvWEEGtY6E1RNv
         exFWn3Dn5xy6qO/g7WSvHB4or+isOWOZJ1Rih9lLWjcIGipIv5Vd/jq2UJOlUW37ISc1
         CbFjxht2COlr7kPi1SyCje8L0p+99KNO9fWMRnIWISKdwiTlW3vv2PnfYLxs4vAeU+ky
         p+PJsPeZLcmBEMMlIEwipBE6DtbjjockUqme329QDRSBS8dxFpfCWK+Gc/TsqY15JrIO
         eIkCYqFCX0gREpICqPLmlRxc9uyJuFG2cQ7AZPwcrA9DuxkvpzD3cMhLQfTRi4waa152
         Zr8g==
X-Gm-Message-State: APjAAAXzvBc4E7OKRrMC4RjH43p8RZFapPhnULqkOaLVSVPf7G1tq/ut
        IzhumwlCmq+lX93cS168RXZkLE5JkOQ=
X-Google-Smtp-Source: APXvYqw9nn3ITDMj0nM8UVIGE1usVpDhiy314FkL/lGwbIvQBKps6uPpSCjVQsJQX/OJ81wT66jZBg==
X-Received: by 2002:ac2:5ec1:: with SMTP id d1mr36103516lfq.83.1568605007675;
        Sun, 15 Sep 2019 20:36:47 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z9sm7981944ljn.78.2019.09.15.20.36.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:36:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c195so11356663lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:36:46 -0700 (PDT)
X-Received: by 2002:ac2:46d2:: with SMTP id p18mr7986062lfo.140.1568605006264;
 Sun, 15 Sep 2019 20:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190913220317.58289-1-dtor@chromium.org> <CANMq1KALGLdZmOgcrrOROU5BXjwnXWSfq6fr85jfRn079JympQ@mail.gmail.com>
In-Reply-To: <CANMq1KALGLdZmOgcrrOROU5BXjwnXWSfq6fr85jfRn079JympQ@mail.gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sun, 15 Sep 2019 20:36:34 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ9U-Lu=Uce0jFjec9JMYMhsQZoTuB+xqDpkOdC+Ufq6Ng@mail.gmail.com>
Message-ID: <CAE_wzQ9U-Lu=Uce0jFjec9JMYMhsQZoTuB+xqDpkOdC+Ufq6Ng@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: google: whiskers: more robust tablet mode detection
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 8:26 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Sat, Sep 14, 2019 at 6:03 AM Dmitry Torokhov <dtor@chromium.org> wrote:
> >
> > The USB interface may get detected before the platform/EC one, so let's
> > note the state of the base (if we receive event) and use it to correctly
> > initialize the tablet mode switch state.
> >
> > Also let's start the HID interface immediately when probing, this will
> > ensure that we correctly process "base folded" events that may be sent
> > as we initialize the base. Note that this requires us to add a release()
>
> s/release/remove/ ?

You are right.

>
> > function where we stop and close the hardware and switch the LED
> > registration away from devm interface as we need to make sure that we
> > destroy the LED instance before we stop the hardware.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > ---
> >  drivers/hid/hid-google-hammer.c | 71 ++++++++++++++++++++++++++-------
> >  1 file changed, 56 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> > index 84f8c127ebdc..4f64f93ddfcb 100644
> > --- a/drivers/hid/hid-google-hammer.c
> > +++ b/drivers/hid/hid-google-hammer.c
> > @@ -208,7 +209,14 @@ static int __cbas_ec_probe(struct platform_device *pdev)
> >                 return error;
> >         }
> >
> > -       input_report_switch(input, SW_TABLET_MODE, !cbas_ec.base_present);
> > +       if (!cbas_ec.base_present)
> > +               cbas_ec.base_folded = false;
>
> I'm not sure to see why this is necessary? The folded base state
> should be in bss and false anyway, and even if it was true, it would
> not change the result of the expression below (!cbas_ec.base_present
> || cbas_ec.base_folded).

To have a more accurate printout generated by the line below. The fact
that it is in bss it not relevant, as I can unbind and rebind the
driver via sysfs, so it could have stale data from the previous run.

>
> > +
> > +       dev_dbg(&pdev->dev, "%s: base: %d, folded: %d\n", __func__,
> > +               cbas_ec.base_present, cbas_ec.base_folded);
> > +
> > +       input_report_switch(input, SW_TABLET_MODE,
> > +                           !cbas_ec.base_present || cbas_ec.base_folded);
> >
> >         cbas_ec_set_input(input);
> >

Thanks,
Dmitry
