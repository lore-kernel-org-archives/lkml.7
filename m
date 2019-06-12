Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B0EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410C82082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GbBe73uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437522AbfFLPNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:13:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408727AbfFLPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:13:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CFBfQr089743;
        Wed, 12 Jun 2019 15:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=aAyXfrsJ3caDYkF9DE8U0DH4YRwJe/cHKCxDlFo6Ipg=;
 b=GbBe73uckIBR4mcA2ACipomRNuKg3tgnmkjySLi3tTBQDF4DGbHLTf/zvgL0lN1PR3RO
 pm6IRDXbQ6hQvNF/uYzg0n6kW1DBoALdvr0EktNl4Vw69rCWWijkhtZo5Yc6S5TUK7I+
 sHpeY9BnNcOlIPOsfQUaBAOmZYNcrPoOQ6M40itDDuS6byAJz2ibGn/O2MWobJWdQ6SR
 kXEuDiSeQ1VJnlwIVQbpz1kmoYfTcLfxRniwPRLa+XABTn1JVv2nZR4iN6ZsJOkQpaxo
 wPjSfC9fdMrpTmX+c26yvJpAA4HoWbuu9FEU5TsyZmrwps1H5RUo04xuAgyy3I/+sycs ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04etv780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:12:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CFCEDT095806;
        Wed, 12 Jun 2019 15:12:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t0p9rx1mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:12:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CFCWNk029114;
        Wed, 12 Jun 2019 15:12:32 GMT
Received: from dhcp-10-159-245-162.vpn.oracle.com (/10.159.245.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 08:12:32 -0700
Subject: Re: [PATCH 3/3] tracing: Add 2 new funcs. for kernel access to Ftrace
 instances.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
 <1559695325-17155-2-git-send-email-divya.indi@oracle.com>
 <1559695325-17155-3-git-send-email-divya.indi@oracle.com>
 <1559695325-17155-4-git-send-email-divya.indi@oracle.com>
 <20190608175142.1a4444a4@oasis.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <6a82c4cb-0b4a-f652-9fc6-e46b6035cad7@oracle.com>
Date:   Wed, 12 Jun 2019 08:12:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608175142.1a4444a4@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thanks for taking the time to review. Please find my comments inline.

On 6/8/19 2:51 PM, Steven Rostedt wrote:
> On Tue,  4 Jun 2019 17:42:05 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Adding 2 new functions -
>> 1) trace_array_lookup : Look up and return a trace array, given its
>> name.
>> 2) trace_array_set_clr_event : Enable/disable event recording to the
>> given trace array.
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> ---
>>   include/linux/trace_events.h |  3 +++
>>   kernel/trace/trace.c         | 11 +++++++++++
>>   kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
>>   3 files changed, 36 insertions(+)
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
>> index a60dc13..1d171fd 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -8465,6 +8465,17 @@ static int instance_rmdir(const char *name)
>>   	return ret;
>>   }
>>   
>> +struct trace_array *trace_array_lookup(const char *name)
>> +{
>> +	struct trace_array *tr;
>> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> Accessing the ftrace_trace_arrays requires taking the trace_types_lock.
> It should also probably increment the ref counter too, and then
> trace_array_put() needs to be called.
>
> This prevents the trace array from being freed while something has
> access to it.
>
> -- Steve

Agree - Noted!

Also, adding a similar change for trace_array_create which also returns 
a ptr to a newly created trace_array so will face the same issue.

Since trace_array_lookup and trace_array_create will be accompanied by a 
trace_array_destroy once the use of the trace_array is done, 
decrementing the reference ctr here.

Sending a v2 to address this.


Thanks,

Divya

>
>> +		if (tr->name && strcmp(tr->name, name) == 0)
>> +			return tr;
>> +	}
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
>> +
>> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
>> +}
>> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
>> +
>>   /* 128 should be much more than enough */
>>   #define EVENT_BUF_SIZE		127
>>   
