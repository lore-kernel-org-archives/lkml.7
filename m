Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8738020818
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WN0wzIFU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cQr12Gmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfENLAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:00:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfENLAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:00:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2305608D4; Tue, 14 May 2019 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557831603;
        bh=xSkLRV2QGI8N8EyzVbCKEkYGEF5Z3gTYYuoMnN/Fx/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WN0wzIFUs/GOugJhJ2WWH+4B1BLt7/EuR82KpU0l5iifupcZxiPPlw4teYFs7RiEV
         esBndgilyoz3FTgcIaCe/khyFI6xgw0uJdpQ7Xg0zCY/9xqUcQNpnOVgYG2FCi4Ljb
         HAQaeok+69ZbUJkOskb7ll+uwsY4PthnU2/DLlDg=
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F388601D4;
        Tue, 14 May 2019 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557831602;
        bh=xSkLRV2QGI8N8EyzVbCKEkYGEF5Z3gTYYuoMnN/Fx/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cQr12GmmGBse208Ems1ZU5Jlz2+rPQke82kPfVbGROSm09QNxE9x/F2DwCUneUySx
         8P2c92Sepp3lJMeB+J9N+EeGHNpNkHxVK0A/y9Mhgd079eVYT+yBgkHIIQ7gASe8ej
         1hi+Y65hgY8avea0YUg1rRv7SseTQji8kYNHT4sk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F388601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue
 directory
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Muchun Song <smuchun@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190423143258.96706-1-smuchun@gmail.com>
 <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
 <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
 <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
 <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com>
 <79fbc203bc9fa09d88ab2c4bff8635be4c293d49.camel@kernel.crashing.org>
 <CAPSr9jHw9hgAZo2TuDAKdSLEG1c6EtJG005MWxsxfnbsk1AXow@mail.gmail.com>
 <d9495ef6-17bc-dc50-f5fe-fb5ff20edfde@codeaurora.org>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <c0166ef7-ef76-56d8-6289-276573e3aea7@codeaurora.org>
Date:   Tue, 14 May 2019 16:29:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d9495ef6-17bc-dc50-f5fe-fb5ff20edfde@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 4:26 PM, Mukesh Ojha wrote:
> ++
> 
> On 5/4/2019 8:17 PM, Muchun Song wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> 于2019年5月2日周四 下午2:25写道：
>>
>>>>> The basic idea yes, the whole bool *locked is horrid though.
>>>>> Wouldn't it
>>>>> work to have a get_device_parent_locked that always returns with
>>>>> the mutex held,
>>>>> or just move the mutex to the caller or something simpler like this
>>>>> ?
>>>>>
>>>> Greg and Rafael, do you have any suggestions for this? Or you also
>>>> agree with Ben?
>>> Ping guys ? This is worth fixing...
>> I also agree with you. But Greg and Rafael seem to be high latency right now.
>>
>>  From your suggestions, I think introduce get_device_parent_locked() may easy
>> to fix. So, do you agree with the fix of the following code snippet
>> (You can also
>> view attachments)?
>>
>> I introduce a new function named get_device_parent_locked_if_glue_dir() which
>> always returns with the mutex held only when we live in glue dir. We should call
>> unlock_if_glue_dir() to release the mutex. The
>> get_device_parent_locked_if_glue_dir()
>> and unlock_if_glue_dir() should be called in pairs.
>>
>> ---
>> drivers/base/core.c | 44 ++++++++++++++++++++++++++++++++++++--------
>> 1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 4aeaa0c92bda..5112755c43fa 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -1739,8 +1739,9 @@ class_dir_create_and_add(struct class *class,
>> struct kobject *parent_kobj)
>> static DEFINE_MUTEX(gdp_mutex);
>> -static struct kobject *get_device_parent(struct device *dev,
>> -                    struct device *parent)
>> +static struct kobject *__get_device_parent(struct device *dev,
>> +                    struct device *parent,
>> +                    bool lock)
>> {
>>     if (dev->class) {
>>         struct kobject *kobj = NULL;
>> @@ -1779,14 +1780,16 @@ static struct kobject
>> *get_device_parent(struct device *dev,
>>             }
>>         spin_unlock(&dev->class->p->glue_dirs.list_lock);
>>         if (kobj) {
>> -           mutex_unlock(&gdp_mutex);
>> +           if (!lock)
>> +               mutex_unlock(&gdp_mutex);
>>             return kobj;
>>         }
>>         /* or create a new class-directory at the parent device */
>>         k = class_dir_create_and_add(dev->class, parent_kobj);
>>         /* do not emit an uevent for this simple "glue" directory */
>> -       mutex_unlock(&gdp_mutex);
>> +       if (!lock)
>> +           mutex_unlock(&gdp_mutex);
>>         return k;
>>     }
>> @@ -1799,6 +1802,19 @@ static struct kobject *get_device_parent(struct
>> device *dev,
>>     return NULL;
>> }
>> +static inline struct kobject *get_device_parent(struct device *dev,
>> +                       struct device *parent)
>> +{
>> +   return __get_device_parent(dev, parent, false);
>> +}
>> +
>> +static inline struct kobject *
>> +get_device_parent_locked_if_glue_dir(struct device *dev,
>> +                struct device *parent)
>> +{
>> +   return __get_device_parent(dev, parent, true);
>> +}
>> +
>> static inline bool live_in_glue_dir(struct kobject *kobj,
>>                  struct device *dev)
>> {
>> @@ -1831,6 +1847,16 @@ static void cleanup_glue_dir(struct device
>> *dev, struct kobject *glue_dir)
>>     mutex_unlock(&gdp_mutex);
>> }
>> +static inline void unlock_if_glue_dir(struct device *dev,
>> +                struct kobject *glue_dir)
>> +{
>> +   /* see if we live in a "glue" directory */
>> +   if (!live_in_glue_dir(glue_dir, dev))
>> +       return;
>> +
>> +   mutex_unlock(&gdp_mutex);
>> +}
>> +
>> static int device_add_class_symlinks(struct device *dev)
>> {
>>     struct device_node *of_node = dev_of_node(dev);
>> @@ -2040,7 +2066,7 @@ int device_add(struct device *dev)
>>     pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
>>     parent = get_device(dev->parent);
>> -   kobj = get_device_parent(dev, parent);
>> +   kobj = get_device_parent_locked_if_glue_dir(dev, parent);
>>     if (IS_ERR(kobj)) {
>>         error = PTR_ERR(kobj);
>>         goto parent_error;
>> @@ -2055,10 +2081,12 @@ int device_add(struct device *dev)
>>     /* first, register with generic layer. */
>>     /* we require the name to be set before, and pass NULL */
>>     error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
>> -   if (error) {
>> -       glue_dir = get_glue_dir(dev);
>> +
>> +   glue_dir = get_glue_dir(dev);
>> +   unlock_if_glue_dir(dev, glue_dir);
>> +
>> +   if (error)
>>         goto Error;
>> -   }
>>     /* notify platform of device entry */
>>     error = device_platform_notify(dev, KOBJ_ADD);
>> -- 

This change has been done in device_add(). AFAICT, locked
version of get_device_parent should be used in device_move()
also.

Thanks

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
