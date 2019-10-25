Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DDCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BB72084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwaL+ofC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394461AbfJYKpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:45:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52001 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390754AbfJYKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572000337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNSt0YD/dZ2dVjz2VhERZukZIeXUrLTm0ijs7s+tVY8=;
        b=TwaL+ofCRUpbnDh/RucrKBJPKXuPLKjFbQNXRKNv67wUG7q9c9cUCiPc1+poUJ/5PWzyyJ
        MWOkdVqMF0CgvfNJf0wfcN/PjoW8AOIlkj+cY8zxx3Qc/amLJjJ3VShLYbl2OG7RIts/Qg
        J5LsvFeOAOXeT5aJJKkslQWSn/aVDvg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-jW_SVPfiO0WyxtCWmBHb2A-1; Fri, 25 Oct 2019 06:45:33 -0400
Received: by mail-wr1-f69.google.com with SMTP id l4so830923wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 03:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTiu1Ma5g3ruaU04I95x/YQwNTmYApEIXzSKhzEuja0=;
        b=LG+tMAynJu6A/WKVUTBGLpqioKxX4T/rbR9K02i51eiQdssJHf0tKKQJBeuxk0+0YM
         ZyBWUj5ek53Em/TpPKd/rVM3+wb8F5A0lGZfBH/6VHVvNuaCQUhOIXjLq3GPuMKmLoBH
         ncntQrDmpft2s/SwzSJadgnDJCzxfi6x5Rjt71t2+93k67zHrkFRKRQnAOKHa5kTFGhT
         Tf1WavN26bUkMBlhIcO6mL3t05/YFokCsQuSWM4vlGvIWbu0URi+FjxzSnn7ekn6DjBx
         FdEC3Yv3iSVNSWV/z4b1C+TKJIjs8WJYK5MkCacozn0K/Muzwt45CxrQi4ySxaewVbzm
         YAkg==
X-Gm-Message-State: APjAAAXB23fxXWtL1dn7JscnOBHsjQ4qzH9mX5wu/8tzOGf3fMVJsHk0
        w3RQ7U0FUiDLdoB4rzFc637199dkjx2VP6PJx6ZalJUygGL1r6RlsLZI/J+CHyK/F+PnaRraxQN
        ytfu4EVtdwnUWmFmOtOBjZLIX
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr2355341wrb.222.1572000332490;
        Fri, 25 Oct 2019 03:45:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykz0nP8xAJokxpN9kj2VOnY+tOpFcXNbW+MB96DcNfU0JuRumJWxFPq8rTwWSxNqgT3t5Eiw==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr2355313wrb.222.1572000332227;
        Fri, 25 Oct 2019 03:45:32 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id a9sm2978105wmf.14.2019.10.25.03.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 03:45:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
 <CAHtQpK5ZSOMKY4U0y-HHHH6QiuYRWHr90SAzjaACpAGgTzALLQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0136a15a-7af4-dabc-a857-fcd80d5576a9@redhat.com>
Date:   Fri, 25 Oct 2019 12:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHtQpK5ZSOMKY4U0y-HHHH6QiuYRWHr90SAzjaACpAGgTzALLQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: jW_SVPfiO0WyxtCWmBHb2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-10-2019 12:11, Andrey Zhizhikin wrote:
> On Fri, Oct 25, 2019 at 11:38 AM Hans de Goede <hdegoede@redhat.com> wrot=
e:
>>
>> Hi,
>>
>> On 25-10-2019 09:53, Andy Shevchenko wrote:
>>> On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
>>>> This patchset introduces additional regulator driver for Intel Cherry
>>>> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
>>>> PMIC, which is used to instantiate this regulator.
>>>>
>>>> Regulator support for this PMIC was present in kernel release from Int=
el
>>>> targeted Aero platform, but was not entirely ported upstream and has
>>>> been omitted in mainline kernel releases. Consecutively, absence of
>>>> regulator caused the SD Card interface not to be provided with Vqcc
>>>> voltage source needed to operate with UHS-I cards.
>>>>
>>>> Following patches are addessing this issue and making sd card interfac=
e
>>>> to be fully operable with UHS-I cards. Regulator driver lists an ACPI =
id
>>>> of the SD Card interface in consumers and exposes optional "vqmmc"
>>>> voltage source, which mmc driver uses to switch signalling voltages
>>>> between 1.8V and 3.3V.
>>>>
>>>> This set contains of 2 patches: one is implementing the regulator driv=
er
>>>> (based on a non upstreamed version from Intel Aero), and another patch
>>>> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
>>>
>>> Thank you.
>>> Hans, Cc'ed, has quite interested in these kind of patches.
>>> Am I right, Hans?
>>
>> Yes since I do a lot of work on Bay and Cherry Trail hw enablement I'm
>> always interested in CHT specific patches.
>>
>> Overall this series looks good (from a high level view I did not
>> do a detailed review) but I wonder if we really want to export all the
>> regulators when we just need the vsdio one?
>=20
> I thought about this point, and actually came to a personal conclusion
> that if I do this as a new driver - then it is better to list all
> possible regulators, creating some sort of "skeleton" which people
> could then work on if need be. I do agree that at the present moment
> the one regulator which is exposed is the one for vsdio, but listing
> all possibilities should not hurt. This was my motivation to put them
> all into the driver on the first place.
>=20
> If you believe additional regulator elements should be removed from
> this version of the driver - I can clean them up and come up with v2
> here.
>=20
>>
>> Most regulators are controlled by either the P-Unit inside the CHT SoC
>> or through ACPI OpRegion accesses.  Luckily the regulator subsys does no=
t
>> expose a sysfs interface for users to directly poke regulators, but this=
 will
>> still make it somewhat easier for users to poke regulators which they sh=
ould
>> leave alone.
>=20
> Agree, this is a valid point. But honestly I would really be surprised
> if a user would directly touch something which can burn his silicon to
> pieces. Regulators are usually not approached by users; unless they
> are really HW engineers and know what they are doing.

True.

Hmm, I do just realize that the regulator subsystem turns off regulators
which are not in use from its pov, which would be kinda bad here.

It does this when the kernel is done initializing / switches to the
initrd or directly to the rootfs. Its been a while since I've last touched
this. Have you tried building the regulator driver (and mfd stuff and i2c
controller, etc.) into the kernel, so that the regulators work without modu=
les?

I'm afraid that if you do that they will all get turned off, with expecting
results... Although I guess the regulator subsystem may skip this step for
regulators without any constrains, to be sure I would have to re-read the c=
ode.

Anyways this is a serious concern which we need to resolve.

>> Andrey, may I ask which device you are testing this on?
>=20
> Sure, I use the original Intel Aero board. It used to have an official
> image from Aero team with a heavily patched 4.4.y kernel, but when I
> decided to have this updated to the latest stable branch - I've faced
> the issue of missing core functionality, which led me to this patch.

Ah I see, the reason I was asking is because I only know of three CHT
devices using a Whiskey Cove PMIC (instead of the AXP288, Crystal Cove or
TI one): the GPD Win, GPD pocket and one of the Lenovo Book versions
(the one with the CHT SoC).

Lets say I want to test this patch-set on one of the GPD devices,
I guess I need an UHS-I capable card and then what should I see
in sysfs for the mmc settings ?

Regards,

Hans

