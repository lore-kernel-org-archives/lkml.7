Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471912184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlVKjZZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfJVF6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:58:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46851 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfJVF6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:58:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so13115378oth.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyoePeW1eU+VxJDZ8UeTfHDfpzKkXF8DIfnO4pkiD+w=;
        b=RlVKjZZYULYRd5O6s2m1dwK4yoIxX8Xiwj8xGNQ5U7OVKc7cGhqUR2UDKTqZ8hozw/
         QONRK59qzRIKmdqhr/zrAC6Bs7sk4+hFqf5Jl7qLV5M02bj1sAhZY1OKw9BLOyGpPAFE
         uywEDekVGXrE8eWVNtBA1mVOOzGssMz9lXZaIiQaXHRrMFxGlbYTiUYEwguC7ZLVhlWv
         RjYBU3kajIsfSDuPDcNMhUr6lr4NtJsMWaXhG3UU5F6finYEo5WHRW8lNsroEax38CbM
         MgttsbvdSwLk/SRJs4tn4upjrvehMgm9fGt1gW1oAsoHv7m6KL73k3uh9NhLJdn8r2Vv
         C8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyoePeW1eU+VxJDZ8UeTfHDfpzKkXF8DIfnO4pkiD+w=;
        b=pKGHrmooIcKCiN1jSQYaCgJRWZI8+Qmpoq9Zgyy1tIMv1wJozYbZRSB2dqfVqOIdDg
         7xFbpyGASOsBp2jtvEj7fm8mofwHnRsraZGx/MP4hSrV/jnibw6HE+ZHCDDQD+BV+m+M
         tUj2fGvq5HdFpH579zNJksIu1do8QkFsNEv9ZSyZg45G5DKJ7xbp6UDlmbJHmb6gqet2
         0eCd6nlz8Hs0ZHzioFklXY3kgYVra5Dw/ILWcBbphzzOn0S2HpMX4OU0vCyPKb9QuFxY
         oCAgxAueGs/AkLOfj0BHQQzVPiy7EZaD0D4QWQeBJBGfA0gX2OPB4dQeetrQHj1DfLQS
         QFAQ==
X-Gm-Message-State: APjAAAUnFIuECTzFOLqKL6ji7OqbCAWh7KWViVYscmCabzuhADEfNykz
        tykpgaPsdLBZl+x9CvltXhlcZOtBJ5ihCt6nqHem/g==
X-Google-Smtp-Source: APXvYqznfN2evn8b9VQ0a4QEJeKciCG4mSEBBB3OCw+ehbmm9runcuaRpXh/ieYPl4NS9yYmrqdoyop15YY1mGXDCHM=
X-Received: by 2002:a05:6830:ca:: with SMTP id x10mr1206900oto.221.1571723925390;
 Mon, 21 Oct 2019 22:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com> <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com> <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com> <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
 <f2236442-111d-cd84-fc47-0737df71cf3a@redhat.com> <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
 <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com> <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
 <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com> <CALAqxLVrEYT5RbL_R0tx_3jHzt7ZuWHDPuEwt1r2iXgPwR+Czw@mail.gmail.com>
 <f5c9f5a3-97b8-389b-47ee-cfa5ddb9afa7@redhat.com> <CALAqxLW5vYpGY1yLTvRefiX6anOGsPWW_Dc1Rj8kdf9+BDm0kw@mail.gmail.com>
 <5965292c-4837-5f3b-816e-287174c909ff@redhat.com>
In-Reply-To: <5965292c-4837-5f3b-816e-287174c909ff@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 21 Oct 2019 22:58:32 -0700
Message-ID: <CALAqxLXhmS2CsPRgjOdZHhzegc_z9pOse4C6oPH44ny9JJcf+A@mail.gmail.com>
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

