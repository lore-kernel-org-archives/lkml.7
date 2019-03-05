Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7DD206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XgZKHL2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfCECLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:11:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58206 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfCECLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:11:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2529AUw035943;
        Tue, 5 Mar 2019 02:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=r4Zhng4BWDF7vzPS9/G7LTMnjj+Bcd3GX5ytDHQlvvI=;
 b=XgZKHL2VgIpUQQw8vxk9T2vDakJwN3ARtWCpUCKIvIzP3DtH2b07gnJzP/sOfJXQSMKa
 i1wTfK3ZutWAxptdVC/YPMNLxbl8B9BsBlc32hTy52cG3AEcVIug+IfzCcHHD5PaTrTD
 fCmAdJWMGwSr842c5EPJNFOTUDLKIsd4joJPDrAdpeva5TsfAm6RejQltSPfmJoByt+O
 QvdzlJaAeMThmWDsUz3P7VE+kLb8n+zvnSCtyfeyYUqDuOXKdXsN+fefDqg9FkyTh242
 5OXed8phPtSogGu0OPStzWechjO0h1sOMUE9GdQui6X/VBQ7ppS5Q/BKbQvGfR5j/a+p Dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qyfbe2tuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 02:11:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x252BGaX029299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 02:11:17 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x252BGIA027396;
        Tue, 5 Mar 2019 02:11:16 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 18:11:15 -0800
Subject: Re: [BUG linux-4.9.x] xen hotplug cpu leads to 100% steal usage
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, tglx@linutronix.de, joe.jin@oracle.com,
        Herbert Van Den Bergh <herbert.van.den.bergh@oracle.com>,
        sboyd@kernel.org, john.stultz@linaro.org
References: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
 <5bd0923f-29f6-0ad0-a1e9-92019a515b11@suse.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <804f087c-2def-4412-6869-5eb483572a52@oracle.com>
