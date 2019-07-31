Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE597C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977E22067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5AKCIfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGaBBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:01:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39697 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfGaBBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:01:11 -0400
Received: by mail-vs1-f66.google.com with SMTP id u3so44974211vsh.6;
        Tue, 30 Jul 2019 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2DpG6Pls3sGs33c/51s1e3Ae1XsBxNxwDLzXf7kXUSw=;
        b=X5AKCIfn/GgIafPTqFsTAmeHOet9XvUPazV0LfFodfaDqzPCZGY/UWHCsBwAam4fE8
         IbfWXTJwSZS3aMXRaGig1X1xjsFFHIw/IuUX3T0MNQWKMtgaxTvqSfuUcQHzPPHgVfTK
         TD6/3uKtQNvR/uK5ulqdVqJCFnnSsiHW3xZHZMdJc1zDgE279X3WDdFWdo6RMFv+qDCB
         ZJNv6uwQh0hxSOsC4GMGBa4iqG9XrnZH8ScIcZYDOjiqab9BINv20cw4pJntspmVjp5F
         mThxZLhY2YRtwpvP4cy8PfjyLp3a8rXqw1df3y3LA1BnuLBF0qivvcI098ilpmLttQDV
         Fw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2DpG6Pls3sGs33c/51s1e3Ae1XsBxNxwDLzXf7kXUSw=;
        b=d8o3AKPl5EKFgVvLIyw3rgXmZYpN+OfVdx0NGaJ08EkPCZQy1BJ/hTNNCmeIwF+5pe
         /r8LzfU5AW8/RGjrN/X7ybjRvY1DB9VTFqh+V0FBX8KbXGKynOnIzOH5izLICgxZU446
         sVLkNvGMUTC+s1O/fK4hGOaa2UAERThctfr2Nr41DRARAjZSZ5G4KP/UHCvKxDNLKwes
         Ew7LpuzYocW/Mk7j7BYIt7CVtFWBPKdJBNXGnaF92MbURQuypNAjWvSIIfZ1JYT8dIl3
         kJbyk/usKOW3d6B1k0GiqgHZhYJSM2wjV002PzVJtM/N3zXMv9tRPLSddGxpIHXfIVLr
         b5LA==
X-Gm-Message-State: APjAAAW078SFv7Us4GpGNW6ruRj9KO/8+NfBpJa53DEEIFU9r1NhsLMc
        mWJ5J8lSkzQy4UfZtEaslA==
X-Google-Smtp-Source: APXvYqyR23c8oTFPsWQScFifTuy5rluSAcnBQlOPX47GHA0PP0bgQUg91j6rFFWzNT7Xq4CfyxNhjw==
X-Received: by 2002:a67:d993:: with SMTP id u19mr81057784vsj.0.1564534869745;
        Tue, 30 Jul 2019 18:01:09 -0700 (PDT)
Received: from localhost ([2601:900:8200:a529::f9b4])
        by smtp.gmail.com with ESMTPSA id n187sm66931526vkd.9.2019.07.30.18.01.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 18:01:08 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:01:07 -0400
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/9] platform/x86: Huawei WMI laptop extras driver
Message-ID: <20190731010107.oksopxcpe3y6t7su@960>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
 <CAHp75VdKCms0ZsqCcq2wWaMFYE3G+kT8FFDQuw=CZKeyDov8pg@mail.gmail.com>
 <20190725200509.snft3xy65ngaaxvs@960>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725200509.snft3xy65ngaaxvs@960>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/25 04:05PM, Ayman Bagabas wrote:
