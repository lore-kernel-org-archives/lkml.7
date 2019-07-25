Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A26C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E58B21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv/6STrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfGYRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:33:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45009 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfGYRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:33:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so23073240pfe.11;
        Thu, 25 Jul 2019 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrodkBeX5Mf5TFe6lBwszo2RsWN3uHi/lpV1v4j+mhI=;
        b=Gv/6STrQ9TKKjlPd+/E/QocW4XnPqBjwfTH/dOvH6OC9gCuzyq2k6LYeKmdaDs0ek+
         tpV3iP+xgP3Bzfu5qLtrrGcjxhhrMl5S2IExQg1JOM4p521B1gYduTmhHklGYNfXNjKZ
         lvBsCW8APOt5Vd1L+wT5Lm7TFs1smC/nVWCL/+yWKFt54K2IyDFkAx8zjTZvB254JvYz
         e/IwXtdy1INuBU1Z8PlVibWue1WMtf0mcf4Iv/LFfBUkkSG5Q8S6pmiOArLZGIansQzD
         N0/S82+PDfqRLdaARbPZHbK+3plyxg6zViEB64gHWFZTKvGkGIhE2yp+OuM1uFBFr/YM
         jhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrodkBeX5Mf5TFe6lBwszo2RsWN3uHi/lpV1v4j+mhI=;
        b=bU4PbV6JiFyt6i1Pg+VQ5yBBcrOeDsFIEWcKV0RuaoGXGpGaURqjhrLnnlm7lKc/vV
         TvAFDeC6om9gjoFORB1WkicuouHaRJTs0otpdwdnJIXRXecQHDTW8NgsqX0WoapNjiui
         Fd8SP2rRUI1j6a1KdxDROlgiA5RHiLg4qeb89PaQeSyprxhSTH77oAChxAd36BI4ot3T
         BZofVkvNccZ2EYoL0N6M6t427bpA/1VbAzzN7L03XAri6ZREI/cBVB4ykATt+g+oOXyH
         pE2xUlF6Q2PdlGn0kearyZ91azmPGC/gb5M+Wn1z4e4X6LAbRYzYa93Iz8rsp3o9w+j6
         4GhQ==
X-Gm-Message-State: APjAAAX6M4bNb6Imo7/h/teirgoG3nydZnpRhYS7nt5qNZi9lLh63hc/
        mCrJZ8zsBZF3johyOkWWml6Xf6OeSGrMxRRgU9eu2tdM
X-Google-Smtp-Source: APXvYqxUnpV7tsdC+Z/xev0yzqymTMPHHNJdKz8TMYjIcaz6enwJLIZ5/EyLf9EES/OiHz1dxL+fV9wGMJXNT7GT1dU=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr12150114pgc.74.1564076016793;
 Thu, 25 Jul 2019 10:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:33:25 +0300
