Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F3AC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77349214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDGWyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:54:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35596 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:54:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so4569696qte.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=SsDVxqDhkwLEE2AZhZkoAcUUPVIkwXJNR2YROTDG3yE=;
        b=UvVSi1wnoDcKltwqvrSMibP7xv7InlLP0cppyvfxhWBz45fRf95ejgr/8s8dPMM5vm
         jLJbuh+vgRj281Yrn9oPF/P7Cl961j2kdUtApYXUXWbadMm3KXZe5HV1VzP+M1Rm0wVn
         T7YcB427cZx0DSXB7KM2JKA5PqzP5TIHqaKFpr7j9AQeYig3R1CTRx1HVyJhB38Ljgv1
         TIlFSHAf+Vc8KIVwW/Ry5JttjGhDwFyzNpRAbEBAQonQwfIwubJzPsLNZtfhvHFIje8+
         3tBcURuBQnuq41Wui/Gmuias38lNwZyWVlhLz67gJburmiWOOc9xniEmRDcnLKoxw/DD
         jk0A==
X-Gm-Message-State: APjAAAVRLx7Xlkt0J6AJhoSemXIkWIamTBNKJHJFomIk4UxblReImmOr
        DXrwStxMj3zcFZusM9fgQNx49w==
X-Google-Smtp-Source: APXvYqwV8xQc+Ge4drN2l6/HZBUYSYd7YXqBViz0RIDfAu8kCHn5Pt4zS4EuHctUknmRyVVGkU+QVA==
X-Received: by 2002:a0c:a8e7:: with SMTP id h39mr20766469qvc.34.1554677684129;
        Sun, 07 Apr 2019 15:54:44 -0700 (PDT)
Received: from malachite.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id i33sm16802565qtb.64.2019.04.07.15.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:54:43 -0700 (PDT)
Message-ID: <0ac9aef48f4cf974f4f7046aad1267ab5c8fe525.camel@redhat.com>
Subject: Re: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer
 Blade Stealth
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 07 Apr 2019 18:54:42 -0400
In-Reply-To: <20190407221034.GA162359@dtor-ws>
References: <20190407213735.10658-1-lyude@redhat.com>
         <20190407221034.GA162359@dtor-ws>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-04-07 at 15:10 -0700, Dmitry Torokhov wrote:
> Hi Lyude,
> 
> On Sun, Apr 07, 2019 at 05:37:34PM -0400, Lyude Paul wrote:
> > The late 2016 model of the Razer Blade Stealth has a built-in USB
> > keyboard, but for some reason the BIOS exposes an i8042 controller with
> > a connected KBD port. While this fake AT Keyboard device doesn't appear
> > to report any events, attempting to change the state of the caps lock
> > LED on it from on to off causes the entire system to hang.
> > 
> > So, introduce a quirk table for disabling keyboard probing by default,
> > i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
> > that table.
> 
> What does dmesg show about i8042 for this device? Especially line "PNP:
> PS/2 Controller  ..."?
> 

Apr 07 18:42:46 malachite kernel: i8042: PNP: No PS/2 controller found.
Apr 07 18:42:46 malachite kernel: i8042: Probing ports directly.
Apr 07 18:42:46 malachite kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 07 18:42:46 malachite kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 07 18:42:46 malachite kernel: mousedev: PS/2 mouse device common for all
mice
Apr 07 18:42:46 malachite kernel: rtc_cmos 00:01: RTC can wake from S4
Apr 07 18:42:46 malachite kernel: rtc_cmos 00:01: registered as rtc0
Apr 07 18:42:46 malachite kernel: rtc_cmos 00:01: alarms up to one month, y3k,
242 bytes nvram, hpet irqs
Apr 07 18:42:46 malachite kernel: device-mapper: uevent: version 1.0.3
Apr 07 18:42:46 malachite kernel: device-mapper: ioctl: 4.39.0-ioctl (2018-04-
03) initialised: dm-devel@redhat.com
Apr 07 18:42:46 malachite kernel: intel_pstate: Intel P-state driver
initializing
Apr 07 18:42:46 malachite kernel: intel_pstate: HWP enabled
Apr 07 18:42:46 malachite kernel: hidraw: raw HID events driver (C) Jiri
Kosina
Apr 07 18:42:46 malachite kernel: usbcore: registered new interface driver
usbhid
Apr 07 18:42:46 malachite kernel: usbhid: USB HID core driver
Apr 07 18:42:46 malachite kernel: intel_pmc_core:  initialized
Apr 07 18:42:46 malachite kernel: drop_monitor: Initializing network drop
monitor service
Apr 07 18:42:46 malachite kernel: Initializing XFRM netlink socket
Apr 07 18:42:46 malachite kernel: NET: Registered protocol family 10
Apr 07 18:42:46 malachite kernel: Segment Routing with IPv6
Apr 07 18:42:46 malachite kernel: mip6: Mobile IPv6
Apr 07 18:42:46 malachite kernel: NET: Registered protocol family 17
Apr 07 18:42:46 malachite kernel: RAS: Correctable Errors collector
initialized.
Apr 07 18:42:46 malachite kernel: microcode: sig=0x806e9, pf=0x80,
revision=0x8e
Apr 07 18:42:46 malachite kernel: microcode: Microcode Update Driver: v2.2.
Apr 07 18:42:46 malachite kernel: AVX2 version of gcm_enc/dec engaged.
Apr 07 18:42:46 malachite kernel: AES CTR mode by8 optimization enabled
Apr 07 18:42:46 malachite kernel: battery: ACPI: Battery Slot [BAT0] (battery
present)
Apr 07 18:42:46 malachite kernel: sched_clock: Marking stable (1166896928,
-586991)->(1172494398, -6184461)
Apr 07 18:42:46 malachite kernel: registered taskstats version 1
Apr 07 18:42:46 malachite kernel: Loading compiled-in X.509 certificates
Apr 07 18:42:46 malachite kernel: Loaded X.509 cert 'Fedora kernel signing
key: eb55b2be431426c78789899a96d617d82132041e'
Apr 07 18:42:46 malachite kernel: zswap: loaded using pool lzo/zbud
Apr 07 18:42:46 malachite kernel: Key type big_key registered
Apr 07 18:42:46 malachite kernel: Key type encrypted registered
Apr 07 18:42:46 malachite kernel: integrity: Loading X.509 certificate:
UEFI:db
Apr 07 18:42:46 malachite kernel: integrity: Loaded X.509 cert 'Microsoft
Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
Apr 07 18:42:46 malachite kernel: integrity: Loading X.509 certificate:
UEFI:db
Apr 07 18:42:46 malachite kernel: integrity: Loaded X.509 cert 'Microsoft
Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
Apr 07 18:42:46 malachite kernel: ima: Allocated hash algorithm: sha1
Apr 07 18:42:46 malachite kernel: input: AT Raw Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4

Also: After doing a bit more research on wikipedia I just noticed that
this laptop is actually a late 2017 model, so I'll respond with a respun
patch in just a sec.

> Thanks.
> 
-- 
Cheers,
	Lyude Paul

