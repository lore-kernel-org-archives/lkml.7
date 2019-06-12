Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823FC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C77F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408727AbfFLPVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:21:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44031 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfFLPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:21:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so5697902qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMRaFc3/hEiSi70Ix5/f3einSpUu2nV4TVmJ7D/hed4=;
        b=W053NTWS7vMSs6KTP5Y63k8NLCpN5bfjB1+FDyJwOgy0ggC1OwvsDGVWKPRgb1UgS0
         jXvLpsdtv4XYMQrACQsVcqpZP5d6PDOgOK2xOLeFGyCrLuxieV5iax0SCll+E7GVdwbq
         a5jQ8zVWdKb7zgsviHp2Do+vD4QBzGcMNZxXNhj2arCY5xCsG4yXQI27qoBRScF+8GB6
         HJ8o19xKjuscyVz8Vf04Rda81kzO0WNg4TJ3YurTnffBx/U+O47SNE/0U6NFAMzAceI1
         FNwEYGA1DHn40WvkM6/gWE9H/ChGe+LCkUGPQy5FHtS+goyaY8KMNErGxQs1h/sQDV83
         mAQA==
X-Gm-Message-State: APjAAAUyTJNjzXUa8GI/tq4873utMAMdtYiE3kw/Ro8ovd9ioaOt6a26
        6gfp0dzEx+Pp2EBqDnmbsL04AGbOvou0xxLfCKNWJQ==
X-Google-Smtp-Source: APXvYqxHbmq550GcVIRTXA5tocwW+ku4/cuYE4oFs0POCYRKMQzp1djocUEawn+SEa0+NCVlpuDhdB86iHxSww+zPq0=
X-Received: by 2002:ac8:303c:: with SMTP id f57mr71183256qte.294.1560352876572;
 Wed, 12 Jun 2019 08:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
 <20190606161322.47192-1-jeffrey.l.hugo@gmail.com> <20190612003507.GG143729@dtor-ws>
 <nycvar.YFH.7.76.1906121644160.27227@cbobk.fhfr.pm> <CAKdAkRQOxTX51rhodoFyYpwi85pk8apvWjCLLX5Sw6NTH=j1kA@mail.gmail.com>
In-Reply-To: <CAKdAkRQOxTX51rhodoFyYpwi85pk8apvWjCLLX5Sw6NTH=j1kA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 12 Jun 2019 17:21:04 +0200
Message-ID: <CAO-hwJKDxu0Bxxjd9reAojHODQTnW1POmifBCVsnjt8+CT4rmw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 5:14 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 7:45 AM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Tue, 11 Jun 2019, Dmitry Torokhov wrote:
> >
> > > > +static const char *hid_elan_i2c_ignore[] = {
> > >
> > > If this is a copy of elan whitelist, then, if we do not want to bother
> > > with sharing it in object form (as a elan-i2c-ids module), can we at
> > > least move it into include/linux/input/elan-i2c-ids.h and consume from
> > > hid-quirks.c?
> >
> > Let's just not duplicate it in both objects. Why not properly export it
> > from hid_quirks?
>
> Strictly speaking Elan does not depend on HID; exporting it from
> quirks would mean adding this dependency. This also mean that you
> can't make Elan built-in while keeping HID as a module (I think this
> at least used to be config on some Chromebooks).
>

I also think it would me things cleaner to have the list of devices in elan_i2c.
If we put the list of devices supported by elan_i2c in a header, and
have HID read this .h file directly, there will be no runtime
dependency.

I am sure we can work something out to remove Jeffrey's fears.

Cheers,
Benjamin
