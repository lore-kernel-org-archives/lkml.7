Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD66C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F6020684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCHI55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:57:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43344 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHI54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:57:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so15760692ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 00:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BSndeN0E8tcUFR3AtEJSjM4LR/892PvPMb/QWN42OXs=;
        b=hXsolE4rjERPnqhi/oZQhkfj87n7OatMcIrqx6CcBwZ1X0HVf9i1LEYQDf7oJAJDhL
         I8yIhYWfhqww7Bp7xTWXkh43afWUPlhs4fd/JB28/6ta8GBh1hy3jhFGdl+Y5VPMC+0B
         AVNpV87IUIMF1Jkp9j6vchUWyJygBdQCTocrGhwtpUUMeYCbsIx2VzPAYWBCXqRiX0EG
         UzWgi07510bMtTBEN5IkPE6KpDrqwjg75cV8YV198Umda4d7eSHmQu14aAoeHGpW72H4
         yviZ+RACK5v0EUmdLBV+v05+tjyIAqg9yKRAldtT9AJiLJWTzWCySl5tLm/Qv7GhUBna
         FgmA==
X-Gm-Message-State: APjAAAWhaev96U8xAVGqDIljOxsJwKOYusg7+z6mJGuuiGcm3Qs4I2Q1
        AYSHIakxare4V5685unkCqAZIg==
X-Google-Smtp-Source: APXvYqzeHzdDgGOIs8Vm2hkVhTRT4RrrVvwUpF0Kh8JcjWs0dZ+T4S9P2dynsqmkqgzXgeDfgmW/hA==
X-Received: by 2002:a50:9857:: with SMTP id h23mr31325601edb.66.1552035475073;
        Fri, 08 Mar 2019 00:57:55 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r14sm2034629eda.12.2019.03.08.00.57.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 00:57:54 -0800 (PST)
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajat Jain <rajatja@google.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
 <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
 <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
 <54d2b8e6-332b-117a-b982-77a535152246@redhat.com>
 <CACK8Z6GzOHJbh-M=0AxNbBoi3TqVehrs5xYsi2cUhW_dxz6vxg@mail.gmail.com>
 <3914af3f82d8aad8c22d814a20af4be654f8ad43.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <917a32a4-c806-af99-a9a3-246b28a5196a@redhat.com>
Date:   Fri, 8 Mar 2019 09:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3914af3f82d8aad8c22d814a20af4be654f8ad43.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08-03-19 01:04, Srinivas Pandruvada wrote:
> On Thu, 2019-03-07 at 15:07 -0800, Rajat Jain wrote:
>> Hello,
>>
>> On Thu, Mar 7, 2019 at 12:37 PM Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 07-03-19 21:27, Gwendal Grignou wrote:
>>>> Srinivas,
>>>>
>>>> I am looking at problem on a laptop machine that suspends to
>>>> S01x, but
>>>> link_management is set to max_performance, because the machine is
>>>> connected to a charger.
>>>
>>> What is setting it to max_performance when charging?  I assume
>>> chrome-os is
>>> running something in userspace to do this (like TLP, but I guess
>>> you are not
>>> using TLP) ?
>>
>> Yes, we have a udev script that does this.
>>
>>>
>>> Have you run benchmarks with max_performance vs the default?
>>> I seriously doubt there will be a significant difference, esp.
>>> with a chrome-os style workload.
>>>
>>>> Given DVLSP must be set before the laptop suspends ["""One of the
>>>> requirement for modern x86 system to enter lowest power
>>>> mode  (SLP_S0)
>>>> is SATA IP block to be off."""], the machine never reaches S01x.
>>>> Does it make sense to change the target_lpm_policy at suspend
>>>> (ata_port_suspend()) to min_power and bring it back to the
>>>> original
>>>> value on resume?
>>>
>>> If userspace messes with the setting, then userspace should also
>>> put it back before suspending...
>>>
>>> The upstream kernel's default behavior is to have the target level
>>> set
>>> to a fixed level independent of the charging state. Could it be
>>> this
>>> fixed level is actually max-performance ? If that is the default
>>> the
>>> kernel comes up with, that would indicate a kernel bug.
>>
>> Side note: max-performance indeed can be the default forced by the
>> kernel for some (broken) SATA devices:
>>
>>          if (dev->horkage & ATA_HORKAGE_NOLPM) {
>>                  ata_dev_warn(dev, "LPM support broken, forcing
>> max_power\n");
>>                  dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>>          }
>>
>> So definitely these systems won't be able to go into S0ix today.
>>
>> But I think the main idea that we are asking is:
>>
>> 1) Yes, we acknowledge that the userspace has set it max-performance.
>>
>> 2) However, given that the kernel already knows that:
>>         - while in suspend, there is no real value in retaining the
>> max-performance.
>>         - On the contrary, we know system will fail to go into lower
>> power mode because of max-suspend.
>>
>> 3) Does it not make sense to use this knowledge and switch to
>> min_power when we are actually going to suspend (even if user
>> specified max-performance), and restore max-performance on resume?
> 
> It is all about regressions. Hence we added multiple conditions for
> setting default to min power.
> It may cause issues for some SATAs, which may not recover once enters
> slumber or DEVSLP. There is also case where user having issues with
> default LPM policy hence he changed policy to max performance. We can't
> detect that.
> So it will be much safer if user space change policy to default before
> calling suspend.

Right, or simply do not mess with the setting in the first place!

I noticed you did not answer this part of my original reply:

"Have you run benchmarks with max_performance vs the default?
I seriously doubt there will be a significant difference, esp.
with a chrome-os style workload."

I seriously doubt the max-performance setting has a user
noticeable impact on performance. So I repeat has someone
actually measured this with real-world chrome-os workloads ?

Regards,

Hans

