Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9978DC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 23:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D49D206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 23:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="auzI147H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfFIXiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 19:38:17 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4312 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFIXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 19:38:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfd98680000>; Sun, 09 Jun 2019 16:38:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 09 Jun 2019 16:38:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 09 Jun 2019 16:38:16 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 9 Jun
 2019 23:38:15 +0000
Subject: Re: [PATCH 1/1] lockdep: fix warning: print_lock_trace defined but
 not used
To:     <paulmck@linux.ibm.com>, <john.hubbard@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
References: <20190521070808.3536-1-jhubbard@nvidia.com>
 <20190521070808.3536-2-jhubbard@nvidia.com>
 <20190609135114.GX28207@linux.ibm.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7336e00d-11d8-9be1-8856-92e47b42aa37@nvidia.com>
Date:   Sun, 9 Jun 2019 16:38:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609135114.GX28207@linux.ibm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560123496; bh=72IEs0DHzEuTu55M1eCjES2KjxauXBeKyWIRnt96fUI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=auzI147HBlJ6kyoY515g3f/wnTWZF+3yEU5fvFLUQEXGfjs3jZjngXm7K0zD8yAF9
         AEBfY9hsJT80pap8JAUnKAFZAT+6e3wKa7RUDH++7DDwFGqJJyMLCjccLjIqc3gNon
         1Sf7J9C3B5EzEqFXzgyO3nV1gTUxSXhS89hXbaYc13toa8ZxCxlLTCwjpwOsnhlmO2
         zv7sGHE1r7OK3Q+X/RVi5fmY+nHnxb+JaZrzRQOJxz02ABxMb/xqwMk53056fwPllV
         Z/clItiKpt6C9cE7QsHnz/v1xiNV/kSrpNEhycot1BzsDY7pmZQgN5RyFY5a0xeyYj
         pzMfKkElDWqsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/19 6:51 AM, Paul E. McKenney wrote:
> On Tue, May 21, 2019 at 12:08:08AM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Commit 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside
>> CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING") moved the only usage of
>> print_lock_trace() that was originally outside of the CONFIG_PROVE_LOCKI=
NG
>> case. It moved that usage into a different case: CONFIG_PROVE_LOCKING &&
>> CONFIG_TRACE_IRQFLAGS. That leaves things not symmetrical, and as a resu=
lt,
>> the following warning fires on my build, when I have
>>
>> !CONFIG_TRACE_IRQFLAGS && !CONFIG_PROVE_LOCKING
>>
>> set:
>>
>> kernel/locking/lockdep.c:2821:13: warning: =E2=80=98print_lock_trace=E2=
=80=99 defined
>>     but not used [-Wunused-function]
>>
>> Fix this by only defining print_lock_trace() in cases in which is it
>> called.
>>
>> Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_=
TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  kernel/locking/lockdep.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index d06190fa5082..3065dc36c27a 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -2817,11 +2817,14 @@ static inline int validate_chain(struct task_str=
uct *curr,
>>  	return 1;
>>  }
>>
>> +#if defined(CONFIG_TRACE_IRQFLAGS)
>>  static void print_lock_trace(struct lock_trace *trace, unsigned int spa=
ces)
>=20
> This works, but another approach is to put "__maybe_unused" in the
> above declaration, which avoids the need to have "#if" in a .c file.


Good idea, that approach appeals to me here, because tracing is a natural f=
it
for "might not be used" types of functions.


> But this file already has quite a few #if and #ifdef commands, so maybe
> it is OK here.
>=20
> Also, "#ifdef CONFIG_TRACE_IRQFLAGS" is a bit more conventional than
> the above, should the "__maybe_unused" be undesirable.

ah, OK, I'll keep that in mind. (The two seemed identical to my mind, but
it's good to make things look like surrounding code, of course.)

thanks,
--=20
John Hubbard
NVIDIA


>=20
> Yet another approach is to move this function to include/linux/lockdep.h,
> where #ifdef is considered less objectionable.
>=20
> But I must defer to the maintainers.
>=20
> 							Thanx, Paul
