Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32013C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E519A208C0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2nULxYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfFFVLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:11:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42186 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ut4YjnRsAbKvSUoR/ii92dovZhOptemNBKQari9Qhk=; b=A2nULxYVaPNiHW0dryiOZdmMXH
        kvf1HcByP2wFmionA4GjDMff/pbPpzBQSUWnVspw3/lbLfAE4kFBbHbDKdZBXOyBJpWrEoSHB8wCa
        cfqkwc5gnVPwFzwLeTkmlpFu90kMiJyx+l6BrscwuFeoz3blwF0gXqGjt8TuaUR3CGU5FCQ1m3myq
        NDO4fpYZU4kOWsGN2s0j3NWR1edCLcFTdOn6T8mRF5S6yX5EWwd2zValRO1IJetkZBx9UaKV83clp
        L1tJYGAf5vawviDBW56oIdiHtjhRGc4h0gf2/zoFgabNVRvEnmhg9horOivhdA4C4in5ZA8/hyQoP
        Gh5weo2g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYzf5-0006BU-D3; Thu, 06 Jun 2019 21:11:03 +0000
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, Enno Luebbers <enno.luebbers@intel.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>, Wu Hao <hao.wu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jilayne Lovejoy <opensource@jilayne.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-4-enric.balletbo@collabora.com>
 <20190604155228.GB9981@kroah.com>
 <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
 <20190604183527.GA20098@kroah.com>
 <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
 <20190604185953.GA2061@kroah.com>
 <bda48bf80add26153e531912fbfca25071934c94.camel@collabora.com>
 <20190606145121.GA13048@kroah.com>
 <1cfc4bfab8d9d8a47e5dacaca88a7fe30ae83076.camel@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c577a7f8-b4d6-0574-bc0e-993637ced41f@infradead.org>
Date:   Thu, 6 Jun 2019 14:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1cfc4bfab8d9d8a47e5dacaca88a7fe30ae83076.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/19 8:12 AM, Ezequiel Garcia wrote:
> On Thu, 2019-06-06 at 16:51 +0200, Greg Kroah-Hartman wrote:
>> On Thu, Jun 06, 2019 at 11:01:17AM -0300, Ezequiel Garcia wrote:
>>> On Tue, 2019-06-04 at 20:59 +0200, Greg Kroah-Hartman wrote:
>>>> On Tue, Jun 04, 2019 at 11:39:21AM -0700, Guenter Roeck wrote:
>>>>> On Tue, Jun 4, 2019 at 11:35 AM Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>> On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
>>>>>>> Hey Greg,
>>>>>>>
>>>>>>>>> + dev_info(&pdev->dev, "Created misc device /dev/%s\n",
>>>>>>>>> +          data->misc.name);
>>>>>>>>
>>>>>>>> No need to be noisy, if all goes well, your code should be quiet.
>>>>>>>>
>>>>>>>
>>>>>>> I sometimes wonder about this being noise or not, so I will slightly
>>>>>>> hijack this thread for this discussion.
>>>>>>>
>>>>>>>> From a kernel developer point-of-view, or even from a platform
>>>>>>> developer or user with a debugging hat point-of-view, having
>>>>>>> a "device created" or "device registered" message is often very useful.
>>>>>>
>>>>>> For you, yes.  For someone with 30000 devices attached to their system,
>>>>>> it is not, and causes booting to take longer than it should be.
>>>>>>
>>>>>>> In fact, I wish people would do this more often, so I don't have to
>>>>>>> deal with dynamic debug, or hack my way:
>>>>>>>
>>>>>>> diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
>>>>>>> index 4589631798c9..473549b26bb2 100644
>>>>>>> --- a/drivers/media/i2c/ov5647.c
>>>>>>> +++ b/drivers/media/i2c/ov5647.c
>>>>>>> @@ -603,7 +603,7 @@ static int ov5647_probe(struct i2c_client *client,
>>>>>>>         if (ret < 0)
>>>>>>>                 goto error;
>>>>>>>
>>>>>>> -       dev_dbg(dev, "OmniVision OV5647 camera driver probed\n");
>>>>>>> +       dev_info(dev, "OmniVision OV5647 camera driver probed\n");
>>>>>>>         return 0;
>>>>>>>  error:
>>>>>>>         media_entity_cleanup(&sd->entity);
>>>>>>>
>>>>>>> In some subsystems, it's even a behavior I'm more or less relying on:
>>>>>>>
>>>>>>> $ git grep v4l2_info.*registered drivers/media/ | wc -l
>>>>>>> 26
>>>>>>>
>>>>>>> And on the downsides, I can't find much. It's just one little line,
>>>>>>> that is not even noticed unless you have logging turned on.
>>>>>>
>>>>>> Its better to be quiet, which is why the "default driver registration"
>>>>>> macros do not have any printk messages in them.  When converting drivers
>>>>>> over to it, we made the boot process much more sane, don't try to go and
>>>>>> add messages for no good reason back in please.
>>>>>>
>>>>>> dynamic debugging can be enabled on a module and line-by-line basis,
>>>>>> even from the boot command line.  So if you need debugging, you can
>>>>>> always ask someone to just reboot or unload/load the module and get the
>>>>>> message that way.
>>>>>>
>>>>>
>>>>> Can we by any chance make this an official policy ? I am kind of tired
>>>>> having to argue about this over and over again.
>>>>
>>>> Sure, but how does anyone make any "official policy" in the kernel?  :)
>>>>
>>>> I could just go through and delete all "look ma, a new driver/device!"
>>>> messages, but that might be annoying...
>>>>
>>>
>>> Well, I really need to task.
>>
>> ???
>>
> 
> Oops, typo: s/task/ask :-)
> 
>>> If it's not an official policy (and won't be anytime soon?),
>>
>> The ":)" there was that we really have very few "official" policies,
>> only things that we all strongly encourage to happen.  And get grumpy if
>> we see them in code reviews.  Like I did here.
>>
> 
> Well, not everyone gets grumpy. As I pointed out, we use this "registered"
> messages (messages or noise, seems this lie in the eye of the beholder),
> consistently across entire subsystems.

:(

>>> then what's preventing Enric from pushing this print on this driver,
>>> given he is the one maintaining the code?
>>
>> Given that he wants people to review his code, why would you tell him to
>> ignore what people are trying to tell him?
>>
> 
> I'm not suggesting to ignore anyone, rather to consider all voices
> involved in each review comment.
> 
>> Again, don't be noisy, it's not hard, and is how things have been
>> trending for many years now.

Ack that.


-- 
~Randy
