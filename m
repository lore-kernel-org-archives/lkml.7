Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3CFC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934FA25DAB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfFCW4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:56:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:1498 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfFCW4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:56:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 15:56:20 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2019 15:56:18 -0700
Subject: Re: A potential broken at platform driver?
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
 <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
 <20190603180255.GA18054@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <b3dd022b-b585-3dfb-5fe6-9c9f5498bc77@linux.intel.com>
Date:   Mon, 3 Jun 2019 18:08:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603180255.GA18054@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/3/19 1:02 PM, Greg KH wrote:
> On Mon, Jun 03, 2019 at 10:57:18AM -0500, Richard Gong wrote:
>>
>> Hi Greg,
>>
>> Following your suggestion, I replaced devm_device_add_groups() with .group =
>> rus_groups in my version #4 submission. But I found out that RSU driver
>> outputs the garbage data if I use .group = rsu_groups.
> 
> What is "garbage"?
I mean incorrect status info.

> 
>> To make RSU driver work properly, I have to revert the change at version #4
>> and use devm_device_add_groups() again. Sorry, I didn't catch this problem
>> early.
>>
>> I did some debug & below are captured log, you can see priv pointer get
>> messed at current_image_show(). I am not sure if something related to
>> platform driver work properly. I attach my debug patch in this mail.
>>
>> 1. Using .groups = rsu_groups,
>>
>> [    1.191115] *** rsu_status_callback:
>> [    1.194782] res->a1=2000000
>> [    1.197588] res->a1=0
>> [    1.199865] res->a2=0
>> [    1.202150] res->a3=0
>> [    1.204433] priv=0xffff80007aa28e80
>> [    1.207933] version=0, state=0, current_image=2000000, fail_image=0,
>> error_location=0, error_details=0
>> [    1.217249] *** stratix10_rsu_probe: priv=0xffff80007aa28e80
>> root@stratix10:/sys/bus/platform/drivers/stratix10-rsu# cat current_image
>> [   38.849341] *** current_image_show: priv=0xffff80007aa28d00
>> ... output garbage data
>> priv pointer got changed
> 
> I don't understand this, sorry.  Are you sure you are actually using the
> correct pointer to your device?
> 
I think so.

The dev pointer at current_image_show() should points to RSU device, but 
it seems point to driver_private if I use .group = rsU_groups. As a 
result I can't get the priv pointer properly at current_image_show().

[    1.190993] *** rsu_status_callback:
[    1.194669] dev=0xffff80007b409410
[    1.198083] priv=0xffff80007a4d4e80
[    1.201582] version=0, state=0, current_image=0x2000000, 
fail_image=0x0, error_location=0x0, error_details=0
[    1.211416] *** stratix10_rsu_probe: priv=0xffff80007a4d4e80
[    1.217063] *** stratix10_rsu_probe: dev=0xffff80007b409410

root@stratix10:/sys/bus/platform/drivers/stratix10-rsu# cat current_image
[   72.101277] *** current_image_show: dev=stratix10_rsu_driver
[   72.136205] *** current_image_show: priv=0xffff80007a4d4d00

If I use devm_device_add_groups(), the dev pointer does point to RSU device,

[    1.191456] *** rsu_status_callback:
[    1.195124] priv=0xffff80007a429280
[    1.198615] version=0, state=0, current_image=0x2000000, 
fail_image=0x0, error_location=0x0, error_details=0
[    1.208458] *** stratix10_rsu_probe: priv=0xffff80007a429280
[    1.214105] *** stratix10_rsu_probe: dev=0xffff80007b409410

root@stratix10:/sys/devices/platform/stratix10-rsu.0# cat current_image
[   31.484131] *** current_image_show: dev=0xffff80007b409410
[   31.489651] *** current_image_show: priv=0xffff80007a429280


>> @@ -394,7 +432,7 @@ static struct platform_driver stratix10_rsu_driver = {
>>   	.remove = stratix10_rsu_remove,
>>   	.driver = {
>>   		.name = "stratix10-rsu",
>> -		.groups = rsu_groups,
>> +//		.groups = rsu_groups,
> 
> Are you sure this is the correct pointer?  I think that might be
> pointing to the driver's attributes, not the device's attributes.
> 
> If platform drivers do not have a way to register groups properly, then
> that really needs to be fixed, as trying to register it by yourself as
> you are doing, is ripe for racing with userspace.
> 
I agree we shouldn't call devm_device_add_groups() directly.

RSU status is only updated after power on or reboot, RSU driver get 
status info at probe() & save them to the private pointer priv via 
platform_set_drvdata().

static struct platform_driver stratix10_rsu_driver = {
         .probe = stratix10_rsu_probe,
         .remove = stratix10_rsu_remove,
         .driver = {
                 .name = "stratix10-rsu",
                 .groups = rsu_groups,
         },
};

The problem is that I don't have a way to properly retrieve the priv 
pointer at xx_show() functions. Global variable is a work around, but I 
don't think it is a good approach.

Any suggestion?

Regards,
Richard

> thanks,
> 
> greg k-h
> 
