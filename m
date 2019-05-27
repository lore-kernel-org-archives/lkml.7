Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEBC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFF4208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFN1ucZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfE0TLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:11:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42082 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfE0TLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:11:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id 33so6562605pgv.9;
        Mon, 27 May 2019 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GWWobeGYg4EECozO9Qj4YTpVWW3X1i9MJHljQCbCuiE=;
        b=HFN1ucZoAnnb4drttbW8myp2r9g43uolH/3ESLFMfRO4K/dwAogLoYIDa3xFc065tf
         xBBOQcc4YTKoGIfQmsntRM7dyHOeTw/QqgMhJA0PMLxcpRlGQv5sid5141zLnOaCtFyJ
         qRofW9gXOElW6HiJN7Fb3zvMKrIryV7+dXsCu0ow4l4jihobB9JnrI8qFhqe7s43h2qE
         rehwqClUpCK8hPsJSgFmA69veXSgAiJML2Hkmg8uuRcMh2Lfi+GZ0vXr1p5mH464M+tW
         Dw7ZPFlXdqx9YmyCgAqArbazxVVV7dAK3k7XXH4HhcaS1iPUDjzrUu3GUtxpocoaPfPR
         bvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GWWobeGYg4EECozO9Qj4YTpVWW3X1i9MJHljQCbCuiE=;
        b=p19MEmiOwxTDSNWZccueP1Yxsd0s96D/QBmxFTati8DY8jPrusPZpxQ8GhTbs9aLbz
         3X1ex8V/3M9J5NzSn5RxffDn/HEegAhxO+Y6mLVIwH0ggtjSU3kP1m2uNRvZMotudzOc
         Lq8Ptqa2rd3Y4N7dce457oQuHEVAb53tvJJcgUnnIB2Gyz3bWLpxz8eqNmnXKa+XOX1I
         +jsnJlWUHP4+mlO+1j+OsohAghcnRgy/i3uyvxWke3Ms3tm/bIMDxElcvsC34xNgUg6d
         4LL7JyMj+WRWiQ3e5y2tUy1IPR/eHpeUAl6vvpHvnI2A1DhjiG+8Mk5pC1nYunmgc3kN
         dTJg==
X-Gm-Message-State: APjAAAWUv6ZcwNiciAaF0ygmWOcoPQEMFrfQ1DMQddgljzrPXdTo+Rd1
        uLUQiis5xVqYZhHyAuhzfA8=
X-Google-Smtp-Source: APXvYqyzZB0e/HKCzbmbW891E7cntlRXWCaEkDNDNcB1A+g7Xe+Fw+aaqINqqyOezQVsXb8VlLVmFQ==
X-Received: by 2002:a17:90a:35c8:: with SMTP id r66mr505097pjb.17.1558984263248;
        Mon, 27 May 2019 12:11:03 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id s2sm12223753pfe.105.2019.05.27.12.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:11:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190523060437.11059-1-peng.fan@nxp.com>
 <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
 <AM0PR04MB4481C44F9B5EFCDD076EF728881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7aa27228-38fc-d5bf-0cb2-b255176a206a@gmail.com>
Date:   Mon, 27 May 2019 12:11:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481C44F9B5EFCDD076EF728881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2019 10:19 PM, Peng Fan wrote:
> Hi Florian,
> 
>> Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
>>
>> Hi,
>>
>> On 5/22/19 10:50 PM, Peng Fan wrote:
>>> This is a modified version from Andre Przywara's patch series
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ke
>> rnel.org%2Fpatchwork%2Fcover%2F812997%2F&amp;data=02%7C01%7Cpe
>> ng.fan%40nxp.com%7C010c9ddd5df645c9c66b08d6dfa46cb2%7C686ea1d3b
>> c2b4c6fa92cd99c5c301635%7C0%7C0%7C636942294631442665&amp;sdat
>> a=BbS5ZQtzMANSwaKRDJ62NKrPrAyaED1%2BvymQaT6Qr8E%3D&amp;rese
>> rved=0.
>>> [1] is a draft implementation of i.MX8MM SCMI ATF implementation that
>>> use smc as mailbox, power/clk is included, but only part of clk has
>>> been implemented to work with hardware, power domain only supports get
>>> name for now.
>>>
>>> The traditional Linux mailbox mechanism uses some kind of dedicated
>>> hardware IP to signal a condition to some other processing unit,
>>> typically a dedicated management processor.
>>> This mailbox feature is used for instance by the SCMI protocol to
>>> signal a request for some action to be taken by the management processor.
>>> However some SoCs does not have a dedicated management core to
>> provide
>>> those services. In order to service TEE and to avoid linux shutdown
>>> power and clock that used by TEE, need let firmware to handle power
>>> and clock, the firmware here is ARM Trusted Firmware that could also
>>> run SCMI service.
>>>
>>> The existing SCMI implementation uses a rather flexible shared memory
>>> region to communicate commands and their parameters, it still requires
>>> a mailbox to actually trigger the action.
>>
>> We have had something similar done internally with a couple of minor
>> differences:
>>
>> - a SGI is used to send SCMI notifications/delayed replies to support
>> asynchronism (patches are in the works to actually add that to the Linux SCMI
>> framework). There is no good support for SGI in the kernel right now so we
>> hacked up something from the existing SMP code and adding the ability to
>> register our own IPI handlers (SHAME!). Using a PPI should work and should
>> allow for using request_irq() AFAICT.
> 
> So you are also implementing a firmware inside ATF for SCMI usecase, right?

