Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E68DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168D12147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfDHPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:41:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:41:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 959D82842C0
Subject: Re: [PATCH] mfd: cros_ec_dev: Add a poll handler to receive MKBP
 events
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        Vincent Palatin <vpalatin@chromium.org>
References: <20190308123659.16101-1-enric.balletbo@collabora.com>
 <20190402040647.GM4187@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c6cd7740-c3aa-6420-a789-735179ba59b4@collabora.com>
Date:   Mon, 8 Apr 2019 17:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402040647.GM4187@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 2/4/19 6:06, Lee Jones wrote:
> On Fri, 08 Mar 2019, Enric Balletbo i Serra wrote:
> 
>> From: Vincent Palatin <vpalatin@chromium.org>
>>
>> Allow to poll on the cros_ec device to receive the MKBP events.
>>
>> The /dev/cros_[ec|fp|..] file operations now implements the poll
>> operation. The userspace can now receive specific MKBP events by doing the
>> following:
>> - Open the /dev/cros_XX file.
>> - Call the CROS_EC_DEV_IOCEVENTMASK ioctl with the bitmap of the MKBP
>>   events it wishes to receive as argument.
>> - Poll on the file descriptor.
>> - When it gets POLLIN, do a read on the file descriptor, the first
>>   queued event will be returned (using the struct
>>   ec_response_get_next_event format: one byte of event type, then
>>   the payload).
>>
>> The read() operation returns at most one event even if there are several
>> queued, and it might be truncated if the buffer is smaller than the
>> event (but the caller should know the maximum size of the events it is
>> reading).
>>
>> read() used to return the EC version string, it still does it when no
>> event mask or an empty event is set for backward compatibility (despite
>> nobody really using this feature).
>>
>> This will be used, for example, by the userspace daemon to receive and
>> treat the EC_MKBP_EVENT_FINGERPRINT sent by the FP MCU.
> 
> MFD does not seem like the correct place for this.  Maybe this is a
> good candidate for drivers/platform/chrome/* where the rest of your
> platform empire now resides.
> 

The patch itself can't be moved without moving other parts, this would imply
move all the file_operations and the chardev, those already resides in MFD, and
some event handling. Is this what you're suggesting?

If that's the case I need to look in more detail.

Thanks,
 Enric


>> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/mfd/cros_ec_dev.c | 163 +++++++++++++++++++++++++++++++++++++-
>>  drivers/mfd/cros_ec_dev.h |   1 +
>>  2 files changed, 160 insertions(+), 4 deletions(-)
> 
