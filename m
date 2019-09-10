Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F71C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 04:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9618C21924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 04:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfIJEvv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 00:51:51 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:63206 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbfIJEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 00:51:51 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7Y7z-000Htx-Gd; Tue, 10 Sep 2019 06:51:43 +0200
Received: from [213.55.220.251] (helo=[100.66.103.90])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7Y7z-0003VR-A3; Tue, 10 Sep 2019 06:51:43 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Staging: gasket: Use temporaries to reduce line length.
Date:   Tue, 10 Sep 2019 06:51:42 +0200
Message-Id: <32BC7615-D278-4EBD-B68B-2891EF996942@volery.com>
References: <348e946eb5e90c1af3971fd50b5678668cc1a3d3.camel@perches.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <348e946eb5e90c1af3971fd50b5678668cc1a3d3.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 10 Sep 2019, at 00:30, Joe Perches <joe@perches.com> wrote:
> 
> ﻿On Mon, 2019-09-09 at 22:28 +0200, Sandro Volery wrote:
>> Using temporaries for gasket_page_table entries to remove scnprintf()
>> statements and reduce line length, as suggested by Joe Perches. Thanks!
> 
> nak.  Slow down.  You broke the code.
> 
> Please be _way_ more careful and verify for yourself
> the code you submit _before_ you submit it.
> 
> compile/test/verify, twice if necessary.
> 

Shoot. I'm sorry I'm just really trying to get into all this...


> You also should have cc'd me on this patch.
> 

Will do! I'll submit v2 this afternoon.

>> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> []
>> @@ -524,29 +526,25 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
>>    }
>> 
>>    type = (enum sysfs_attribute_type)gasket_attr->data.attr_type;
>> +    gpt = gasket_dev->page_table[0];
>>    switch (type) {
>>    case ATTR_KERNEL_HIB_PAGE_TABLE_SIZE:
>> -        ret = scnprintf(buf, PAGE_SIZE, "%u\n",
>> -                gasket_page_table_num_entries(
>> -                    gasket_dev->page_table[0]));
>> +        val = gasket_page_table_num_simple_entries(gpt);
> 
> You likely duplicated this line via copy/paste.
> This should be:
>        val = gasket_page_table_num_entries(gpt);
> 

Thanks for being patient with me so far... I'd imagine others would've freaked out at me by now :)


