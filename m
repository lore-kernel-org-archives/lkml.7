Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8817EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53837214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfDWNK6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:10:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727725AbfDWNK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:10:57 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id B63AF5F89F4749E473A9;
        Tue, 23 Apr 2019 21:10:54 +0800 (CST)
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi405-hub.china.huawei.com ([10.3.17.143]) with mapi id 14.03.0415.000;
 Tue, 23 Apr 2019 21:10:53 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Thread-Topic: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Thread-Index: AdT51YDlnU0d+FcxSneaCWEN6wQNxA==
Date:   Tue, 23 Apr 2019 13:10:52 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB16AE@DGGEMI530-MBX.china.huawei.com>
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

On Mon, Apr 22, 2019 at 11:25 PM Oleg Nesterov <oleg@redhat.com> wrote:
>On 04/22, Zhenliang Wei wrote:
>>
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
>
>Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Last time Oleg suggested using SIG_DFL as the third parameter, but its type is 'void (*)(int)', but not expected 'struct k_sigaction *'.

How about
	trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, &sighand->action[signr - 1]);
?

Although we know that action[SIGKILL] must be SIG_DFL, in order to adapt to the parameter type, I suggest to use the original variable value.

Zhenliang Wei.
