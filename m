Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECFDECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83802168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTlvYzaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391539AbfJPXnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:43:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJPXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:43:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GNYNPi018558;
        Wed, 16 Oct 2019 23:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=osJD6m35OiCWopz2Dei1ScyyZlJ7i/ztQyasFpfFaTI=;
 b=MTlvYzaOIm2z7kKlMUgZX8Kvfpn7/IIiodheLG46UXrHnD0bzU3BQC+F8clBGQPQY/Tl
 b90Os/q/+C9lqY2JRAj0GQ7s0jAqT9iRqHDyAnVPCwgWeKgpZEej0OTkzczbn3dQ6Eh0
 YAhgwcoBAOhzy8XXjsOXFAXep5v4jQXyNHRbYmv8qsb63BIIPjwzJcR+JiltF3qVJDbG
 TbUwLb6CeS0MESizKDDZVFQmtJtn2pZm4xfuHWb7HAOshQj0Cq2ThJWHt4t6GHsp+nEO
 IZePfl4jkEe/GGHyPPdLVd41k3SgGzmld6sTM4kimOicOI0sL5oxsflyeQG35Te/hq+w tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vk68uth70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 23:42:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GNblKp069078;
        Wed, 16 Oct 2019 23:42:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vp70nt5jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 23:42:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GNg49n026786;
        Wed, 16 Oct 2019 23:42:04 GMT
Received: from dhcp-10-159-240-200.vpn.oracle.com (/10.159.240.200)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 23:42:03 +0000
Subject: Re: [PATCH 4/5] tracing: Handle the trace array ref counter in new
 functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
 <1565805327-579-5-git-send-email-divya.indi@oracle.com>
 <20191015190436.65c8c7a3@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <4cad186e-ba8b-8e1a-731b-4350a095ba5a@oracle.com>
Date:   Wed, 16 Oct 2019 16:42:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015190436.65c8c7a3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160194
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thanks again for taking the time to review and providing feedback. Please find my comments inline.

On 10/15/19 4:04 PM, Steven Rostedt wrote:
> Sorry for taking so long to getting to these patches.
>
> On Wed, 14 Aug 2019 10:55:26 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> For functions returning a trace array Eg: trace_array_create(), we need to
>> increment the reference counter associated with the trace array to ensure it
>> does not get freed when in use.
>>
>> Once we are done using the trace array, we need to call
>> trace_array_put() to make sure we are not holding a reference to it
>> anymore and the instance/trace array can be removed when required.
> I think it would be more in line with other parts of the kernel if we
> don't need to do the trace_array_put() before calling
> trace_array_destroy().

The reason we went with this approach is

instance_mkdir -          ref_ctr = 0  // Does not return a trace array ptr.
trace_array_create -      ref_ctr = 1  // Since this returns a trace array ptr.
trace_array_lookup -      ref_ctr = 1  // Since this returns a trace array ptr.

if we make trace_array_destroy to expect ref_ctr to be 1, we risk destroying the trace array while in use.

We could make it -

instance_mkdir - 	ref_ctr = 1
trace_array_create -    ref_ctr = 2
trace_array_lookup -    ref_ctr = 2+  // depending on no of lookups

but, we'd still need the trace_array_put() (?)

We can also have one function doing create (if does not exist) or lookup (if exists), but that would require
some redundant code since instance_mkdir needs to return -EXIST when a trace array already exists.

Let me know your thoughts on this.

Thanks,
Divya

