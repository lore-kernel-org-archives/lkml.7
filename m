Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7667FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D271222CC
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwoSpUbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJDIK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:10:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725826AbfJDIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570176654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuRKb/AKanHFu7IRUH/Aoxnbj0xpkLLpedIZ6GV2V+g=;
        b=RwoSpUbb0SjkMX0AiQ26PvIhiZD4oO2cjXzB8fD0vEnZykAcjXWuh/mav7bZgxi5uXMlcZ
        crxW/jnvSdxAtPBe/B3n6Rq+e69pyyZZBWGKdzlyzeYYoxPsBi5efM5KwksbIgEWVLPWRK
        5TI+8Ien4HT5aBvTKMaAl7LQOs93mqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-QC4x75v_MRC3puYwuCuxVw-1; Fri, 04 Oct 2019 04:10:52 -0400
Received: by mail-wr1-f72.google.com with SMTP id w10so2357404wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 01:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GrUSA1I8ZiHnogeP6HyMR/rUIqRSB2rZw//LXyHfqY4=;
        b=Mh5ETg2Rc/HxXbWMrh+EEFZ7bd7HdnzMTyCFCpYHDF69G82667YqVvGINSv3x7/PMw
         5Ev/GWIc7u9pCf8al2wS32cW+/uoWw5/y94CFWtFhMVXkNIUZ3cVcg99I9J6xW83hTMU
         4QmQ4kjCWfojxAlJLI2ePLGdw4mk4UVCZQvMuT6cqycoOdLJ3WFy8vKqsfMQC/bkVtKI
         mKw0vu31UwJTpf25Tra4nY+JAhXApug96pLkRtwJOHxA/KPS8kv347OjIhAzpZhNc5R/
         FbdrmttQizQAnUPWWxEHA4HK5KsCwT348fRBGAbDud4FeOMSEzEP/Kb64EjOaBLloiJw
         jkTg==
X-Gm-Message-State: APjAAAXw+PI8YnLjXYAm2PU+uVRizvOtGpppCiIg2hpsc1j/8KmPvO3l
        tV43wE2mbmlJDyFEaw+b7Bmz6J5pkDbzx02jvwN8dYiZXxRohdpQsKsRWXolRa3VfTwtyDlcGuU
        9aHHvfLrSY+iDhaNgL4OmBiHt
X-Received: by 2002:a05:600c:48e:: with SMTP id d14mr4237662wme.175.1570176650585;
        Fri, 04 Oct 2019 01:10:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz60cHZl9u6iwt5CbPFVFvjqE6Mroz1NqbPNQr+N7M0LUyn4CMyjhNjmKO51mxz+c2mi1kd4Q==
X-Received: by 2002:a05:600c:48e:: with SMTP id d14mr4237575wme.175.1570176649352;
        Fri, 04 Oct 2019 01:10:49 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id y186sm8141804wmd.26.2019.10.04.01.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 01:10:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
Date:   Fri, 4 Oct 2019 10:10:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003181045.7fb1a5b3@gandalf.local.home>
Content-Language: en-US
X-MC-Unique: QC4x75v_MRC3puYwuCuxVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 00:10, Steven Rostedt wrote:
> On Wed, 2 Oct 2019 20:21:06 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Wed, Oct 02, 2019 at 06:35:26PM +0200, Daniel Bristot de Oliveira wro=
te:
>>
>>> ftrace was already batching the updates, for instance, causing 3 IPIs t=
o enable
>>> all functions. The text_poke() batching also works. But because of the =
limited
>>> buffer [ see the reply to the patch 2/3 ], it is flushing the buffer du=
ring the
>>> operation, causing more IPIs than the previous code. Using the 5.4-rc1 =
in a VM,
>>> when enabling the function tracer, I see 250+ intermediate text_poke_fi=
nish()
>>> because of a full buffer...
>>>
>>> Would this be the case of trying to use a dynamically allocated buffer?
>>>
>>> Thoughts? =20
>>
>> Is it a problem? I tried growing the buffer (IIRC I made it 10 times
>> bigger) and didn't see any performance improvements because of it.
>=20
> I'm just worried if people are going to complain about the IPI burst.
> Although, I just tried it out before applying this patch, and there's
> still a bit of a burst. Not sure why. I did:
>=20
> # cat /proc/interrupts > /tmp/before; echo function > /debug/tracing/curr=
ent_tracer; cat /proc/interrupts > /tmp/after
> # cat /proc/interrupts > /tmp/before1; echo nop > /debug/tracing/current_=
tracer; cat /proc/interrupts > /tmp/after1
>=20
> Before this patch:
>=20
> # diff /tmp/before /tmp/after
> < CAL:       2342       2347       2116       2175       2446       2030 =
      2416       2222   Function call interrupts
