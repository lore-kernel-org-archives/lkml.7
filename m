Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E1C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2682067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBoG8XVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfGOFGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:06:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47716 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfGOFGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:06:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F54etU079658;
        Mon, 15 Jul 2019 05:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2l/EtsL/XoHbgXHMaLYFldByJTczF6kBDhxbYvtpLPM=;
 b=kBoG8XVv42nEqXSF2HoXapvC9IDjC1xkeDPzSWf6XbriQVP6kHFRX7xEX2dnL7tvyWr7
 QL/qzlu1Kad1UFxq05tQWuCry+jCi4YTzLHOX/OqgPhpOjMwNOaY/XEUWu+xHJNqtR/w
 LiXFCapfyb67oFcmgI8vBk/y7FzC24Uvs5Pfdzko1p0tGYVnTAcNq+YkAw79yocN/dfM
 9iIW/yZns16jWToOZM+zD6WhHIEPxUg6l6bqP3fwPGfoBW3vKrcAVl+Qy280ONL4rDFq
 QNZfq9c4gp8wpBBFnFGsCufqEh8vtDV4IRKZxKsD+bUHVir9AgWQoP93mJis3c2pJSG4 EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtca54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 05:05:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F536LJ132940;
        Mon, 15 Jul 2019 05:05:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tq6mm30un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 05:05:26 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6F55KrY025333;
        Mon, 15 Jul 2019 05:05:23 GMT
Received: from [192.168.0.8] (/116.136.20.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Jul 2019 22:05:20 -0700
Subject: Re: [Xen-devel] [PATCH v2] xen/pv: Fix a boot up hang revealed by
 int3 self test
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        srinivas.eeda@oracle.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
 <ebf9657b-7d97-87a0-e32e-af8453ee7bba@citrix.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <b9702975-dd2d-cf0b-e47f-a1c4361db18f@oracle.com>
Date:   Mon, 15 Jul 2019 13:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ebf9657b-7d97-87a0-e32e-af8453ee7bba@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/12 22:06, Andrew Cooper wrote:
> On 11/07/2019 03:15, Zhenzhong Duan wrote:
>> Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
>> selftest") is used to ensure there is a gap setup in exception stack
>> which could be used for inserting call return address.
>>
>> This gap is missed in XEN PV int3 exception entry path, then below panic
>> triggered:
>>
>> [    0.772876] general protection fault: 0000 [#1] SMP NOPTI
>> [    0.772886] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0+ #11
>> [    0.772893] RIP: e030:int3_magic+0x0/0x7
>> [    0.772905] RSP: 3507:ffffffff82203e98 EFLAGS: 00000246
>> [    0.773334] Call Trace:
>> [    0.773334]  alternative_instructions+0x3d/0x12e
>> [    0.773334]  check_bugs+0x7c9/0x887
>> [    0.773334]  ? __get_locked_pte+0x178/0x1f0
>> [    0.773334]  start_kernel+0x4ff/0x535
>> [    0.773334]  ? set_init_arg+0x55/0x55
>> [    0.773334]  xen_start_kernel+0x571/0x57a
>>
>> As xenint3 and int3 entry code are same except xenint3 doesn't generate
>> a gap, we can fix it by using int3 and drop useless xenint3.
> For 64bit PV guests, Xen's ABI enters the kernel with using SYSRET, with
> %rcx/%r11 on the stack.
>
> To convert back to "normal" looking exceptions, the xen thunks do `pop
> %rcx; pop %r11; jmp do_*`...
I will add this to commit message.
>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 0ea4831..35a66fc 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1176,7 +1176,6 @@ idtentry stack_segment		do_stack_segment	has_error_code=1
>>   #ifdef CONFIG_XEN_PV
>>   idtentry xennmi			do_nmi			has_error_code=0
>>   idtentry xendebug		do_debug		has_error_code=0
>> -idtentry xenint3		do_int3			has_error_code=0
>>   #endif
> What is confusing is why there are 3 extra magic versions here.  At a
> guess, I'd say something to do with IST settings (given the vectors),
> but I don't see why #DB/#BP would need to be different in the first
> place.  (NMI sure, but that is more to do with the crazy hoops needing
> to be jumped through to keep native functioning safely.)

xenint3 will be removed in this patch safely as it don't use IST now.

But debug and nmi need paranoid_entry which will read MSR_GS_BASE to 
determine

if swapgs is needed. I guess PV guesting running in ring3 will #GP with 
swapgs?


Zhenzhong

