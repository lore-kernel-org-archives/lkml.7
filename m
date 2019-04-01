Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77562086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iksYh277";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iksYh277"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfDAEwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:52:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46786 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDAEwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:52:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9BB086047C; Mon,  1 Apr 2019 04:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554094353;
        bh=TF+u+nOM5gO2yY8qfDWCWZ7hWLWIiwJVjyS9JUrCfSU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=iksYh277yz3JaiObMzT7ueQ6LhoSKd+D4IZsfLHSQW3apUeACRPbghmiSQ4K+XvcE
         GO0Qn1+HVFKXvetodTlSV+Sb+MPOab69TU1/Si30VN9lli312F3FT5Qm/JKDLytEkF
         ie6P9lol8OWVLgs13sMrgW9/pmp4Ge5iEJPQFyBo=
Received: from [10.204.78.172] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6F9C60234;
        Mon,  1 Apr 2019 04:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554094353;
        bh=TF+u+nOM5gO2yY8qfDWCWZ7hWLWIiwJVjyS9JUrCfSU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=iksYh277yz3JaiObMzT7ueQ6LhoSKd+D4IZsfLHSQW3apUeACRPbghmiSQ4K+XvcE
         GO0Qn1+HVFKXvetodTlSV+Sb+MPOab69TU1/Si30VN9lli312F3FT5Qm/JKDLytEkF
         ie6P9lol8OWVLgs13sMrgW9/pmp4Ge5iEJPQFyBo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6F9C60234
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
 <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
 <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
 <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
 <cfa22512-2abe-f0db-0576-e6d0cd1eee9c@linaro.org>
 <4451d4f2-d651-9db6-99af-e07870fc699a@codeaurora.org>
 <beac6d10-5a13-5524-49cb-e50db229b4fe@codeaurora.org>
Message-ID: <67d71ed4-17dc-a4ff-19cd-c49a3f137fc1@codeaurora.org>
Date:   Mon, 1 Apr 2019 10:22:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <beac6d10-5a13-5524-49cb-e50db229b4fe@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Thanks for the patch, Can you please merge , So will cherry pick the same.


Regards

Gaurav

