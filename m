Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9621852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iFql2BBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632949AbfJRIsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:48:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632940AbfJRIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:48:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I8i9BP028994;
        Fri, 18 Oct 2019 08:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=XykSB0gBQiTVbG4KBFgo1d2RuALABYecpLgSMG6zHrw=;
 b=iFql2BBIM8CpDm7UmmJuk9L3BBkuCq28HuJKP+91dn+Ln6VMIKeq1vx20gmMCz88eO3h
 6LfQmusNCEIvzU8+Fvik5FjIi/pcdy/58K5jL3+AOFj9OTMFK15GqSW2oA5OVm8eyh6z
 dSt8L71v448jrwxkxNs/o8s2WHTbVErLESEAkLnjUfuOiNTsF9LdNA1XPemEWQFhVS9Q
 4rPycX5dq7ZnHcI1vgAAK5XpQ95dnaBE0qErpBOAWZw59OcGc7NCOdOXSp+uCUh+EdB2
 ogdAweSU7aOqvZNDJvb08sNXpRuxDpU7gWHyxKv6gEUNJqLpb3H+ocqE5UpOnrASGgFQ mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vq0q42e7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 08:47:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I8hXMK173381;
        Fri, 18 Oct 2019 08:47:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vq0dxdmt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 08:47:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9I8lOnR002288;
        Fri, 18 Oct 2019 08:47:28 GMT
Received: from [10.191.11.92] (/10.191.11.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 08:47:24 +0000
Subject: Re: [PATCH] x86: Don't use MWAIT if explicitly requested
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        tim.c.chen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <1571370354-17736-1-git-send-email-zhenzhong.duan@oracle.com>
 <20191018071206.GZ2328@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <56b074ab-8718-180c-b3dd-72687025c5a8@oracle.com>
Date:   Fri, 18 Oct 2019 16:47:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018071206.GZ2328@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/18 15:12, Peter Zijlstra wrote:
> On Fri, Oct 18, 2019 at 11:45:54AM +0800, Zhenzhong Duan wrote:
>> If 'idle=nomwait' is specified or process matching what's in
>> processor_idle_dmi_table, we should't use MWAIT at bootup stage before
>> cpuidle driver loaded, even if it's preferred by default on Intel.
>>
>> Add a check so that HALT instruction is used in those cases.
> The comment in idle_setup():
>
> 	/*
> 	 * If the boot option of "idle=nomwait" is added,
> 	 * it means that mwait will be disabled for CPU C2/C3
> 	 * states. In such case it won't touch the variable
> 	 * of boot_option_idle_override.
> 	 */
> 	boot_option_idle_override = IDLE_NOMWAIT;
>
> explicitly states this option is for C2+

Yea, this is confusing. Other place referencing 
boot_option_idle_override tell me

"idle=nomwait" means not using mwait for all cstates. Maybe 'C2/C3' could be

removed from above comment?

See drivers/acpi/processor_idle.c:

                         if (cx.type == ACPI_STATE_C1 &&
                             (boot_option_idle_override == IDLE_NOMWAIT)) {
                                 /*
                                  * In most cases the C1 space_id 
obtained from
                                  * _CST object is FIXED_HARDWARE access 
mode.
                                  * But when the option of idle=halt is 
added,
                                  * the entry_method type should be 
changed from
                                  * CSTATE_FFH to CSTATE_HALT.
                                  * When the option of idle=nomwait is 
added,
                                  * the C1 entry_method type should be
                                  * CSTATE_HALT.
                                  */
                                 cx.entry_method = ACPI_CSTATE_HALT;
                                 snprintf(cx.desc, ACPI_CX_DESC_LEN, 
"ACPI HLT");
                         }

and drivers/acpi/processor_pdc.c:

         if (boot_option_idle_override == IDLE_NOMWAIT) {
                 /*
                  * If mwait is disabled for CPU C-states, the C2C3_FFH 
access
                  * mode will be disabled in the parameter of _PDC object.
                  * Of course C1_FFH access mode will also be disabled.
                  */
                 union acpi_object *obj;
                 u32 *buffer = NULL;

                 obj = pdc_in->pointer;
                 buffer = (u32 *)(obj->buffer.pointer);
                 buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);

         }

>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> ---
>>   arch/x86/kernel/process.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index 5e94c43..37fc577 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -667,6 +667,10 @@ static void amd_e400_idle(void)
>>    */
>>   static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>   {
>> +	/* Don't use MWAIT-C1 if explicitly requested */
>> +	if (boot_option_idle_override == IDLE_NOMWAIT)
>> +		return 0;
> And this is very much about C1...
>
> OTOH, "idle=halt" should be forcing HLT over MWAIT, so did you want to
> write:
>
> 	if (boot_option_idle_override == IDLE_HALT)
> 		return 0;
>
> instead?

I think it's not necessory, if 'idle=halt' specified, 
select_idle_routine() returns early,

prefer_mwait_c1_over_halt() is never called.

Zhenzhong

