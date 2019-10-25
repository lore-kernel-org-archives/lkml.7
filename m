Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E50ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E1921D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4ajQvXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394353AbfJYJi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:38:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43505 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731534AbfJYJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571996336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcJIhEUCXzXaO1oNGaOVJjMG7gFbrtsgy/QLeGg64MM=;
        b=P4ajQvXgSDydao8vAwew+5d8lEgX2UMRHAHAgV9aJrQGmCHqdzcarw/xL/MzoQupXOwIzi
        z17VvABL3XQFZih9wMZrrXD48aKkJzfTu9Cg9QmSAx8Y5SCUbivJUCGTYz6O8TjNcisUeN
        znS8YxwOmSHXGPQZ8MoHtPWhVOmfdHM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-zKn2KipTMouF9qIYe49Rrg-1; Fri, 25 Oct 2019 05:38:55 -0400
Received: by mail-wm1-f71.google.com with SMTP id x23so782617wmj.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OVeT+7cnPgbJlLsaEINIFnl4yRiVR5WnQpdwKy7I0P8=;
        b=szPdzxrpKO3Cj2nzOqG7k2TSRqn1Wj64zgKhAOB2fD/s7VOuiz92q3XolBkYjMnKjH
         mD4UKszUVDBl8bgKZFJAIhlBvhkQKBWaSNHzc5CymQ01MPwPuE9hKdzGLmHBTfvdPtF+
         hUMKV6OA+3uhHnk1a/Og2ns+RFEsR4vwtkyrULXeYrDT8XJeueV+xp7YQ3M+O5g9fBoX
         7WPORsvzbW+aT+gNWFN0hvy+AGyMwdusljBpbB6zaki2skht1J2cFon6YS1MAIcEds52
         iPftrSJqUo/8Raa4GwwpuLPRFxEXjA98OBFZCjhrV1FbuyDzAV5V9suok5+aQJ1By6J4
         UQQQ==
X-Gm-Message-State: APjAAAU+m0NWtwgClhddPFH3VvZqBjYR4Far2ftD4y/tvEjJR8kc9Hvx
        bZE+7avwbmw2Z/kR4AEKsHJECPGwOvNWdca17HsGsoqwpQ3lRfoyaZa1d3MzMSjWXgS/6/cTwm4
        7fcgsO7dz6XFEAYeaiuUmjxUm
X-Received: by 2002:adf:f74e:: with SMTP id z14mr2238692wrp.84.1571996334191;
        Fri, 25 Oct 2019 02:38:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySkzgj1VQ5ZtPYk/oljlIJlpGxJaR+dn/77o9mSIC1E5YuWstiqiT40Z+LXNnfNwN3hDVHSA==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr2238665wrp.84.1571996333944;
        Fri, 25 Oct 2019 02:38:53 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id j14sm1989813wrj.35.2019.10.25.02.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:38:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
Date:   Fri, 25 Oct 2019 11:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025075335.GC32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: zKn2KipTMouF9qIYe49Rrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-10-2019 09:53, Andy Shevchenko wrote:
> On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
>> This patchset introduces additional regulator driver for Intel Cherry
>> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
>> PMIC, which is used to instantiate this regulator.
>>
>> Regulator support for this PMIC was present in kernel release from Intel
>> targeted Aero platform, but was not entirely ported upstream and has
>> been omitted in mainline kernel releases. Consecutively, absence of
>> regulator caused the SD Card interface not to be provided with Vqcc
>> voltage source needed to operate with UHS-I cards.
>>
>> Following patches are addessing this issue and making sd card interface
>> to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
>> of the SD Card interface in consumers and exposes optional "vqmmc"
>> voltage source, which mmc driver uses to switch signalling voltages
>> between 1.8V and 3.3V.
>>
>> This set contains of 2 patches: one is implementing the regulator driver
>> (based on a non upstreamed version from Intel Aero), and another patch
>> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
>=20
> Thank you.
> Hans, Cc'ed, has quite interested in these kind of patches.
> Am I right, Hans?

Yes since I do a lot of work on Bay and Cherry Trail hw enablement I'm
always interested in CHT specific patches.

Overall this series looks good (from a high level view I did not
do a detailed review) but I wonder if we really want to export all the
regulators when we just need the vsdio one?

Most regulators are controlled by either the P-Unit inside the CHT SoC
or through ACPI OpRegion accesses.  Luckily the regulator subsys does not
expose a sysfs interface for users to directly poke regulators, but this wi=
ll
still make it somewhat easier for users to poke regulators which they shoul=
d
leave alone.

Note I'm not saying this is wrong, having support for all regulators in pla=
ce
in case we need it in the future is also kinda nice. OTOH if we just need t=
he
one now, maybe we should just support the one for now ?

Andy do you have an opinion on this?

Andrey, may I ask which device you are testing this on?

Anyways overall good work, thank you for doing this!

Regards,

Hans

