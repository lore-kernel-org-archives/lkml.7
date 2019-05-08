Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FBEC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5EC204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZozwdce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEHBi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:38:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42470 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEHBi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:38:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so9061363pln.9;
        Tue, 07 May 2019 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=+pgQLypyY2Fj2S5dVJnqSt5dqi0gQft1+N33h98eRBw=;
        b=KZozwdcebhBe8qErPUIBActm1dRPR7vJ9wGcKKrfkTm+dNPx5zmipJIKSFY/jy5Zl5
         saSqmk8h1O7lJh1RdP32+3M/daq6vt0aExqBu7JVMsCvtyoKYGA/nMG4mu6y6sfoK1qA
         B3a8E4wCrR1JpxZKdp26Pb+HNZ2gAEOiDYUX9CjDJVTTmaZt++u+rmGoKgGHqjkBlg8X
         dTqRf5LeahXmPKB8kb5QYLqgA//JYm/JxIC4WUnww7c6jIwNhkbAHsr7Bzql+DpO3WKM
         lp+yHHYMDnz4u2sNQI66a8xTrhvDDTY521XDCFe9qBI99z0+aJ8bt9QVV53fO8oWKxEp
         R0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=+pgQLypyY2Fj2S5dVJnqSt5dqi0gQft1+N33h98eRBw=;
        b=fsxcguZZTP0KP9kaNSBVrDc8qIKcbYlDCoHzSRknLBu0Vf7vEnTlU9HoC1l8K1/D+e
         5zm0aJCrYQBwbtTkm8nikuQCPQWKyU915PLGBVdMFahiw9AGw7hnQQ2zGzjErTCIc1Zg
         qQJDriv8f9Od3/yXJnC2SfB83sJEVFiYO1hSDt54kNr+zE3I8R1bx9nn9GN20WcSYi64
         uZ40xSbztZS1b8Dt9JqiwgKx3vBoxhFwKkA99pIy/iGQT5/6GZ4VAFbdBNiFe35vJQLr
         U2814YcaJgzXjP4EF50pXDS1g3LNaclgtQ5oZ4Yv1enRFYiJgtawLzKLA1dtt0NTW7NN
         86Pw==
X-Gm-Message-State: APjAAAV1/b4mAnkhqvspUkDtWpaqxRrDw9ZV+9DNF8Kmq92rTRULiwvy
        YSGtvTMGg6N7IsrvUKShilk=
X-Google-Smtp-Source: APXvYqyVmi92X1RVuwvJNIiD6zN6JseBToIkWtzou/aEJSMt4X9iuenstQsSzHGfz4EDdZ6cPRc2rg==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr43581347plb.219.1557279505814;
        Tue, 07 May 2019 18:38:25 -0700 (PDT)
Received: from localhost ([203.63.161.72])
        by smtp.gmail.com with ESMTPSA id v1sm20766595pff.81.2019.05.07.18.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 18:38:24 -0700 (PDT)
Date:   Wed, 08 May 2019 11:38:18 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [tip:sched/core] sched/isolation: Require a present CPU in
 housekeeping mask
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
References: <20190411033448.20842-5-npiggin@gmail.com>
        <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
        <20190504002733.GB19076@lenoir> <1556952021.2xpa7joi2y.astroid@bobo.none>
        <20190506151615.GA14529@lenoir> <1557186148.ocs72ssdjc.astroid@bobo.none>
        <20190508003458.GA21658@lenoir>
In-Reply-To: <20190508003458.GA21658@lenoir>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1557279164.6speg3hhsy.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker's on May 8, 2019 10:35 am:
> On Tue, May 07, 2019 at 09:50:24AM +1000, Nicholas Piggin wrote:
>> Frederic Weisbecker's on May 7, 2019 1:16 am:
>> > On Sat, May 04, 2019 at 04:59:12PM +1000, Nicholas Piggin wrote:
>> >> Frederic Weisbecker's on May 4, 2019 10:27 am:
>> >> > On Fri, May 03, 2019 at 10:47:37AM -0700, tip-bot for Nicholas Pigg=
in wrote:
>> >> >> Commit-ID:  9219565aa89033a9cfdae788c1940473a1253d6c
>> >> >> Gitweb:     https://git.kernel.org/tip/9219565aa89033a9cfdae788c19=
40473a1253d6c
>> >> >> Author:     Nicholas Piggin <npiggin@gmail.com>
>> >> >> AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
>> >> >> Committer:  Ingo Molnar <mingo@kernel.org>
>> >> >> CommitDate: Fri, 3 May 2019 19:42:58 +0200
>> >> >>=20
>> >> >> sched/isolation: Require a present CPU in housekeeping mask
>> >> >>=20
>> >> >> During housekeeping mask setup, currently a possible CPU is requir=
ed.
>> >> >> That does not guarantee the CPU would be available at boot time, s=
o
>> >> >> check to ensure that at least one present CPU is in the mask.
>> >> >=20
>> >> > I have a doubt about the requirements and semantics of cpu_present_=
mask.
>> >> > IIUC a present CPU means that it is physically plugged in (from ACP=
I
>> >> > perspective) but might not be logically plugged in (set on cpu_onli=
ne_mask).
>> >>=20
>> >> Right, a superset of cpu_possible_mask, subset of cpu_online_mask. It=
=20
>> >> means that CPU can be brought online at any time.
>> >>=20
>> >> > But do we have the guarantee that a present CPU _will_ be online at=
 least once
>> >> > right after the boot? After all, kernel parameters such as "maxcpus=
=3D" can prevent
>> >> > from turning some CPUs on. I guess there are even more creative way=
s to achieve
>> >> > that.
>> >> >=20
>> >> > In any case we really require the housekeeper to be forced online. =
Perhaps
>> >> > I missed that enforcement somewhere in the patchset?
>> >>=20
>> >> No I think you're right, that may be able to boot without anything in
>> >> the housekeeping mask. Maybe we can just cpu_up() a CPU in the=20
>> >> housekeeping mask with a warning that it has overidden their SMP
>> >> command line option. I'll take a look at it.
>> >=20
>> > But then what if cpu_up() fails? In this case I can think of only two
>> > answers:
>> >=20
>> > * Force the boot CPU as the housekeeper.
>> > * Rollback the whole thing: nohz and all isolation.
>>=20
>> If cpu_up fails despite being in the present map and we explicitly
>> selected it as the housekeeper? I think it would be okay to print
>> a message telling admin to correct the config, and panic.
>>=20
>> We try a best effort to make the system boot and limp along, but if
>> you misconfigure it, crashing is not unreasonable. There's lots of
>> command line option misconfiguration that will cause the same thing.
>>=20
>> The primary problem with my patch that needs to be addressed is that
>> the error is not explicitly caught and printed if the housekeeper
>> does not come up, so the system might die in non-obvious ways.
>=20
> I usually reserve panic and BUG_ON() to last resort when data integrity i=
s
> directly threatened. But indeed I guess that's all we have for now.

Right, specifying a CPU for housekeeping that excluded from coming
up at boot with maxcpus=3D or whatever, is not such a big deal to
panic I think. Just need to have a clear error message.

> If we take that path, I'd rather not call that cpu_up() and simply panic =
if
> the given CPU happens not to be online after SMP bootup.

Sure that's fine by me too.

Thanks,
Nick

=
