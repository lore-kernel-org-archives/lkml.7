Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77C520854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMcBcy2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfJOTyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:54:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfJOTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:54:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FJhthX188883;
        Tue, 15 Oct 2019 19:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=eoUduIyV9H1MXYs+zb8W+38M9Juyos1S7c1SaknckLw=;
 b=OMcBcy2WV4NdOjLVjXggB/WHnEufBpcZ/HRTKd5lEu7o2M32VmjO/OXuvLxTT2+wBqvr
 6Evf1dekFkSHCNP/ov6jMi8f+A5usQC+IUlWB5AM2HopRaY+M3U41yCatLExmF+wY5en
 PXV5oDs+3TDkuAhSpAUBLXMU40A8lm1jSgTdL/OS00EkgtTzAC/2YoXXYQiTUVUswB9l
 /1P6xOakjx5r6Cu0bZv1bTuHahVvYva2io+XSNWJD1TNUUau0Y6U/3XK8ftF+m9bpemZ
 CPageYpMk8zNBXHBw6XBY2zERoYvqMqM1zJTU2Fr3M6M8k7JVBRaqMzn/uy3bUMB+hAl ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frab6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 19:53:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FJqouf042465;
        Tue, 15 Oct 2019 19:53:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vnf7ru736-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 19:53:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FJrpdj024121;
        Tue, 15 Oct 2019 19:53:51 GMT
Received: from diindi-vnc.local (/10.11.47.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 19:53:51 +0000
Subject: Re: [PATCH] tracing: Sample module to demonstrate kernel access to
 Ftrace instances.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
References: <1569023966-23004-1-git-send-email-divya.indi@oracle.com>
 <1569023966-23004-2-git-send-email-divya.indi@oracle.com>
 <20191015130536.3b1f5bf6@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <2040eac0-01f6-9a6f-2254-40e484fb3cd3@oracle.com>
Date:   Tue, 15 Oct 2019 12:53:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015130536.3b1f5bf6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies for multiple resends, formatting issue]


Hi Steven,


Thanks for taking a look.

This sample module is dependent on -

- commit: f45d122 tracing: Kernel access to Ftrace instances
- Patches pending review: https://lore.kernel.org/lkml/1565805327-579-1-git-send-email-divya.indi@oracle.com/

I mentioned it in the cover page, but will add to this patch as well to avoid confusion.

So, I think the messages you are seeing is due to the absence of

Patches pending review: https://lore.kernel.org/lkml/1565805327-579-1-git-send-email-divya.indi@oracle.com/


Let me know if you prefer to have the sample module and this patch-set (pending review) as part of one patch set.

For reference, adding the cover page details here -

------------------------------------------------------------------------------------------------------------------
This patch is for a sample module to demonstrate the use of APIs that
were introduced/exported in order to access Ftrace instances from within the kernel.

Please Note: This module is dependent on -
- commit: f45d122 tracing: Kernel access to Ftrace instances
- Patches pending review: https://lore.kernel.org/lkml/1565805327-579-1-git-send-email-divya.indi@oracle.com/

The sample module creates/lookup a trace array called sample-instance on module load time.
We then start a kernel thread(simple-thread) to -
1) Enable tracing for event "sample_event" to buffer associated with the trace array - "sample-instance".
2) Start a timer that will disable tracing to this buffer after 5 sec. (Tracing disabled after 5 sec ie at count=4)
3) Write to the buffer using trace_array_printk()
4) Stop the kernel thread and destroy the buffer during module unload.

A sample output for the same -

# tracer: nop
#
# entries-in-buffer/entries-written: 16/16   #P:4
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
  sample-instance-26797 [003] .... 955180.489833: simple_thread: trace_array_printk: count=0
  sample-instance-26797 [003] .... 955180.489836: sample_event: count value=0 at jiffies=5249940864
  sample-instance-26797 [003] .... 955181.513722: simple_thread: trace_array_printk: count=1
  sample-instance-26797 [003] .... 955181.513724: sample_event: count value=1 at jiffies=5249941888
  sample-instance-26797 [003] .... 955182.537629: simple_thread: trace_array_printk: count=2
  sample-instance-26797 [003] .... 955182.537631: sample_event: count value=2 at jiffies=5249942912
  sample-instance-26797 [003] .... 955183.561516: simple_thread: trace_array_printk: count=3
  sample-instance-26797 [003] .... 955183.561518: sample_event: count value=3 at jiffies=5249943936
  sample-instance-26797 [003] .... 955184.585423: simple_thread: trace_array_printk: count=4
  sample-instance-26797 [003] .... 955184.585427: sample_event: count value=4 at jiffies=5249944960
  sample-instance-26797 [003] .... 955185.609344: simple_thread: trace_array_printk: count=5
  sample-instance-26797 [003] .... 955186.633241: simple_thread: trace_array_printk: count=6
  sample-instance-26797 [003] .... 955187.657157: simple_thread: trace_array_printk: count=7
  sample-instance-26797 [003] .... 955188.681039: simple_thread: trace_array_printk: count=8
  sample-instance-26797 [003] .... 955189.704937: simple_thread: trace_array_printk: count=9
  sample-instance-26797 [003] .... 955190.728840: simple_thread: trace_array_printk: count=10

