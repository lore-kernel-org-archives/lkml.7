Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4AACA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D389222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdRm8Fkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443414AbfJRUVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:21:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729145AbfJRUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571430094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSbdbj+wXGSv6Xtgci7agv/N2COPVch8KltnfFcM01A=;
        b=DdRm8FkxjGvCSCCFns3h3IE0f05kCJbM10g/Nncl9+ZZWq/UzToVCY/9/6dEv9lEVop/VY
        b6IVmcKLKGdpl2oKLFknltIk3Hzjtw3Q5CdhGQ3JgeNEdVn0BNqsHu6kmyWAYc6D9ASG3j
        hIfjAO5HIrOt5W0onFaf2Wisp/iSw8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-j6EJ-oBnNEa3R9UnMcWvkw-1; Fri, 18 Oct 2019 16:21:31 -0400
Received: by mail-wm1-f71.google.com with SMTP id m16so2771172wmg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6u6vJO+zIbtOKQSr5a8/ZaiKiRenOVbT3zCNikSDSSg=;
        b=s24e7x2nUEryxPRHdE0VIaPy4DyHiB7mOIVuwRxoepI6i4RQWzzpyRG75IWlepsbIq
         U5d18tC6I33YFBpt1Ld0gzphXhEuScSUvwQBTgTvuIRajklM1CVMB4QnD9Ugfn9aDLFl
         +JW1Cegz7orRrtaL3LbSmc6clgr8zljpo92gSegBviCeBT6WVU4t1vzTWJQ5HJpXn3+w
         i28kZwdnpYpMcjd+J10nYTMqLQ053SJAEsAf4R1ZKABCCPHh2jQCDyy1k/DQeNZ5WSHM
         XQUl+nXpU4UnMpwCCO+lYy05LM2zvtvtuwf/o3PxJU7IkJXM3b7Rd+xQblg15vSxejnE
         cP+w==
X-Gm-Message-State: APjAAAXzHbmII0pkLnmE3XvlNTrkim8KQ0f7X6jjs4p9pNvcX43fR0mW
        vvtrYlEKMerfmUFe+ngtxnbu8DkaH/MnJ0G/pHVeOf+Jr+1qT2BDPdHf498N7k6a9IMK8B9p8hq
        pZUF29mVBr5aXTe6sHc19R0IJ
X-Received: by 2002:a05:600c:490:: with SMTP id d16mr9074956wme.131.1571430090124;
        Fri, 18 Oct 2019 13:21:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCCcieYMEnaT1Hycj8RUPMk9oRpKyXHixT+kFXUt3/2glO8P/PUCAbl0452Azbls+mfm+5Sw==
X-Received: by 2002:a05:600c:490:: with SMTP id d16mr9074940wme.131.1571430089848;
        Fri, 18 Oct 2019 13:21:29 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id t13sm7910568wra.70.2019.10.18.13.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 13:21:29 -0700 (PDT)
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     John Stultz <john.stultz@linaro.org>
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
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
 <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
 <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com>
 <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
 <f2236442-111d-cd84-fc47-0737df71cf3a@redhat.com>
 <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
 <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com>
 <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
 <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com>
 <CALAqxLVrEYT5RbL_R0tx_3jHzt7ZuWHDPuEwt1r2iXgPwR+Czw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f5c9f5a3-97b8-389b-47ee-cfa5ddb9afa7@redhat.com>
Date:   Fri, 18 Oct 2019 22:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLVrEYT5RbL_R0tx_3jHzt7ZuWHDPuEwt1r2iXgPwR+Czw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: j6EJ-oBnNEa3R9UnMcWvkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-10-2019 22:12, John Stultz wrote:
> On Fri, Oct 18, 2019 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrot=
e:
>> On 18-10-2019 21:53, John Stultz wrote:
>>> On Fri, Oct 18, 2019 at 12:30 PM Hans de Goede <hdegoede@redhat.com> wr=
ote:
>>>> Looking at drivers/usb/typec/tcpm/tcpci.c: tcpci_set_vconn I see that
>>>> there is a data struct with vendor specific callbacks and that the
>>>> drivers/usb/typec/tcpm/tcpci_rt1711h.c implements that.
>>>>
>>>> So you may want something similar here. But things are tricky here,
>>>> because when nothing is connected you want to provide Vbus for
>>>> the USB-A ports, which means that if someone then connects a
>>>> USB-A to C cable to connect the board to a PC (switching the port
>>>> to device mode) there will be a time when both sides are supplying
>>>> 5V if I remember the schedule correctly.
>>>
>>> Ok. Thanks for the pointer, I'll take a look at that to see if I can
>>> get it to work.
>>>
>>>> I think that the original hack might not be that bad, the whole hw
>>>> design seems so, erm, broken, that you probably cannot do proper
>>>> roleswapping anyways.  So just tying Vbus to host mode might be
>>>> fine, the question then becomes again how can some other piece
>>>> of code listen to the role-switch events...
>>>
>>> So, at least in the current approach (see the v3 series), I've
>>> basically set the hub driver as an role-switch intermediary, sitting
>>> between the calls from the tcpm to the dwc3 driver. It actually works
>>> better then the earlier notifier method (which had some issues with
>>> reliably establishing the initial state on boot).  Does that approach
>>> work for you?
>>
>> That sounds like it might be a nice solution. But I have not seen the
>> code, I think I was not Cc-ed on v3. Do you have a patchwork or
>> lore.kernel.org link for me?
>=20
> Oh! I think I had you on CC, maybe it got caught in your spam folder?

More likely I just deleted mail to aggressively, sorry.

> My apologies either way! The thread is here:
>    https://lore.kernel.org/lkml/20191016033340.1288-1-john.stultz@linaro.=
org/
>=20
> And the hub/role-switch-intermediary driver is here:
>    https://lore.kernel.org/lkml/20191016033340.1288-12-john.stultz@linaro=
.org/

Hm, this looks very nice actually, much much better then the notifier stuff=
!

As for your:

"NOTE: It was noted that controlling the TYPEC_VBUS_POWER_OFF and
TYPEC_VBUS_POWER_ON values here is not reccomended. I'm looking
for a way to remove that bit from the logic here, but wanted to
still get feedback on this approach."

Comment in the commit message, normally a type-c port would turn external V=
bus
off until a sink is connected, IIRC the same Vbus is also used for the Tupe=
A ports
on the hub, so that would mean those are unusable when nothing is connected=
 to
the TypeC port, which is not what you want.

So I think that given the special case / hack-ish hw you have, that just se=
tting
Vbus based on the role is ok(ish).

Regards,

Hans




