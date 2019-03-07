Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64204C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27107206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCGBFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:05:09 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53174 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfCGBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:05:08 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07447757|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.229133-0.10439-0.666477;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.E4ziVM4_1551920701;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E4ziVM4_1551920701)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 07 Mar 2019 09:05:02 +0800
Subject: Re: [PATCH v12 3/4] pstore/blk: support pmsg for pstore block
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
 <1551337948-16451-4-git-send-email-liaoweixiong@allwinnertech.com>
 <a7ae72c0-2425-a43a-da53-22f30a173f7e@infradead.org>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <e88aed98-a96b-6e78-9183-5ff50dfa64e7@allwinnertech.com>
Date:   Thu, 7 Mar 2019 09:05:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a7ae72c0-2425-a43a-da53-22f30a173f7e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-03-06 09:16, Randy Dunlap wrote:
> Hi,
> 
> On 2/27/19 11:12 PM, liaoweixiong wrote:
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index 7dfe00b..b417bf5 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -210,6 +210,27 @@ config PSTORE_BLKOOPS_DMESG_SIZE
>>  	     It is the first priority. Take care of that blkoops will take lower
>>  	     priority settings if higher priority one do not set.
>>  
>> +config PSTORE_BLKOOPS_PMSG_SIZE
>> +	int "pmsg size in kbytes for blkoops"
>> +	depends on PSTORE_BLKOOPS
>> +	default 64
>> +	help
>> +	  This just sets size of pmsg (pmsg_size) for pstore/blk. The value must
>> +	  be a multiple of 4096. Pmsg work only if "blkdev" is set.
> 
> 	                              works
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
>>  config PSTORE_BLKOOPS_TOTAL_SIZE
>>  	int "total size in kbytes for blkoops"
>>  	depends on PSTORE_BLKOOPS
> 
> cheers.
> 

Thank you. Cheers.

-- 
liaoweixiong
