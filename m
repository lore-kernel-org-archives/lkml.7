Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C4C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1805120859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfDVCh1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:37:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2563 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfDVCh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:37:26 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 5F0A9B586E130D3D3AC8;
        Mon, 22 Apr 2019 10:37:24 +0800 (CST)
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0415.000;
 Mon, 22 Apr 2019 10:37:20 +0800
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
Subject: RE: [PATCH] signal: trace_signal_deliver when signal_group_exit
Thread-Topic: [PATCH] signal: trace_signal_deliver when signal_group_exit
Thread-Index: AdT4sMRJz5sKA+ApROaRV0FeV6WCvA==
Date:   Mon, 22 Apr 2019 02:37:21 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB1476@DGGEMI530-MBX.china.huawei.com>
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

On 04/20, Oleg Nesterov wrote:
>On 04/20, Zhenliang Wei wrote:
>>
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2441,6 +2441,8 @@ bool get_signal(struct ksignal *ksig)
>>  	if (signal_group_exit(signal)) {
>>  		ksig->info.si_signo = signr = SIGKILL;
>>  		sigdelset(&current->pending.signal, SIGKILL);
>> +		trace_signal_deliver(signr, &ksig->info,
>> +				&sighand->action[signr - 1]);
>
>Well, in this case ksig->info is not fully initialized for TP_STORE_SIGINFO() which reads si_errno/si_code...
>
>How about
>
>		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL)
>
>?
>
>We know that action[SIGKILL] must be SIG_DFL.
>
>And SEND_SIG_NOINFO matches the fact that SIGKILL doesn't have any info,
>collect_signal() sets SI_USER and clears si_errno in this case.
>
>Oleg.

Thank you for your review, I agree with your suggestion, and I will recommit the patch later.

Zhenliang Wei.
