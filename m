Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED8BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183121D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXCShMKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440179AbfJRUMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:12:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37907 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394929AbfJRUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:12:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id o15so7068447wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x389mZLGXetFlk8yGllbW5v4Nob+O0GHyuteffuWsmc=;
        b=UXCShMKff3dfekkJDK07Mosf/v3FGsUxpM8MHsFMJt28ppHXP1o2a/SQayUPhfA4ui
         SMbG18EWv2XFgxoO7DDO678BAufx0TS3etwCZ+nPI0vRiWhojnHZe3MGXOvaBcksxBcz
         qsbUEU31/whajAWjSEssU/q8riphAkFvuaOhrnn1iNySQreYGHu0XT+833q9/nxZqFO4
         C7gj8wp7tluw00B667NbPCvdthIDiXHde4W73qqPHS/YTP5o0QA88wmUvOLGQVeXsJKD
         Hg6UtCwEEqeiuwfNvH5IhwTARhuv1ZoXLenunMNzEkbbfx+plJAp4sGvJZTg7gRH1i0c
         dNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x389mZLGXetFlk8yGllbW5v4Nob+O0GHyuteffuWsmc=;
        b=IW8FNQHs4V06DyEv0s0tpgAYVMxxTgV1YuD3f8UF0RY/Znj9w52Gxx0ZZK3KP4roC2
         GyfxlexP6YgLEOXm2OKqw6T53YsmY9Itxvaw04uMXUNhVK+1U0r7mPMOoHqZlb/1fj0W
         NP4tx62ovd96rVwkaCoiGbcftjRYaMXiP/DX77kY+TCZA7+kW/4ftDe2/+t8VcziCyNj
         YRZL1SfNd6U+KzoX3nALUl/5cUAEMi0KnQdyp753MwSPUf8usx5ehPJEZosd+luN5pUt
         3FPScCfK0vnF3dqo9O9SC/8APt6jKjMGpiYUgKkX0tVB3E4qvfHHQWku9IIc2HBOyo+Q
         l2uw==
X-Gm-Message-State: APjAAAVyQcn13wq5SmveNNH3D2x7OUiXwnEr3iVn7GgOjxHzJM+sDSkv
        bboIIef1r1nrRvdZUc5KLvHCK6GpBlj7jd3Vweos3A==
X-Google-Smtp-Source: APXvYqwTwdLPBaO/BM+V90ZClXiOqHs9r7Etx4BZoATqavnhQU21JleuKX7nVqy4opGKQjw4sDJyJeSR5b9dq+NYFXs=
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr9094072wrw.169.1571429550545;
 Fri, 18 Oct 2019 13:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com> <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com> <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com> <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
 <f2236442-111d-cd84-fc47-0737df71cf3a@redhat.com> <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
 <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com> <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
 <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com>
In-Reply-To: <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 13:12:18 -0700
Message-ID: <CALAqxLVrEYT5RbL_R0tx_3jHzt7ZuWHDPuEwt1r2iXgPwR+Czw@mail.gmail.com>
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

On Fri, Oct 18, 2019 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 18-10-2019 21:53, John Stultz wrote:
> > On Fri, Oct 18, 2019 at 12:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> Looking at drivers/usb/typec/tcpm/tcpci.c: tcpci_set_vconn I see that
> >> there is a data struct with vendor specific callbacks and that the
> >> drivers/usb/typec/tcpm/tcpci_rt1711h.c implements that.
> >>
> >> So you may want something similar here. But things are tricky here,
> >> because when nothing is connected you want to provide Vbus for
> >> the USB-A ports, which means that if someone then connects a
> >> USB-A to C cable to connect the board to a PC (switching the port
> >> to device mode) there will be a time when both sides are supplying
> >> 5V if I remember the schedule correctly.
> >
> > Ok. Thanks for the pointer, I'll take a look at that to see if I can
> > get it to work.
> >
> >> I think that the original hack might not be that bad, the whole hw
> >> design seems so, erm, broken, that you probably cannot do proper
> >> roleswapping anyways.  So just tying Vbus to host mode might be
> >> fine, the question then becomes again how can some other piece
> >> of code listen to the role-switch events...
> >
> > So, at least in the current approach (see the v3 series), I've
> > basically set the hub driver as an role-switch intermediary, sitting
> > between the calls from the tcpm to the dwc3 driver. It actually works
> > better then the earlier notifier method (which had some issues with
> > reliably establishing the initial state on boot).  Does that approach
> > work for you?
>
> That sounds like it might be a nice solution. But I have not seen the
> code, I think I was not Cc-ed on v3. Do you have a patchwork or
> lore.kernel.org link for me?

Oh! I think I had you on CC, maybe it got caught in your spam folder?
My apologies either way! The thread is here:
  https://lore.kernel.org/lkml/20191016033340.1288-1-john.stultz@linaro.org/

And the hub/role-switch-intermediary driver is here:
  https://lore.kernel.org/lkml/20191016033340.1288-12-john.stultz@linaro.org/

thanks
-john
