Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BAEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00DA2343C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzdt7evj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfH3ItN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:49:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3ItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:49:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so4212081pfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fy5RCypOSw6fnMqIi43Vs9ijq5L4lXewxgc5rJ+S784=;
        b=fzdt7evj4rlMEqd5KHksjF6VnY+xn4/xz4I80NKZ/dQUtWUKrw7Q6zO6ygp7pz2Q5j
         t1addEM9E4vuNe2zteRvZgieLEdK/tUID3exQfdNn//bI5d8WFKJYwoVfzZ9KgZgw+Qf
         tmRdO7Bzoq+O9EuK856y6YYxMO+2nPvNgGkmigd7JF+I/V6dqXpEsYSDvHz+5+JEhU9m
         /p3V1wB0alchS6PwbPej3sDCBnLIgelAAyncw0bMYuRq1jVn1QHwWEWm3QfbbBOmqvpE
         zpeqxryV6SSKbvPFzbnHh608lHki6wvIgwRKz4ptXtbyxQ8szE8lg+rf7AAk5qLpdrTs
         aQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fy5RCypOSw6fnMqIi43Vs9ijq5L4lXewxgc5rJ+S784=;
        b=cNVj9xeJIvjul6WJjAaeawedZdSZz8koco4SIPCzBMaEkUS52r5fzvUzukhJQoIm4r
         XHMS4aJ2Ze5oEPYQkv5FVG8wQVWMxyCicvieba6lWwQmk7yWXfFOXtzZp3H9lv1ohAmX
         6XxJ4YsVDD7/08P1jPfcCULi+RsPLLyYA5GrMLPOdn5p3jn4Ta5x4bwlsgWraJrOSsen
         tuiueQm5u21jPZofOUHSLhPjUZtgrBp0KBckdikzRSxwPldFxSLk+nUowXj1egjVQpt+
         KEzkmV2lEPplMyuqa7ZVOfIIMoJWWprQgA+8DwXg2KWBM2onNQNaVJjtjLQMWIhfq5qf
         FwiA==
X-Gm-Message-State: APjAAAX5yJl5khSd13f9g5YP2zQXkfteeiD/utaAmE7giP/EfoEeWBFL
        CKZvwbvx9wBhFmbw7XqYIk0eCw==
X-Google-Smtp-Source: APXvYqyTBbRFyDb26C0HRFORUu3wBQNviNWQ1kv0/WpSFJkysfo5WfQhySFhW0guy5rkmbEPS4RLdg==
X-Received: by 2002:a17:90a:9105:: with SMTP id k5mr2998899pjo.9.1567154951754;
        Fri, 30 Aug 2019 01:49:11 -0700 (PDT)
Received: from ?IPv6:240e:362:494:1a00:8c5c:fbf7:e27e:53b2? ([240e:362:494:1a00:8c5c:fbf7:e27e:53b2])
        by smtp.gmail.com with ESMTPSA id a6sm4273404pjv.30.2019.08.30.01.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 01:49:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] uacce: add uacce driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1566998876-31770-1-git-send-email-zhangfei.gao@linaro.org>
 <1566998876-31770-3-git-send-email-zhangfei.gao@linaro.org>
 <20190828152201.GA10163@kroah.com>
 <5c2b0889-ea05-1ecd-fe5b-40611bd31945@linaro.org>
 <20190829095439.GA13915@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0fe1ac96-4332-45f2-ba1e-2283420b65fe@linaro.org>
Date:   Fri, 30 Aug 2019 16:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829095439.GA13915@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On 2019/8/29 下午5:54, Greg Kroah-Hartman wrote:
> On Thu, Aug 29, 2019 at 05:05:13PM +0800, zhangfei wrote:
>> Hi, Greg
>>
>> On 2019/8/28 下午11:22, Greg Kroah-Hartman wrote:
>>> On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
>>>> +struct uacce {
>>>> +	const char *drv_name;
>>>> +	const char *algs;
>>>> +	const char *api_ver;
>>>> +	unsigned int flags;
>>>> +	unsigned long qf_pg_start[UACCE_QFRT_MAX];
>>>> +	struct uacce_ops *ops;
>>>> +	struct device *pdev;
>>>> +	bool is_vf;
>>>> +	u32 dev_id;
>>>> +	struct cdev cdev;
>>>> +	struct device dev;
>>>> +	void *priv;
>>>> +	atomic_t state;
>>>> +	int prot;
>>>> +	struct mutex q_lock;
>>>> +	struct list_head qs;
>>>> +};
>>> At a quick glance, this problem really stood out to me.  You CAN NOT
>>> have two different objects within a structure that have different
>>> lifetime rules and reference counts.  You do that here with both a
>>> 'struct cdev' and a 'struct device'.  Pick one or the other, but never
>>> both.
>>>
>>> I would recommend using a 'struct device' and then a 'struct cdev *'.
>>> That way you get the advantage of using the driver model properly, and
>>> then just adding your char device node pointer to "the side" which
>>> interacts with this device.
>>>
>>> Then you might want to call this "struct uacce_device" :)
>> Here the 'struct cdev' and 'struct device' have the same lifetime and
>> refcount.
> No they do not, that's impossible as refcounts are incremented from
> different places (i.e. userspace).
Yes, cdev's refcount is increased by open, from user space.

