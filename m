Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FFBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC76222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUa53n35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgAGReb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:34:31 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45339 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgAGReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:34:31 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so182771qvu.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQeEMT7Uz6T1uHjZZ7wDlx6MfkTw1Gqq50Vkv5c5Vi4=;
        b=RUa53n35Z9RAxRw9OT1anZmKVoVf0jBhXe8lwPDD3haYO4fFnvHnRdLMQrfeNjFMxZ
         XzrcVFGJF/YwbgmDVF5ezKa0wmekFrb/mCF8WVCoBmpZ8MftnQDm6JzCwy+NIujp878y
         CPyjCONQuSqCSFJXblxABSVYiAJWKoSPPSQ40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQeEMT7Uz6T1uHjZZ7wDlx6MfkTw1Gqq50Vkv5c5Vi4=;
        b=CIKKRTgQYkViEPf9pl5tYfi/pp00apaBjXEv3WirMzYw2IbrLXb4RLWMPLZ9qAEw3N
         6MNIz84NXTnJxOeGjvzMEdZjuVqJHlGk1WYG8BDvas4oG033clZCbJR01tvr0Awc7h4D
         x95tAx2GV5ZeIeBgcD5sQf15UKN0eAr5MfhPfqOMPF85oyZ1TUqr1g6VKVyNpp8e00r6
         3n51CIEe1DYmfY2NpzieSraICSA1ke9OqE3KbO7LJNc7o92zn+ZVvI73g+nysBhdeO94
         zVne2PQZQbK1bJZnNssv4bfqZuXRJgrPtgO5PxYGxMke4GKFIMdQVsO0F/Eu8F4TKERH
         a9/w==
X-Gm-Message-State: APjAAAXAR+zIkUonCvfzt9DKYjbw0ZPZcCoZoPKf1fHla0OnNtpHjbSH
        EsN+3vssfQtTYE2+E3Mozb2EbHAnv71UfdGVIViZvPjj
X-Google-Smtp-Source: APXvYqyDW/dUDmhEHj2/dPMxxsL95cfFYwqp441uPJd0ajaReD7DFo/Ee01NZikbU/snqc7YXa0vxbxX2lm2h/7uTjo=
X-Received: by 2002:a05:6214:192f:: with SMTP id es15mr470828qvb.219.1578418470131;
 Tue, 07 Jan 2020 09:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20191220193843.47182-1-pmalani@chromium.org> <20191220193843.47182-2-pmalani@chromium.org>
 <7eecafb2-4686-b448-2837-4181188365b1@collabora.com> <CACeCKadFKWUNHHT-vs686Sz2-CcD0kNeUgqkJT5Q2ATji4L58w@mail.gmail.com>
 <CACeCKadAJE-ayisXOib4ZV9_BDORp-dpoT_KSMnJj3Y30dF_6A@mail.gmail.com> <d825c0ec-8fbd-b23b-2125-bdfccb623dd7@collabora.com>
In-Reply-To: <d825c0ec-8fbd-b23b-2125-bdfccb623dd7@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 7 Jan 2020 09:34:19 -0800
Message-ID: <CACeCKaft-DHxjXf4JiEqi1Ptn5ctcV0f=zxWqWgYj7V59NGCNw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mfd: cros_ec: Add cros-usbpd-notify subdevice
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Jan 7, 2020 at 8:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 3/1/20 0:52, Prashant Malani wrote:
> > Hi Enric,
> >
> >>> Sorry to not catch this before, but a worry arose. Is non-ACPI platforms or
> >>> non-X86 platforms or on OF platforms?
> >>>
> >>> ARM64 for example has the CONFIG_ACPI symbol set to yes, with the below
> >>> condition condition will not work on Kevin for example and IIUC this is not what
> >>> we want, I think we want IS_ENABLED(CONFIG_OF)?
> >> Thanks for noting this. I will check with a kevin, and with the
> >> internal build flags to verify whether there are ARM64 which have the
> >> GOOG0003 PD notification device.
> >> I'll update this thread with my findings.
> > AFAICT from the Chrome OS kernel build step .config output, kevin
> > doesn't have CONFIG_ACPI enabled (it is marked as "# CONFIG_ACPI is
> > not set"), and it doesn't look like there are Chrome OS ARM devices
> > that use ACPI (I believe it's only used on Chrome OS x86-based
> > devices). So perhaps it is not a concern?
> >
>
> The problem is, although it is not used in your configs, it can be selected, and
> fwiw some defconfigs in mainline have it enabled, i.e the arm64 defconfig.
>
> I think you're testing the patch on x86 but I suspect we want also the notifier
> on some arm64 platforms (like kevin) right? In such case I won't get the
> notifier because CONFIG_OF and CONFIG_ACPI is enabled on my defconfig.
I tested the patchset on an arm64 platform and confirmed that
CONFIG_ACPI is enabled, but I suppose that is not a sufficient test
given that, as you mentioned, upstream configs like arm64 defconfig
have it enabled.
>
> My guess is that the logic should be if IS_ENABLED(CONFIG_OF) call
> cros_ec_check_features, otherwise ACPI will do the magic instead of
> (!IS_ENABLED(CONFIG_ACPI))
Noted. Thanks! I have a pending query on Patch 1/2. Once that is
resolved, I will update both patches.
>
> Best,
>  Enric
>
> >>
> >> Best,
> >>
> >>>
> >>> Thanks,
> >>>  Enric
> >>>
> >>>> +      */
> >>>> +     if (!IS_ENABLED(CONFIG_ACPI)) {
> >>>> +             if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> >>>> +                     retval = mfd_add_hotplug_devices(ec->dev,
> >>>> +                                     cros_usbpd_notify_cells,
> >>>> +                                     ARRAY_SIZE(cros_usbpd_notify_cells));
> >>>> +                     if (retval)
> >>>> +                             dev_err(ec->dev,
> >>>> +                                     "failed to add PD notify devices: %d\n",
> >>>> +                                     retval);
> >>>> +             }
> >>>> +     }
> >>>> +
> >>>>       /*
> >>>>        * The following subdevices cannot be detected by sending the
> >>>>        * EC_FEATURE_GET_CMD to the Embedded Controller device.
> >>>>
