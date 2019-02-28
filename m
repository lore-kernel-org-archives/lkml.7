Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26C020C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfB1XnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:43:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:10077 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfB1XnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:43:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 15:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="126840936"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.136.95]) ([10.249.136.95])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2019 15:43:06 -0800
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost> <20190227093104.GA5354@kroah.com>
 <20190227094021.GL4747@localhost> <20190227095424.GA11387@kroah.com>
 <20190227105951.GM4747@localhost> <20190227120645.GA15587@kroah.com>
 <20190227133226.GQ4747@localhost> <20190228083534.GA16271@kroah.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <f6a68e50-fa39-4a51-5960-8f2d1015b41d@intel.com>
Date:   Fri, 1 Mar 2019 00:43:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190228083534.GA16271@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2019 9:35 AM, Greg Kroah-Hartman wrote:
> On Wed, Feb 27, 2019 at 02:32:26PM +0100, Johan Hovold wrote:
>> On Wed, Feb 27, 2019 at 01:06:45PM +0100, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 27, 2019 at 11:59:51AM +0100, Johan Hovold wrote:
>>> Yeah, that is a good point, normally we use packed to keep padding from
>>> the middle of the structure from happening.
>>>
>>> I just don't like that 4 bytes sitting there doing nothing :)
>> You could perhaps put them directly in struct device if the
>> dev_links_info struct is just used a separator there and this really
>> bothers you. :)
> True :)
>
>>> But, in thinking about this, there is no real reason that I can see that
>>> this structure even is in struct device.  It should be able to be in the
>>> private "internal" structure.
>>>
>>> The patch below moves it out of struct device entirely.  Overall there
>>> is no memory savings, but it could give us the chance to only create
>>> this structure if we really need it later on, as very few things use
>>> links at this point in time.
>>>
>>> Rafael, there is one logic change below, the link structure is not
>>> initialized until device_add() happens, instead of device_initialize().
>>> Will that affect anything that you can think of?  Does anyone do
>>> anything with links before device_add() is called?
>> I think device_add() may be too late.
>>
>> 	The earliest point in time when device links can be added is
>> 	after :c:func:`device_add()` has been called for the supplier
>> 	and :c:func:`device_initialize()` has been called for the
>> 	consumer.
> That is true today due to the way the code is set up, but it would be
> good to figure out if anyone actually does call it this early.

ISTR a use case where it was needed in the IOMMU subsystem, but I'm not 
sure if it has been used that way eventually.

The only way to really find out would be to audit all of the 
device_link_add() callers I'm afraid.

Cheers,

Rafael