Date:   Tue, 5 Mar 2019 10:14:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5bd0923f-29f6-0ad0-a1e9-92019a515b11@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 3/4/19 4:14 PM, Juergen Gross wrote:
> On 01/03/2019 03:35, Dongli Zhang wrote:
>> This issue is only for stable 4.9.x (e.g., 4.9.160), while the root cause is
>> still in the lasted mainline kernel.
>>
>> This is obviated by new feature patch set ended with b672592f0221
>> ("sched/cputime: Remove generic asm headers").
>>
>> After xen guest is up for long time, once we hotplug new vcpu, the corresponding
>> steal usage might become 100% and the steal time from /proc/stat would increase
>> abnormally.
>>
>> As we cannot wait for long time to reproduce the issue, here is how I reproduce
>> it on purpose by accounting a large initial steal clock for new vcpu 2 and 3.
>>
>> 1. Apply the below patch to guest 4.9.160 to account large initial steal clock
>> for new vcpu 2 and 3:
>>
>> diff --git a/drivers/xen/time.c b/drivers/xen/time.c
>> index ac5f23f..3cf629e 100644
>> --- a/drivers/xen/time.c
>> +++ b/drivers/xen/time.c
>> @@ -85,7 +85,14 @@ u64 xen_steal_clock(int cpu)
>>         struct vcpu_runstate_info state;
>>  
>>         xen_get_runstate_snapshot_cpu(&state, cpu);
>> -       return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
>> +
>> +       if (cpu == 2 || cpu == 3)
>> +               return state.time[RUNSTATE_runnable]
>> +                      + state.time[RUNSTATE_offline]
>> +                      + 0x00071e87e677aa12;
>> +       else
>> +               return state.time[RUNSTATE_runnable]
>> +                      + state.time[RUNSTATE_offline];
>>  }
>>  
>>  void xen_setup_runstate_info(int cpu)
>>
>>
>> 2. Boot hvm guest with "vcpus=2" and "maxvcpus=4". By default, VM boot with
>> vcpu 0 and 1.
>>
>> 3. Hotplug vcpu 2 and 3 via "xl vcpu-set <domid> 4" on dom0.
>>
>> In my env, the steal becomes 100% within 10s after the "xl vcpu-set" command on
>> dom0.
>>
>> I can reproduce on kvm with similar method. However, as the initial steal clock
>> on kvm guest is always 0, I do not think it is easy to hit this issue on kvm.
>>
>> --------------------------------------------------------
>>
>> The root cause is that the return type of jiffies_to_usecs() is 'unsigned int',
>> but not 'unsigned long'. As a result, the leading 32 bits are discarded.
>>
>> jiffies_to_usecs() is indirectly triggered by cputime_to_nsecs() at line 264.
>> If guest is already up for long time, the initial steal time for new vcpu might
>> be large and the leading 32 bits of jiffies_to_usecs() would be discarded.
>>
>> As a result, the steal at line 259 is always large and the
>> this_rq()->prev_steal_time at line 264 is always small. The difference at line
>> 260 is always large during each time steal_account_process_time() is involved.
>> Finally, the steal time in /proc/stat would increase abnormally.
>>
>> 252 static __always_inline cputime_t steal_account_process_time(cputime_t maxtime)
>> 253 {
>> 254 #ifdef CONFIG_PARAVIRT
>> 255         if (static_key_false(&paravirt_steal_enabled)) {
>> 256                 cputime_t steal_cputime;
>> 257                 u64 steal;
>> 258 
>> 259                 steal = paravirt_steal_clock(smp_processor_id());
>> 260                 steal -= this_rq()->prev_steal_time;
>> 261 
>> 262                 steal_cputime = min(nsecs_to_cputime(steal), maxtime);
>> 263                 account_steal_time(steal_cputime);
>> 264                 this_rq()->prev_steal_time += cputime_to_nsecs(steal_cputime);
>> 265 
>> 266                 return steal_cputime;
>> 267         }
>> 268 #endif
>> 269         return 0;
>> 270 }
>>
>> --------------------------------------------------------
>>
>> I have emailed the kernel mailing list about the return type of
>> jiffies_to_usecs() and jiffies_to_msecs():
>>
>> https://lkml.org/lkml/2019/2/26/899
>>
>>
>> So far, I have two solutions:
>>
>> 1. Change the return type from 'unsigned int' to 'unsigned long' as in above
>> link and I am afraid it would bring side effect. The return type in latest
>> mainline kernel is still 'unsigned int'.
>>
>> 2. Something like below based on stable 4.9.160:
> 
> 3. use jiffies64_to_nsecs() instead of trying to open code it.

Thank you very much for the suggestion!

I have tested that jiffies64_to_nsecs() works well by reproducing the issue in
kvm guest on purpose.

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 734377a..94aff43 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -287,13 +287,13 @@ extern unsigned long preset_lpj;
 extern unsigned int jiffies_to_msecs(const unsigned long j);
 extern unsigned int jiffies_to_usecs(const unsigned long j);

+extern u64 jiffies64_to_nsecs(u64 j);
+
 static inline u64 jiffies_to_nsecs(const unsigned long j)
 {
-       return (u64)jiffies_to_usecs(j) * NSEC_PER_USEC;
+       return jiffies64_to_nsecs(j);
 }

-extern u64 jiffies64_to_nsecs(u64 j);



Below is the patch used to reproduce on kvm. cpu 2 is added to reproduce on
purpose via "device_add
qemu64-x86_64-cpu,id=core2,socket-id=2,core-id=0,thread-id=0" in qemu monitor.
Guest is boot with qemu cmd "-smp 2,maxcpus=3"

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 77f17cb..54d46e0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -407,7 +407,10 @@ static u64 kvm_steal_clock(int cpu)
                rmb();
        } while ((version & 1) || (version != src->version));

-       return steal;
+       if (cpu == 0 || cpu == 1)
+               return steal;
+       else
+               return steal + 0x00071e87e677aa12;
 }


Dongli Zhang
