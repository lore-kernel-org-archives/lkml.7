Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3CCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900FA2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv1xUhp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDJULl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:11:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:11:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so3959212wmf.2;
        Wed, 10 Apr 2019 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4WefY8iGSgn8xy1IHjdrCO8EubRJBr1ynHyrWGdAVJc=;
        b=Gv1xUhp7gOYdwOGzseSNnTD25LG0t1eSmALt6uqmvT6TX9IR6BKF8SCyge2Bc4Yl58
         8f6KTDBqbZi7Buq3zL+Ku0MAThPqcDe9NvYxYSwm5JUj/uJmu6TBhRKCBKGHdd4jIrAn
         tABSqfDxULTs1qLOsN3dZOoMigBKis+IpdpSVZQtAP3VqlDMNQDY+zOjoxnRxSzrRhEC
         +Nd6j4ZLmI9nE2yM2iiVdOMghSBXRlxM3gWB1u1HWofJq5N0zIjS26kRDu6b6zTQB9b4
         mI/tj/pa2zL1t4gEU+EqSRzImEcF84ada5mKG75yGgrvbW+I7O1QUO5VxeJ1FZ6wm31+
         uZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4WefY8iGSgn8xy1IHjdrCO8EubRJBr1ynHyrWGdAVJc=;
        b=BoPK2n1lVvq/qRvBfRD9auWzYKwis9YXs+j7pV8oRMf8CMQUSJW+h1Ov35qkcLGbSs
         I4kuDS8PjfOCnPhd9lcs2500l5onLl4kYNorZ57CdBPfeTc5V4h+I6QxOJ13Jz3/Vcd+
         XKJXx2oPJRrMUOIY2+kuivkcYpwbvZnDdK4gVjiwsiR8Q2f47KM7ZoJHRhE/DffPsnhv
         3U1BemPfCwBVb5oZclDk2b1A49/VWQZmwWnatqWsQlmJ4kPUL1io9tBYRvYpTqdvb80Q
         7Vgx+V8kzw+U1eyP65W+g+GRH6HFWDKLBySEK4IRvzYjAEiQAwrSVnc2xPTy1OhaxmIF
         zFMw==
X-Gm-Message-State: APjAAAVUX64zWN1ZH8BU42XM1ysZpe3xBuoJ9APHZyp2GYdNcKcfxQRc
        /4xGHS9cKHAHSXfoL6y49Bw/fNuunSU=
X-Google-Smtp-Source: APXvYqyO8NaDe6BTBh1tFfv+Ohbd/iqaZehLpg8JT4gT570yWrbg5qU5pBelDmLnUmLbnYgf+aoacQ==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr3786980wmh.13.1554927097033;
        Wed, 10 Apr 2019 13:11:37 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id r196sm4342023wmf.22.2019.04.10.13.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:11:36 -0700 (PDT)
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Subject: [PATCH 00/11] asus-wmi: Support of ASUS TUF Gaming series laptops
Message-ID: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Date:   Wed, 10 Apr 2019 22:11:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm new to kernel development, so first I would like to apologize in
advance for any mistakes.

The support for this laptop series is currently non-existent, as the
asus-nb-wmi driver (which is essentially configuration for asus-wmi) fails
to load and multiple ACPI errors are logged in dmesg. This patch series
adds pretty comprehenisve support for these relatively new laptops, adds
some code organization, and fixes couple of bugs in the asus-wmi module.

I have FX565GM (FX505GM) model, but I would guess that the same will
likely apply to the complete FX505 / FX705 series. I've also tested 
this on an older K54C model to ensure that it doesn't break support.
Unfortunately I don't have capacity to test this on more devices.

The patches 1 and 2 are pure bug fixes, but I can not measure relevance
for stable.

OVERALL DESIGN DECISIONS
Besides this patch, I've written experimental separate driver [1] for this
series to make it usable on my system as a DKMS module for 4.18 kernel for
the time being. One might wonder if it is more reasonable to make a new
independent module. The things to consider are that: asus-nb-wmi is
currently loaded by the WMI GUID alias, whereas the original ASUS driver
does check for the ASUS7000 device in ACPI. One should then choose
appropriate base driver instead of asus-wmi when asus-nb-wmi is loaded,
about third of the code gets duplicated in this case and the whole ends up
ugly.

Another question, does it make sense to embed RGB keyboard backlight
support in kernel code? There was discussion [2] about exposing WMI to the
userspace. The same would apply for the fan boost mode support. As I
understand as of yet it is still preferrable to support hardware features
in kernel.

NOTE ON HWMON
One open issue with the result is that hwmon device gets loaded anyway,
but it does not do anything noticeable. The heavily reduced code for the
MFUN is present in DSDT, but it either really does nothing or possibly
call something unnoticeable via DMA.

I've managed to detect that thermal sensor is not present, but the MFUN
for read fan speed does return 0 and not an error. Taking this as 
condition for disabling hwmon might intermittently break some existing
devices if the RPM is really 0 (no idea if that is really possible). One
might ponder on the better way to detect the presence of manual fan
control.

NOTE ON QUIRKS
I would speculate that the queue might be really present in many more
devices, it just didn't get noticed. Anyway after this is merged one might
consider if it is reasonable to enable it always and fallback if flush
fails. The patch does enable the new quirks only for very new models.

Regarding the DSTS force quirk, as I understand the underlying issue is a
workaround for EEEPC devices and use of DSTS is more conventional. It
might be reasonable to find a way to detect specific DSTS device ID that
is present on EEEPC instead, apply same ACPI device detection approach or
just duplicate the relevant method calls. I don't have access to such
device or it's DSDT and can't evaluate any of these options myself.

NOTE ON KEYBOARD BACKLIGHT
When the keyboard backlight is set via 0x50021 DEVID the brightness drops
slightly compared to brightness after boot. I did not found any way to
revert this. The method does set some bit in EC RAM, but this address is
not used anywhere else.  Unfortunately I wiped original OS after two hours
after unpacking.If someone can verify whether it is identical to behavior
of the vendor driver it would be appreciated.

NOTE ON UPOWER DAEMON
If you're testing with GNOME, notice that UPower does hang pretty badly if
the module is removed at runtime at least on my device. Stop it with
'systemctl stop upower' before removing the module and then restart it
again.

[1] https://github.com/hackbnw/faustus
[2] https://lwn.net/Articles/725725/

Yurii Pavlovskyi (11):
  platform/x86: asus-wmi: Fix hwmon device cleanup
  platform/x86: asus-wmi: Fix preserving keyboard backlight intensity on
    load
  platform/x86: asus-wmi: Increase input buffer size of WMI methods
  platform/x86: asus-wmi: Add quirk to force DSTS WMI method detection
  platform/x86: asus-wmi: Support queued WMI event codes
  platform/x86: asus-nb-wmi: Add microphone mute key code
  platform/x86: asus-wmi: Organize code into sections
  platform/x86: asus-wmi: Enhance detection of thermal data
  platform/x86: asus-wmi: Control RGB keyboard backlight
  platform/x86: asus-wmi: Switch fan boost mode
  platform/x86: asus-wmi: Do not disable keyboard backlight on unload

 .../ABI/testing/sysfs-platform-asus-wmi       |  71 ++
 drivers/platform/x86/asus-nb-wmi.c            |   9 +-
 drivers/platform/x86/asus-wmi.c               | 755 +++++++++++++++---
 drivers/platform/x86/asus-wmi.h               |   7 +
 include/linux/platform_data/x86/asus-wmi.h    |   3 +
 5 files changed, 742 insertions(+), 103 deletions(-)

-- 
2.17.1

