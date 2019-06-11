Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73106C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1BF212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvUUJzsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404630AbfFKPSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:18:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35596 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfFKPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:18:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so7645994pfd.2;
        Tue, 11 Jun 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nWL90qXjUuK8w+rtJZaynRsIXMY+sEETNIVgozGcpYY=;
        b=hvUUJzscbqBqMtPEpSRuAuTno/JL6vDZa4C3VZHRLut01wds25WxWaiXi0hBAIpkoW
         jNcMfBqsrcp1KT/6fFkHImK4/emdBsRF+jFmEr6+pSE0WauLpXCwJpzIS5kG+A5VrGq/
         W0eVkzBzeXBocol9+uzyekHrXBcENDbMtU/K5kDYtuza2TY+BCp1rEJ8s6XH4txjDOu4
         yiUov03zBYKi5wZF5PIkOJqHM5skau1sl1KO2/H1KUszXuzVpHVsdnoGmCrkvTVpGqSD
         vyn7IeTeti0gOcYDKUr3kCgRrVoSwZLFOR3mVzBfCkGxgMQVStXP26RRWD7KQ8Jizg2l
         wCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWL90qXjUuK8w+rtJZaynRsIXMY+sEETNIVgozGcpYY=;
        b=BIY+Zi3KSfyGcWOvpfAlWP5tEeuSGMS59RORMBK4XIZKiAjm8yJApUGrIp9PxshBxL
         avwveUi3Pod2/YURksznobG8IXJ4+HqE/6Pe1zDX20dJWtPcouflxWL5xOhI3t+xNhA0
         KHxddx7ILU7VngS5suDe6A3mAsSrS0gGXp9gkjBiYivnDqmmTmxnhV1PbHUcYPYKTt92
         2QeAEd6nJdeMArJOrdbyRj+QaqbvW6pQwGmqUqUpckfEDjAjJKTt4U89BFDnLBFz7b0L
         1++565bxEZlRXPtcZ1ma4ytZ6uz2Ef/IQMP26MtrDYjBZVx0Yz9I1rYdLo7xsT1KATGt
         vvLw==
X-Gm-Message-State: APjAAAXT4/tfBxDgnNwv+GycPyQfw5CJlmPQbB1uM4pKIvtMC9supmjF
        ZH+yuMZesMiaBv30arsMwyY=
X-Google-Smtp-Source: APXvYqzqf8kgGYBTPaIZ1SBTEBOIIkVoUdOeKbbH7LVXNmxiy2I3a6qFL2H3o2/OGR3G+E5S/h5toA==
X-Received: by 2002:a63:1657:: with SMTP id 23mr19568964pgw.98.1560266324025;
        Tue, 11 Jun 2019 08:18:44 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d6sm12660100pgv.4.2019.06.11.08.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:18:43 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up
 of_find_device_by_node()
To:     Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <570474f4-8749-50fd-5f72-36648ed44653@gmail.com>
Date:   Tue, 11 Jun 2019 08:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 6/10/19 10:36 AM, Rob Herring wrote:
> Why are you resending this rather than replying to Frank's last
> comments on the original?

Adding on a different aspect...  The independent replies from three different
maintainers (Rob, Mark, myself) pointed out architectural issues with the
patch series.  There were also some implementation issues brought out.
(Although I refrained from bringing up most of my implementation issues
as they are not relevant until architecture issues are resolved.)

When three maintainers say the architecture has issues, you should step
back and think hard.  (Not to say maintainers are always correct...)

My suggestion at this point is that you need to go back to the drawing board
and re-think how to address the use case.

-Frank

> 
> On Mon, Jun 3, 2019 at 6:32 PM Saravana Kannan <saravanak@google.com> wrote:
>>
>> Add a pointer from device tree node to the device created from it.
>> This allows us to find the device corresponding to a device tree node
>> without having to loop through all the platform devices.
>>
>> However, fallback to looping through the platform devices to handle
>> any devices that might set their own of_node.
>>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> ---
>>  drivers/of/platform.c | 20 +++++++++++++++++++-
>>  include/linux/of.h    |  3 +++
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 04ad312fd85b..1115a8d80a33 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
>>         return dev->of_node == data;
>>  }
>>
>> +static DEFINE_SPINLOCK(of_dev_lock);
>> +
>>  /**
>>   * of_find_device_by_node - Find the platform_device associated with a node
>>   * @np: Pointer to device tree node
>> @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>>  {
>>         struct device *dev;
>>
>> -       dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
>> +       /*
>> +        * Spinlock needed to make sure np->dev doesn't get freed between NULL
>> +        * check inside and kref count increment inside get_device(). This is
>> +        * achieved by grabbing the spinlock before setting np->dev = NULL in
>> +        * of_platform_device_destroy().
>> +        */
>> +       spin_lock(&of_dev_lock);
>> +       dev = get_device(np->dev);
>> +       spin_unlock(&of_dev_lock);
>> +       if (!dev)
>> +               dev = bus_find_device(&platform_bus_type, NULL, np,
>> +                                     of_dev_node_match);
>>         return dev ? to_platform_device(dev) : NULL;
>>  }
>>  EXPORT_SYMBOL(of_find_device_by_node);
>> @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
>>                 platform_device_put(dev);
>>                 goto err_clear_flag;
>>         }
>> +       np->dev = &dev->dev;
>>
>>         return dev;
>>
>> @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
>>         if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
>>                 device_for_each_child(dev, NULL, of_platform_device_destroy);
>>
>> +       /* Spinlock is needed for of_find_device_by_node() to work */
>> +       spin_lock(&of_dev_lock);
>> +       dev->of_node->dev = NULL;
>> +       spin_unlock(&of_dev_lock);
>>         of_node_clear_flag(dev->of_node, OF_POPULATED);
>>         of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 0cf857012f11..f2b4912cbca1 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -48,6 +48,8 @@ struct property {
>>  struct of_irq_controller;
>>  #endif
>>
>> +struct device;
>> +
>>  struct device_node {
>>         const char *name;
>>         phandle phandle;
>> @@ -68,6 +70,7 @@ struct device_node {
>>         unsigned int unique_id;
>>         struct of_irq_controller *irq_trans;
>>  #endif
>> +       struct device *dev;             /* Device created from this node */
>>  };
>>
>>  #define MAX_PHANDLE_ARGS 16
>> --
>> 2.22.0.rc1.257.g3120a18244-goog
>>
> .
> 

