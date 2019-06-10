Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A801C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DAE207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbfFJMt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:49:29 -0400
Received: from foss.arm.com ([217.140.110.172]:42220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389474AbfFJMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:49:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBC7337;
        Mon, 10 Jun 2019 05:49:28 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77F4C3F557;
        Mon, 10 Jun 2019 05:49:27 -0700 (PDT)
Subject: Re: [RFC PATCH 22/57] drivers: i2c: Use generic helper to match
 device by acpi_dev
To:     wsa@the-dreams.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, mika.westerberg@linux.intel.com,
        linux-i2c@vger.kernel.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-23-git-send-email-suzuki.poulose@arm.com>
 <20190606200337.GA8739@kunai>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c9a807a5-c847-7553-71a5-dff47775014a@arm.com>
Date:   Mon, 10 Jun 2019 13:49:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606200337.GA8739@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/06/2019 21:03, Wolfram Sang wrote:
> 
>> -	dev = bus_find_device(&i2c_bus_type, NULL, adev,
>> -			      i2c_acpi_find_match_device);
>> +	dev = bus_find_device(&i2c_bus_type, NULL, adev, device_match_acpi_dev);
> 
> In general, this looks like a nice cleanup which I am in favour of.
> However, I didn't understand why ACPI uses bus_find_device() but OF has
> a seperate helper bus_find_device_by_of_node(). Why this inconsistency
> of having a seperate helper here and not there?

This was skipped purposefully due to the header file dependency issues with
adding "acpi_bus.h" to linux/device.h, which kind of creates a circular
dependency for adding "struct acpi_device" to the prototype.

However, I think I have found a way to solve that and include that in
the next version.

Thanks
Suzuki
