Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F98C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08C20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR+o+HdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEYAMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:12:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35075 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEYAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:12:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so4023428pfd.2;
        Fri, 24 May 2019 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=legFY0topXHt5n7Q1f3qF4TFm8c+jyoWIg2AC5lE/QU=;
        b=HR+o+HdR8Tx9MiiNaaz5TfmPHgXL/vA9YlYYBVE93WpQn9gv7XDavOTo4Ez0WGU4Jh
         9BTpLktDC5hszrIzgDVK4mLE5H8GKKZJmLnwqWt7nBoG48wmQTYEwj46TzSeU6PObdCU
         jU0B35sLjWri+tiIUWPsHOAqGcJdCsNsMr/psE87/cpQ6Fqp1daANfc4P6+I44tY1f/P
         rI8aeXEj3YuqJGTX6qZMHriH3n0y2Ov9I/vtLGiYB8DazXbp8S5Kr4fZ+2I7u7Zl0Aok
         0ivXCROMtGKVcxt38EKqh7YabKWx4Zgre9rGvxVQjQKHEUp3EgtnuO3Oq2LG8dLwXrPP
         zLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=legFY0topXHt5n7Q1f3qF4TFm8c+jyoWIg2AC5lE/QU=;
        b=SNYElyyYLwXcUNKD6LRqzLT3lYj2810lUFer3zXU7SQxL5jyIfqlrs9qBUkPC6t0Ch
         Fzdtt6HWSxupty7EPpuWCl7vqZDI54unxRhShb1ecVMOGY1GUndkY2XnX47j23ZytQIM
         t0QL327y4dFL35xUSeH6f51Egplr1+ieCZnPuQjOwn0E1uGHmPbXfWknlp7GtnQc5+/Z
         uZQ18xZP+I2wWGXq3LKikQKDYn0OxgukboQLM4Phgtl7E2Z88q0/6BDIUpsOSy/bnSZF
         i/lHfxfe9IleKCCpJsxKSnSsgh/yf2EjygprYsZzjxICv3Xme0igCx4z026RAcc3jY8W
         mgiw==
X-Gm-Message-State: APjAAAV/HpPAdsmnaCb8v+f8uKkKaH1Q8zHU3iEDC/YRJebcaCQUkP3r
        ooyWfZkqzOR6u0bRZHx9Cnw=
X-Google-Smtp-Source: APXvYqxAWP4YJjFNdmQ300Km3eF/N8ToxlpRskJ2TBptA7rPHrqNglTI/Ay3sBNdK9IToPNbCgY/+A==
X-Received: by 2002:a17:90b:d97:: with SMTP id bg23mr13327211pjb.87.1558743157133;
        Fri, 24 May 2019 17:12:37 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y17sm3650641pfn.79.2019.05.24.17.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 17:12:36 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190524010117.225219-1-saravanak@google.com>
 <20190524010117.225219-2-saravanak@google.com>
 <6f4ca588-106f-93d1-8579-9e8d32c8031d@gmail.com>
 <CAGETcx9zgMs5ne3jPa+6xR+EHR=+QuF7XfRb1gpenh-3ZQwV+w@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b3a88f46-5c3b-0e33-e08f-e0d9b5df2864@gmail.com>
