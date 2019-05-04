Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C573C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D09206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0DT9XTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEDG7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:59:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38958 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfEDG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:59:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so4026290pfg.6;
        Fri, 03 May 2019 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=3K8a0f7BsoE8M2AEpn5p2m8ygPynpnFY5zG8ECmybB8=;
        b=l0DT9XTwf5JH4rJk0BiBZN2AwxyjUlChkv7PkEE2Q0h7GA1wrQCSUbCTUgbGFkf+oA
         PZg9OkehQnlfNuQ50GYvwtzaNoIczW4NQhzbDbJM8khFMoqNwC1bQsOq56YHcr+sCgs3
         8ggOfeS581bTlsdsE4TyBmH+QSxPmlYGsTiEkAL53q4YssbHjiIY3Brg7meeufCEPr+Y
         aCNF8ga07MkbLlBYHThj9MDYhCvi5uTcx8wrumU+EvdjzVnZh6be+gXU7oqRFw3Q9LgJ
         8r5gTdaJ+bq351KbBfivw+7t1+SLjrOjUz3QhO0acWpRcKOH5hrpKkn07AhKD5qkmstj
         QcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=3K8a0f7BsoE8M2AEpn5p2m8ygPynpnFY5zG8ECmybB8=;
        b=BNLZpZMAXhpIdjx52DSGz1bepGbeWN1mbyxqRHonE6tEGu8T9xDIWO/+V7+Cucyp7P
         Y8irnB+CmRAwz2ynisS2bT8TYoZEVetqBCj19pOoogldQG3x8ElaRTLjsv7K77ZAdAgg
         8MRD2gzXH6BwAz9z8ePe0Uz7Mpfcg6SRgu8QtWDFpfNhFDgugQPd/Tc72TRJO1cZ4jIK
         oUD1DGOh7lagVaVR5GcBldpAkbAq3L1n17r4GOLOjLuA6oNRbtPU7OHxpQQ2Re+HXqkA
         xp3JxtLSzl+t1scgrMUD52aTNKTjqmFLmAt6FVQpQ9OBUt1CIe8HcMMTHUlBuL2TwMbE
         zHuQ==
X-Gm-Message-State: APjAAAVqowNWEWT3+YYj+/bHKMFS1uoz/lbzI/TFzuLr9165dI/5/5El
        Z6ffLZtzm2GOvLvT2n6g3ws=
X-Google-Smtp-Source: APXvYqyKJwpsJ7adcXwhdF7JCRwAhEYIBwbqJ9RsPj7RGf3o+NtlTxekCbMiQfZrDISVWv7CypJ1aQ==
X-Received: by 2002:a62:1990:: with SMTP id 138mr16881240pfz.98.1556953160657;
        Fri, 03 May 2019 23:59:20 -0700 (PDT)
Received: from localhost (193-116-98-44.tpgi.com.au. [193.116.98.44])
        by smtp.gmail.com with ESMTPSA id q80sm9913053pfa.66.2019.05.03.23.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 23:59:19 -0700 (PDT)
Date:   Sat, 04 May 2019 16:59:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [tip:sched/core] sched/isolation: Require a present CPU in
 housekeeping mask
To:     Frederic Weisbecker <frederic@kernel.org>, fweisbec@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Cc:     linux-tip-commits@vger.kernel.org
References: <20190411033448.20842-5-npiggin@gmail.com>
        <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
        <20190504002733.GB19076@lenoir>
In-Reply-To: <20190504002733.GB19076@lenoir>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556952021.2xpa7joi2y.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker's on May 4, 2019 10:27 am:
> On Fri, May 03, 2019 at 10:47:37AM -0700, tip-bot for Nicholas Piggin wro=
te:
>> Commit-ID:  9219565aa89033a9cfdae788c1940473a1253d6c
>> Gitweb:     https://git.kernel.org/tip/9219565aa89033a9cfdae788c1940473a=
1253d6c
>> Author:     Nicholas Piggin <npiggin@gmail.com>
>> AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
>> Committer:  Ingo Molnar <mingo@kernel.org>
>> CommitDate: Fri, 3 May 2019 19:42:58 +0200
>>=20
>> sched/isolation: Require a present CPU in housekeeping mask
>>=20
>> During housekeeping mask setup, currently a possible CPU is required.
>> That does not guarantee the CPU would be available at boot time, so
>> check to ensure that at least one present CPU is in the mask.
>=20
> I have a doubt about the requirements and semantics of cpu_present_mask.
> IIUC a present CPU means that it is physically plugged in (from ACPI
> perspective) but might not be logically plugged in (set on cpu_online_mas=
k).

Right, a superset of cpu_possible_mask, subset of cpu_online_mask. It=20
means that CPU can be brought online at any time.

> But do we have the guarantee that a present CPU _will_ be online at least=
 once
> right after the boot? After all, kernel parameters such as "maxcpus=3D" c=
an prevent
> from turning some CPUs on. I guess there are even more creative ways to a=
chieve
> that.
>=20
> In any case we really require the housekeeper to be forced online. Perhap=
s
> I missed that enforcement somewhere in the patchset?

No I think you're right, that may be able to boot without anything in
the housekeeping mask. Maybe we can just cpu_up() a CPU in the=20
housekeeping mask with a warning that it has overidden their SMP
command line option. I'll take a look at it.

Thanks,
Nick

=
