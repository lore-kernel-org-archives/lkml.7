Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CAECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B78920663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLlEgGTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfJ1N02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:26:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726691AbfJ1N01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572269186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9TW8mW6u0TYBeeY+W6dVr0PHUxc5fffEDZPCioNZHk=;
        b=cLlEgGTOhhw7o15fCc4wePKdLy2/Km7M5lBP4Hc1/sJql9rTAbWVzz3/uCR8O85cEfGHpG
        Mt4eNG+3bGgruzGq7TIYQLnBO0d4j7CZ4pjZy3wgjk8rUhw63WIrQo14uzuR7swvEibJkI
        MB9sMLEtA3cCvEO1tDVKg/8MWZAK1UI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-jLMyV8EdPBu8SFrjQ6t10A-1; Mon, 28 Oct 2019 09:26:24 -0400
Received: by mail-wm1-f72.google.com with SMTP id i8so2230506wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 06:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Si4Z1KsF+e4usTz9EQyO3e6lWF2BgkJb9zOZNHxAaEQ=;
        b=FMmhMW79iTHzSppuIkW0kmr4+RTjwyQ8PbV6NfRCjMi3oQnARWEznCsnJwxtx5J+K9
         BofRnqQxkon/h68JIIvOvgklpEpKbvpBLfZL6gUn8zGW/JEMfmZtSFQJFtcZrBUzJ+Sl
         nHGvjx1scq+pqP+bn929wQ/tpsn7s+X1B6HCGV905uhkYuNAlsGSIYKW4l75DWG2tIEk
         13r9S0NgA7DIxG0lWURHkfYfb3+Ly8FYqnSrkW4MnsrNAyrDuqpoea4c0OnsLwdMyWux
         lQCS2mGRKkE/kuCbEeAvybj1GxAUIdUTu7B58xVxGD9b2E2McES91Sw2pq4egSkHIiG9
         fjcw==
X-Gm-Message-State: APjAAAXBLQG5JOvRW55ujsQjYHkKThlFtUxaZ0llkyZA9TQ4ltcDHj2v
        1k5c4ipnjc+y/Qtey4y4pkHGEQOi8rNSht+hEvXwgAdRMR4DGw3gypqe/Lm6tUM7arWCbAAD1Nu
        YnVmxXustiSysM2OtzW75tFmE
X-Received: by 2002:adf:fec3:: with SMTP id q3mr15007967wrs.343.1572269183126;
        Mon, 28 Oct 2019 06:26:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyll9zfVxUoQ/Wumh3Wks/s09Y9MeHgtOp3ThjrLKsKv7pjQOM/fvbWPLVI4z/CLE239nJUsA==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr15007950wrs.343.1572269182958;
        Mon, 28 Oct 2019 06:26:22 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id f204sm15471362wmf.32.2019.10.28.06.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 06:26:22 -0700 (PDT)
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>, lgirdwood@gmail.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
 <20191028124554.GF5015@sirena.co.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com>
Date:   Mon, 28 Oct 2019 14:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028124554.GF5015@sirena.co.uk>
Content-Language: en-US
X-MC-Unique: jLMyV8EdPBu8SFrjQ6t10A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-10-2019 13:45, Mark Brown wrote:
> On Mon, Oct 28, 2019 at 02:41:46PM +0200, Adrian Hunter wrote:
>> On 25/10/19 10:55 AM, Andy Shevchenko wrote:
>=20
>>> Since it's about UHS/SD, Cc to Adrian as well.
>=20
>> My only concern is that the driver might conflict with ACPI methods tryi=
ng
>> to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin D=
SDT
>> with code like this:

Oh, right that is a very good point.

> That's certainly what's idiomatic for ACPI (though machine specific
> quirks are too!).  The safe thing to do would be to only register the
> supply on systems where we know there's no ACPI method.

Right, so as I mentioned before Andrey told me about the evaluation
board he is using I was aware of only 3 Cherry Trail devices using
the Whiskey Cove PMIC. The GPD win, the GPD pocket and the Lenovo
Yoga book. I've checked the DSDT of all 3 and all 3 of them offer
voltage control through the Intel _DSM method for voltage control.

I've also actually tested this on the GPD win and 1.8V signalling
works fine there without needing Andrey's patch.

So it seems that Andrey's patch should only be active on his
dev-board, as actual production hardware ships with the _DSM method.

I believe that the best solution is for the Whiskey Cove MFD driver:
drivers/mfd/intel_soc_pmic_chtwc.c

To only register the new cell on Andrey's evaluation board model
(based in a DMI match I guess). Another option would be to do
the DMI check in the regulator driver, but that would mean
udev will needlessly modprobe the regulator driver on production
hardware, so doing it in the MFD driver and not registering the cell
seems best,

Regards,

Hans

