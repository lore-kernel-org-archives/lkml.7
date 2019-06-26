Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A66C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFZUzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:55:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39260 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfFZUzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:55:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A44972639EE
Subject: Re: [PATCH v2] platform/chrome: Expose resume result via debugfs
To:     Lee Jones <lee.jones@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
References: <20190617215234.260982-1-evgreen@chromium.org>
 <20190625130515.GJ21119@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e9e6e090-7c9b-ff5c-7389-702f9deb6712@collabora.com>
Date:   Wed, 26 Jun 2019 22:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625130515.GJ21119@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Two few comments and I think I'm fine with it.

On 25/6/19 15:05, Lee Jones wrote:
> On Mon, 17 Jun 2019, Evan Green wrote:
> 
>> For ECs that support it, the EC returns the number of slp_s0
>> transitions and whether or not there was a timeout in the resume
>> response. Expose the last resume result to usermode via debugfs so
>> that usermode can detect and report S0ix timeouts.
>>
>> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> This still needs a platform/chrome Ack.
> 
>> ---
>>
>> Changes in v2:
>>  - Moved from sysfs to debugfs (Enric)
>>  - Added documentation (Enric)
>>
>>
>> ---
>>  Documentation/ABI/testing/debugfs-cros-ec | 22 ++++++++++++++++++++++
>>  drivers/mfd/cros_ec.c                     |  6 +++++-
>>  drivers/platform/chrome/cros_ec_debugfs.c |  7 +++++++
>>  include/linux/mfd/cros_ec.h               |  1 +
>>  4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
>> index 573a82d23c89..008b31422079 100644
>> --- a/Documentation/ABI/testing/debugfs-cros-ec
>> +++ b/Documentation/ABI/testing/debugfs-cros-ec
>> @@ -32,3 +32,25 @@ Description:
>>  		is used for synchronizing the AP host time with the EC
>>  		log. An error is returned if the command is not supported
>>  		by the EC or there is a communication problem.
>> +
>> +What:		/sys/kernel/debug/cros_ec/last_resume_result

Thinking about it, as other the other interfaces, I'd do

s/cros_ec/<cros-ec-device>/

I know that for now only cros_ec supports that, but we don't know what will
happen in the future, specially now that the number of cros devices is incrementing.

>> +Date:		June 2019
>> +KernelVersion:	5.3
>> +Description:
>> +		Some ECs have a feature where they will track transitions to
>> +		the (Intel) processor's SLP_S0 line, in order to detect cases
>> +		where a system failed to go into S0ix. When the system resumes,
>> +		an EC with this feature will return a summary of SLP_S0
>> +		transitions that occurred. The last_resume_result file returns
>> +		the most recent response from the AP's resume message to the EC.
>> +
>> +		The bottom 31 bits contain a count of the number of SLP_S0
>> +		transitions that occurred since the suspend message was
>> +		received. Bit 31 is set if the EC attempted to wake the
>> +		system due to a timeout when watching for SLP_S0 transitions.
>> +		Callers can use this to detect a wake from the EC due to
>> +		S0ix timeouts. The result will be zero if no suspend
>> +		transitions have been attempted, or the EC does not support
>> +		this feature.
>> +
>> +		Output will be in the format: "0x%08x\n".
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index 5d5c41ac3845..2a9ac5213893 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -102,12 +102,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>>  
>>  	/* For now, report failure to transition to S0ix with a warning. */
>>  	if (ret >= 0 && ec_dev->host_sleep_v1 &&
>> -	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
>> +	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
>> +		ec_dev->last_resume_result =
>> +			buf.u.resp1.resume_response.sleep_transitions;
>> +
>>  		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
>>  			  EC_HOST_RESUME_SLEEP_TIMEOUT,
>>  			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
>>  			  buf.u.resp1.resume_response.sleep_transitions &
>>  			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
>> +	}
>>  
>>  	return ret;
>>  }
>> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
>> index cd3fb9c22a44..663bebf699bf 100644
>> --- a/drivers/platform/chrome/cros_ec_debugfs.c
>> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
>> @@ -447,6 +447,13 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>>  	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
>>  			    &cros_ec_uptime_fops);
>>  
>> +	if (!strcmp(ec->class_dev.kobj.name, CROS_EC_DEV_NAME)) {

For debugfs I don't care having the file exposed even is not supported, anyway
there are some CROS_EC_DEV_NAME that won't support it, so just make this simple
and create the file always.

>> +		debugfs_create_x32("last_resume_result",
>> +				   0444,
>> +				   debug_info->dir,
>> +				   &ec->ec_dev->last_resume_result);
>> +	}
>> +
>>  	ec->debug_info = debug_info;
>>  
>>  	dev_set_drvdata(&pd->dev, ec);
>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>> index 5ddca44be06d..45aba26db964 100644
>> --- a/include/linux/mfd/cros_ec.h
>> +++ b/include/linux/mfd/cros_ec.h
>> @@ -155,6 +155,7 @@ struct cros_ec_device {
>>  	struct ec_response_get_next_event_v1 event_data;
>>  	int event_size;
>>  	u32 host_event_wake_mask;
>> +	u32 last_resume_result;
>>  };
>>  
>>  /**
> 

Thanks,
~ Enric
