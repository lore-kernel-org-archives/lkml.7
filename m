Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D94C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9C420645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfGLMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:43:39 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49229 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfGLMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:43:38 -0400
Received: from [167.98.27.226] (helo=[10.35.6.255])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hlutf-0005tl-S8; Fri, 12 Jul 2019 13:43:31 +0100
Subject: Re: [PATCH v1 07/11] ti948: Add sysfs node for alive attribute
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-8-michael.drake@codethink.co.uk>
 <20190611181144.GV5016@pendragon.ideasonboard.com>
From:   Michael Drake <michael.drake@codethink.co.uk>
Message-ID: <bc3f0563-f7d9-42ef-21a7-836ad4ded6b1@codethink.co.uk>
Date:   Fri, 12 Jul 2019 13:43:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190611181144.GV5016@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 11/06/2019 19:11, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.

My pleasure, and thank you for the feedback!

> On Tue, Jun 11, 2019 at 03:04:08PM +0100, Michael Drake wrote:
>> This may be used by userspace to determine the state
>> of the device.
> 
> Why is this needed ? Userspace shouldn't even be aware that this device
> exists.

The display (containing the ti948) could be unplugged.  (See my
response to the feedback on the previous commit in the series.)

If you can suggest a better or more standard way of doing this
I would be very happy to learn of it.

>> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  drivers/gpu/drm/bridge/ti948.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
>> index b5c766711c4b..b624eaeabb43 100644
>> --- a/drivers/gpu/drm/bridge/ti948.c
>> +++ b/drivers/gpu/drm/bridge/ti948.c
>> @@ -412,6 +412,16 @@ static void ti948_alive_check(struct work_struct *work)
>>  	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
>>  }
>>  
>> +static ssize_t alive_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
>> +
>> +	return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned int)ti948->alive);
>> +}
>> +
>> +static DEVICE_ATTR_RO(alive);
>> +
>>  static int ti948_pm_resume(struct device *dev)
>>  {
>>  	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
>> @@ -614,17 +624,31 @@ static int ti948_probe(struct i2c_client *client,
>>  
>>  	i2c_set_clientdata(client, ti948);
>>  
>> +	ret = device_create_file(&client->dev, &dev_attr_alive);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Could not create alive attr\n");
>> +		return ret;
>> +	}
>> +
>>  	ret = ti948_pm_resume(&client->dev);
>> -	if (ret != 0)
>> -		return -EPROBE_DEFER;
>> +	if (ret != 0) {
>> +		ret = -EPROBE_DEFER;
>> +		goto error;
>> +	}
>>  
>>  	dev_info(&ti948->i2c->dev, "End probe (addr: %x)\n", ti948->i2c->addr);
>>  
>>  	return 0;
>> +
>> +error:
>> +	device_remove_file(&client->dev, &dev_attr_alive);
>> +	return ret;
>>  }
>>  
>>  static int ti948_remove(struct i2c_client *client)
>>  {
>> +	device_remove_file(&client->dev, &dev_attr_alive);
>> +
>>  	return ti948_pm_suspend(&client->dev);
>>  }
>>  
> 

-- 
Michael Drake                 https://www.codethink.co.uk/
