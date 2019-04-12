Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECFFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A4520850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf7WtE8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfDLUE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:04:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:04:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so12459921wmi.5;
        Fri, 12 Apr 2019 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ocrb2VWWs7Nnp5MYzo7t6LV+BOLb+dTLJX6dSaQqGi4=;
        b=Yf7WtE8dgMIu2a0mlGcpIOsoHdrqhMav8ombg7WvAoLU6HkqOts1uzMKeWopT1qp5N
         5jjkZ8Rd98zufQBbcrKneOYbppMBwZEaVpHuPLCbPb5MiOR+VTX4YLXkHyHQG8uylmb0
         djNHvi7YyOj0LfA1sCBEiOH00r7e0aV0Bjcpr7afGruz8X3vpib70Lj1GRp6bIR8Ycjn
         2quV7JIMYIzk01/cNXg6k2EmxfFzfqCflzXdL6kUORDb+uF4jTPt4xBrauDJz9OaWMCf
         zFpCRkKGGxR+UK/qq7n9OSSZVrs9/dZ/k4i2M3nGLyDugQlREuKGkI4ToHWUmFzCkbJu
         OuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ocrb2VWWs7Nnp5MYzo7t6LV+BOLb+dTLJX6dSaQqGi4=;
        b=dtbRax+EC7HEKpww3KFimBCV44j/fFXRBGmiXKSSftcco5dKsx45W54QDReSL8QI/3
         IV95gpnTX1WMIlTrmvSsQjK/9epVLmwfbBhpWdYQJOv2dTxR/EITFwDT6eeRkLZdhbQ2
         iLZxacoZQIIRTx1LrRACXn2t1dyXzLkTsBC2BgMUHP1SKNOtr2FjFly5qVbP+U1OtH3G
         r9eXszXirrmNM4w8wH+ApPPXeVYfs/mXkbCEwrSKfw7RdB6BliovsNjcywYJWs0CAzfG
         sRlPgllCws6zbFy0jvhsZh8RQpaZ9GYLK6dCZ5ToaJ0eYCF0c0akYBEO+TlGl0MoK/Ly
         Q6ZA==
X-Gm-Message-State: APjAAAVoC2lFj4n52zBA4weN+IbDtno3PKPS1fYjlP3vj/Vne8fSjzSH
        PmqViT8rO8ezfzJV30A278o=
X-Google-Smtp-Source: APXvYqzHHs3WCBUfKpElPvfU0pWVOkfaDPT+Gq3DTey6NHmuMLHdLbExsU+S5gwIkmx8pEOPq9eOvQ==
X-Received: by 2002:a1c:1c5:: with SMTP id 188mr12833102wmb.52.1555099465917;
        Fri, 12 Apr 2019 13:04:25 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id f1sm8274266wml.28.2019.04.12.13.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 13:04:25 -0700 (PDT)
Subject: Re: [PATCH 04/11] platform/x86: asus-wmi: Add quirk to force DSTS WMI
 method detection
To:     Daniel Drake <drake@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <d8e0f65c-8c4e-7b60-93bd-3bf90e2da344@gmail.com>
 <CAD8Lp46Xs2QJ521+ameM3793jaYXzEeV=PqLYfW4J2ZRoRKbRw@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <99de12d7-ac8d-3bb2-f154-e7fd424e11db@gmail.com>
Date:   Fri, 12 Apr 2019 22:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46Xs2QJ521+ameM3793jaYXzEeV=PqLYfW4J2ZRoRKbRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wow that is a great thing you done, thanks a lot for your time and your
kind words! Your suggestion indeed sounds good judging by your results.

Both of my devices have UID "ATK" (actually FX505 also has two other
PNP0C14 devices with HIDs SampleDev and TestDev, but I think they are
disabled by default).

It looks like the driver is loaded already only if ASUS_WMI_MGMT_GUID is
present, so I guess that could be used for wmi_driver_register. A little
obstacle is that ACPI device pointer is stored in wmi_block structure,
which is internal to the wmi.c. This means we would have to add a new
method to wmi.h / wmi.c for getting the UID of WMI ACPI device.

I guess it might be possible to somehow navigate the device tree back to
the platform driver of WMI module, but it would definitely be more obscure,
and searching for the device by HID again is not only slower but generally
would require a guarantee that it's the same device. So adding a new
function looks reasonable to me. It might also be useful to someone
implementing similar things for other vendors in the future.

