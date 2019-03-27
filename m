Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BBFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3B22087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZwYqS/o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfC0LPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:15:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC0LPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:15:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2RBEY2j071681;
        Wed, 27 Mar 2019 06:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553685274;
        bh=vCV/hMZ+QzIZpg8WE23m5Dr0O1VTmo9wuJreqOkka38=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZwYqS/o7TZyigJ40OUP6Bih5PeYm8j2ubmwjYhhWm+BYJCjML79shRMMG4DkNfhch
         61IR+x44XQ3S3Nr8lOTDSBGTY8NFOnuxnnLwCp1fzOEDQ24HOxSa1qzAejVmEg0gF7
         0qrqqM8Sg+GYcaKLpaPxT5HqwrC7WE/rPj2yuRJQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2RBEYBI115017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Mar 2019 06:14:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 27
 Mar 2019 06:14:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 27 Mar 2019 06:14:34 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2RBEUXb032891;
        Wed, 27 Mar 2019 06:14:31 -0500
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on
 da850-evm
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20190322133105.5945-1-brgl@bgdev.pl>
 <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
 <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com>
Date:   Wed, 27 Mar 2019 16:44:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 26/03/19 11:21 PM, Bartosz Golaszewski wrote:
> wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisał(a):
>>
>> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> The system_rev variable is never set on davinci and is always 0, so
>>> we're using the default max operating point of 300MHz. The cvdd supply
>>> comes from the tps6507 pmic and the voltage can go all the way to 1.3V
>>> so the maximum supported rate should be 456MHz.
>>
>> My understanding is that only certain revisions of the silicon can go
>> to 456MHz.   The L138's Datasheet lists both a 456 and 375 version.  I
>> cannot find a way to read a register to determine which version of the
>> silicon is available. Maybe Sekhar can confirm.
>>
> 
> Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add support
> for higher speed grades") mentions the following:
> 
> ---
> U-Boot on the EVM sets up ATAG_REVISION to inform the OS
> regarding the speed grade supported by the silicon. We use
> this information to pass on the speed grade information to
> the SoC code.
> ---
> 
> Should the system_rev somehow reflect that revision? Any way I can check it?

Can you check if the procedure in doc/README.davinci in U-Boot sources 
still works?

Environment Variables
=====================

The DA850 EVM allows the user to specify the maximum cpu clock allowed by the
silicon, in Hz, via an environment variable "maxcpuclk".

The maximum clock rate allowed depends on the silicon populated on the EVM.
Please make sure you understand the restrictions placed on this clock in the
device specific datasheet before setting up this variable. This information is
passed to the Linux kernel using the ATAG_REVISION atag.

If "maxcpuclk" is not defined, the configuration CONFIG_DA850_EVM_MAX_CPU_CLK
is used to obtain this information.

Thanks,
Sekhar