Date:   Fri, 24 May 2019 17:12:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx9zgMs5ne3jPa+6xR+EHR=+QuF7XfRb1gpenh-3ZQwV+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 11:21 AM, Saravana Kannan wrote:
> On Fri, May 24, 2019 at 10:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> Hi Sarvana,
>>
>> I'm not reviewing patches 1-5 in any detail, given my reply to patch 0.
>>
>> But I had already skimmed through this patch before I received the
>> email for patch 0, so I want to make one generic comment below,
>> to give some feedback as you continue thinking through possible
>> implementations to solve the underlying problems.
> 
> Appreciate the feedback Frank!
> 
>>
>>
>> On 5/23/19 6:01 PM, Saravana Kannan wrote:
>>> Add a pointer from device tree node to the device created from it.
>>> This allows us to find the device corresponding to a device tree node
>>> without having to loop through all the platform devices.
>>>
>>> However, fallback to looping through the platform devices to handle
>>> any devices that might set their own of_node.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> ---
>>>  drivers/of/platform.c | 20 +++++++++++++++++++-
>>>  include/linux/of.h    |  3 +++
>>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index 04ad312fd85b..1115a8d80a33 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
>>>       return dev->of_node == data;
>>>  }
>>>
>>> +static DEFINE_SPINLOCK(of_dev_lock);
>>> +
>>>  /**
>>>   * of_find_device_by_node - Find the platform_device associated with a node
>>>   * @np: Pointer to device tree node
>>> @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>>>  {
>>>       struct device *dev;
>>>
>>> -     dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
>>> +     /*
>>> +      * Spinlock needed to make sure np->dev doesn't get freed between NULL
>>> +      * check inside and kref count increment inside get_device(). This is
>>> +      * achieved by grabbing the spinlock before setting np->dev = NULL in
>>> +      * of_platform_device_destroy().
>>> +      */
>>> +     spin_lock(&of_dev_lock);
>>> +     dev = get_device(np->dev);
>>> +     spin_unlock(&of_dev_lock);
>>> +     if (!dev)
>>> +             dev = bus_find_device(&platform_bus_type, NULL, np,
>>> +                                   of_dev_node_match);
>>>       return dev ? to_platform_device(dev) : NULL;
>>>  }
>>>  EXPORT_SYMBOL(of_find_device_by_node);
>>> @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
>>>               platform_device_put(dev);
>>>               goto err_clear_flag;
>>>       }
>>> +     np->dev = &dev->dev;
>>>
>>>       return dev;
>>>
>>> @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
>>>       if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
>>>               device_for_each_child(dev, NULL, of_platform_device_destroy);
>>>
>>> +     /* Spinlock is needed for of_find_device_by_node() to work */
>>> +     spin_lock(&of_dev_lock);
>>> +     dev->of_node->dev = NULL;
>>> +     spin_unlock(&of_dev_lock);
>>>       of_node_clear_flag(dev->of_node, OF_POPULATED);
>>>       of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>>>
>>> diff --git a/include/linux/of.h b/include/linux/of.h
>>> index 0cf857012f11..f2b4912cbca1 100644
>>> --- a/include/linux/of.h
>>> +++ b/include/linux/of.h
>>> @@ -48,6 +48,8 @@ struct property {
>>>  struct of_irq_controller;
>>>  #endif
>>>
>>> +struct device;
>>> +
>>>  struct device_node {
>>>       const char *name;
>>>       phandle phandle;
>>> @@ -68,6 +70,7 @@ struct device_node {
>>>       unsigned int unique_id;
>>>       struct of_irq_controller *irq_trans;
>>>  #endif
>>> +     struct device *dev;             /* Device created from this node */
>>
>> We have actively been working on shrinking the size of struct device_node,
>> as part of reducing the devicetree memory usage.  As such, we need strong
>> justification for adding anything to this struct.  For example, proof that
>> there is a performance problem that can only be solved by increasing the
>> memory usage.
> 
> I didn't mean for people to focus on the deferred probe optimization.

I was speaking specifically of the of_find_device_by_node() optimization.
I did not chase any further back in the call chain to see how that would
impact anything else.  My comments stand, whether this patch is meant
to optimize deferred probe optimization or to optimize something else.


> In reality that was just a added side benefit of this series. The main
> problem to solve is that of suppliers having to know when all their
> consumers are up and managing the resources actively, especially in a
> system with loadable modules where we can't depend on the driver to
> notify the supplier because the consumer driver module might not be
> available or loaded until much later.
> 
> Having said that, I'm not saying we should go around and waste space
> willy-nilly. But, isn't the memory usage going to increase based on
> the number of DT nodes present in DT? I'd think as the number of DT
> nodes increase it's more likely for those devices have more memory? So
> at least in this specific case I think adding the field is justified.

Struct device_node is the nodes of the in kernel devicetree data.  This
patch adds a field to every single node of the devicetree.

The patch series is also adding a new property, of varying size, to
some nodes.  This also results in additional memory usage by
devicetree. 

Arguing that a more complex system is likely to have more memory is
likely true, but beside the point.  Minimizing devicetree memory
used on less complex systems is also one of our goals.


> Also, right now the look up is O(n) complexity and if we are trying to
> add device links to most of the devices, that whole process becomes
> O(n^2). Having this field makes the look up a O(1) and the entire
> linking process a O(n) process. I think the memory usage increase is
> worth the efficiency improvement.

Hand waving about O(n) and O(1) and O(n2) is not sufficient.  We require
actual measurements that show O(n2) (when the existing algorithm is such)
is a performance problem and that the proposed change to the algorithm
results in a specific change in the performance.

The devicetree maintainers have decided that memory use is important and
to be minimized, and the burden of proof that performance is an issue
lies on the submitter of a patch that improves performance at the cost
of memory.

Most devicetree boot time cpu overhead only affects the boot event.
Added memory use persists for the entire booted lifetime of the system.

That is not to say that we never increase memory use to improve boot
performance.  We have done so when the measured performance issue and
measured performance improvement justified the change.

> 
> And if people are still strongly against it, we could make this a config option.
> 
> -Saravana
> 

