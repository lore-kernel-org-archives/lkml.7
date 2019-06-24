Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DD1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625342089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfFXIb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:31:59 -0400
Received: from foss.arm.com ([217.140.110.172]:43664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfFXIb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:31:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13EE82B;
        Mon, 24 Jun 2019 01:31:58 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC103F71E;
        Mon, 24 Jun 2019 01:31:57 -0700 (PDT)
Subject: Re: [PATCH v2 00/28] drivers: Consolidate device lookup helpers
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <20190624032348.GA28919@kroah.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a89c2e8c-8c98-9ec4-ec66-9d05eff36d17@arm.com>
Date:   Mon, 24 Jun 2019 09:31:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624032348.GA28919@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On 24/06/2019 04:23, Greg KH wrote:
> On Fri, Jun 14, 2019 at 06:53:55PM +0100, Suzuki K Poulose wrote:
>> We have device iterators to find a particular device matching a criteria
>> for a given bus/class/driver. i.e, {bus,class,driver}_find_device() APIs.
>> The matching criteria is a function pointer for the APIs. Often the lookup
>> is based on a generic property of a device (e.g, name, fwnode, of node pointer
>> or device type) rather than a driver specific information. However, each driver
>> writes up its own "match" function, spilling the similar match functions all
>> over the driver subsystems.
>>
>> Additionally the prototype for the "match" functions accepted by the above APIs
>> have a minute difference which prevents us otherwise sharing the match functions.
>> i.e,
>> 	int (*match)(struct device *dev, void *data) for {bus/driver}_find_device()
>> 	  vs
>> 	int (*match)(struct device *dev, const void *) for class_find_device()
>>
>> If we promote the former to accept a "const void*" parameter, we could share one
>> single match function for all the helpers. This series achieves the following:
>>
>>   a) [Patches 03-05] Unify the prototype for "match" functions accepted by the
>>       device lookup APIs.
> 
> I've applied the first 6 patches of this series to my tree now.  Let's
> see how that goes, and this should give you a more solid base to redo
> the rest of the series off of.

Thanks for that. I will rebase my next version on top your tree sometime soon.

Cheers
Suzuki
