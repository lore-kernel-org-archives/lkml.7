Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236F0204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br7efCq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403772AbfJ2ROV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:14:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25211 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727692AbfJ2ROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572369258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHCv+9FsqHGfuk8wUBArturJIiljIZ5g6WjkiyVu2GA=;
        b=br7efCq/MJCUshXvP4Z8k2vN2T03FmPBQwsonVEpk0JTAsIRxGItYpI/qPpK2ppn+vk3em
        BudFJhNFLeVjpj0g3U/X8uy94HN7aiH7uwnwF7TUI7ZaS+dHBsCBNxwASRFNlued0wjoo5
        zK9SeNAhO7JLdGvnmPQjZjvacisnyCA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-42CTa6BTNMavShpXLU7zQg-1; Tue, 29 Oct 2019 13:14:15 -0400
Received: by mail-wr1-f70.google.com with SMTP id h4so8867024wrx.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3zevxV+3XhilJwW93b7hTHVOh2RK/iBtiutNi3Bvz6U=;
        b=dPHn9owh7eUt/N84U1ajdSBSdgv4ucVKbmw+QN5BSZmw8gd5GDUftfIzu2W5QWW2JV
         uwcW/mCMeAdyJIuIbL1sZUJyvA6LQhEVz/gsTZYLB6v7hVAjpeAl1SLmxqEGD8/4I+mA
         SCzvEpSdEIFDiF5Z3PuSYwy1H4NPPJaNvJ+4isXfQTj3VAxN1sRwINcyu+LHxHOZTvS+
         kgECM1iTC+j/OmpBNL8VlcCjQhs8n0xFHRbv3WPeBlrJaPmPFnheEhV9mQCdoisvx+n0
         aef/mzK8rBE6sIyRIAtS/haWkqTjfbDpx5OeRj4d5iLiS6z/CMmrScXf/7HLmUr/Ou+1
         9V9A==
X-Gm-Message-State: APjAAAXBxfa1elsPr2edImO1jZkKnWEU7ZFyBDv4QBYjjZj1YsUpexeF
        0zczsRRx1weJv5woroGGp7TvZi3cuy3XCunOL/WFXqftq+vNpeZQWB61iA/vckj4vZZtQ7IVf1T
        FJV0VjjJNgVpOCw73clLXkoLf
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr4206329wrw.82.1572369254348;
        Tue, 29 Oct 2019 10:14:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyO6hWJJ1dPVajjbU5oiOtlqhmyeQKiD5NdVZRqPgSEoZEMFL/O0rAsEE6tySNMNIn7GUZfhw==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr4206317wrw.82.1572369254103;
        Tue, 29 Oct 2019 10:14:14 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id v10sm14049083wrm.26.2019.10.29.10.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 10:14:13 -0700 (PDT)
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
 <20191028124554.GF5015@sirena.co.uk>
 <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com>
 <CAHtQpK5ocb8mqnf2dwcT7hQ9f8rQLtkHJsPppDWgfRPitJk6_Q@mail.gmail.com>
 <75d0e22f-c3fd-245c-c91e-2e3b6134b569@redhat.com>
 <CAHtQpK5-wK-v2fS_cVT6f4evHDafFPv49XDNGO9B+daRR_bOkg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e9c958ea-f10f-668a-eb0b-117ff5f55632@redhat.com>
