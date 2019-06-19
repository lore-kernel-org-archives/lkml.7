Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03825C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C892621479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaHRBZYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfFSKrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:47:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:47:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so9456673pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=200XxydEFi55bUNsx9pcWTaDk7SFbRW+2sQbTbQJgsM=;
        b=aaHRBZYWPczbQFqJe9JJFA0dlLlJzzBJC/oTJXqGKCNuMLuBOY+dTvIh9dbUV+V+z1
         M/S9iuWU9FuhO/8Lgi6ik9IeD4gD9wfBvILBynTUQBfUQqb810rGAg7Bmy1wY688mP7+
         7r+hqoXD403MfWK6HCdotz2jLosUibL/qmzWQwAzx7fQ+D8noSJRamt/6HjG2MpPximC
         PQcbcuLZ1v1c5lqOpuBGkAOgGjG4OY+Ulj5cLZ+QfyiZY/fv0AkL3k2SEKxDFHkAFCXx
         nmlFw9MABm5Z4uKJNy4JGtlZdpjiixAU9s/oCG13IzJo7pN8wv3jcDuuuf+E1Vt25rrg
         ibXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=200XxydEFi55bUNsx9pcWTaDk7SFbRW+2sQbTbQJgsM=;
        b=UhlrlQSO1gqAl1JOM+cmBm+DPgh+UkGq2HI5i950oUKju38fsPn3/ImfIso9d5Kndp
         4+Gca1LsI+D3J26Gicq4O+zNCmNLFvmwe4wavNJ8d1c9yPUXpEuxsKdsWF1MMhYQa6IC
         wQc7QxPI+lVUiqmM4CsyIDAyZ4puFSemqBt9nSQobuWm0czXU9vToIXweYXKuj5M62Qw
         CuY0fKd7bt4DccopovfSHnGbNENv/A9yHrFF9xp0bpQ2mZmE+nj5EhLYBfVT6fjkPgoz
         HTjTvsGlDJgSr/4fqLtX5MhwncX/Y0SyMgIaeQiTj14E1/+O2H6HvJTYq+SNTpUtjla7
         SnRA==
X-Gm-Message-State: APjAAAUvu+hY4NiuaoXalI7KBwAJ/1lqayxyw7NSFGakXW4JyiNMN0NV
        bRdIWZjy8bkq1BaKeQDC3WY=
X-Google-Smtp-Source: APXvYqyUoVCDTnkdi8S5XBhHAWD7lToyn4p07rWUBoIE9b24JPYzcTPmfroVgY3GX4XQa3wGy24piA==
X-Received: by 2002:aa7:9786:: with SMTP id o6mr38027796pfp.222.1560941219859;
        Wed, 19 Jun 2019 03:46:59 -0700 (PDT)
Received: from localhost (193-116-72-140.tpgi.com.au. [193.116.72.140])
        by smtp.gmail.com with ESMTPSA id v10sm14141318pfe.163.2019.06.19.03.46.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:46:59 -0700 (PDT)
Date:   Wed, 19 Jun 2019 20:41:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <72492bc769cd6f40a536e689fc3195570d07fd5c.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <877e9idum7.fsf@concordia.ellerman.id.au>
        <1560927184.kqsg9x9bd1.astroid@bobo.none>
        <1560935530.70niyxru6o.naveen@linux.ibm.com>
In-Reply-To: <1560935530.70niyxru6o.naveen@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560939496.ovo51ph4i4.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao's on June 19, 2019 7:53 pm:
> Nicholas Piggin wrote:
>> Michael Ellerman's on June 19, 2019 3:14 pm:
>>> Hi Naveen,
>>>=20
>>> Sorry I meant to reply to this earlier .. :/
>=20
> No problem. Thanks for the questions.
>=20
>>>=20
>>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>>> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' t=
o
>>>> enable function tracing and profiling. So far, with dynamic ftrace, we
>>>> used to only patch out the branch to _mcount(). However, mflr is
>>>> executed by the branch unit that can only execute one per cycle on
>>>> POWER9 and shared with branches, so it would be nice to avoid it where
>>>> possible.
>>>>
>>>> We cannot simply nop out the mflr either. When enabling function
>>>> tracing, there can be a race if tracing is enabled when some thread wa=
s
>>>> interrupted after executing a nop'ed out mflr. In this case, the threa=
d
>>>> would execute the now-patched-in branch to _mcount() without having
>>>> executed the preceding mflr.
>>>>
>>>> To solve this, we now enable function tracing in 2 steps: patch in the
>>>> mflr instruction, use synchronize_rcu_tasks() to ensure all existing
>>>> threads make progress, and then patch in the branch to _mcount(). We
>>>> override ftrace_replace_code() with a powerpc64 variant for this
>>>> purpose.
>>>=20
>>> According to the ISA we're not allowed to patch mflr at runtime. See th=
e
>>> section on "CMODX".
>>=20
>> According to "quasi patch class" engineering note, we can patch
>> anything with a preferred nop. But that's written as an optional
>> facility, which we don't have a feature to test for.
>>=20
>=20
> Hmm... I wonder what the implications are. We've been patching in a=20
> 'trap' for kprobes for a long time now, along with having to patch back=20
> the original instruction (which can be anything), when the probe is=20
> removed.

Will have to check what implementations support "quasi patch class"
instructions. IIRC recent POWER processors are okay. May have to add
a feature test though.

>>>=20
>>> I'm also not convinced the ordering between the two patches is
>>> guaranteed by the ISA, given that there's possibly no isync on the othe=
r
>>> CPU.
>>=20
>> Will they go through a context synchronizing event?
>>=20
>> synchronize_rcu_tasks() should ensure a thread is scheduled away, but
>> I'm not actually sure it guarantees CSI if it's kernel->kernel. Could
>> do a smp_call_function to do the isync on each CPU to be sure.
>=20
> Good point. Per=20
> Documentation/RCU/Design/Requirements/Requirements.html#Tasks RCU:
> "The solution, in the form of Tasks RCU, is to have implicit read-side=20
> critical sections that are delimited by voluntary context switches, that=20
> is, calls to schedule(), cond_resched(), and synchronize_rcu_tasks(). In=20
> addition, transitions to and from userspace execution also delimit=20
> tasks-RCU read-side critical sections."
>=20
> I suppose transitions to/from userspace, as well as calls to schedule()=20
> result in context synchronizing instruction being executed. But, if some=20
> tasks call cond_resched() and synchronize_rcu_tasks(), we probably won't=20
> have a CSI executed.
>=20
> Also:
> "In CONFIG_PREEMPT=3Dn kernels, trampolines cannot be preempted, so these=
=20
> APIs map to call_rcu(), synchronize_rcu(), and rcu_barrier(),=20
> respectively."
>=20
> In this scenario as well, I think we won't have a CSI executed in case=20
> of cond_resched().
>=20
> Should we enhance patch_instruction() to handle that?

Well, not sure. Do we have many post-boot callers of it? Should
they take care of their own synchronization requirements?

Thanks,
Nick
=
