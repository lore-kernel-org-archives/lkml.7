Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A293DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D23B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfDPKbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:31:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDPKbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:31:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B46C15A2;
        Tue, 16 Apr 2019 03:31:43 -0700 (PDT)
Received: from [10.37.12.114] (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F493F68F;
        Tue, 16 Apr 2019 03:31:41 -0700 (PDT)
Subject: Re: [PATCH v2 27/36] drivers: Add a generic helper to match device by
 fwnode handle
To:     rafael@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, rjw@rjwysocki.net, robert.walker@arm.com,
        gregkh@linuxfoundation.org
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0jZCwPm-mg5L43RbqLKq1vB9zno85G+LPUVb+73KLimVA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0e152d7f-4b5f-0b0e-ac25-94b6cefa6901@arm.com>
Date:   Tue, 16 Apr 2019 11:34:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jZCwPm-mg5L43RbqLKq1vB9zno85G+LPUVb+73KLimVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael

On 04/16/2019 11:20 AM, Rafael J. Wysocki wrote:
> On Mon, Apr 15, 2019 at 6:06 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Make the device_fwnode_match() a generic helper to match device
>> by fwnode handle for use with bus_find_device(). This will be
>> also used by coresight.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Can you resend this with a CC to linux-acpi@vger.kernel.org, please?
> 
> There's some device properties material for 5.2 collected already and
> it would be good to keep all that together.
> 

Sure, will do. Btw, I have a question w.r.t the match function.

We have :


class_find_device(struct class *class, struct device *start,
                   const void *data,
                   int (*match)(struct device *, const void *))
and

bus_find_device(struct bus_type *bus,
                 struct device *start, void *data,
                 int (*match)(struct device *dev, void *data))

Just because the "match" has slightly different constraint for the
data (i.e, const void * vs void *), we can't reuse the same match
function for class_find_device. Do you think we should converge the
types to reuse the same match every where (Of course in a separate
patch series) ?

Cheers
Suzuki
