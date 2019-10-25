Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C22CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3E21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkAEZa1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408511AbfJYI7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:59:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407620AbfJYI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571993951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEfAMrGGJdre6q5960sJV82kiqLRtWiqhggy8x2XByk=;
        b=dkAEZa1vmRqorgjqBp1iBnvrmf2fOZM6LsxyPCSh0pJfc/sIH45zot3I18SZUu6NaqxHGa
        Zo3MTYayuhszbXAgqa6ghhJHfK5gfbH3yOQ8baD9KcGQTj/DQMrdKzmPvT9wuzf60qjfzB
        F51Y0mlA9WUwrWS/Aw0/2Q+vgzLWPpk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Lfw5pdjXMEqwhHG1Vxy9YQ-1; Fri, 25 Oct 2019 04:59:10 -0400
Received: by mail-wr1-f72.google.com with SMTP id h4so684399wrx.15
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rw+NkxbACn9hciv6WEMv7l0zZ0kLC27u/GkuGUvdJJs=;
        b=HUCNLJ5VNqk1OoUHdnVnY40lPA3ngWcRPm3M5edWyM2ISCbx6HS4YqVdfI89dwc+GE
         Ud7n8Q2+LqMd4qHyI1LXwJgBS1cA4pwLDKDOi46bXsPxIJaUcfLfjG86CtDvrcoUrSBG
         Eo5vm1+5MIIyguqn1u+sx4Tmwmub+kjZhp0TLw8jYp/RWNsk8/M6pcKDUcr479KR9xiQ
         5a7dwDdAZi93egvjMCX2BRce8BeizMISPNgnyAIKgDcxU/B86h/k0QwvR7aGknhEpm4c
         8p/eX5q+x8DSLsJw8s8QXTRoVz7i/okXvPq3BvZ5PcScXXuTH1+RXbuVSmnZpVsV8tpL
         veoA==
X-Gm-Message-State: APjAAAURn9T+D0Z2oRgkXgj0eitNetUZdBdztADvXV923qtHzerRbB9S
        Eq/kzpSs1yNX+O/WBBiyvpw9tMq0xbhXVccNNCrd9iz3eLVy69UJdypjSezQcnIVdTLyVrp/89J
        lt5aAWQrabop++xEoKySplLoN
X-Received: by 2002:adf:e805:: with SMTP id o5mr2008918wrm.223.1571993948472;
        Fri, 25 Oct 2019 01:59:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2KbwzkROwYeADYLzyzJJATVkZ+ZEbGR5TPyEOXAq9XM/sAeNbXmJtO++ErjZ+kJbNgSDC5Q==
X-Received: by 2002:adf:e805:: with SMTP id o5mr2008895wrm.223.1571993948246;
        Fri, 25 Oct 2019 01:59:08 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id r2sm1837777wma.1.2019.10.25.01.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:59:07 -0700 (PDT)
Subject: Re: [PATCH 2/4] ACPI / PMIC: Add byt prefix to Crystal Cove PMIC
 OpRegion driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-3-hdegoede@redhat.com>
 <20191025074154.GX32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <49aa39b7-d457-1140-afdb-2a154278b29f@redhat.com>
Date:   Fri, 25 Oct 2019 10:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025074154.GX32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: Lfw5pdjXMEqwhHG1Vxy9YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-10-2019 09:41, Andy Shevchenko wrote:
> On Thu, Oct 24, 2019 at 11:38:25PM +0200, Hans de Goede wrote:
>> Our current Crystal Cove OpRegion driver is only valid for the
>> Crystal Cove PMIC variant found on Bay Trail (BYT) boards,
>> Cherry Trail (CHT) based boards use another variant.
>>
>> At least the regulator registers are different on CHT and these register=
s
>> are one of the things controlled by the custom PMIC OpRegion.
>>
>> Commit 4d9ed62ab142 ("mfd: intel_soc_pmic: Export separate mfd-cell
>> configs for BYT and CHT") has disabled the intel_pmic_crc.c code for CHT
>> devices by removing the "crystal_cove_pmic" MFD cell on CHT devices.
>>
>> This commit renames the intel_pmic_crc.c driver and the cell to be
>> prefixed with "byt" to indicate that this code is for BYT devices only.
>>
>> This is a preparation patch for adding a separate PMIC OpRegion
>> driver for the CHT variant of the Crystal Cove PMIC (sometimes called
>> Crystal Cove Plus in Android kernel sources).
>=20
>>   .../acpi/pmic/{intel_pmic_crc.c =3D> intel_pmic_bytcrc.c}    | 4 ++--
>>   drivers/mfd/intel_soc_pmic_crc.c                           | 2 +-
>=20
> I would go with previously established pattern, i.e. intel_pmic_bytcc.c.

Well that would be consistent with the chtwc for the Whiskey Cove, but
Crystal Cove related files are shortened to crc in many places already:

Filenames before this patch:
drivers/acpi/pmic/intel_pmic_crc.c
drivers/pwm/pwm-crc.c
drivers/mfd/intel_soc_pmic_crc.c

And to me "cc" stands for the Type-C cc lines, or for Cc: from email,
so IMHO it is best to stick with crc here.

>> +++ b/drivers/mfd/intel_soc_pmic_crc.c
>> @@ -75,7 +75,7 @@ static struct mfd_cell crystal_cove_byt_dev[] =3D {
>>   =09=09.resources =3D gpio_resources,
>>   =09},
>>   =09{
>> -=09=09.name =3D "crystal_cove_pmic",
>> +=09=09.name =3D "byt_crystal_cove_pmic",
>>   =09},
>>   =09{
>>   =09=09.name =3D "crystal_cove_pwm",
>=20
> I'm wondering shouldn't we rename the PWM and GPIO for the sake of consis=
tency?
> Yes, if a driver is used on both CHT and BYT, let it provide two names.

I believe it is fine to keep the blocks which are identical between
the 2 versions as just "crystal_cove_foo", but renaming them is fine with m=
e
too, but that follows outside the scope of this series and should be
done in a follow-up series IMHO.

Regards,

Hans

