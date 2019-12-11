Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D72DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ED424654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqwJ7U/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLKWTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:19:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40453 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:19:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id c93so20834579edf.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=72CkmEu8P0deCrZSK3BbV39L1/XfAcEqTc+T0/vC9p8=;
        b=JqwJ7U/LA2SMeghbmpJ0R3IbdVMoHlrcIrEqcEnWBOJYg1X47XE1vElstrUfVqfOe9
         7Nm9Ve0wPUG+eL/33omQ3z+lfWJ3ZuEFYPQgQhGVHRoQwdfZyBlRx72U1gnPsLcwQvrA
         eEymZjvC2Os3hjP6l4q6HSOzp0Gbb72XhMqGlT5gk/sVsAasKMpGIWw9OThTEKCns8+r
         PBVXHwHJq8Crr3ZF2HH/fAVHZ7VwGo3VI1FZ8Gru00EPm7LTvAdUMT6wW6yzBQghPR2o
         d2TLW0wSqTwP/6JT9UatESP2h23cTh4m4+D/Pb1GzLzhPTYRUr3KZCppK8zOGb8WMY63
         MQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=72CkmEu8P0deCrZSK3BbV39L1/XfAcEqTc+T0/vC9p8=;
        b=GteuV7Uut1hRsxXCOGznyEUiBFEgCs793JQtX/hwJ7GpgcvNL7BABm1P9nQyWoyt82
         S4H1m8LXM1Gb1tG/0ORIMl96qeEWkG/u1yTLm8u5Bh8Izb69/5IxS+7ejHQoFejNVBqG
         dbz8Ism9SROb+Ear9bwwzPytWnOIZRNF/pCWZgefCfP2HkOjkD0Ejw0MiH0qy1c9F6fU
         oTT8eeo/M7IWPHf2pLc2yqrzjeSaBaAISinB3u/d3zPjb4jt9HDmvZPI8IoCe8sOCMgA
         /DzJtOk6vLfPlJUHWNI8bmtWfcHY901HoVv+be1+2RwbH6GtuJoTuSf8fkOjG+zydfLW
         MDIw==
X-Gm-Message-State: APjAAAXNNJlyaTVs+IhoKJ3lkyKW2839hxE++aEte2tL91YMbLFCrvDL
        DAC0VK1n8/z8g2QNvi0QZhS9IW5APwaKyFRqtqowrmMH9a0=
X-Received: by 2002:a17:906:9716:: with SMTP id k22mt5047774ejx.233.1576102754435;
 Wed, 11 Dec 2019 14:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org> <20191211085400.GB500800@kroah.com>
 <CAGXk5yrFp1eeeadhJar_qJqJ9G1q2mn+5m8JW4705ouQDLqzsw@mail.gmail.com> <f0ebc98d-25f2-6326-c0d8-8dda543c4091@linaro.org>
In-Reply-To: <f0ebc98d-25f2-6326-c0d8-8dda543c4091@linaro.org>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 11 Dec 2019 14:19:03 -0800
Message-ID: <CAGXk5yosq5saYWdsz2k+uCYZ5CNTR4zNR2nB3H7-=TQs07u8Sw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 1:11 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/12/2019 21:11, Wei Wang wrote:
> > On Wed, Dec 11, 2019 at 12:54 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
> >>> On 10/12/2019 21:01, Wei Wang wrote:
> >>>> On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> >>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>
> >>>>> On 05/12/2019 08:19, Wei Wang wrote:
> >>>>>> The paths thermal_zone%d and cooling_device%d are not intuitive an=
d the
> >>>>>> numbers are subject to change due to device tree change. This usua=
lly
> >>>>>> leads to tree traversal in userspace code.
> >>
> >> tree traversal is supposed to be done in userspace code :)
> >>
> > Yes, that can be done in userspace, but given the amount of thermal
> > zones we have in some mobile devices, this will bring a lot of
> > convenience.
>
> But usually all these thermal zones are fixed and building the name<->tz
> association is just a question of a few lines of code from userspace,
> no? What would be the benefit of adding more ABI?


code reuse as tz mapping is per device tree setup and we try to use
the same _type_  in thermal zone in shared client code for Android
thermal API.

>
> If there is a thermal zone change, then a notification can be used, so
> the userspace code rebuild the name<->tz, no?


Assuming you meant for type<->tz, this mapping won't change in runtime
in our case (not unloading things), but it could be changed due to
device tree change, e.g. adding/removing thermal zones.


>
> > e.g. this is on Pixel 4 XL:
> > coral:/ # ls  /sys/devices/virtual/thermal/
> > cdev-by-name      cooling_device15  cooling_device22  cooling_device3
> >  cooling_device9  thermal_zone15  thermal_zone22  thermal_zone3
> > thermal_zone37  thermal_zone44  thermal_zone51  thermal_zone59
> > thermal_zone66  thermal_zone73  thermal_zone80  thermal_zone88
> > cooling_device0   cooling_device16  cooling_device23  cooling_device30
> >  thermal_zone0    thermal_zone16  thermal_zone23  thermal_zone30
> > thermal_zone38  thermal_zone45  thermal_zone52  thermal_zone6
> > thermal_zone67  thermal_zone74  thermal_zone81  thermal_zone9
> > cooling_device1   cooling_device17  cooling_device24  cooling_device31
> >  thermal_zone1    thermal_zone17  thermal_zone24  thermal_zone31
> > thermal_zone39  thermal_zone46  thermal_zone53  thermal_zone60
> > thermal_zone68  thermal_zone75  thermal_zone82  tz-by-name
> > cooling_device10  cooling_device18  cooling_device25  cooling_device4
> >  thermal_zone10   thermal_zone18  thermal_zone25  thermal_zone32
> > thermal_zone4   thermal_zone47  thermal_zone54  thermal_zone61
> > thermal_zone69  thermal_zone76  thermal_zone83
> > cooling_device11  cooling_device19  cooling_device26  cooling_device5
> >  thermal_zone11   thermal_zone19  thermal_zone26  thermal_zone33
> > thermal_zone40  thermal_zone48  thermal_zone55  thermal_zone62
> > thermal_zone7   thermal_zone77  thermal_zone84
> > cooling_device12  cooling_device2   cooling_device27  cooling_device6
> >  thermal_zone12   thermal_zone2   thermal_zone27  thermal_zone34
> > thermal_zone41  thermal_zone49  thermal_zone56  thermal_zone63
> > thermal_zone70  thermal_zone78  thermal_zone85
> > cooling_device13  cooling_device20  cooling_device28  cooling_device7
> >  thermal_zone13   thermal_zone20  thermal_zone28  thermal_zone35
> > thermal_zone42  thermal_zone5   thermal_zone57  thermal_zone64
> > thermal_zone71  thermal_zone79  thermal_zone86
> > cooling_device14  cooling_device21  cooling_device29  cooling_device8
> >  thermal_zone14   thermal_zone21  thermal_zone29  thermal_zone36
> > thermal_zone43  thermal_zone50  thermal_zone58  thermal_zone65
> > thermal_zone72  thermal_zone8   thermal_zone87
> >
> >
> >> But what userspace code needs to do this, and for what?
> > In Android, thermal daemon and thermal HAL as well as some init.rc
> > script would use those thermal paths for managing and monitoring
> > thermal. The daemon/HAL could have logic pipled in, however Android's
> > init.rc script would be really tricky.
> > On a related note, we also create /dev/block/by-name links from userspa=
ce.
> >
> > Thanks!
> > -Wei
> >>
> >> thanks,
> >>
> >> greg k-h
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