> On 19/07/25 08:33PM, Andy Shevchenko wrote:
> > On Sun, Jun 30, 2019 at 8:41 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
> > >
> > > This patch series introduce changes to huawei-wmi driver that includes:
> > > * Move to platform driver
> > > * Implement WMI management interface
> > > * Add micmute LED support through WMI
> > > * Add battery charging protection support through WMI
> > > * Add fn-lock support through WMI
> > > * Implement driver quirks and parameters
> > > * Add a debugfs interface to WMI
> > >
> > > # Move to platform driver
> > >
> > > The current driver offers hotkeys and micmute led support only. With
> > > these changes, a platform driver makes more sense since it handles these
> > > changes pretty nicely.
> > >
> > > # Implement WMI management interface
> > >
> > > Huawei Matebook laptops come with two WMI interfaces. The first being
> > > WMI0 which is considered "legacy" and AFAIK only found on the Matebook X
> > > released in 2017. The second has a UID of "HWMI" and is found in pretty
> > > much all models with a slight difference in implementation except for
> > > the Matebook X (2017). Since this model has two interfaces, some aspects
> > > are controlled through the legacy interface and some through the other
> > > interface. Currently, the legacy interface is not fully implemented and
> > > is only used for hotkeys and further debugging has to be done.
> > >
> > > The WMI interface takes a 64 bit integer, although uses 32 bits most of
> > > the time, and returns a 256-260 bytes buffer consists of either one ACPI
> > > buffer of 260 bytes, in the case of Matebook X (2017), or one ACPI
> > > package of two buffers, one with 4 bytes, and the other with 256 bytes.
> > > We only care about the latter 256 buffer in both cases since the 4 bytes
> > > always return zeros. The first byte of this 256 buffer always has the
> > > return status where 1 indicated error. Some models require calling the
> > > WMI interface twice to execute a command.
> > >
> > > # Add micmute LED support through WMI
> > >
> > > After implementing the WMI interface, micmute LED can be controlled
> > > easily. Models with the legacy interface fall back to ACPI EC method
> > > control since the legacy interface is not implemented.
> > >
> > > # Add battery charging protection support through WMI
> > >
> > > Most models, that has the WMI interface, are capable of battery
> > > protection where it can control battery charging thresholds and limits
> > > charging the battery to certain values.
> > >
> > > # Add fn-lock support through WMI
> > >
> > > The behavior of hotkeys is not the same among all models. Some models
> > > require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. By default,
> > > hotkeys behave as special keys (media keys, Ins, etc), but if a modifier
> > > is used (ctrl, alt, shift) these keys behave as F1-F12 keys. If the Fn
> > > key is toggled on, the hotkeys with or without a modifier, behave as
> > > F1-F12 keys. This makes it impossible to use a modifier and `PrtSc` or
> > > `Ins`.
> > >
> > > Now, some models fix this by excluding `PrtSc` and `Ins` keys from being
> > > treated as F11 and F12 keys with the use of a modifier. However, some
> > > models do not, and fixes this by the so called fn-lock.
> > >
> > > Fn-lock inverts the behavior of the top row from special keys to F1-F12
> > > keys. So a modifier and a special key would be possible which make
> > > things like `Alt-Ins` possible. Now, with fn-lock we would have 4 modes:
> > >
> > > * Fn-key off & fn-lock off - hotkeys treated as special keys using a
> > >   modifier gives F1-F12 keys.
> > > * Fn-key on & fn-lock off - hotkeys treated as F1-F12 keys and using a
> > >   modifier gives F1-F12.
> > > * Fn-key off & fn-lock on - hotkeys are treated as F1-F12 keys and using
> > >   a modifier gives special keys.
> > > * Fn-key on & fn-lock on - hotkeys are treated as special keys and using
> > >   a modifier gives special keys.
> > >
> > > # Implement driver quirks and parameters
> > >
> > > The driver introduces 3 quirks and 2 parameters that can change the
> > > driver's behavior. These quirks being as:
> > > 1. Fixes reporting brightness keys twice since it's already handled by
> > >    acpi-video.
> > > 2. Some models need a short delay when setting battery thresholds to
> > >    prevent a race condition when two processes read/write.
> > > 3. Matebook X (2017) handles micmute led through the "legacy" interface
> > >    which is not currently implemented. Use ACPI EC method to control
> > >    this led.
> > >
> > > and the 2 parameters can enforce the behavior of quirk 1 & 2.
> > >
> > > # Add a debugfs interface to WMI
> > >
> > > An interface to the WMI management interface that allows easier
> > > debugging.
> > >
> > 
> > It doesn't apply to current for-next.
> 
> Hey Andi,
I'm sorry, I meant Andy.
> 
> I was basing them on the stable branch.
> 
> It doesn't apply because of commit 440c4983de262f78033ec58f6abcd199a664327d
> (platform/x86: wmi: add context argument to the probe function)
> 
> One line change in huawei-wmi.c:
> -static int huawei_wmi_probe(struct wmi_device *wdev)
> +static int huawei_wmi_probe(struct wmi_device *wdev, const void *context)
> 
> I'll address that in the next version. For now, feedback is really
> appreciated.
> 
> > 
> > > Ayman Bagabas (9):
> > >   platform/x86: huawei-wmi: rename guid and driver name
> > >   platform/x86: huawei-wmi: move to platform driver
> > >   platform/x86: huawei-wmi: implement huawei wmi management interface
> > >   platform/x86: huawei-wmi: add quirks and module parameters
> > >   platform/x86: huawei-wmi: control micmute led through wmi interface
> > >   platform/x86: huawei-wmi: add battery charging thresholds
> > >   platform/x86: huawei-wmi: add fn-lock support
> > >   platform/x86: huawei-wmi: add sysfs interface support
> > >   platform/x86: huawei-wmi: add debugfs support
> > >
> > >  drivers/platform/x86/huawei-wmi.c | 710 ++++++++++++++++++++++++++----
> > >  1 file changed, 629 insertions(+), 81 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >
> > 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> 
> -- 
> Thank you,
> Ayman

-- 
Thank you,
Ayman
