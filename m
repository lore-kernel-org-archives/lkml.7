Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1ECC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767B024AC5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfFDLj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:39:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727390AbfFDLj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:39:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D7380D;
        Tue,  4 Jun 2019 04:39:56 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0983F690;
        Tue,  4 Jun 2019 04:39:51 -0700 (PDT)
Subject: Re: [RFC PATCH 27/57] drivers: Unify the match prototype for
 bus_find_device with class_find_device
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, wsa@the-dreams.de,
        jic23@kernel.org, knaack.h@gmx.de, grygorii.strashko@ti.com,
        davem@davemloft.net, bhelgaas@google.com, sebott@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, balbi@kernel.org,
        david.kershner@unisys.com
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-28-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0ghb969phwKDJd_hJV6mBm0_B8R9Lrk8RG3Tu9ieO69OQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d51d8361-8807-5795-7da0-68c299217213@arm.com>
Date:   Tue, 4 Jun 2019 12:39:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ghb969phwKDJd_hJV6mBm0_B8R9Lrk8RG3Tu9ieO69OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2019 12:26, Rafael J. Wysocki wrote:
> On Mon, Jun 3, 2019 at 5:51 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> We have iterators for devices by bus and class, with a supplied
>> "match" function to do the comparison. However, both of the helper
>> function have slightly different prototype for the "match" argument.
>>
>>   int (*) (struct device *dev, void *data)  // bus_find_device
>>    vs
>>   int (*) (struct device *dev, const void *data) // class_find_device
>>
>> Unify the prototype by promoting the match function to use that of
>> the class_find_device(). This will allow us to share the generic
>> match helpers with class_find_device() users.
> 
> The patch looks good to me, but the changelog might be a bit better.
> 
> It seems to be all about the bus_find_device() and class_find_device()
> prototype consolidation, so that the same pair of data and match()
> arguments can be passed to both of them, which then will allow some
> optimizations to be made, so what about the following:
> 
> "There is an arbitrary difference between the prototypes of
> bus_find_device() and class_find_device() preventing their callers
> from passing the same pair of data and match() arguments to both of
> them, which is the const qualifier used in the prototype of
> class_find_device().  If that qualifier is also used in the
> bus_find_device() prototype, it will be possible to pass the same
> match() callback function to both bus_find_device() and
> class_find_device(), which will allow some optimizations to be made in
> order to avoid code duplication going forward.
> 
> For this reason, change the prototype of bus_find_device() to match
> the prototype of class_find_device() and adjust its callers to use the
> const qualifier in accordance with the new prototype of it.".

Agreed, I will reword the description.

> 
> Also, it looks like there is no need to make all of the following
> changes in the series along with this one in one go and making them
> separately would be *much* better from the patch review perspective.

Sure. I started with the helpers in the hope that, I would need fewer
changes to individual subsystems, once I convert them to use the
new helpers.

i.e, driver A -> use new helper and the change the new helper.

rather than

change all callers of *_find_device() and then all to switch to new helper.

Anyways, looks like the latter is better in terms of splitting the series.
I will rework the series.

Thanks a lot for your input

Cheers
Suzuki