> ---
>> CAL:       2462       2467       2236       2295       2446       2150  =
     2536       2342   Function call interrupts
>=20
> (Just showing the function call interrupts)
>=20
> There appears to be 120 IPIs sent to all CPUS for enabling function trace=
r.
>=20
> # diff /tmp/before1 /tmp/after1
> < CAL:       2462       2467       2236       2295       2446       2150 =
      2536       2342   Function call interrupts
> ---
>> CAL:       2577       2582       2351       2410       2446       2265  =
     2651       2457   Function call interrupts
>=20
> And 151 IPIs for disabling it.
>=20
> After applying this patch:
>=20
> # diff /tmp/before /tmp/after
> < CAL:      66070      46620      59955      59236      68707      63397 =
     61644      62742   Function call interrupts
> ---
>> CAL:      66727      47277      59955      59893      69364      64054  =
    62301      63399   Function call interrupts
>=20
> # diff /tmp/before1 /tmp/after1
> < CAL:      66727      47277      59955      59893      69364      64054 =
     62301      63399   Function call interrupts
> ---
>> CAL:      67358      47938      59985      60554      70025      64715  =
    62962      64060   Function call interrupts
>=20
>=20
> We get 657 IPIs for enabling function tracer, and 661 for disabling it.
> Funny how it's more on the disable than the enable with the patch but
> the other way without it.
>=20
> But still, we are going from 120 to 660 IPIs for every CPU. Not saying
> it's a problem, but something that we should note. Someone (those that
> don't like kernel interference) may complain.

That is the point I was raising.

When enabling ftrace, we have three different paths:

1) the enabling/disabling ftrace path
2) the int3 path - if a thread/irq is running a kernel function
3) the IPI - that affects all CPUs, even those that are not "hitting" trace
code, e.g., user-space.

The first one is for sure a cold-path. The second one is a hot-path: any ta=
sk
running kernel functions will hit it. But IMHO, the hottest one is the IPIs=
,
because it will run on all CPUs, e.g., even isolated CPUs that are running =
in
user-space.

Currently, ftrace does:

=09for_ftrace_rec:
=09=09Install all breakpoints
=09send IPI

=09for_ftrace_rec:
=09=09write the end of the instruction
=09send IPI

=09for_ftrace_rec:
=09=09 write the first byte of the instruction
=09send IPI

And that is the same thing we do with the batch mode, and so it would be be=
tter
to integrate both.

The problem is that considering the patch 2/3, the amount of entries we can
batch in the text_poke is limited, and so we batch on chunks of TP_VEC_MAX
entries. So, rather than doing 3 IPIs to change the code, we do:

(ftrace_rec count/TP_VEC_MAX) * 3 IPIs.

One possible solution for this would be to allocate a buffer with "number o=
f
ftrace_rec" and use it in the text_poke batch mode.

But to do it, we should keep the old interface (the one that the 2/3 is
changing). Well, at least using a per-use-case buffer.

[ In addition ]

Currently, ftrace_rec entries are ordered inside the group of functions, bu=
t
"groups of function" are not ordered. So, the current int3 handler does a (=
*):

for_each_group_of_functions:
=09check if the ip is in the range    ----> n by the number of groups.
=09=09do a bsearch.=09=09   ----> log(n) by the numbers of entry
=09=09=09=09=09         in the group.

If, instead, it uses an ordered vector, the complexity would be log(n) by t=
he
total number of entries, which is better. So, how bad is the idea of:

=09in the enabling ftrace code path, it:
=09=09discover the number of entries
=09=09alloc a buffer
=09=09discover the order of the groups
=09=09for each group in the correct order
=09=09=09queue the entry in the buffer
=09=09apply the changes using the text_poke...

In this way we would optimize the two hot-paths:
=09int3 will be log(n)
=09IPIs bounded to 3.

I am not saying we need to do it now, as Steve said, not sure if this is a =
big
problem, but... those that don't like kernel interference may complain. But=
 if
we leave the per-use-case vector in the text_poke_batch interface, things w=
ill
be easier to fix.

NOTE: the other IPIs are generated by hooking the tracepoints and switching=
 the
code to RO/RW...
=09=09
* as far as I understood ftrace_location_range().

-- Daniel

> -- Steve
>=20