Correct, SCMI is implemented in part within the trusted firmware (it is
not ATF, something custom), and in part using an external processor for
specific tasks.

> 
> Introducing SGI in ATF to notify Linux will introduce complexity, there is
> no good framework inside ATF for SCMI, and I use synchronization call for
> simplicity for now.

Sure that's fine, the point we all seem to agree upon is that putting
provision in the binding document for an optional interrupt is already
known to be desirable.

> 
>>
>> - the mailbox identifier is indicated as part of the SMC call such that we can
>> have multiple SCMI mailboxes serving both standard protocols and
>> non-standard (in the 0x80 and above) range, also they may have different
>> throughput (in hindsight, these could simply be different channels)
>>
>> Your patch series looks both good and useful to me, I would just put a
>> provision in the binding to support an optional interrupt such that
>> asynchronism gets reasonably easy to plug in when it is available (and
>> desirable).
> 
> Ok. Let me think about and add that in new version patch.
> 
> Thanks,
> Peng.
> 
>>
>>>
>>> This patch series provides a Linux mailbox compatible service which
>>> uses smc calls to invoke firmware code, for instance taking care of SCMI
>> requests.
>>> The actual requests are still communicated using the standard SCMI way
>>> of shared memory regions, but a dedicated mailbox hardware IP can be
>>> replaced via this new driver.
>>>
>>> This simple driver uses the architected SMC calling convention to
>>> trigger firmware services, also allows for using "HVC" calls to call
>>> into hypervisors or firmware layers running in the EL2 exception level.
>>>
>>> Patch 1 contains the device tree binding documentation, patch 2
>>> introduces the actual mailbox driver.
>>>
>>> Please note that this driver just provides a generic mailbox
>>> mechanism, though this is synchronous and one-way only (triggered by
>>> the OS only, without providing an asynchronous way of triggering
>>> request from the firmware).
>>> And while providing SCMI services was the reason for this exercise,
>>> this driver is in no way bound to this use case, but can be used
>>> generically where the OS wants to signal a mailbox condition to
>>> firmware or a hypervisor.
>>> Also the driver is in no way meant to replace any existing firmware
>>> interface, but actually to complement existing interfaces.
>>>
>>> [1]
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
>>>
>> ub.com%2FMrVan%2Farm-trusted-firmware%2Ftree%2Fscmi&amp;data=02
>> %7C01%7
>>>
>> Cpeng.fan%40nxp.com%7C010c9ddd5df645c9c66b08d6dfa46cb2%7C686ea1
>> d3bc2b4
>>>
>> c6fa92cd99c5c301635%7C0%7C0%7C636942294631442665&amp;sdata=kN
>> 9bEFFcsZA
>>> 1ePeNLLfHmONpVaG6O5ajVQvKMuaBXyk%3D&amp;reserved=0
>>>
>>> Peng Fan (2):
>>>   DT: mailbox: add binding doc for the ARM SMC mailbox
>>>   mailbox: introduce ARM SMC based mailbox
>>>
>>>  .../devicetree/bindings/mailbox/arm-smc.txt        |  96
>> +++++++++++++
>>>  drivers/mailbox/Kconfig                            |   7 +
>>>  drivers/mailbox/Makefile                           |   2 +
>>>  drivers/mailbox/arm-smc-mailbox.c                  | 154
>> +++++++++++++++++++++
>>>  include/linux/mailbox/arm-smc-mailbox.h            |  10 ++
>>>  5 files changed, 269 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/mailbox/arm-smc.txt
>>>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c  create mode
>>> 100644 include/linux/mailbox/arm-smc-mailbox.h
>>>
>>
>>
>> --
>> Florian

-- 
Florian
