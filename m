Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E51FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D293214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfDWOZO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:25:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2993 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfDWOZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:25:13 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 07446692A14290045861;
        Tue, 23 Apr 2019 22:25:09 +0800 (CST)
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0415.000;
 Tue, 23 Apr 2019 22:25:07 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Thread-Topic: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Thread-Index: AdT53lFy7/5lmntORAqlla0EhT1kYw==
Date:   Tue, 23 Apr 2019 14:25:07 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB16FB@DGGEMI530-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.99.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Greg KH wrote:
>On Mon, Apr 22, 2019 at 10:59:50PM +0800, Zhenliang Wei wrote:
>> In the fixes commit, removing SIGKILL from each thread signal mask and 
>> executing "goto fatal" directly will skip the call to 
>> "trace_signal_deliver". At this point, the delivery tracking of the 
>> SIGKILL signal will be inaccurate.
>> 
>> Therefore, we need to add trace_signal_deliver before "goto fatal"
>> after executing sigdelset.
>> 
>> Note: The action[SIGKILL] must be SIG_DFL, and SEND_SIG_NOINFO matches 
>> the fact that SIGKILL doesn't have any info.
>> 
>> Acked-by: Christian Brauner <christian@brauner.io>
>> Fixes: cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")
>> Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
>> ---
>>  kernel/signal.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/kernel/signal.c b/kernel/signal.c index 
>> 227ba170298e..0f69ada376ef 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2441,6 +2441,7 @@ bool get_signal(struct ksignal *ksig)
>>  	if (signal_group_exit(signal)) {
>>  		ksig->info.si_signo = signr = SIGKILL;
>>  		sigdelset(&current->pending.signal, SIGKILL);
>> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL);
>>  		recalc_sigpending();
>>  		goto fatal;
>>  	}
>> --
>> 2.14.1.windows.1
>> 
>> 
>
><formletter>
>
>This is not the correct way to submit patches for inclusion in the stable kernel tree.  Please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>for how to do this properly.
>
></formletter>

Thans for your reply, is that mean I still need to add tags
	Cc: stable@vger.kernel.org
if I want to submit this patch to the stable kernel tree?

Is my understanding correct or missing?

Wei
