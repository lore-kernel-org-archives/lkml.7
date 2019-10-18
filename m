Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539D7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B692054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W69Zhxtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443489AbfJRUh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:37:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46270 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443483AbfJRUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:37:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so7521377wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3UV8UFcJXmjR8xWcyajZiE4sW1UaQr14OUnxYin0zs=;
        b=W69ZhxtcR3kEhzKTH2ppDDQlp2xuHqjvVPvb8g7MCaMKvJtrGmDQfS+xmx1MWd1hh3
         QdpwpFZ99tTKz2te6dL/wBpDqKbY0S5bSaMX6Vmp4JINdE+Bqt+lk1Wu1u5kD84Dc2Q+
         5RtBaef8PynQwb9Ljk6vWRAshRymWsFte5uNn66HYAcKz651iy77RKs5rnO3gqJzMp7b
         QVcQ7OI19bTTvuIugp4NbrXZyotEiFX6o3wLZaO/VZDeL1y5KG+ZQo1DiG85Du2xp/X2
         BUjDvNl/1m/N2FUK5XNLaiu/lZLRzh8MOKLMQc1M62AgAd8VCpzGhFglTNx88iFW8aDW
         S4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3UV8UFcJXmjR8xWcyajZiE4sW1UaQr14OUnxYin0zs=;
        b=cuv3Ry9pTyW7xINsNSs8GgmKVxxIfCwCPS1B9vQ6ltSJ+KUQVXM/Uo8o1GycTCdhC5
         VcQg/qCLU6/I3AN0FtkGgtYSEIz2uNj67ht5iDX1FTgrNezHGlnTK98nKL6U36SBKK/2
         X5G7hAWW3/P4MY0zS9UmJKpJAc2Gu2vT1st+3lVQGdaat+Au8fOlxgrKmz9uf165vEM/
         Ye/QgMVYb34fJ+dU8UubUsAt2sWmhpC23GxsqtOd2v3Phpih4b2tGHWs8NWjzaekTjk3
         h5VyBQXVBgCoK6GYgpzsM59MKFr+uQcsDOaYE83NHuANKh6q4yIp3jExuJHaPjNPTwta
         FY7g==
X-Gm-Message-State: APjAAAVqAHKly+g2ibDiBOHWxZ/QpLZYM0ujZBawJsVLkO3ALu+uxJlT
        8iepqN9NLJCMV7yRlmk/5k5WwqNH3XXyWH9hn+cwqsDgnuc=
X-Google-Smtp-Source: APXvYqw2ZOeG9Qok15FEuCqv0VPjp925ukdnNDK2HvOgBeJidTalVOsPQfwmo811wLb4RXONWUEEJmfoTECJ+r0Plkw=
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr6224464wrx.105.1571431071003;
 Fri, 18 Oct 2019 13:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com> <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com> <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com> <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
 <f2236442-111d-cd84-fc47-0737df71cf3a@redhat.com> <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
 <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com> <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
 <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com> <CALAqxLVrEYT5RbL_R0tx_3jHzt7ZuWHDPuEwt1r2iXgPwR+Czw@mail.gmail.com>
 <f5c9f5a3-97b8-389b-47ee-cfa5ddb9afa7@redhat.com>
In-Reply-To: <f5c9f5a3-97b8-389b-47ee-cfa5ddb9afa7@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 13:37:39 -0700
Message-ID: <CALAqxLW5vYpGY1yLTvRefiX6anOGsPWW_Dc1Rj8kdf9+BDm0kw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 1:21 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 18-10-2019 22:12, John Stultz wrote:
> > On Fri, Oct 18, 2019 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 18-10-2019 21:53, John Stultz wrote:
> >>> On Fri, Oct 18, 2019 at 12:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>> Looking at drivers/usb/typec/tcpm/tcpci.c: tcpci_set_vconn I see that
> >>>> there is a data struct with vendor specific callbacks and that the
> >>>> drivers/usb/typec/tcpm/tcpci_rt1711h.c implements that.
> >>>>
> >>>> So you may want something similar here. But things are tricky here,
> >>>> because when nothing is connected you want to provide Vbus for
> >>>> the USB-A ports, which means that if someone then connects a
> >>>> USB-A to C cable to connect the board to a PC (switching the port
> >>>> to device mode) there will be a time when both sides are supplying
> >>>> 5V if I remember the schedule correctly.
> >>>
> >>> Ok. Thanks for the pointer, I'll take a look at that to see if I can
> >>> get it to work.
> >>>
> >>>> I think that the original hack might not be that bad, the whole hw
> >>>> design seems so, erm, broken, that you probably cannot do proper
> >>>> roleswapping anyways.  So just tying Vbus to host mode might be
> >>>> fine, the question then becomes again how can some other piece
> >>>> of code listen to the role-switch events...
> >>>
> >>> So, at least in the current approach (see the v3 series), I've
> >>> basically set the hub driver as an role-switch intermediary, sitting
> >>> between the calls from the tcpm to the dwc3 driver. It actually works
> >>> better then the earlier notifier method (which had some issues with
> >>> reliably establishing the initial state on boot).  Does that approach
> >>> work for you?
> >>
> >> That sounds like it might be a nice solution. But I have not seen the
> >> code, I think I was not Cc-ed on v3. Do you have a patchwork or
> >> lore.kernel.org link for me?
> >
> > Oh! I think I had you on CC, maybe it got caught in your spam folder?
>
> More likely I just deleted mail to aggressively, sorry.
>
> > My apologies either way! The thread is here:
> >    https://lore.kernel.org/lkml/20191016033340.1288-1-john.stultz@linaro.org/
> >
> > And the hub/role-switch-intermediary driver is here:
> >    https://lore.kernel.org/lkml/20191016033340.1288-12-john.stultz@linaro.org/
>
> Hm, this looks very nice actually, much much better then the notifier stuff!
>
> As for your:
>
> "NOTE: It was noted that controlling the TYPEC_VBUS_POWER_OFF and
> TYPEC_VBUS_POWER_ON values here is not reccomended. I'm looking
> for a way to remove that bit from the logic here, but wanted to
> still get feedback on this approach."
>
> Comment in the commit message, normally a type-c port would turn external Vbus
> off until a sink is connected, IIRC the same Vbus is also used for the TupeA ports
> on the hub, so that would mean those are unusable when nothing is connected to
> the TypeC port, which is not what you want.

Uh, so I think for the HiKey960, the type-A ports on the hub are
separately powered via the hub_power_ctrl(hisi_hikey_usb,
HUB_VBUS_POWER_OFF/ON) call.

At least, with the current driver, the functionality is working as
expected: remove the USB-C cable, and devices connected to the hub
power on, plug something into the USB-C port and devices plugged into
the hub shutdown.

But maybe I'm missing what you mean?

> So I think that given the special case / hack-ish hw you have, that just setting
> Vbus based on the role is ok(ish).

Ok. I'm happy to stick with what works here, since it is at least the
oddness is isolated to the device specific hub driver.

thanks
-john