--------------------------------------------------------------------------------------------------------------------


Thanks,
Divya

On 10/15/19 10:05 AM, Steven Rostedt wrote:
> On Fri, 20 Sep 2019 16:59:26 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> This is a sample module to demostrate the use of the newly introduced and
>> exported APIs to access Ftrace instances from within the kernel.
>>
>> Newly introduced APIs used here -
>>
>> 1. Create a new trace array if it does not exist.
>> struct trace_array *trace_array_create(const char *name)
>>
>> 2. Destroy/Remove a trace array.
>> int trace_array_destroy(struct trace_array *tr)
>>
>> 3. Lookup a trace array, given its name.
>> struct trace_array *trace_array_lookup(const char *name)
>>
>> 4. Enable/Disable trace events:
>> int trace_array_set_clr_event(struct trace_array *tr, const char *system,
>>          const char *event, int set);
>>
>> Exported APIs -
>> 1. trace_printk equivalent for instances.
>> int trace_array_printk(struct trace_array *tr,
>>                 unsigned long ip, const char *fmt, ...);
>>
>> 2. Helper function.
>> void trace_printk_init_buffers(void);
>>
>> 3. To decrement the reference counter.
>> void trace_array_put(struct trace_array *tr)
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> Reviewed-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> Reviewed-by: Joe Jin <joe.jin@oracle.com>
>> ---
>>   samples/Kconfig                              |   7 ++
>>   samples/Makefile                             |   1 +
>>   samples/ftrace_instance/Makefile             |   6 ++
>>   samples/ftrace_instance/sample-trace-array.c | 134 +++++++++++++++++++++++++++
>>   samples/ftrace_instance/sample-trace-array.h |  84 +++++++++++++++++
>>   5 files changed, 232 insertions(+)
>>   create mode 100644 samples/ftrace_instance/Makefile
>>   create mode 100644 samples/ftrace_instance/sample-trace-array.c
>>   create mode 100644 samples/ftrace_instance/sample-trace-array.h
>>
> I applied this patch but get this:
>
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘mytimer_handler’:
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:35:2: error: implicit declaration of function ‘trace_array_set_clr_event’; did you mean ‘trace_set_clr_event’? [-Werror=implicit-function-declaration]
>    trace_array_set_clr_event(tr, "sample-subsystem", "sample_event", 0);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
>    trace_set_clr_event
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘simple_thread_func’:
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:47:2: error: implicit declaration of function ‘trace_array_printk’; did you mean ‘trace_seq_printf’? [-Werror=implicit-function-declaration]
>    trace_array_printk(tr, _THIS_IP_, "trace_array_printk: count=%d\n",
>    ^~~~~~~~~~~~~~~~~~
>    trace_seq_printf
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘simple_thread’:
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:85:2: error: implicit declaration of function ‘trace_array_put’; did you mean ‘trace_seq_putc’? [-Werror=implicit-function-declaration]
>    trace_array_put(tr);
>    ^~~~~~~~~~~~~~~
>    trace_seq_putc
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘sample_trace_array_init’:
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:100:7: error: implicit declaration of function ‘trace_array_lookup’; did you mean ‘radix_tree_lookup’? [-Werror=implicit-function-declaration]
>    tr = trace_array_lookup("sample-instance");
>         ^~~~~~~~~~~~~~~~~~
>         radix_tree_lookup
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:100:5: warning: assignment to ‘struct trace_array *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>    tr = trace_array_lookup("sample-instance");
>       ^
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:102:8: error: implicit declaration of function ‘trace_array_create’; did you mean ‘ftrace_force_update’? [-Werror=implicit-function-declaration]
>     tr = trace_array_create("sample-instance");
>          ^~~~~~~~~~~~~~~~~~
>          ftrace_force_update
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:102:6: warning: assignment to ‘struct trace_array *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>     tr = trace_array_create("sample-instance");
>        ^
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:110:2: error: implicit declaration of function ‘trace_printk_init_buffers’; did you mean ‘trace_event_get_offsets’? [-Werror=implicit-function-declaration]
>    trace_printk_init_buffers();
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
>    trace_event_get_offsets
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘sample_trace_array_exit’:
> /work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:126:2: error: implicit declaration of function ‘trace_array_destroy’; did you mean ‘assoc_array_destroy’? [-Werror=implicit-function-declaration]
>    trace_array_destroy(tr);
>    ^~~~~~~~~~~~~~~~~~~
>    assoc_array_destroy
> cc1: some warnings being treated as errors
> make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:266: samples/ftrace_instance/sample-trace-array.o] Error 1
> make[2]: *** [/work/git/linux-trace.git/scripts/Makefile.build:509: samples/ftrace_instance] Error 2
> make[1]: *** [/work/git/linux-trace.git/Makefile:1650: samples] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
>
> -- Steve