On 3/25/2019 11:45 AM, Gaurav Kohli wrote:
>
> On 3/22/2019 11:42 PM, Gaurav Kohli wrote:
>> Hi Srinivas,
>>
>> Thanks for the patch, Something like this only i have tested in the 
>> morning, instead of unused, i have put dev group inside config as well.
>>
>> We will test the exact patch and update the same.
>>
>> Regards
>>
>> Gaurav
>>
>> On 3/22/2019 8:32 PM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 20/03/2019 17:50, Gaurav Kohli wrote:
>>>>
>>>>> Is root only option not helping you in this case?
>>>> Yes we want to protect at root level as well, i mean it is better 
>>>> if we can avoid exposing to userspace at all.
>>> Can you try below patch!
>>>
> Hi Srinivas,
>
> Thanks for the patch.
>
> I have checked the patch and also tested the same , and it is working 
> as expected(no creation of nvmem sysfs)
>
> Applied with some conflict on line 41.
>
> Reviewed-by: Gaurav Kohli <gkohli@codeaurora.org>
> Tested-by: Gaurav Kohli <gkohli@codeaurora.org>
>
> Regards
>
> Gaurav
>
>
>>>>>
>>>>> We could go down the route of adding new config option something 
>>>>> like CONFIG_NVMEM_NO_SYSFS_ENTRY to prevent adding nvmem entry in 
>>>>> userspace.
>>>>>
>>>>> Let me know if you are happy to create a patch for this change?
>>>>
>>>> I am happy with either way config option or dt binding(seems easy), 
>>>> please let me know we will post new patch for the same.
>>> DT way is totally NAK.
>>>
>>>
>>> --------------------------->cut<-----------------------------------
>>>
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Date: Wed, 20 Mar 2019 16:15:21 +0000
>>> Subject: [PATCH] nvmem: core: add support to NVMEM_NO_SYSFS_ENTRY
>>>
>>> Some users might not want to expose nvmem entry to sysfs and
>>> only intend to use kernel interface so add such provision.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>  Documentation/ABI/stable/sysfs-bus-nvmem |  2 ++
>>>  drivers/nvmem/Kconfig                    |  5 +++++
>>>  drivers/nvmem/core.c                     | 11 ++++++-----
>>>  3 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem 
>>> b/Documentation/ABI/stable/sysfs-bus-nvmem
>>> index 5923ab4620c5..12aab0a85fea 100644
>>> --- a/Documentation/ABI/stable/sysfs-bus-nvmem
>>> +++ b/Documentation/ABI/stable/sysfs-bus-nvmem
>>> @@ -6,6 +6,8 @@ Description:
>>>          This file allows user to read/write the raw NVMEM contents.
>>>          Permissions for write to this file depends on the nvmem
>>>          provider configuration.
>>> +        Note: This file is not present if CONFIG_NVMEM_NO_SYSFS_ENTRY
>>> +        is enabled
>>>
>>>          ex:
>>>          hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
>>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>>> index 0a7a470ee859..6ab3276d287c 100644
>>> --- a/drivers/nvmem/Kconfig
>>> +++ b/drivers/nvmem/Kconfig
>>> @@ -192,4 +192,9 @@ config SC27XX_EFUSE
>>>        This driver can also be built as a module. If so, the module
>>>        will be called nvmem-sc27xx-efuse.
>>>
>>> +config NVMEM_NO_SYSFS_ENTRY
>>> +    bool "No nvmem sysfs entry"
>>> +
>>> +    help
>>> +        Say Yes if you do not want to add nvmem entry to sysfs.
>>>  endif
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index b9a0270883a0..c70f183fe379 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -216,7 +216,7 @@ static const struct attribute_group 
>>> nvmem_bin_rw_group = {
>>>      .attrs        = nvmem_attrs,
>>>  };
>>>
>>> -static const struct attribute_group *nvmem_rw_dev_groups[] = {
>>> +static const __maybe_unused struct attribute_group 
>>> *nvmem_rw_dev_groups[] = {
>>>      &nvmem_bin_rw_group,
>>>      NULL,
>>>  };
>>> @@ -240,7 +240,7 @@ static const struct attribute_group 
>>> nvmem_bin_ro_group = {
>>>      .attrs        = nvmem_attrs,
>>>  };
>>>
>>> -static const struct attribute_group *nvmem_ro_dev_groups[] = {
>>> +static const __maybe_unused struct attribute_group 
>>> *nvmem_ro_dev_groups[] = {
>>>      &nvmem_bin_ro_group,
>>>      NULL,
>>>  };
>>> @@ -265,7 +265,7 @@ static const struct attribute_group 
>>> nvmem_bin_rw_root_group = {
>>>      .attrs        = nvmem_attrs,
>>>  };
>>>
>>> -static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
>>> +static const __maybe_unused struct attribute_group 
>>> *nvmem_rw_root_dev_groups[] = {
>>>      &nvmem_bin_rw_root_group,
>>>      NULL,
>>>  };
>>> @@ -289,7 +289,7 @@ static const struct attribute_group 
>>> nvmem_bin_ro_root_group = {
>>>      .attrs        = nvmem_attrs,
>>>  };
>>>
>>> -static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>>> +static const __maybe_unused struct attribute_group 
>>> *nvmem_ro_root_dev_groups[] = {
>>>      &nvmem_bin_ro_root_group,
>>>      NULL,
>>>  };
>>> @@ -688,6 +688,7 @@ struct nvmem_device *nvmem_register(const struct 
>>> nvmem_config *config)
>>>      nvmem->read_only = device_property_present(config->dev, 
>>> "read-only") |
>>>                 config->read_only;
>>>
>>> +#if !defined(CONFIG_NVMEM_NO_SYSFS_ENTRY)
>>>      if (config->root_only)
>>>          nvmem->dev.groups = nvmem->read_only ?
>>>              nvmem_ro_root_dev_groups :
>>> @@ -696,7 +697,7 @@ struct nvmem_device *nvmem_register(const struct 
>>> nvmem_config *config)
>>>          nvmem->dev.groups = nvmem->read_only ?
>>>              nvmem_ro_dev_groups :
>>>              nvmem_rw_dev_groups;
>>> -
>>> +#endif
>>>      device_initialize(&nvmem->dev);
>>>
>>>      dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", 
>>> config->name);
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