Date:   Tue, 29 Oct 2019 18:14:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHtQpK5-wK-v2fS_cVT6f4evHDafFPv49XDNGO9B+daRR_bOkg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 42CTa6BTNMavShpXLU7zQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29-10-2019 17:57, Andrey Zhizhikin wrote:
> Hi Hans!
>=20
> On Tue, Oct 29, 2019 at 1:04 PM Hans de Goede <hdegoede@redhat.com> wrote=
:
>>
>> Hi,
>>
>> On 28-10-2019 16:01, Andrey Zhizhikin wrote:
>>> Hi Hans,
>>>
>>> On Mon, Oct 28, 2019 at 2:26 PM Hans de Goede <hdegoede@redhat.com> wro=
te:
>>>>
>>>> Hi,
>>>>
>>>> On 28-10-2019 13:45, Mark Brown wrote:
>>>>> On Mon, Oct 28, 2019 at 02:41:46PM +0200, Adrian Hunter wrote:
>>>>>> On 25/10/19 10:55 AM, Andy Shevchenko wrote:
>>>>>
>>>>>>> Since it's about UHS/SD, Cc to Adrian as well.
>>>>>
>>>>>> My only concern is that the driver might conflict with ACPI methods =
trying
>>>>>> to do the same thing, e.g. there is one ACPI SDHC instance from GPDW=
in DSDT
>>>>>> with code like this:
>>>>
>>>> Oh, right that is a very good point.
>>>>
>>>>> That's certainly what's idiomatic for ACPI (though machine specific
>>>>> quirks are too!).  The safe thing to do would be to only register the
>>>>> supply on systems where we know there's no ACPI method.
>>>>
>>>> Right, so as I mentioned before Andrey told me about the evaluation
>>>> board he is using I was aware of only 3 Cherry Trail devices using
>>>> the Whiskey Cove PMIC. The GPD win, the GPD pocket and the Lenovo
>>>> Yoga book. I've checked the DSDT of all 3 and all 3 of them offer
>>>> voltage control through the Intel _DSM method for voltage control.
>>>>
>>>> I've also actually tested this on the GPD win and 1.8V signalling
>>>> works fine there without needing Andrey's patch.
>>>
>>> Thanks a lot for checking this one out! At least this proves now that
>>> the only platform affected is in fact Intel Aero board, and the patch
>>> as it is might not be necessary to accommodate for all CHT-based
>>> products with Whiskey Cove.
>>>
>>>>
>>>> So it seems that Andrey's patch should only be active on his
>>>> dev-board, as actual production hardware ships with the _DSM method.
>>>>
>>>> I believe that the best solution is for the Whiskey Cove MFD driver:
>>>> drivers/mfd/intel_soc_pmic_chtwc.c
>>>>
>>>> To only register the new cell on Andrey's evaluation board model
>>>> (based in a DMI match I guess). Another option would be to do
>>>> the DMI check in the regulator driver, but that would mean
>>>> udev will needlessly modprobe the regulator driver on production
>>>> hardware, so doing it in the MFD driver and not registering the cell
>>>> seems best,
>>>
>>> I tend to lean to a solution to perform a DMI check in MFD rather than
>>> in the regulator driver, since this would keep the regulator
>>> more-or-less agnostic to the where it is running on.
>>>
>>> Or maybe it would even make more sense to create a board-specific hook
>>> (like it was suggested for vqmmc voltage and sdmmc ACPI d of
>>> consumer), and then only register a cell for Aero match? This would
>>> actually keep the regulator consumer and mfd cell together and would
>>> not allow the device-specific code to leak into generic driver
>>> implementation. In this case I'd go with mfd_add_cell() if I get a DMI
>>> match and register a vqmmc consumer in there.
>>>
>>> In that case, can you please tell me what you think about it and if
>>> the drivers/acpi/acpi_lpss.c would still be an appropriate location to
>>> put this code to?
>>
>> I do not think that drivers/acpi/acpi_lpss.c is a good place.
>=20
> Thanks a lot for clarifying this point, I was also not sure whether I
> would need combine the platform-specific functionality with LPSS
> implementation.
>=20
>>
>> Thinking a bit more about this, my preferred solutions would be:
>>
>> 1. A BIOS update fixing the DSDT, as Andy suggested. Note we can
>> lso use an overlay DSDT in the initrd, but that will only help users
>> which take manual steps to add this to their initrd...
>=20
> This I believe would not be an option since the Aero platform has been
> phased-out from Intel, and Insyde most probably would not do an update
> on the BIOS. I can go with DSDT overlay, but I was not sure whether
> this is a good way to solve this.
>=20
>>
>> 2. A new drivers/platform/x86 driver binding to the dmi-ids of the Areo
>> board, like e.g. drivers/platform/x86/intel_oaktrail.c is doing,
>> unlike that one you do not need to register a platform_device from
>> the module_init() function, you can just add the mfd-cell and the
>> regulator constraints from the module_init() function.
>=20
> This would be my preferred solution, since in this case I can contain
> all the Aero-specific modifications to it's own board file. If there
> would be further modifications needed for it - they would be nicely
> contained within that board file.
>=20
>>
>> Assuming 1. is not an option (I do not know if Intel still
>> supports the Aero), then 2 will nicely isolate all the Aero
>> specific code into a driver which will only auto-load on
>> the Aero.
>=20
> Just as I indicated above, chances that BIOS would receive an update
> are between slim and nil. If no one have any objection, I'd prefer to
> go with the approach [2] from above.

I agree that 2. probably is the best, so I say go for it :)

Regards,

Hans