Message-ID: <CAHp75VdKCms0ZsqCcq2wWaMFYE3G+kT8FFDQuw=CZKeyDov8pg@mail.gmail.com>
Subject: Re: [RFC 0/9] platform/x86: Huawei WMI laptop extras driver
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 8:41 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This patch series introduce changes to huawei-wmi driver that includes:
> * Move to platform driver
> * Implement WMI management interface
> * Add micmute LED support through WMI
> * Add battery charging protection support through WMI
> * Add fn-lock support through WMI
> * Implement driver quirks and parameters
> * Add a debugfs interface to WMI
>
> # Move to platform driver
>
> The current driver offers hotkeys and micmute led support only. With
> these changes, a platform driver makes more sense since it handles these
> changes pretty nicely.
>
> # Implement WMI management interface
>
> Huawei Matebook laptops come with two WMI interfaces. The first being
> WMI0 which is considered "legacy" and AFAIK only found on the Matebook X
> released in 2017. The second has a UID of "HWMI" and is found in pretty
> much all models with a slight difference in implementation except for
> the Matebook X (2017). Since this model has two interfaces, some aspects
> are controlled through the legacy interface and some through the other
> interface. Currently, the legacy interface is not fully implemented and
> is only used for hotkeys and further debugging has to be done.
>
> The WMI interface takes a 64 bit integer, although uses 32 bits most of
> the time, and returns a 256-260 bytes buffer consists of either one ACPI
> buffer of 260 bytes, in the case of Matebook X (2017), or one ACPI
> package of two buffers, one with 4 bytes, and the other with 256 bytes.
> We only care about the latter 256 buffer in both cases since the 4 bytes
> always return zeros. The first byte of this 256 buffer always has the
> return status where 1 indicated error. Some models require calling the
> WMI interface twice to execute a command.
>
> # Add micmute LED support through WMI
>
> After implementing the WMI interface, micmute LED can be controlled
> easily. Models with the legacy interface fall back to ACPI EC method
> control since the legacy interface is not implemented.
>
> # Add battery charging protection support through WMI
>
> Most models, that has the WMI interface, are capable of battery
> protection where it can control battery charging thresholds and limits
> charging the battery to certain values.
>
> # Add fn-lock support through WMI
>
> The behavior of hotkeys is not the same among all models. Some models
> require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. By default,
> hotkeys behave as special keys (media keys, Ins, etc), but if a modifier
> is used (ctrl, alt, shift) these keys behave as F1-F12 keys. If the Fn
> key is toggled on, the hotkeys with or without a modifier, behave as
> F1-F12 keys. This makes it impossible to use a modifier and `PrtSc` or
> `Ins`.
>
> Now, some models fix this by excluding `PrtSc` and `Ins` keys from being
> treated as F11 and F12 keys with the use of a modifier. However, some
> models do not, and fixes this by the so called fn-lock.
>
> Fn-lock inverts the behavior of the top row from special keys to F1-F12
> keys. So a modifier and a special key would be possible which make
> things like `Alt-Ins` possible. Now, with fn-lock we would have 4 modes:
>
> * Fn-key off & fn-lock off - hotkeys treated as special keys using a
>   modifier gives F1-F12 keys.
> * Fn-key on & fn-lock off - hotkeys treated as F1-F12 keys and using a
>   modifier gives F1-F12.
> * Fn-key off & fn-lock on - hotkeys are treated as F1-F12 keys and using
>   a modifier gives special keys.
> * Fn-key on & fn-lock on - hotkeys are treated as special keys and using
>   a modifier gives special keys.
>
> # Implement driver quirks and parameters
>
> The driver introduces 3 quirks and 2 parameters that can change the
> driver's behavior. These quirks being as:
> 1. Fixes reporting brightness keys twice since it's already handled by
>    acpi-video.
> 2. Some models need a short delay when setting battery thresholds to
>    prevent a race condition when two processes read/write.
> 3. Matebook X (2017) handles micmute led through the "legacy" interface
>    which is not currently implemented. Use ACPI EC method to control
>    this led.
>
> and the 2 parameters can enforce the behavior of quirk 1 & 2.
>
> # Add a debugfs interface to WMI
>
> An interface to the WMI management interface that allows easier
> debugging.
>

It doesn't apply to current for-next.

> Ayman Bagabas (9):
>   platform/x86: huawei-wmi: rename guid and driver name
>   platform/x86: huawei-wmi: move to platform driver
>   platform/x86: huawei-wmi: implement huawei wmi management interface
>   platform/x86: huawei-wmi: add quirks and module parameters
>   platform/x86: huawei-wmi: control micmute led through wmi interface
>   platform/x86: huawei-wmi: add battery charging thresholds
>   platform/x86: huawei-wmi: add fn-lock support
>   platform/x86: huawei-wmi: add sysfs interface support
>   platform/x86: huawei-wmi: add debugfs support
>
>  drivers/platform/x86/huawei-wmi.c | 710 ++++++++++++++++++++++++++----
>  1 file changed, 629 insertions(+), 81 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
