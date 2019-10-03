Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DFFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E622133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="n9B5O4YZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJCPTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:19:02 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:15744 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbfJCPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:19:02 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93FA2qG015613;
        Thu, 3 Oct 2019 16:17:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=yPUa0VympczCHQKEV8JCK8Xng4WXHXVbTta5NJUb/yo=;
 b=n9B5O4YZo+beVX1gLeJgcURbFleUfB2UZlPhfGGYvjs+kjcJAkdOycTR8LMvPDlZFbpi
 IZderzyDiCRM3czWekwTWF1dockVukcvPipp2P7TrEp7oDMGRpBIyr5NQeJ9lZ+YAWj3
 cZVVPuSZcqXBznuMHY5K+XO74xivpcXqsUcuLnO80MZtWYUnvTgOq9AS3EZaOzMLWWCV
 0Nc1jzLnB8VtVlXys8Qw+et5NLMg61sgUAJwh27B/eA8XCNrDdo31gmcAKl1MZANZz16
 SEznRqgKLTYBRABRwDbDY9+j/qe0x1GR0mpwAGOuVaei1Vpvreuh+gvT0hJr1Z3g2Oe2 Pw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2v9xs8keqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 16:17:41 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x93F6Md6025414;
        Thu, 3 Oct 2019 11:17:40 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2va2ux9jg7-1;
        Thu, 03 Oct 2019 11:17:39 -0400
Received: from [0.0.0.0] (prod-ssh-gw02.sanmateo.corp.akamai.com [172.22.187.166])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id E0B9D1FC36;
        Thu,  3 Oct 2019 15:17:38 +0000 (GMT)
Subject: Re: 4.19 dwarf unwinding broken
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     john@metanate.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, khlebnikov@yandex-team.ru,
        namhyung@kernel.org, peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
References: <ab87d20b-526c-9435-0532-c298beeb0318@akamai.com>
 <20191003100300.GA22784@krava>
From:   Josh Hunt <johunt@akamai.com>
Message-ID: <d0e0a675-1344-a47b-c27e-ea05230d88b8@akamai.com>
Date:   Thu, 3 Oct 2019 08:17:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003100300.GA22784@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030141
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_06:2019-10-03,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=21
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/19 3:03 AM, Jiri Olsa wrote:
> On Thu, Oct 03, 2019 at 12:54:09AM -0700, Josh Hunt wrote:
>> The following commit is breaking dwarf unwinding on 4.19 kernels:
> 
> how?

When doing something like:
perf record -p $(cat /var/run/app.pid) -g --call-graph dwarf -F 999 -- 
sleep 3

with 4.19.75 perf I see things like:

app_Thr00 26247 1810131.375329:     168288 cycles:ppp:

app_Thr01 26767 1810131.377449:     344415 cycles:ppp:

uvm:WorkerThread 26746 1810131.383052:        504 cycles:ppp:
         ffffffff9f77cce0 _raw_spin_lock+0x10 (/boot/vmlinux-4.19.46)
         ffffffff9f181527 __perf_event_task_sched_in+0xf7 
(/boot/vmlinux-4.19.46)
         ffffffff9f09a7b8 finish_task_switch+0x158 (/boot/vmlinux-4.19.46)
         ffffffff9f778276 __schedule+0x2f6 (/boot/vmlinux-4.19.46)
         ffffffff9f7787f2 schedule+0x32 (/boot/vmlinux-4.19.46)
         ffffffff9f77bb0a schedule_hrtimeout_range_clock+0x8a 
(/boot/vmlinux-4.19.46)
         ffffffff9f22ea12 poll_schedule_timeout.constprop.6+0x42 
(/boot/vmlinux-4.19.46)
         ffffffff9f22eeeb do_sys_poll+0x4ab (/boot/vmlinux-4.19.46)
         ffffffff9f22fb7b __se_sys_poll+0x5b (/boot/vmlinux-4.19.46)
         ffffffff9f0023de do_syscall_64+0x4e (/boot/vmlinux-4.19.46)
         ffffffff9f800088 entry_SYSCALL_64+0x68 (/boot/vmlinux-4.19.46)
---

and with 4.19.75 perf with e5adfc3e7e77 reverted those empty call stacks 
go away and also other call stacks show more thread details:

uvm:WorkerThread 26746 1810207.336391:          1 cycles:ppp:
         ffffffff9f181505 __perf_event_task_sched_in+0xd5 
(/boot/vmlinux-4.19.46)
         ffffffff9f09a7b8 finish_task_switch+0x158 (/boot/vmlinux-4.19.46)
         ffffffff9f778276 __schedule+0x2f6 (/boot/vmlinux-4.19.46)
         ffffffff9f7787f2 schedule+0x32 (/boot/vmlinux-4.19.46)
         ffffffff9f77bb0a schedule_hrtimeout_range_clock+0x8a 
(/boot/vmlinux-4.19.46)
         ffffffff9f22ea12 poll_schedule_timeout.constprop.6+0x42 
(/boot/vmlinux-4.19.46)
         ffffffff9f22eeeb do_sys_poll+0x4ab (/boot/vmlinux-4.19.46)
         ffffffff9f22fb7b __se_sys_poll+0x5b (/boot/vmlinux-4.19.46)
         ffffffff9f0023de do_syscall_64+0x4e (/boot/vmlinux-4.19.46)
         ffffffff9f800088 entry_SYSCALL_64+0x68 (/boot/vmlinux-4.19.46)
             7f7ef3f5c90d [unknown] (/lib/x86_64-linux-gnu/libc-2.23.so)
                  3eb5c99 poll+0xc9 (inlined)
                  3eb5c99 colib::ipc::EventFd::wait+0xc9 
(/usr/local/bin/app)
                  3296779 uvm::WorkerThread::run+0x129 (/usr/local/bin/app)
         ffffffffffffffff [unknown] ([unknown])

They also look the same as earlier kernel versions we have running.

In addition reading e8ba2906f6b's changelog sounded very similar to what 
I was seeing. This application launches a # of threads and is definitely 
already running before the invocation of perf.

Thanks for looking at this.

Josh
> 
> jirka
> 
>>
>> commit e5adfc3e7e774ba86f7bb725c6eef5f32df8630e
>> Author: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Date:   Tue Aug 7 12:09:01 2018 +0300
>>
>>      perf map: Synthesize maps only for thread group leader
>>
>> It looks like this was fixed later by:
>>
>> commit e8ba2906f6b9054102ad035ac9cafad9d4168589
>> Author: John Keeping <john@metanate.com>
>> Date:   Thu Aug 15 11:01:45 2019 +0100
>>
>>      perf unwind: Fix libunwind when tid != pid
>>
>> but was not selected as a backport to 4.19. Are there plans to backport the
>> fix? If not, could we have the breaking commit reverted in 4.19 LTS?
>>
>> Thanks
>> Josh