Not sure whether I understand correctly, Is this correct?

@@ -819,9 +819,10 @@ static int uacce_create_chrdev(struct uacce *uacce)
         if (ret < 0)
                 return ret;

-       cdev_init(&uacce->cdev, &uacce_fops);
+       uacce->cdev = cdev_alloc();
+       uacce->cdev->ops = &uacce_fops;
         uacce->dev_id = ret;
-       uacce->cdev.owner = THIS_MODULE;
+       uacce->cdev->owner = THIS_MODULE;
         device_initialize(&uacce->dev);
         uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
         uacce->dev.class = uacce_class;
@@ -829,7 +830,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
         uacce->dev.parent = uacce->pdev;
         uacce->dev.release = uacce_release;
         dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
-       ret = cdev_device_add(&uacce->cdev, &uacce->dev);
+       ret = cdev_device_add(uacce->cdev, &uacce->dev);
         if (ret)
                 goto err_with_idr;

@@ -843,7 +844,7 @@ static int uacce_create_chrdev(struct uacce *uacce)

  static void uacce_destroy_chrdev(struct uacce *uacce)
  {
-       cdev_device_del(&uacce->cdev, &uacce->dev);
+       cdev_device_del(uacce->cdev, &uacce->dev);
         put_device(&uacce->dev);
  }

diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 1892b94..39a2c4b 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -155,7 +155,7 @@ struct uacce {
         struct device *pdev;
         bool is_vf;
         u32 dev_id;
-       struct cdev cdev;
+       struct cdev *cdev;

And use struct uacce_device instead of struct uacce

-struct uacce *uacce_register(struct device *parent,
-                            struct uacce_interface *interface);
+struct uacce_device *uacce_register(struct device *parent,
+                                   struct uacce_interface *interface);

>
>> They are allocated with uacce when uacce_register and freed when
>> uacce_unregister.
> And that will not work.
>
>> To make it clear, how about adding this.
>>
>> +static void uacce_release(struct device *dev)
>> +{
>> +       struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +
>> +       idr_remove(&uacce_idr, uacce->dev_id);
>> +       kfree(uacce);
>> +}
>> +
>>   static int uacce_create_chrdev(struct uacce *uacce)
>>   {
>>          int ret;
>> @@ -819,6 +827,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
>>          uacce->dev.class = uacce_class;
>>          uacce->dev.groups = uacce_dev_attr_groups;
>>          uacce->dev.parent = uacce->pdev;
>> +       uacce->dev.release = uacce_release;
> You have to have a release function today, otherwise you will get nasty
> kernel messages from the log.  I don't know why you aren't seeing that
> already.
Yes, kernel report warning after using put_device.
>
>>          dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
>>          ret = cdev_device_add(&uacce->cdev, &uacce->dev);
>>          if (ret)
>> @@ -835,7 +844,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
>>   static void uacce_destroy_chrdev(struct uacce *uacce)
>>   {
>>          cdev_device_del(&uacce->cdev, &uacce->dev);
>> -       idr_remove(&uacce_idr, uacce->dev_id);
>> +       put_device(&uacce->dev);
>>   }
>>
>>   static int uacce_dev_match(struct device *dev, void *data)
>> @@ -1042,8 +1051,6 @@ void uacce_unregister(struct uacce *uacce)
>>          uacce_destroy_chrdev(uacce);
>>
>>          mutex_unlock(&uacce_mutex);
>> -
>> -       kfree(uacce);
>>   }
>>
>>
>> uacce_destroy_chrdev->put_device(&uacce->dev)->uacce_release->kfree(uacce).
>>
>> And find there are many examples in driver/
>> $ grep -rn cdev_device_add drivers/
>> drivers/rtc/class.c:362:        err = cdev_device_add(&rtc->char_dev,
>> &rtc->dev);
>> rivers/gpio/gpiolib.c:1181:    status = cdev_device_add(&gdev->chrdev,
>> &gdev->dev);
>> drivers/soc/qcom/rmtfs_mem.c:223:       ret =
>> cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>> drivers/input/joydev.c:989:     error = cdev_device_add(&joydev->cdev,
>> &joydev->dev);
>> drivers/input/mousedev.c:907:   error = cdev_device_add(&mousedev->cdev,
>> &mousedev->dev);
>> drivers/input/evdev.c:1419:     error = cdev_device_add(&evdev->cdev,
>> &evdev->dev);
> Are you sure these all have the full structures inbedded in them?
>
>> like drivers/input/evdev.c,
>> evdev is alloced with initialization of dev and cdev,
>> and evdev is freed in release ops evdev_free
>> struct evdev {
>>          struct device dev;
>>          struct cdev cdev;
>>          ~
> Ick, that too is totally wrong and needs to be fixed.
>
> Please don't copy incorrect code, that's why we review stuff :)
>
OK, understand. Thanks Greg.

