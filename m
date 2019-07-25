Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9957322BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfGYSt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:49:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:58904 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfGYSt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:49:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 11:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="197980763"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2019 11:49:27 -0700
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct
 platform_driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com> <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com>
 <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
 <20190706171948.GA23324@kroah.com>
 <CAKdAkRR=fG3i32cY69skYHYmwiT-qQ5pNAzqGkTjisKp9D7teg@mail.gmail.com>
 <20190719115220.GD20044@kroah.com> <20190720043857.GA14290@penguin>
 <20190725134411.GE11115@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <ea210d4d-45ec-4d06-c68d-6a2374e978f9@linux.intel.com>
Date:   Thu, 25 Jul 2019 14:02:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725134411.GE11115@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 7/25/19 8:44 AM, Greg Kroah-Hartman wrote:
> On Sat, Jul 20, 2019 at 07:38:57AM +0300, Dmitry Torokhov wrote:
>> On Fri, Jul 19, 2019 at 08:52:20PM +0900, Greg Kroah-Hartman wrote:
>>> On Sat, Jul 06, 2019 at 10:39:38AM -0700, Dmitry Torokhov wrote:
>>>> On Sat, Jul 6, 2019 at 10:19 AM Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>
>>>>> On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>>
>>>>>>> On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
>>>>>>>> Hi Greg,
>>>>>>>>
>>>>>>>> On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
>>>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>>>>
>>>>>>>>> Platform drivers like to add sysfs groups to their device, but right now
>>>>>>>>> they have to do it "by hand".  The driver core should handle this for
>>>>>>>>> them, but there is no way to get to the bus-default attribute groups as
>>>>>>>>> all platform devices are "special and unique" one-off drivers/devices.
>>>>>>>>>
>>>>>>>>> To combat this, add a dev_groups pointer to platform_driver which allows
>>>>>>>>> a platform driver to set up a list of default attributes that will be
>>>>>>>>> properly created and removed by the platform driver core when a probe()
>>>>>>>>> function is successful and removed right before the device is unbound.
>>>>>>>>
>>>>>>>> Why is this limited to platform bus? Drivers for other buses also
>>>>>>>> often want to augment list of their attributes during probe(). I'd
>>>>>>>> move it to generic probe handling.
>>>>>>>
>>>>>>> This is not limited to the platform at all, the driver core supports
>>>>>>> this for any bus type today, but it's then up to the bus-specific code
>>>>>>> to pass that on to the driver core.  That's usually set for the
>>>>>>> bus-specific attributes that they want exposed for all devices of that
>>>>>>> bus type (see the bus_groups, dev_groups, and drv_groups pointers in
>>>>>>> struct bus_type).
>>>>>>>
>>>>>>> For the platform devices, the problem is that this is something that the
>>>>>>> individual drivers want after they bind to the device.  And as all
>>>>>>> platform devices are "different" they can't be a "common" set of
>>>>>>> attributes, so they need to be created after the device is bound to the
>>>>>>> driver.
>>>>>>
>>>>>> I believe that your assertion that only platform devices want to
>>>>>> install custom attributes is incorrect.
>>>>>
>>>>> Sorry, I didn't mean to imply that only platform drivers want to do
>>>>> this, as you say, many other drivers do as well.
>>>>>
>>>>>> Drivers for devices attached
>>>>>> to serio, i2c, USB, spi, etc, etc, all have additional attributes:
>>>>>>
>>>>>> dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
>>>>>> `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
>>>>>> wc -l
>>>>>> 170
>>>>>>
>>>>>> I am pretty sure some of this count is false positives, but majority
>>>>>> is actually proper hits.
>>>>>
>>>>> Yeah, I know, we need to add this type of functionality to those busses
>>>>> as well.  I don't see a way of doing it other than this bus-by-bus
>>>>> conversion, do you?
>>>>
>>>> Can't you push the **dev_groups from platform driver down to the
>>>> generic driver structure and handle them in driver_sysfs_add()?
>>>
>>> Sorry for the delay, got busy with the merge window...
>>>
>>> Anyway, no, we can't call this then, because driver_sysfs_add() is
>>> called before probe() is called.  So if probe() fails, we don't bind the
>>> device to the driver.  We also should not be creating sysfs files for a
>>> driver that has not had probe() called yet, as internal structures will
>>> not be set up at that time.
>>
>> Ah, yes, I got confused by the fact that driver_sysfs_remove is called
>> early. Anyway, I think you want something like this:
> 
> Ah, nice, this looks good.  Let me try this and see how it goes...
> 

I tried Dmitry's patch on Intel Stratix10 platform and it works.

I added one minor change on the top of Dmitry's patch, since I think we 
need add one additional check prior to device_add_groups(). To align 
with Dmitry's patch, I also change my code to use the new dev_groups 
pointer in the struct of device_driver.

My changes are below,

diff --git a/include/linux/device.h b/include/linux/device.h
index 6717ade..9207aea3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -296,6 +296,7 @@ struct device_driver {
         int (*suspend) (struct device *dev, pm_message_t state);
         int (*resume) (struct device *dev);
         const struct attribute_group **groups;
+       const struct attribute_group **dev_groups;

         const struct dev_pm_ops *pm;

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 994a907..a91e69f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -554,9 +554,19 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
                         goto probe_failed;
         }

+       if (drv->dev_groups) {
+               if (device_add_groups(dev, drv->dev_groups)) {
+                       dev_err(dev, "device_add_groups(%s) failed\n",
+                               dev_name(dev));
+                       goto dev_groups_failed;
+               }
+       }
+
         if (test_remove) {
                 test_remove = false;

+               device_remove_groups(dev, drv->dev_groups);
+
                 if (dev->bus->remove)
                         dev->bus->remove(dev);
                 else if (drv->remove)
@@ -584,6 +594,12 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
                  drv->bus->name, __func__, dev_name(dev), drv->name);
         goto done;

+dev_groups_failed:
+       if (dev->bus->remove)
+               dev->bus->remove(dev);
+       else if (drv->remove)
+               drv->remove(dev);
+
  probe_failed:
         if (dev->bus)
                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
@@ -1114,6 +1130,8 @@ static void __device_release_driver(struct device 
*dev, struct device *parent)

                 pm_runtime_put_sync(dev);

+               device_remove_groups(dev, drv->dev_groups);
+
                 if (dev->bus && dev->bus->remove)
                         dev->bus->remove(dev);
                 else if (drv->remove)


diff --git a/drivers/firmware/stratix10-rsu.c 
b/drivers/firmware/stratix10-rsu.c
index 98d8030..93b44e9 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -391,9 +391,9 @@ static int stratix10_rsu_remove(struct 
platform_device *pdev)
  static struct platform_driver stratix10_rsu_driver = {
         .probe = stratix10_rsu_probe,
         .remove = stratix10_rsu_remove,
         .driver = {
                 .name = "stratix10-rsu",
+               .dev_groups = rsu_groups,
         },
  };

Regards,
Richard

>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 0df9b4461766..61d9d650d890 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -515,9 +515,17 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>   			goto probe_failed;
>>   	}
>>   
>> +	if (device_add_groups(dev, drv->dev_groups)) {
>> +		printk(KERN_ERR "%s: device_add_groups(%s) failed\n",
>> +			__func__, dev_name(dev));
> 
> dev_err() of course :)
> 
> thanks for the review, much appreciated.
> 
> greg k-h
> 
