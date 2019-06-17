Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E720C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390A22084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfFQKHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:07:33 -0400
Received: from foss.arm.com ([217.140.110.172]:44122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfFQKHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:07:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7DD344;
        Mon, 17 Jun 2019 03:07:32 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10E9C3F246;
        Mon, 17 Jun 2019 03:09:16 -0700 (PDT)
Subject: Re: [PATCH v2 00/28] drivers: Consolidate device lookup helpers
To:     joe@perches.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <3aa6d42db4b64c625b8461ee7d442f3f1830e8c3.camel@perches.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c6813d08-b70b-f153-a651-94d1bcaa5522@arm.com>
Date:   Mon, 17 Jun 2019 11:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3aa6d42db4b64c625b8461ee7d442f3f1830e8c3.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Greg, Rafael

Hi Joe,

On 14/06/2019 19:24, Joe Perches wrote:
> (dropping the very long cc list just cc'ing LKML and devicetree)
> 
> On Fri, 2019-06-14 at 18:53 +0100, Suzuki K Poulose wrote:
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
> 
> As you are doing treewide conversions, perhaps using
> 
> 	bool (*match)(...)
> 
> is a more sensible api.

I agree that it is more suitable api. However, that would need much more
conversions for the existing "class_find_device()" , which are not touched by
the series and would make this series even more bigger. With that said, I
am fine with implementing the suggestion if Greg/Rafael thinks that is fine.

>> Changes since v1:
>>   - Drop start parameter for *_find_device_by_devt().
>>   - Fix build warnings for s390
>>   - Add *_find_device_by_acpi_dev() wrappers.
>>   - Group wrappers and the consumers into single patch, reducing
>>     the total patches to 28 from 57. (Rafael).
>>   - Better description for acpi cleanup patch.
>>   - Added tags from v1.
> 
> Below this is a _very_ long list of cc:'s.

Unfortunately, yes.

> If the list is generated using scripts/get_maintainer.pl
> perhaps it is more sensible to add --nogit --nogit-fallback

Yes, and trimmed manually a bit to remove the "commit-signers".
I have tried to keep only the maintainers/reviewers/supporters.
Thanks for the option, I will give that a try.

> to its arguments to cc actual maintainers and avoid people
> that have submitted cleanup style patches to various files.
> 

Cheers
Suzuki
