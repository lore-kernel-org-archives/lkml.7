Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC24C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D464217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="doiaRa7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbfDRPp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:45:28 -0400
Received: from mail.efficios.com ([167.114.142.138]:34824 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:45:27 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 542F618CBD1;
        Thu, 18 Apr 2019 11:45:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id q3A5jv81wklf; Thu, 18 Apr 2019 11:45:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DD59C18CBC8;
        Thu, 18 Apr 2019 11:45:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DD59C18CBC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555602325;
        bh=wx+d4/Ew5sWNE1k2M00jLFmc9PiB+/rIg9xnPzz/IMI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=doiaRa7lGOlMoBIb2023XLzd4SSGYmUoP50joquWJyeCrukMhPA9+Dq8Ft4r/GtO0
         ETQzGZllBargISDcun/AeOWfqPsDuU3NVFJfwlV2kE7yY+7ACNRoUt+HwOH3u9CZnZ
         RvaaPPb+kv5RHHNKk1dE8ACdg6h6K/fTScBnDu/Wti+6I6WqC4iWMhdd/rN720lIx0
         TrUPtv81QZDB4NzRD/DDFaEqvujUNHv9qfa85TheFZD7FzjxZITzAsJFq7oruRCyPk
         PDtmOkO3shg3FmcNidBsmQoL2HGDNBFGsqA3NHcKywUGn3y98PPXRw/oUzUJlBV5to
         zayKudIHJhugA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 6nM6zsHsJ73F; Thu, 18 Apr 2019 11:45:25 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C51E218CBC1;
        Thu, 18 Apr 2019 11:45:25 -0400 (EDT)
Date:   Thu, 18 Apr 2019 11:45:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     carlos <carlos@redhat.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1072203859.1074.1555602325772.JavaMail.zimbra@efficios.com>
In-Reply-To: <c9c53d4b-ed9b-f2d9-60b0-e5e805de0324@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-3-mathieu.desnoyers@efficios.com> <c9c53d4b-ed9b-f2d9-60b0-e5e805de0324@arm.com>
Subject: Re: [PATCH 2/5] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
 (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v2)
Thread-Index: AQHU9HpZl2rnFP3D20yib30BAxg97aZCDzCAXM98Qgw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 18, 2019, at 11:33 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:

> On 16/04/2019 18:32, Mathieu Desnoyers wrote:
>> --- a/sysdeps/unix/sysv/linux/sched_getcpu.c
>> +++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
>> @@ -37,3 +37,26 @@ sched_getcpu (void)
>>    return -1;
>>  #endif
>>  }
>> +
>> +#ifdef __NR_rseq
>> +#include <sys/rseq.h>
>> +#endif
>> +
>> +#if defined __NR_rseq && defined RSEQ_SIG
>> +extern __attribute__ ((tls_model ("initial-exec")))
>> +__thread volatile struct rseq __rseq_abi;
> 
> i'd expect sys/rseq.h to provide this declaration.

And it actually does! Will remove this duplicate.

Thanks,

Mathieu

> 
>> +
>> +int
>> +sched_getcpu (void)
>> +{
>> +  int cpu_id = __rseq_abi.cpu_id;
>> +
>> +  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
>> +}
>> +#else
>> +int
>> +sched_getcpu (void)
>> +{
>> +  return vsyscall_sched_getcpu ();
>> +}
>> +#endif
>> -- 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