I'm going to implement this in updated patch.

Thanks,
Yurii

On 11.04.19 12:55, Daniel Drake wrote:
> On Thu, Apr 11, 2019 at 4:28 AM Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
>> The DSTS method detection fails, as nothing is returned if method is not
>> defined in WMNB. As a result the control of keyboard backlight is not
>> functional for TUF Gaming series laptops (at the time the only
>> functionality of the driver on this model implemented with WMI methods).
>>
>> Patch was tested on a newer TUF Gaming FX505GM and older K54C model.
>>
>> FX505GM:
>> Method (WMNB, 3, Serialized)
>> { ...
>>     If ((Local0 == 0x53545344))
>>     {
>>         ...
>>         Return (Zero)
>>     }
>>     ...
>>     // No return
>> }
>>
>> K54C:
>> Method (WMNB, 3, Serialized)
>> { ...
>>     If ((Local0 == 0x53545344))
>>     {
>>         ...
>>         Return (0x02)
>>     }
>>     ...
>>     Return (0xFFFFFFFE)
>> }
>>
>> The non-existing method ASUS_WMI_METHODID_DSTS=0x53544344 (actually it is
>> DCTS in little endian ASCII) is selected in asus->dsts.
>>
>> One way to fix this would be to call both for every known device ID until
>> some answers - this would increase module load time.
>>
>> Another option is to check some device that is known to exist on every
>> model - none known at the time.
>>
>> Last option, which is implemented, is to check for presence of the
>> ASUS7000 device in ACPI tree (it is a dummy device), which is the
>> condition used for loading the vendor driver for this model. This might
>> not fix every affected model ever produced, but it likely does not
>> introduce any regressions. The patch introduces a quirk that is enabled
>> when ASUS7000 is found.
>>
>> Scope (_SB)
>> {
>>     Device (ATK)
>>     {
>>         Name (_HID, "ASUS7000")  // _HID: Hardware ID
>>     }
>> }
> 
> Hmm, tricky! But about time we did something about the DSTS vs DCTS guessing.
> 
> While we don't have definitive knowledge of the right thing to do
> here, I think I have enough info available to solidify some
> assumptions we'd otherwise be afraid to make, and then we can
> implement a better approach here.
> 
> In our database of 144 Asus DSDTs, 14 of them respond to DCTS:
> 
> AS_D520MT
> D425MC
> D640SA
> D320SF-K
> D415MT
> D830MT
> G11DF
> M32CD4-K
> V221ID
> V272UN_SKU3
> Z240IE
> ZN220IC-K
> ZN241IC
> ZN270IE
> 
> Of those 14, they all additionally respond to DSTS, except for D415MT
> and AS_D520MT.
> 
> In all 14 cases, the DCTS handling is done inside a device with _UID
> ASUSWMI. None of the other 130 products have a device with that _UID.
> 
> Furthermore, we recently received access to the ASUS spec, which
> confirms that the Instance Name for EeePC is "ACPI\PNP0C14\ASUSWMI_0"
> whereas the Instance Name for other notebooks is "ACPI\PNP0C14\ATK_0".
> 
> The 12 devices that respond to both DCTS and DSTS, do it on separate
> different devices, albeit with the same _WDG UUID. The one with _UID
> ASUSWMI responds to DCTS, and the one with _UID ATK responds to DSTS.
> 
> So that seems fairly convincing. My thinking is that we can check the
> _UID of the underlying device, and use DCTS for ASUSWMI, DSTS
> otherwise. To do that, I think you'd have to rework the driver probing
> so that it happens through wmi_driver_register(). Then from the probe
> function onwards you will get a wmi_device, and hopefully you can get
> the _UID through that instance somehow.
> 
> There's a separate issue of what happens on those 12 machines where
> there are two WMI devs, with the same _WDG GUID.
> drivers/platform/x86/wmi.c drops duplicates, so one of them is being
> ignored in that case. We'd ideally find a way to ignore the ASUSWMI
> node and go with ATK in that situation. But I think this can be
> separated from your work here.
> 
> Thanks for these patches and welcome to the world of kernel development!
> 
> Daniel
> 