> That is, if we make the following change:
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5ff206ce259e..ae12aac21c6c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8527,9 +8527,11 @@ static int __remove_instance(struct trace_array *tr)
>   {
>   	int i;
>   
> -	if (tr->ref || (tr->current_trace && tr->current_trace->ref))
> +	if (tr->ref > 1 || (tr->current_trace && tr->current_trace->ref))
>   		return -EBUSY;
>   
> +	WARN_ON_ONCE(tr->ref != 1);
> +
>   	list_del(&tr->list);
>   
>   	/* Disable all the flags that were enabled coming in */
>
>> Hence, additionally exporting trace_array_put().
>>
>> Example use:
>>
>> tr = trace_array_create("foo-bar");
>> // Use this trace array
>> // Log to this trace array or enable/disable events to this trace array.
>> ....
>> ....
>> // tr no longer required
>> trace_array_put();
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> ---
>>   include/linux/trace.h |  1 +
>>   kernel/trace/trace.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/trace.h b/include/linux/trace.h
>> index 24fcf07..2c782d5 100644
>> --- a/include/linux/trace.h
>> +++ b/include/linux/trace.h
>> @@ -31,6 +31,7 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>>   		const char *fmt, ...);
>>   struct trace_array *trace_array_create(const char *name);
>>   int trace_array_destroy(struct trace_array *tr);
>> +void trace_array_put(struct trace_array *tr);
>>   #endif	/* CONFIG_TRACING */
>>   
>>   #endif	/* _LINUX_TRACE_H */
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 22bf166..7b6a37a 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -297,12 +297,22 @@ static void __trace_array_put(struct trace_array *this_tr)
>>   	this_tr->ref--;
>>   }
>>   
>> +/**
>> + * trace_array_put - Decrement reference counter for the given trace array.
>> + * @tr: Trace array for which reference counter needs to decrement.
>> + *
>> + * NOTE: Functions like trace_array_create increment the reference counter for
>> + * the trace array to ensure they do not get freed while in use. Make sure to
>> + * call trace_array_put() when the use is done. This will ensure that the
>> + * instance can be later removed.
>> + */
>>   void trace_array_put(struct trace_array *this_tr)
>>   {
>>   	mutex_lock(&trace_types_lock);
>>   	__trace_array_put(this_tr);
>>   	mutex_unlock(&trace_types_lock);
>>   }
>> +EXPORT_SYMBOL_GPL(trace_array_put);
>>   
>>   int call_filter_check_discard(struct trace_event_call *call, void *rec,
>>   			      struct ring_buffer *buffer,
>> @@ -8302,6 +8312,16 @@ static void update_tracer_options(struct trace_array *tr)
>>   	mutex_unlock(&trace_types_lock);
>>   }
>>   
>> +/**
>> + * trace_array_create - Create a new trace array with the given name.
>> + * @name: The name of the trace array to be created.
>> + *
>> + * Create and return a trace array with given name if it does not exist.
>> + *
>> + * NOTE: The reference counter associated with the returned trace array is
>> + * incremented to ensure it is not freed when in use. Make sure to call
>> + * "trace_array_put" for this trace array when its use is done.
>> + */
>>   struct trace_array *trace_array_create(const char *name)
>>   {
>>   	struct trace_array *tr;
>> @@ -8364,6 +8384,8 @@ struct trace_array *trace_array_create(const char *name)
>>   
>>   	list_add(&tr->list, &ftrace_trace_arrays);
>>   
>> +	tr->ref++;
>> +
>>   	mutex_unlock(&trace_types_lock);
>>   	mutex_unlock(&event_mutex);
>>   
>> @@ -8385,7 +8407,19 @@ struct trace_array *trace_array_create(const char *name)
>>   
>>   static int instance_mkdir(const char *name)
>>   {
>> -	return PTR_ERR_OR_ZERO(trace_array_create(name));
>> +	struct trace_array *tr;
>> +
>> +	tr = trace_array_create(name);
>> +	if (IS_ERR(tr))
>> +		return PTR_ERR(tr);
>> +
>> +	/* This function does not return a reference to the created trace array,
>> +	 * so the reference counter is to be 0 when it returns.
>> +	 * trace_array_create increments the ref counter, decrement it here
>> +	 * by calling trace_array_put() */
>> +	trace_array_put(tr);
>> +
> If we make it that the destroy needs tr->ref == 1, we can remove the
> above.
>
>> +	return 0;
>>   }
>>   
>>   static int __remove_instance(struct trace_array *tr)
>> @@ -8424,6 +8458,11 @@ static int __remove_instance(struct trace_array *tr)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * NOTE: An instance cannot be removed if there is still a reference to it.
>> + * Make sure to call "trace_array_put" for a trace array returned by functions
>> + * like trace_array_create(), otherwise trace_array_destroy will not succeed.
>> + */
> And remove the above comment too.
>
> -- Steve
>
>>   int trace_array_destroy(struct trace_array *this_tr)
>>   {
>>   	struct trace_array *tr;
