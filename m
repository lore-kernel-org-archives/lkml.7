Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7832083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMlJb/w/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDLDXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:23:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39943 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLDXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:23:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so4424725pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 20:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=8aEILMZ75lgTGmzjl2UIwSn0xboviUpKBzB7LC8bgrM=;
        b=iMlJb/w/AJQ9Sjrywb8YyZ1nedXbOuU6Znx0IuFDrgO7oGFh0cn5vphATqlLJ0nsHZ
         h1hHDdg4Nmjg8yru3INzZbUpbgB8m+n21Iv4/eQKWD2GWIW/oOmJxZGdzPz/MsKks3Es
         FJfgc/WrJP8njgGQ0+/ccxF9QRtcHQxrbekwsC2l+JD3T8n59rUTCtgbG45UWbUpjkj1
         RPv/fDF39S/taqFlVkLE3TUL8pxoTDKeu2Q3Zq/vlThcmNDn9B2ix/8LKEB9L8YWvlp6
         GrOtF6Zc+tvuSO1Mnb/sN37SpvjRdtClrlsHf4vn+BBS4QXqntCArh5k0laAIWQD7O/D
         mjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=8aEILMZ75lgTGmzjl2UIwSn0xboviUpKBzB7LC8bgrM=;
        b=ZTUjbGJw/MCGBgfMX44ZKdD7eiaxW9+Yebp6/umTfxwqDS6OBUz5AUcuUBzx/+7/DS
         tM/5QcHFJylQSXprvG/5FEz2EdpcBj1vsFL6WYP4kW9hX0CpByMe5FD0r1Als1jSaq3k
         x+HQPcZuGeMy1TgfsWo9gJvWvc30LUKKB8787YkV0Lhdygp+/XtnvrbO+lgEkHZNWU6Y
         ZM6c1NSWyxSGzJzlW1GduhV7LzqhQK7nHw4H8RXzrNcrCsfiGtD7kiMjyoA2jlJT27F/
         98n9O1fgyBVmwP5UFkgAktVA6yppW9U+mTgpLFNriTfYQrwCrT7nOBv3tzqS4smaX+Tl
         55OA==
X-Gm-Message-State: APjAAAXxi2eA4vkoUG3oD+dL0drYnHWpXx18LDAoSt9wTxdoQPo7FK3P
        zPl/f8rBoVeKjjwuuly1TPg=
X-Google-Smtp-Source: APXvYqxsGhFr9EI0E2kznx8R8QT/Z628F2+shH0cl+elkMLdDs/FpDmflfMZBly+lNmqhjDqYbu4fw==
X-Received: by 2002:a65:524a:: with SMTP id q10mr49070326pgp.224.1555039425292;
        Thu, 11 Apr 2019 20:23:45 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
        by smtp.gmail.com with ESMTPSA id v188sm64490310pgb.7.2019.04.11.20.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 20:23:44 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:23:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: your mail
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190411060536.22409-1-npiggin@gmail.com>
        <20190411105336.GK4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190411105336.GK4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555039052.5o9b9e6rcr.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra's on April 11, 2019 8:53 pm:
> Was this supposed to be patch 6/5 of your previous series?

Dang, I screwed up the headers? Thanks for the ping, I will resend.

It is standalone. It seems more suited to the scheduler tree than the
timers one, but your call.

It is generally of more use when CPU0 is _not_ a housekeeping one,
and that's where I've done most testing, but I don't see any hard
dependency.

Thanks,
Nick

>=20
> On Thu, Apr 11, 2019 at 04:05:36PM +1000, Nicholas Piggin wrote:
>> Date: Tue, 9 Apr 2019 20:23:16 +1000
>> Subject: [PATCH] kernel/sched: run nohz idle load balancer on HK_FLAG_MI=
SC
>>  CPUs
>>=20
>> The nohz idle balancer runs on the lowest idle CPU. This can
>> interfere with isolated CPUs, so confine it to HK_FLAG_MISC
>> housekeeping CPUs.
>>=20
>> HK_FLAG_SCHED is not used for this because it is not set anywhere
>> at the moment. This could be folded into HK_FLAG_SCHED once that
>> option is fixed.
>>=20
>> The problem was observed with increased jitter on an application
>> running on CPU0, caused by nohz idle load balancing being run on
>> CPU1 (an SMT sibling).
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  kernel/sched/fair.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fdab7eb6f351..d29ca323214d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9522,22 +9522,26 @@ static inline int on_null_domain(struct rq *rq)
>>   * - When one of the busy CPUs notice that there may be an idle rebalan=
cing
>>   *   needed, they will kick the idle load balancer, which then does idl=
e
>>   *   load balancing for all the idle CPUs.
>> + * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED no=
t set
>> + *   anywhere yet.
>>   */
>> =20
>>  static inline int find_new_ilb(void)
>>  {
>> -	int ilb =3D cpumask_first(nohz.idle_cpus_mask);
>> +	int ilb;
>> =20
>> -	if (ilb < nr_cpu_ids && idle_cpu(ilb))
>> -		return ilb;
>> +	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
>> +			      housekeeping_cpumask(HK_FLAG_MISC)) {
>> +		if (idle_cpu(ilb))
>> +			return ilb;
>> +	}
>> =20
>>  	return nr_cpu_ids;
>>  }
>> =20
>>  /*
>> - * Kick a CPU to do the nohz balancing, if it is time for it. We pick t=
he
>> - * nohz_load_balancer CPU (if there is one) otherwise fallback to any i=
dle
>> - * CPU (if there is one).
>> + * Kick a CPU to do the nohz balancing, if it is time for it. We pick a=
ny
>> + * idle CPU in the HK_FLAG_MISC housekeeping set (if there is one).
>>   */
>>  static void kick_ilb(unsigned int flags)
>>  {
>> --=20
>> 2.20.1
>>=20
>=20
=