On Fri, Oct 18, 2019 at 2:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 18-10-2019 22:37, John Stultz wrote:
> > At least, with the current driver, the functionality is working as
> > expected: remove the USB-C cable, and devices connected to the hub
> > power on, plug something into the USB-C port and devices plugged into
> > the hub shutdown.
> >
> > But maybe I'm missing what you mean?
>
> Ok, so double checking the schematic I do see separate Vbus-es for the
> TypeC port and the TypeA ports, with the TypeC port one being controlled
> by GPIO_202_VBUS_TYPEC. So ideally that gpio would be  controlled to
> enable/disable vbus by the tcpm framework.

So I've given this a shot, adding a gpio regulator for the type-c
vbus, and added a set_vbus hook to the tcpci_rt1711 with logic to
enable and disable the regulator depending on the source state.  I've
also added some debug logic to check the regulator disabling/enabling
is working properly. However, doing the type-c vbus control via the
tcpm logic doesn't seem to be working properly.

The issue seems to be when the USB-C cable is unplugged the device
goes into ROLE_NONE, we switch to the on-board hub. Then when we
connect a USB-C hub to the type-c port, we switch to ROLE_HOST, and
power on the regulator, and that starts to power on the USB-C hub
devices. However, since this disconnects/powers down the on-board hub,
we see the on-board hub device disconnect. I'm guessing the hub
disconnection causes some confusion in the state machine, as then I
see the state change from state change SRC_ATTACHED -> SRC_UNATTACHED,
and set_vbus is immediately called with source=0 and the regulator is
disabled, and we switch back to ROLE_NONE (which powers on the onboard
hub).  The system then seems to quickly oscillate between the
ROLE_HOST and ROLE_NONE switching the regulator on and off fairly
quickly (see log below for more details) and never really settling for
one state or the other.

Any off-hand thoughts on what might be going wrong here? I'm fine to
continue digging and working on this approach, but I also don't want
to have to pollute the core code too much for this oddball hardware
(esp since doing the vbus control in the role-switch intermediary does
work ok - or at least better then this approach so far).

thanks
-john


Starts in ROLE_NONE with nothing connected to type-c port, with the
on-board hub powered on, then we connect a type-c usb hub.

