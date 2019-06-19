Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C22C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCB020B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IiS26Kcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfFSOXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:23:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:23:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JEIlhC029734;
        Wed, 19 Jun 2019 14:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0OhG3IZgEE/Oxlh2ToGZlxZNwEyKb0PnO9RhNleTfdI=;
 b=IiS26Kcp8ess4u6PR6hrfVl59aaLQSnT8O5l7wILGEsMHXnN7BoZTUxq3kwdC5cBz9hj
 yAwPhhH3Z4j9gK+2WzHEvxYQqESmpYpw1gakUDj1IGWnlqmBa6pkEYiMzdA0qPaXbQe1
 2rR4evzv755zsugODNltphkiG/gLlBmuvlZAXRuz7IZOWIy+OjO+Aa+VFe5f8XOBcCWQ
 4/yf1/Vhz8dCS4Lil95X3mBmCHuUcYi0OVKaanbRwy/c88An5H/Gi9ojK7dhLKyWJVaw
 U7QeyybsAy5DM5gfUcHUPVVnmvDCaX+mX4JbORajB7fbz5h83nQgHUTZKd/F/J72Ce0n Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t7809bsu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 14:23:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JELEOo120487;
        Wed, 19 Jun 2019 14:23:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t77yncm9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 14:23:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JEN6O9022563;
        Wed, 19 Jun 2019 14:23:06 GMT
Received: from dhcp-10-159-224-52.vpn.oracle.com (/10.159.224.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 07:23:06 -0700
Subject: Re: [PATCH 3/3] tracing: Add 2 new funcs. for kernel access to Ftrace
 instances.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <1560357259-3497-1-git-send-email-divya.indi@oracle.com>
 <1560357259-3497-2-git-send-email-divya.indi@oracle.com>
 <1560357259-3497-3-git-send-email-divya.indi@oracle.com>
 <1560357259-3497-4-git-send-email-divya.indi@oracle.com>
 <20190617194514.2f760437@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <ac4a7362-fc2c-cdff-d204-095fb4743c8c@oracle.com>
Date:   Wed, 19 Jun 2019 07:23:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617194514.2f760437@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thanks for reviewing the patch. I have made a note of all the suggested 
changes, comment requirements.

Will send them out soon as v2.

(comments inline)

On 6/17/19 4:45 PM, Steven Rostedt wrote:
> On Wed, 12 Jun 2019 09:34:19 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Adding 2 new functions -
>> 1) trace_array_lookup : Look up and return a trace array, given its
>> name.
>> 2) trace_array_set_clr_event : Enable/disable event recording to the
>> given trace array.
>>
>> Newly added functions trace_array_lookup and trace_array_create also
>> need to increment the reference counter associated with the trace array
>> they return. This is to ensure the trace array does not get freed
>> while in use by the newly introduced APIs.
>> The reference ctr is decremented in the trace_array_destroy.
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> ---
>>   include/linux/trace_events.h |  3 +++
>>   kernel/trace/trace.c         | 30 +++++++++++++++++++++++++++++-
>>   kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
>>   3 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>> index d7b7d85..0cc99a8 100644
>> --- a/include/linux/trace_events.h
>> +++ b/include/linux/trace_events.h
>> @@ -545,7 +545,10 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>>   struct trace_array *trace_array_create(const char *name);
>>   int trace_array_destroy(struct trace_array *tr);
>>   int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
>> +struct trace_array *trace_array_lookup(const char *name);
>>   int trace_set_clr_event(const char *system, const char *event, int set);
>> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
>> +		const char *event, int set);
>>   
>>   /*
>>    * The double __builtin_constant_p is because gcc will give us an error
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index a60dc13..fb70ccc 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -8364,6 +8364,8 @@ struct trace_array *trace_array_create(const char *name)
>>   
>>   	list_add(&tr->list, &ftrace_trace_arrays);
>>   
>> +	tr->ref++;
>> +
> Needs a comment for why the ref is incremented.
>
>
>>   	mutex_unlock(&trace_types_lock);
>>   	mutex_unlock(&event_mutex);
>>   
>> @@ -8385,7 +8387,14 @@ struct trace_array *trace_array_create(const char *name)
>>   
>>   static int instance_mkdir(const char *name)
>>   {
>> -	return PTR_ERR_OR_ZERO(trace_array_create(name));
>> +	struct trace_array *tr;
>> +
>> +	tr = trace_array_create(name);
>> +	if (IS_ERR(tr))
>> +		return PTR_ERR(tr);
>> +	trace_array_put(tr);
> Need a comment to why we need to do a put here.
>
>> +
>> +	return 0;
>>   }
>>   
>>   static int __remove_instance(struct trace_array *tr)
>> @@ -8434,6 +8443,7 @@ int trace_array_destroy(struct trace_array *tr)
>>   	mutex_lock(&event_mutex);
>>   	mutex_lock(&trace_types_lock);
>>   
>> +	tr->ref--;
>>   	ret = __remove_instance(tr);
>>   
>>   	mutex_unlock(&trace_types_lock);
>> @@ -8465,6 +8475,24 @@ static int instance_rmdir(const char *name)
>>   	return ret;
>>   }
>>   
> Need a kerneldoc heading here, that also states that if a trace_array
> is returned, it requires a call to trace_array_put().
>
>
>> +struct trace_array *trace_array_lookup(const char *name)
>> +{
>> +	struct trace_array *tr;
>> +
>> +	mutex_lock(&trace_types_lock);
>> +
>> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>> +		if (tr->name && strcmp(tr->name, name) == 0) {
>> +			tr->ref++;
>> +			mutex_unlock(&trace_types_lock);
>> +			return tr;
>> +		}
>> +	}
>> +	mutex_unlock(&trace_types_lock);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(trace_array_lookup);
>> +
>>   static __init void create_trace_instances(struct dentry *d_tracer)
>>   {
>>   	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index 445b059..c126d2c 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -859,6 +859,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
>>   }
>>   EXPORT_SYMBOL_GPL(trace_set_clr_event);
>>   
>> +/**
>> + * trace_array_set_clr_event - enable or disable an event for a trace array
>> + * @system: system name to match (NULL for any system)
>> + * @event: event name to match (NULL for all events, within system)
>> + * @set: 1 to enable, 0 to disable
>> + *
>> + * This is a way for other parts of the kernel to enable or disable
>> + * event recording to instances.
>> + *
>> + * Returns 0 on success, -EINVAL if the parameters do not match any
>> + * registered events.
>> + */
>> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
>> +		const char *event, int set)
>> +{
>> +	if (!tr)
>> +		return -ENODEV;
> If we have this, should we get rid of the external use of
> ftrace_set_clr_event()?

I think so too. External use of trace_array_set_clr_event is more 
convenient and intuitive. Will make the change.


Thanks,

Divya

>
> -- Steve
>
>> +
>> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
>> +}
>> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
>> +
>>   /* 128 should be much more than enough */
>>   #define EVENT_BUF_SIZE		127
>>   
