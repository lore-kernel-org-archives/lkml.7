Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25E720675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCGBBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:01:11 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:34309 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfCGBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:01:10 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=SPAM|CONTINUE|true|0.696362-0.054115-0.249523;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.E4zQJRN_1551920463;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E4zQJRN_1551920463)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 07 Mar 2019 09:01:04 +0800
Subject: Re: [PATCH v12 2/4] pstore/blk: add blkoops for pstore_blk
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551337948-16451-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1551337948-16451-3-git-send-email-liaoweixiong@allwinnertech.com>
 <21827ba0-1c89-c16e-0d64-0a508eeae915@infradead.org>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <de396c69-0ae5-d594-393a-be77bf80a304@allwinnertech.com>
Date:   Thu, 7 Mar 2019 09:01:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <21827ba0-1c89-c16e-0d64-0a508eeae915@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will fix all on next version. Thank you very much.

On 2019-03-06 09:14, Randy Dunlap wrote:
> Hi,
> 
> On 2/27/19 11:12 PM, liaoweixiong wrote:
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index defcb75..7dfe00b 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -160,3 +160,117 @@ config PSTORE_BLK
>>  	help
>>  	  This enables panic and oops message to be logged to a block dev
>>  	  where it can be read back at some later point.
>> +
>> +config PSTORE_BLKOOPS
>> +	tristate "pstore block with oops logger"
>> +	depends on PSTORE_BLK
>> +	help
>> +	  This is a sample for pstore block with oops logger.
>> +
>> +	  It CANNOT record panic log as no read/write apis for panic registered.
> 
> 	                                              APIs
> 

Fixed.

>> +
>> +	  It CAN record oops log even power failure if
>> +	  "PSTORE_BLKOOPS_BLKDEV" on Kconfig or "block-device" on dts or
>> +	  "blkdev" on module parameter is valid.
>> +
>> +	  Otherwise, it can only record data to ram buffer, which will be
>> +	  dropped when reboot.
> 
> 	  dropped on reboot.
> or
> 	  dropped when rebooting.
> 

Fixed.

>> +
>> +	  NOTE that, there are three ways to set parameters of blkoops and
>> +	  prioritize according to configuration flexibility. That is
>> +	  Kconfig < device tree < module parameters. It means that the value can
>> +	  be overwritten by higher priority settings.
>> +	  1. Kconfig
>> +	     It	just sets a default value.
>> +	  2. device tree
>> +	     It is set on device tree, which will overwrites value from Kconfig,
> 
> 	                                          overwrite the value from Kconfig,
> 

Fixed.

>> +	     but can also be overwritten by module parameters.
>> +	  3. module parameters
>> +	     It is the first priority. Take care of that blkoops will take lower
>> +	     priority settings if higher priority one do not set.
>> +
>> +config PSTORE_BLKOOPS_DMESG_SIZE
>> +	int "dmesg size in kbytes for blkoops"
>> +	depends on PSTORE_BLKOOPS
>> +	default 64
>> +	help
>> +	  This just sets size of dmesg (dmesg_size) for pstore/blk. The value
>> +	  must be a multiple of 4096.
>> +
>> +	  NOTE that, there are three ways to set parameters of blkoops and
>> +	  prioritize according to configuration flexibility. That is
>> +	  Kconfig < device tree < module parameters. It means that the value can
>> +	  be overwritten by higher priority settings.
>> +	  1. Kconfig
>> +	     It	just sets a default value.
>> +	  2. device tree
>> +	     It is set on device tree, which will overwrites value from Kconfig,
> 
> 	                                          overwrite the value from Kconfig,
> 

It cancels device tree support. I forget to delete it.

>> +	     but can also be overwritten by module parameters.
>> +	  3. module parameters
>> +	     It is the first priority. Take care of that blkoops will take lower
>> +	     priority settings if higher priority one do not set.
>> +
>> +config PSTORE_BLKOOPS_TOTAL_SIZE
>> +	int "total size in kbytes for blkoops"
>> +	depends on PSTORE_BLKOOPS
>> +	default 0
>> +	help
>> +	  The total size in kbytes pstore/blk can use. It must be less than or
>> +	  equal to size of block device if @blkdev valid. If @total_size is zero
>> +	  with @blkdev, @total_size will be set to equal to size of @blkdev.
> 
> 	                                    set equal to size of @blkdev.
> 

Fixed.

>> +	  The value must be a multiple of 4096.
>> +
>> +	  NOTE that, there are three ways to set parameters of blkoops and
>> +	  prioritize according to configuration flexibility. That is
>> +	  Kconfig < device tree < module parameters. It means that the value can
>> +	  be overwritten by higher priority settings.
>> +	  1. Kconfig
>> +	     It	just sets a default value.
>> +	  2. device tree
>> +	     It is set on device tree, which will overwrites value from Kconfig,
> 
> 	                                          overwrite the value from Kconfig,
> 

Fixed.

>> +	     but can also be overwritten by module parameters.
>> +	  3. module parameters
>> +	     It is the first priority. Take care of that blkoops will take lower
>> +	     priority settings if higher priority one do not set.
>> +
>> +config PSTORE_BLKOOPS_BLKDEV
>> +	string "block device for blkoops"
>> +	depends on PSTORE_BLKOOPS
>> +	default ""
>> +	help
>> +	  This just sets block device (blkdev) for pstore/blk. Pstore/blk
>> +	  will record data to this block device to avoid losing data due to
>> +	  power failure. So, If it is not set, pstore/blk will drop all data
> 
> 	                     if
> 

Fixed.

>> +	  when reboot.
> 
> 	  on reboot.
> 

Fixed.

>> +
>> +	  It accpet the following variants:
> 
> 	     accepts
> 

Fixed.

>> +	  1) <hex_major><hex_minor> device number in hexadecimal represents
>> +	     itself no leading 0x, for example b302.
>> +	  2) /dev/<disk_name> represents the device number of disk
>> +	  3) /dev/<disk_name><decimal> represents the device number
>> +	     of partition - device number of disk plus the partition number
>> +	  4) /dev/<disk_name>p<decimal> - same as the above, that form is
> 
> 	                                              above; this form is
> 

Fixed.

>> +	     used when disk name of partitioned disk ends on a digit.
> 
> 	                                             ends with a digit.
> 

Fixed.

>> +	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
>> +	     unique id of a partition if the partition table provides it.
>> +	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
>> +	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
>> +	     filled hex representation of the 32-bit "NT disk signature", and PP
>> +	     is a zero-filled hex representation of the 1-based partition number.
>> +	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
>> +	     to a partition with a known unique id.
>> +	  7) <major>:<minor> major and minor number of the device separated by
>> +	     a colon.
>> +
>> +	  NOTE that, there are three ways to set parameters of blkoops and
>> +	  prioritize according to configuration flexibility. That is
>> +	  Kconfig < device tree < module parameters. It means that the value can
>> +	  be overwritten by higher priority settings.
>> +	  1. Kconfig
>> +	     It	just sets a default value.
>> +	  2. device tree
>> +	     It is set on device tree, which will overwrites value from Kconfig,
> 
> 	                                          overwrite the value from Kconfig,
> 

Fixed.

>> +	     but can also be overwritten by module parameters.
>> +	  3. module parameters
>> +	     It is the first priority. Take care of that blkoops will take lower
>> +	     priority settings if higher priority one do not set.
> 
> 

-- 
liaoweixiong