[   57.828323] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   58.031325] JDB: state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[   58.031525] JDB: tcpm_state_machine_work state chage: SNK_TRY->SNK_TRY
[   58.135273] JDB: state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
[   58.135296] JDB: tcpm_state_machine_work state chage:
SNK_TRY_WAIT->SRC_TRYWAIT
[   58.149344] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT->SRC_TRYWAIT
[   58.251273] JDB: state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED
[delayed 100 ms]
[   58.251297] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT_UNATTACHED->SNK_UNATTACHED
[   58.269076] JDB: tcpm_state_machine_work state chage:
SNK_UNATTACHED->TOGGLING
[   58.276789] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   58.323506] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   58.527310] JDB: state change SRC_ATTACH_WAIT -> SRC_ATTACHED
[delayed 200 ms]
[   58.527788] JDB: hub_usb_role_switch_set switching to ROLE_HOST!
[   58.541555] usb usb1-port1: disabled by hub (EMI?), re-enabling...
[   58.548654] usb 1-1: USB disconnect, device number 2
[   58.554077] usb 1-1.5: USB disconnect, device number 3
[   58.560133] JDB: rt1711h_set_vbus  source: 1 sink: 0
[   58.565377] JDB: rt1711h_set_vbus enabling regulator!
[   58.570495] type-c-vbus-current-regulator:  being enabled! JDB!
[   58.586202] type-c-vbus-current-regulator:  enabled successfully?! JDB!
[   58.602350] rt1711h_set_vbus: vbus := On
[   58.602354] rt1711h_set_vbus: charge is already Off
[   58.747321] usb 2-1: USB disconnect, device number 2
[   58.819706] JDB: tcpm_state_machine_work state chage:
SRC_ATTACHED->SRC_ATTACHED
[   58.871270] usb 1-1: new high-speed USB device number 4 using xhci-hcd
[   59.030402] usb 1-1: New USB device found, idVendor=2109,
idProduct=2813, bcdDevice=90.11
[   59.038677] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   59.045881] usb 1-1: Product: USB2.0 Hub
[   59.049838] usb 1-1: Manufacturer: VIA Labs, Inc.
[   59.104926] hub 1-1:1.0: USB hub found
[   59.109112] hub 1-1:1.0: 4 ports detected
[   59.327259] JDB: state change SRC_ATTACHED -> SRC_UNATTACHED [delayed 480 ms]
[   59.327710] JDB: rt1711h_set_vbus  source: 0 sink: 0
[   59.340022] JDB: rt1711h_set_vbus disabling regulator!
[   59.345296] type-c-vbus-current-regulator:  disabled successfully?!
JDB! (ret=0)
[   59.353458] rt1711h_set_vbus: vbus := Off
[   59.353465] rt1711h_set_vbus: charge is already Off
[   59.483278] usb 1-1.1: new low-speed USB device number 5 using xhci-hcd
[   59.571494] JDB: hub_usb_role_switch_set switching to ROLE_NONE!
[   59.577810] usb 1-1: USB disconnect, device number 4
[   59.586675] JDB: tcpm_state_machine_work state chage:
SRC_UNATTACHED->TOGGLING
[   59.593896] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   59.600757] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   59.627362] usb 1-1.1: Device not responding to setup address.
[   59.661413] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   59.839438] usb 1-1.1: Device not responding to setup address.
[   59.863252] JDB: state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[   59.863428] JDB: tcpm_state_machine_work state chage: SNK_TRY->SNK_TRY
[   59.967359] JDB: state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
[   59.967383] JDB: tcpm_state_machine_work state chage:
SNK_TRY_WAIT->SRC_TRYWAIT
[   59.981452] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT->SRC_TRYWAIT
[   60.051272] usb 1-1.1: device not accepting address 5, error -71
[   60.083337] JDB: state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED
[delayed 100 ms]
[   60.083365] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT_UNATTACHED->SNK_UNATTACHED
[   60.101151] JDB: tcpm_state_machine_work state chage:
SNK_UNATTACHED->TOGGLING
[   60.108462] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   60.155642] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   60.183338] usb 2-1: new SuperSpeed Gen 1 USB device number 3 using xhci-hcd
[   60.207782] usb 1-1-port1: attempt power cycle
[   60.212603] usb 2-1: New USB device found, idVendor=0424,
idProduct=5734, bcdDevice= 2.02
[   60.220923] usb 2-1: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[   60.228147] usb 2-1: Product: USB5734
[   60.231883] usb 2-1: Manufacturer: Microchip Tech
[   60.256450] hub 2-1:1.0: USB hub found
[   60.260360] hub 2-1:1.0: 5 ports detected
[   60.359385] JDB: state change SRC_ATTACH_WAIT -> SRC_ATTACHED
[delayed 200 ms]
[   60.359853] JDB: hub_usb_role_switch_set switching to ROLE_HOST!
[   60.374310] JDB: rt1711h_set_vbus  source: 1 sink: 0
[   60.379386] JDB: rt1711h_set_vbus enabling regulator!
[   60.384485] type-c-vbus-current-regulator:  being enabled! JDB!
[   60.390552] hub 2-1:1.0: hub_ext_port_status failed (err = -71)
[   60.396544] type-c-vbus-current-regulator:  enabled successfully?! JDB!
[   60.403538] usb 2-1: Failed to suspend device, error -71
[   60.403694] usb 2-1: USB disconnect, device number 3
[   60.413841] rt1711h_set_vbus: vbus := On
[   60.413844] rt1711h_set_vbus: charge is already Off
[   60.631357] JDB: tcpm_state_machine_work state chage:
SRC_ATTACHED->SRC_ATTACHED
[   60.815285] usb 1-1: new high-speed USB device number 9 using xhci-hcd
[   60.969662] usb 1-1: New USB device found, idVendor=2109,
idProduct=2813, bcdDevice=90.11
[   60.977964] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   60.985156] usb 1-1: Product: USB2.0 Hub
[   60.989419] usb 1-1: Manufacturer: VIA Labs, Inc.
[   61.056894] hub 1-1:1.0: USB hub found
[   61.061194] hub 1-1:1.0: 4 ports detected
[   61.119310] JDB: state change SRC_ATTACHED -> SRC_UNATTACHED [delayed 480 ms]
[   61.119759] JDB: rt1711h_set_vbus  source: 0 sink: 0
[   61.131951] JDB: rt1711h_set_vbus disabling regulator!
[   61.137141] type-c-vbus-current-regulator:  disabled successfully?!
JDB! (ret=0)
[   61.145007] rt1711h_set_vbus: vbus := Off
[   61.145010] rt1711h_set_vbus: charge is already Off
[   61.362956] JDB: hub_usb_role_switch_set switching to ROLE_NONE!
[   61.374082] usb 1-1: USB disconnect, device number 9
[   61.380600] JDB: tcpm_state_machine_work state chage:
SRC_UNATTACHED->TOGGLING
[   61.390394] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   61.397257] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   61.419292] usb 1-1.1: new low-speed USB device number 10 using xhci-hcd
[   61.427378] usb 1-1-port1: attempt power cycle
[   61.452874] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   61.655250] JDB: state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[   61.655398] JDB: tcpm_state_machine_work state chage: SNK_TRY->SNK_TRY
[   61.723383] usb 2-1: new SuperSpeed Gen 1 USB device number 4 using xhci-hcd
[   61.748163] usb 2-1: New USB device found, idVendor=0424,
idProduct=5734, bcdDevice= 2.02
[   61.757846] usb 2-1: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[   61.763291] JDB: state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
[   61.763317] JDB: tcpm_state_machine_work state chage:
SNK_TRY_WAIT->SRC_TRYWAIT
[   61.766781] usb 2-1: Product: USB5734
[   61.782560] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT->SRC_TRYWAIT
[   61.790221] usb 2-1: Manufacturer: Microchip Tech
[   61.824476] hub 2-1:1.0: USB hub found
[   61.828701] hub 2-1:1.0: 5 ports detected
[   61.883350] JDB: state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED
[delayed 100 ms]
[   61.883378] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT_UNATTACHED->SNK_UNATTACHED
[   61.901040] JDB: tcpm_state_machine_work state chage:
SNK_UNATTACHED->TOGGLING
[   61.909513] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   61.955483] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   62.035296] usb 1-1: new high-speed USB device number 14 using xhci-hcd
[   62.159263] JDB: state change SRC_ATTACH_WAIT -> SRC_ATTACHED
[delayed 200 ms]
[   62.159750] JDB: hub_usb_role_switch_set switching to ROLE_HOST!
[   62.174502] JDB: rt1711h_set_vbus  source: 1 sink: 0
[   62.179534] JDB: rt1711h_set_vbus enabling regulator!
[   62.185067] type-c-vbus-current-regulator:  being enabled! JDB!
[   62.191039] type-c-vbus-current-regulator:  enabled successfully?! JDB!
[   62.198180] usb 1-1: device descriptor read/all, error -71
[   62.203769] rt1711h_set_vbus: vbus := On
[   62.203775] rt1711h_set_vbus: charge is already Off
[   62.351356] usb 2-1: USB disconnect, device number 4
[   62.421558] JDB: tcpm_state_machine_work state chage:
SRC_ATTACHED->SRC_ATTACHED
[   62.543282] usb 1-1: new high-speed USB device number 15 using xhci-hcd
[   62.696916] usb 1-1: New USB device found, idVendor=2109,
idProduct=2813, bcdDevice=90.11
[   62.705142] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   62.712616] usb 1-1: Product: USB2.0 Hub
[   62.716595] usb 1-1: Manufacturer: VIA Labs, Inc.
[   62.784743] hub 1-1:1.0: USB hub found
[   62.788841] hub 1-1:1.0: 4 ports detected
[   62.911249] JDB: state change SRC_ATTACHED -> SRC_UNATTACHED [delayed 480 ms]
[   62.911598] JDB: rt1711h_set_vbus  source: 0 sink: 0
[   62.923769] JDB: rt1711h_set_vbus disabling regulator!
[   62.928940] type-c-vbus-current-regulator:  disabled successfully?!
JDB! (ret=0)
[   62.936711] rt1711h_set_vbus: vbus := Off
[   62.936714] rt1711h_set_vbus: charge is already Off
[   63.143272] usb 1-1.1: new low-speed USB device number 16 using xhci-hcd
[   63.154684] JDB: hub_usb_role_switch_set switching to ROLE_NONE!
[   63.160941] usb 1-1-port1: cannot reset (err = -71)
[   63.161185] usb 1-1: USB disconnect, device number 15
[   63.171398] JDB: tcpm_state_machine_work state chage:
SRC_UNATTACHED->TOGGLING
[   63.175823] usb 1-1-port1: attempt power cycle
[   63.181995] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   63.182155] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   63.244450] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   63.447246] JDB: state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[   63.447391] JDB: tcpm_state_machine_work state chage: SNK_TRY->SNK_TRY
[   63.507335] usb 2-1: new SuperSpeed Gen 1 USB device number 5 using xhci-hcd
[   63.532130] usb 2-1: New USB device found, idVendor=0424,
idProduct=5734, bcdDevice= 2.02
[   63.542169] usb 2-1: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[   63.549402] usb 2-1: Product: USB5734
[   63.551286] JDB: state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
[   63.551313] JDB: tcpm_state_machine_work state chage:
SNK_TRY_WAIT->SRC_TRYWAIT
[   63.554868] usb 2-1: Manufacturer: Microchip Tech
[   63.571708] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT->SRC_TRYWAIT
[   63.600310] hub 2-1:1.0: USB hub found
[   63.604194] hub 2-1:1.0: 5 ports detected
[   63.675303] JDB: state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED
[delayed 100 ms]
[   63.675331] JDB: tcpm_state_machine_work state chage:
SRC_TRYWAIT_UNATTACHED->SNK_UNATTACHED
[   63.693027] JDB: tcpm_state_machine_work state chage:
SNK_UNATTACHED->TOGGLING
[   63.701676] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   63.747517] JDB: tcpm_state_machine_work state chage:
SRC_ATTACH_WAIT->SRC_ATTACH_WAIT
[   63.827281] usb 1-1: new high-speed USB device number 20 using xhci-hcd
[   63.941498] JDB: tcpm_state_machine_work state chage:
SRC_UNATTACHED->TOGGLING
[   63.948872] JDB: tcpm_state_machine_work state chage: TOGGLING->TOGGLING
[   63.979728] usb 1-1: New USB device found, idVendor=0424,
idProduct=2734, bcdDevice= 2.02
[   63.988033] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   63.995636] usb 1-1: Product: USB2734
[   63.999540] usb 1-1: Manufacturer: Microchip Tech
[   64.064532] hub 1-1:1.0: USB hub found
[   64.068557] hub 1-1:1.0: 5 ports detected
[   64.415290] usb 1-1.5: new high-speed USB device number 21 using xhci-hcd
[   64.520307] usb 1-1.5: New USB device found, idVendor=0424,
idProduct=2740, bcdDevice= 2.00
[   64.528969] usb 1-1.5: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[   64.536345] usb 1-1.5: Product: Hub Controller
[   64.540828] usb 1-1.5: Manufacturer: Microchip Tech
