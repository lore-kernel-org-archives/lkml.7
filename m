Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F20C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6AB2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uwfWXJDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDKK4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:56:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43249 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfDKK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:56:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so3118126qkc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7OiOdVA5wDwNKWk2i4kftupGzN+IIRXiTSHIiUx/Wk=;
        b=uwfWXJDSD529M0KIrkvTfwOAeNhKy4CiUzZd9+fn6yDPBYCS6z76hT2jIzUCJzHnZS
         LgbTMbuj6vwy8pf+RSkZmlXbCVQV/mr2lBwSshsCu0w62UXeUGWOdRt+3LNTIcDNd9Yf
         1LDU4pNZ5kmKP8cvQ5roQzsrS1VqKxdxAJ3dbv2WmOOIskqT1fxujStZlDO3oeatd+8V
         kzxOYdFDulEkbFT+vwI/Jhn0hEeRCGpLLqtyaJuAGS8KND3PHUgRrq1lyKk/ZcEjuT75
         WTDTwcHOjXpO1jaySDFfNJChmkstwefMCJyaIF7MEvJh3uFLwrDVfKFnP5r+wTYUm6YV
         m4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7OiOdVA5wDwNKWk2i4kftupGzN+IIRXiTSHIiUx/Wk=;
        b=XW4l6sukeVdapIDN5MOIZP9c59TxfTdMhFyFQGZg9O6KFw/7W15F6zOoTjq5NYuS9l
         3i7zoMkYjfKtZzVbScYmKjSyodz8fIVzV+XTPaDv8L7W389Gp1pEsR73uhOMay/fsEgs
         3HwzasW7o50OYjYWC/vA7HXBvJY5196KJQKyTZrOeAk65y2FKeqUnONspRawL+FoVRvI
         XEh6PyJdKg56w5LARUnmxkdgXsJQiCpBlcxe5kB5fBs6Jj/OBKq6JG00fTrQyc9V4I8O
         ktDDqPRILlLetP77rI5a/5GQgrTa3ugFk4zQ8ASxnWeDSR4rNYy5Kk8TKs1bfvOLLMo8
         nNfA==
X-Gm-Message-State: APjAAAVQkK97gY1ydjOPx0u3bNIP8R5NuPhLrIKtho3eIavldSPTmB0n
        KS2Y+X0GMxhUnfnFi9zy93HuHjzHyiTP63pBzFFS2g==
X-Google-Smtp-Source: APXvYqyeaDrhaWVPMWtYpFh6bAL7w0rhh8pJaXQrKOXa5e00TdRXBLaX9sqNMGIWcAF0Sv6NnZAtdlqd70vjl6LfXqI=
X-Received: by 2002:a37:ad15:: with SMTP id f21mr36011256qkm.152.1554980166706;
 Thu, 11 Apr 2019 03:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com> <d8e0f65c-8c4e-7b60-93bd-3bf90e2da344@gmail.com>
In-Reply-To: <d8e0f65c-8c4e-7b60-93bd-3bf90e2da344@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 11 Apr 2019 18:55:55 +0800
Message-ID: <CAD8Lp46Xs2QJ521+ameM3793jaYXzEeV=PqLYfW4J2ZRoRKbRw@mail.gmail.com>
Subject: Re: [PATCH 04/11] platform/x86: asus-wmi: Add quirk to force DSTS WMI
 method detection
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 4:28 AM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
> The DSTS method detection fails, as nothing is returned if method is not
> defined in WMNB. As a result the control of keyboard backlight is not
> functional for TUF Gaming series laptops (at the time the only
> functionality of the driver on this model implemented with WMI methods).
>
> Patch was tested on a newer TUF Gaming FX505GM and older K54C model.
>
> FX505GM:
> Method (WMNB, 3, Serialized)
> { ...
>     If ((Local0 == 0x53545344))
>     {
>         ...
>         Return (Zero)
>     }
>     ...
>     // No return
> }
>
> K54C:
> Method (WMNB, 3, Serialized)
> { ...
>     If ((Local0 == 0x53545344))
>     {
>         ...
>         Return (0x02)
>     }
>     ...
>     Return (0xFFFFFFFE)
> }
>
> The non-existing method ASUS_WMI_METHODID_DSTS=0x53544344 (actually it is
> DCTS in little endian ASCII) is selected in asus->dsts.
>
> One way to fix this would be to call both for every known device ID until
> some answers - this would increase module load time.
>
> Another option is to check some device that is known to exist on every
> model - none known at the time.
>
> Last option, which is implemented, is to check for presence of the
> ASUS7000 device in ACPI tree (it is a dummy device), which is the
> condition used for loading the vendor driver for this model. This might
> not fix every affected model ever produced, but it likely does not
> introduce any regressions. The patch introduces a quirk that is enabled
> when ASUS7000 is found.
>
> Scope (_SB)
> {
>     Device (ATK)
>     {
>         Name (_HID, "ASUS7000")  // _HID: Hardware ID
>     }
> }

Hmm, tricky! But about time we did something about the DSTS vs DCTS guessing.

While we don't have definitive knowledge of the right thing to do
here, I think I have enough info available to solidify some
assumptions we'd otherwise be afraid to make, and then we can
implement a better approach here.

In our database of 144 Asus DSDTs, 14 of them respond to DCTS:

AS_D520MT
D425MC
D640SA
D320SF-K
D415MT
D830MT
G11DF
M32CD4-K
V221ID
V272UN_SKU3
Z240IE
ZN220IC-K
ZN241IC
ZN270IE

Of those 14, they all additionally respond to DSTS, except for D415MT
and AS_D520MT.

In all 14 cases, the DCTS handling is done inside a device with _UID
ASUSWMI. None of the other 130 products have a device with that _UID.

Furthermore, we recently received access to the ASUS spec, which
confirms that the Instance Name for EeePC is "ACPI\PNP0C14\ASUSWMI_0"
whereas the Instance Name for other notebooks is "ACPI\PNP0C14\ATK_0".

The 12 devices that respond to both DCTS and DSTS, do it on separate
different devices, albeit with the same _WDG UUID. The one with _UID
ASUSWMI responds to DCTS, and the one with _UID ATK responds to DSTS.

So that seems fairly convincing. My thinking is that we can check the
_UID of the underlying device, and use DCTS for ASUSWMI, DSTS
otherwise. To do that, I think you'd have to rework the driver probing
so that it happens through wmi_driver_register(). Then from the probe
function onwards you will get a wmi_device, and hopefully you can get
the _UID through that instance somehow.

There's a separate issue of what happens on those 12 machines where
there are two WMI devs, with the same _WDG GUID.
drivers/platform/x86/wmi.c drops duplicates, so one of them is being
ignored in that case. We'd ideally find a way to ignore the ASUSWMI
node and go with ATK in that situation. But I think this can be
separated from your work here.

Thanks for these patches and welcome to the world of kernel development!

Daniel
