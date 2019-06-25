Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E110C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D81D206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfbeQGEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfFYAGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:06:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36535 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFYAGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:06:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so7962865pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=A4JLijstsEbt7bgpP/rJB5rz/anEJk4GklqKMuLHmb0=;
        b=nfbeQGEAwO/zvJ7FHUqD9VPIfa6MAWAjJDAGWOJbcW0kmMqHSjGX2XcRSDKkyH2o6l
         SQuXFZ7uKRTbRdg/dsjW+PBqYlSwhTHxsSlNiNiZzqZckb+ArmlDeo4oiNBi4Ws6W2US
         nCGnBZiCyDZbFpyTsF9RI5TL8CtbMsJjQgd0I1ijygHbpuKMjdIriOovmS1J1IxeKnqo
         VsrugoJ7bMEeh8fCeIEkDkGGQu8YvAN/C2mUx29xnSF0ZgIFX+Hp+uvez9H6yKjeKm1F
         CTiB7pigDkfJnCXbVOIPRSBzpo/xQubtSnUpYCcwl1ZzNYU3GENK6wYcVaZigs4bLfIz
         2O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=A4JLijstsEbt7bgpP/rJB5rz/anEJk4GklqKMuLHmb0=;
        b=RBylsdNg/tmCWj0Kjml2J8zcfIpdO4NPPEG/nMUiG4KmPwXdeSC57YnnRqgJNFiz0z
         Zyc4wKQB7CNhR0dKhrinmCjx7bsRzJtCCDxaHJay8Z0K9zrEq3gNWbcFWVrkQ19c0DXO
         6RQxAk3WWz6lOBRmJgXRtUAYJBWlTzmsMuEvCVY2wp8YFnyDBLxH7v+UXV3jBp6k7SYr
         at3CJMtrbgbsuuL6v08L54Id5n5YDKMoY+p3rnaaPwkwTxYHT8LHoCi7QRVk5vtQvFr5
         T2UaHZehz1QUimnHcU9+Bx+lFuEN86pnahFVofwX/us1KQwNJbOtWLZdIQjILbzlHeA5
         IORg==
X-Gm-Message-State: APjAAAViNuId/hXx/cVZjLp4NB96U7ID16ucgmndfgaPA/gBwKnLMaKT
        7Pxl9yHK36eNWqk2VVZLGAsvJmtI
X-Google-Smtp-Source: APXvYqxBMUtPGkWAS3/xbUBTPhyr8K4uWo4WDakaauiIlVvyAkmS4GN9hjPmaLvt+jqyiNETZMUtzQ==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr15746973pgh.174.1561421178893;
        Mon, 24 Jun 2019 17:06:18 -0700 (PDT)
Received: from localhost ([1.129.222.223])
        by smtp.gmail.com with ESMTPSA id g8sm13512963pfi.8.2019.06.24.17.06.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 17:06:17 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:05:17 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up
 at boot time
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190601113919.2678-1-npiggin@gmail.com>
        <20190624105729.3isejrp4455suxaz@e107158-lin.cambridge.arm.com>
In-Reply-To: <20190624105729.3isejrp4455suxaz@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1561420886.o0ruiu47ya.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qais Yousef's on June 24, 2019 8:57 pm:
> On 06/01/19 21:39, Nicholas Piggin wrote:
>> With the change to allow the boot CPU0 to be isolated, it is possible
>> to specify command line options that result in no housekeeping CPU
>> online at boot.
>>=20
>> An 8 CPU system booted with "nohz_full=3D0-6 maxcpus=3D4", for example.
>>=20
>> It is not easily possible at housekeeping init time to know all the
>> various SMP options that will result in an invalid configuration, so
>> this patch adds a sanity check after SMP init, to ensure that a
>> housekeeping CPU has been onlined.
>>=20
>> The panic is undesirable, but it's better than the alternative of an
>> obscure non deterministic failure. The panic will reliably happen
>> when advanced parameters are used incorrectly.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  kernel/sched/isolation.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>=20
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 123ea07a3f3b..7b9e1e0d4ec3 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -63,6 +63,29 @@ void __init housekeeping_init(void)
>>  	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
>>  }
>> =20
>> +static int __init housekeeping_verify_smp(void)
>> +{
>> +	int cpu;
>> +
>> +	/*
>> +	 * Early housekeeping setup is done before CPUs come up, and there are
>> +	 * a range of options scattered around that can restrict which CPUs
>> +	 * come up. It is possible to pass in a combination of housekeeping
>> +	 * and SMP arguments that result in housekeeping assigned to an
>> +	 * offline CPU.
>> +	 *
>> +	 * Check that condition here after SMP comes up, and give a useful
>> +	 * error message rather than an obscure non deterministic crash or
>> +	 * hang later.
>> +	 */
>> +	for_each_online_cpu(cpu) {
>> +		if (cpumask_test_cpu(cpu, housekeeping_mask))
>> +			return 0;
>> +	}
>> +	panic("Housekeeping: nohz_full=3D or isolcpus=3D resulted in no online=
 CPUs for housekeeping.\n");
>=20
> I am hitting this panic when I boot my juno board.
>=20
>=20
> I have CONFIG_CPU_ISOLATION=3Dy but I don't pass nohuz_full nor isolcpus =
in the
> commandline. I think what's going on is that housekeeping_setup() doesn't=
 get
> called and hence housekeeping_mask isn't initialized in my case, causing =
this
> check to fail and trigger the panic.
>=20
> The below seems to 'fix' it though not sure if it's the right way forward=
.
> A revert obviously fixes it too but I doubt we want that :-)

That'll do it. Thanks for the report and investigation.

>=20
>=20
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7b9e1e0d4ec3..a9ca8628c1a2 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -67,6 +67,9 @@ static int __init housekeeping_verify_smp(void)
>  {
>  	int cpu;
> =20
> +	if (!housekeeping_flags)
> +		return 0;
> +
>  	/*
>  	 * Early housekeeping setup is done before CPUs come up, and there are
>  	 * a range of options scattered around that can restrict which CPUs
>=20
>=20
> Cheers
>=20
> --
> Qais Yousef
>=20
>=20
>> +}
>> +core_initcall(housekeeping_verify_smp);
>> +
>>  static int __init housekeeping_setup(char *str, enum hk_flags flags)
>>  {
>>  	cpumask_var_t non_housekeeping_mask;
>> --=20
>> 2.20.1
>>=20
>=20
=
