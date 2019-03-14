Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F228421872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="ucszaVr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCNUnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:43:18 -0400
Received: from rfvt.org.uk ([37.187.119.221]:47790 "EHLO rfvt.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfCNUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:43:18 -0400
Received: from wylie.me.uk (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by rfvt.org.uk (Postfix) with ESMTPS id 88787821B4;
        Thu, 14 Mar 2019 20:43:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
        s=mydkim005; t=1552596194;
        bh=g35oWiSy0ASjdKSbPMVHDIlErezG7wtjhQ7ua/oM4V8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=ucszaVr4XHSwVLZIAhJl886HrdDRovn/dQ0z6ooGvZ3KG/KNheK2rXErIuDtMVLO5
         LDLLtGZG2nvgQcqqu9k2V92mwr9KEsN6L/e262cFZfetI63yHToGMHfHbx5Zx9UGvl
         5Gkc2CWgzMvc8vHOX0yrj3jb8Qze9ShV6n8juY6k9cwWzv80XNAygBaTZl3HHCLCc6
         zgsH49tmSq8VSUkr0jJkhzLV1HQ0iLWX491SrE+6fDiybIKsnTLjJ3V4qN6y7mepe8
         8wnrJzsIsleY4KGhemfMzqrBHncYAdcZcazyNO2VPPbpTR83HSO/239VY4z5Y2YypN
         5otANCbJWnthQ==
From:   alan@wylie.me.uk (Alan J. Wylie)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alec Ari <neotheuser@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression] Re: Linux 5.0.2
References: <20190314162756.GA20704@kroah.com> <87pnqtkz23.fsf@wylie.me.uk>
        <20190314200709.GA16125@kroah.com>
Date:   Thu, 14 Mar 2019 20:43:14 +0000
In-Reply-To: <20190314200709.GA16125@kroah.com> (Greg KH's message of "Thu, 14
        Mar 2019 13:07:09 -0700")
Message-ID: <87ftrpkx0d.fsf@wylie.me.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(Adding Linus, since his tree is also broken)

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Mar 14, 2019 at 07:59:00PM +0000, Alan J. Wylie wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>>=20
>> > I'm announcing the release of the 5.0.2 kernel.
>>=20
>> There is a regression for AMD-only builds.
>
> Adding the stable list, which people should do...
>
>>=20
>> See also Alec Ari's report:
>> https://lkml.org/lkml/2019/3/13/1113
>>=20
>> > If CONFIG_CPU_SUP_INTEL is disabled with either the 5.0.2 or 4.20.16
>> > kernel, it errors out right away:
>>=20
>> $ grep "CONFIG_CPU_SUP_" .config
>> # CONFIG_CPU_SUP_INTEL is not set
>> CONFIG_CPU_SUP_AMD=3Dy
>> # CONFIG_CPU_SUP_HYGON is not set
>> # CONFIG_CPU_SUP_CENTAUR is not set
>>=20
>> CC      arch/x86/events/core.o
>> In file included from arch/x86/events/core.c:44:
>> arch/x86/events/perf_event.h:1035:45: warning: =E2=80=98struct cpu_hw_ev=
ent=E2=80=99 declared inside parameter list will not be visible outside of =
this definition or declaration
>>  static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
>>                                              ^~~~~~~~~~~~
>> arch/x86/events/perf_event.h:1040:45: warning: =E2=80=98struct cpu_hw_ev=
ent=E2=80=99 declared inside parameter list will not be visible outside of =
this definition or declaration
>>  static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
>>                                              ^~~~~~~~~~~~
>> arch/x86/events/core.c: In function =E2=80=98free_fake_cpuc=E2=80=99:
>> arch/x86/events/core.c:1998:20: error: passing argument 1 of =E2=80=98in=
tel_cpuc_finish=E2=80=99 from incompatible pointer type [-Werror=3Dincompat=
ible-pointer-types]
>>   intel_cpuc_finish(cpuc);
>>                     ^~~~
>> In file included from arch/x86/events/core.c:44:
>> arch/x86/events/perf_event.h:1040:59: note: expected =E2=80=98struct cpu=
_hw_event *=E2=80=99 but argument is of type =E2=80=98struct cpu_hw_events =
*=E2=80=99
>>  static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
>>                                       ~~~~~~~~~~~~~~~~~~~~~^~~~



>> arch/x86/events/core.c: In function =E2=80=98allocate_fake_cpuc=E2=80=99:
>> arch/x86/events/core.c:2012:25: error: passing argument 1 of
>> =E2=80=98intel_cpuc_prepare=E2=80=99 from incompatible pointer type
>> [-Werror=3Dincompatible-pointer-types] if (intel_cpuc_prepare(cpuc,
>> cpu)) ^~~~ In file included from arch/x86/events/core.c:44:
>> arch/x86/events/perf_event.h:1035:59: note: expected =E2=80=98struct
>> cpu_hw_event *=E2=80=99 but argument is of type =E2=80=98struct cpu_hw_e=
vents *=E2=80=99
>> static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int
>> cpu) ~~~~~~~~~~~~~~~~~~~~~^~~~ cc1: some warnings being treated as
>> errors
>
> Is this a regression?

5.0.1 was fine, git pulled, then "make oldconfig" just answering the defaul=
t "N"s

> If so, what commit caused this?

It looks as if it's

commit 3ad8e57560d7652a66da12b41c668a593509f3ad
Author: Peter Zijlstra (Intel) <peterz@infradead.org>
Date:   Tue Mar 5 22:23:15 2019 +0100

    perf/x86/intel: Make cpuc allocations consistent

    The cpuc data structure allocation is different between fake and
    real cpuc's; use the same code to init/free both.

which is the commit which introduces the function:

+static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)

> Is this also an issue in Linus's tree right now?

Yes, as of 3b319ee220a8795406852a897299dbdfc1b09911

  CC      arch/x86/entry/common.o
arch/x86/events/core.c: In function =E2=80=98free_fake_cpuc=E2=80=99:
arch/x86/events/core.c:1998:20: error: passing argument 1 of =E2=80=98intel=
_cpuc_finish=E2=80=99 from incompatible pointer type [-Werror=3Dincompatibl=
e-pointer-types]
  intel_cpuc_finish(cpuc);
                    ^~~~
Thanks
Alan

--=20
Alan J. Wylie                                          https://www.wylie.me=
.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
