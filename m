Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F8CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAC9206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyy8Cwb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEFXud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:50:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44787 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFXuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:50:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so7248725pgv.11;
        Mon, 06 May 2019 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=e1BH/13SfZ3XaTKw+rGmuIvZM7E0chy4OEUBJjQkVh8=;
        b=iyy8Cwb4tUyXOPBZZ7vKSInyJ69btlQW1E4XeTw5U1q2Ce9HLHYwmDAplXSYp225HK
         029WfgJX6vRfVdONCUTcveff+4IoZGtol/wThCLXWa1p3cP3TLiLR9SZIldzRJ1Wtsgj
         EYAgJfU7YSrqw9RMRmdJv0sINk9g+kOhi5MNBYtI5i4447BoxTpGHd20kXy70J9Cvsz8
         wEzOFSv23qFy+BmWyChYmoN1PosP0Vt97V8LKygscl7XL7enmsE7MpxNtoLqzNSwIp2L
         mk1rtfRAeTAONgnvQiVN20hwRlm4QAGeKjVYJu4lGTavcEP0IKRB4ookcM7m2dHrguZ8
         noSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=e1BH/13SfZ3XaTKw+rGmuIvZM7E0chy4OEUBJjQkVh8=;
        b=LxkdV5IPsHZ5GcHaQ+3htVxTg9CbOHRXWEiB+3w3DHefbiY5Rp6dfEmlsqrp/RdyZN
         sqbkKDjukcYOOZrWenrLtfoJ/UcseoPmS0v6V7crhop0C6ULTscaJH28ilyo0CHtYZn/
         xCEl+XOXrOnTkECnjXOsim0Uc9bLToYhL9z681mC2QDO5Nvn8+GwNh8ytWXdDbNCuxjr
         eknCcPIl8F0ym62D5xcmD7ZhDELpkYfCJmOWmHEEAQIuodQBnhO3AsjVGYQ3GFHg42Vt
         GNy1eXuKOlp+7wShCJ+F7w4EXDN4AhJ26lmqS4Cajuq5ggXKbypugCBXLZU0T6mo2Zcj
         e3Yg==
X-Gm-Message-State: APjAAAWmpM7LS7WE/1o1jmDZyQx28kMzFe80uR/t54aJYP4Qt+wcw9TK
        K95my20vyRI7QEHDpS4BTEg=
X-Google-Smtp-Source: APXvYqzS7UG3lbx7Dlz4TGjj9fWBy1CPaNYzoREyX0fqJR3dCZKaqUGdJz3+MMWnhVaIyXpczhl47A==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr4766738pfn.213.1557186631397;
        Mon, 06 May 2019 16:50:31 -0700 (PDT)
Received: from localhost ([203.63.161.72])
        by smtp.gmail.com with ESMTPSA id e8sm20817127pfc.47.2019.05.06.16.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 16:50:30 -0700 (PDT)
Date:   Tue, 07 May 2019 09:50:24 +1000
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
        <20190506151615.GA14529@lenoir>
In-Reply-To: <20190506151615.GA14529@lenoir>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1557186148.ocs72ssdjc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker's on May 7, 2019 1:16 am:
> On Sat, May 04, 2019 at 04:59:12PM +1000, Nicholas Piggin wrote:
>> Frederic Weisbecker's on May 4, 2019 10:27 am:
>> > On Fri, May 03, 2019 at 10:47:37AM -0700, tip-bot for Nicholas Piggin =
wrote:
>> >> Commit-ID:  9219565aa89033a9cfdae788c1940473a1253d6c
>> >> Gitweb:     https://git.kernel.org/tip/9219565aa89033a9cfdae788c19404=
73a1253d6c
>> >> Author:     Nicholas Piggin <npiggin@gmail.com>
>> >> AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
>> >> Committer:  Ingo Molnar <mingo@kernel.org>
>> >> CommitDate: Fri, 3 May 2019 19:42:58 +0200
>> >>=20
>> >> sched/isolation: Require a present CPU in housekeeping mask
>> >>=20
>> >> During housekeeping mask setup, currently a possible CPU is required.
>> >> That does not guarantee the CPU would be available at boot time, so
>> >> check to ensure that at least one present CPU is in the mask.
>> >=20
>> > I have a doubt about the requirements and semantics of cpu_present_mas=
k.
>> > IIUC a present CPU means that it is physically plugged in (from ACPI
>> > perspective) but might not be logically plugged in (set on cpu_online_=
mask).
>>=20
>> Right, a superset of cpu_possible_mask, subset of cpu_online_mask. It=20
>> means that CPU can be brought online at any time.
>>=20
>> > But do we have the guarantee that a present CPU _will_ be online at le=
ast once
>> > right after the boot? After all, kernel parameters such as "maxcpus=3D=
" can prevent
>> > from turning some CPUs on. I guess there are even more creative ways t=
o achieve
>> > that.
>> >=20
>> > In any case we really require the housekeeper to be forced online. Per=
haps
>> > I missed that enforcement somewhere in the patchset?
>>=20
>> No I think you're right, that may be able to boot without anything in
>> the housekeeping mask. Maybe we can just cpu_up() a CPU in the=20
>> housekeeping mask with a warning that it has overidden their SMP
>> command line option. I'll take a look at it.
>=20
> But then what if cpu_up() fails? In this case I can think of only two
> answers:
>=20
> * Force the boot CPU as the housekeeper.
> * Rollback the whole thing: nohz and all isolation.

If cpu_up fails despite being in the present map and we explicitly
selected it as the housekeeper? I think it would be okay to print
a message telling admin to correct the config, and panic.

We try a best effort to make the system boot and limp along, but if
you misconfigure it, crashing is not unreasonable. There's lots of
command line option misconfiguration that will cause the same thing.

The primary problem with my patch that needs to be addressed is that
the error is not explicitly caught and printed if the housekeeper
does not come up, so the system might die in non-obvious ways.

>=20
> The second solution looks sane to me. After all if the user doesn't
> include CPU 0 in the housekeeping set, forcing it isn't going to
> help much.
>=20
> But that means we must enhance the isolation code (nohz included)
> to be able to dynamically add/del CPUs to the houseeeping/isolation
> set. That's not going to be easy but it's a necessary evolution
> of that subsystem since we want to drive it through cpusets.
>=20
> I should start working on that.

I considered that when looking at the series, but couldn't justify
the complexity based on my usage (which is static boot time).

If you have other uses for it, then that would solve all these boot
time issues as well, which will be nice.

Thanks,
Nick

=
