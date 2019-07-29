Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DBC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDBF21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvsRVHES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfG2LIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:08:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45854 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbfG2LI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:08:29 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so118963114ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3DaRRgpLj/uGSL399j7IMa9G4GhvVqiLRKGA1q5ZiY=;
        b=lvsRVHESmsKtrfUmE3oYHPSZngETasXxWpHs6GDX0x78UQShr4gRHYHndcarQk2ujX
         SAikAhnYCVWq/TqAHBHiUqRsi+69JhVuxkB5naa+IwscaqwfslK9/OuLB4X6heBovhe/
         vEocnR4/WyW4hVtn1eljixutmTUYHLC86HdphjyHfCnMKJQ+eB85R/vcg4bq+rylaXSc
         yo4LGTFn3ZioKDWSo0o+MFVJUzydGWM2RcmKmp+eUnN2WM5ilWRA0nceGHDzf6S9AZ+X
         iiY78Wg3EpTnld9tl1qBMx6Baj8j7f4mXsIX2I8fvFoLnp1bcR1gddWtUogvRA9I7BRD
         gaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3DaRRgpLj/uGSL399j7IMa9G4GhvVqiLRKGA1q5ZiY=;
        b=GmJtPaJYcpwGnne1MIR5BIqF2puhH69x6fqm2T2QTjw8rJAoyV0d2MVqn7pcNwkI6S
         Shoz2dm/84tyL7L665S4SEeJ57V9yuXThASwaa4EEBDV9oRvmRQjvEttEcDdL8usugCT
         JVXkUCVBWuRvrn++37QeYpsGR9i0Wph5anVULKdEdDsd2MdlS7IL/eYWboOmX2Ety83T
         F+Fom42CcoX6+vnNkavPA2NjRZ6493osqbZw3858Qqh+qonu+Td7L4Hq3wmYTPjJCF2m
         ZhtODUItvG1GWh6k6kaEozKSBGzv4+Hp5ERTBRpxWoBNswlZPh67299tziOlocW1F+nD
         KX+w==
X-Gm-Message-State: APjAAAWOAKqSYH2nOgunpcbVLG/U3r6/ghd7f39aB17GY/iApPBJg9EA
        Ls6aVqiBKHJp9mYKXgKxe3/g1YjQj191Ce2/y9eAfA==
X-Google-Smtp-Source: APXvYqwqnsYVXt7mxm9UQA6RoyUlfFLVXYfEgvB3jdmtllmT0MlaUIIYyoPAIwh3WyiiMvtVhTqLKcqQNhqQPU+/19Q=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr94529516iop.58.1564398508067;
 Mon, 29 Jul 2019 04:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Y3nN=nLEkHXLFcX7vxp_vs1JrD=8auJ3cX9we6TQHO+w@mail.gmail.com>
In-Reply-To: <CACT4Y+Y3nN=nLEkHXLFcX7vxp_vs1JrD=8auJ3cX9we6TQHO+w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Jul 2019 13:08:16 +0200
Message-ID: <CACT4Y+YXQBF1QQwEPEkR3b3-RoeZw_We5B-o_71xxc9HMSyTdw@mail.gmail.com>
Subject: Re: syzbot bisection analysis
To:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 6:20 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hello,
>
> As most of you probably already noticed, syzbot started bisecting
> cause commits for crashes about 2 weeks ago and sending emails like
> this:
> https://groups.google.com/d/msg/syzkaller-bugs/2XhfN2Kfbqs/0U3YnKsGBQAJ
> The bisection results are also available on the dashboard, e.g.:
> https://syzkaller.appspot.com/bug?id=02bde0600a225e8efa31bdce2e7f1b822542fef1
>
> Bisection was probably the most popular feature request for syzbot.
> Cause commits allow to add the right people to CC and also should help
> to pin-point the harder bugs. If you are interested in details of the
> bisection process, some are described here:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bisection
> The next step step will be fix commit bisection to help identify and
> close bugs that are already fixed but syzbot is not aware yet.
>
> As expected automatic bisection of kernel bugs is not completely
> trivial and we've got lots of incorrect results. To better understand
> what happens, why and how we are doing, I've analyzed the 118
> bisections that we have so far for the following metrics:
>  - if the bisection was correct or not
>  - the crash has multiple manifestations (on the same commit or on
> different commits)
>  - if the fact that bug hard to reproduce contributed to incorrect bisection
>  - if unrelated bugs contributed to incorrect bisection
>  - if skipped commits contributed to incorrect bisection
>  - if disabled configs contributed to incorrect bisection
> There are also some auto-extracted metrics like the start release of
> bisection, start/end crash, etc. I won't claim that the analysis is
> 100% correct, which would require spending a day on each case. But it
> should be 95% correct or so. The results are here (there is a second
> tab with raw data):
> https://docs.google.com/spreadsheets/d/1WdBAN54-csaZpD3LgmTcIMR7NDFuQoOZZqPZ-CUqQgA
>
> Total success rate is slightly above 50%. But there is strong
> correlation with how far back in history we have to go: for recently
> introduced bugs the rate is 70+%. And for bugs introduced since v5.0
> it's 95%. So hopefully this is a good forecast for future.
>
> The 2 major contributors to incorrect results look quite fundamental:
>  - unrelated bugs contributed to 66% of incorrect results
>  - hard to reproduce bugs contributed to 46% of incorrect results
>
> I've started collecting feedback/ideas re improving bisection quality here:
> https://github.com/google/syzkaller/issues/1051
> But so far no magic bullet come up. So please continue treating the
> results with understanding. The incorrect results were usually easy to
> identify: commit to a completely unrelated subsystem, or even
> non-current arch. There is always a detailed bisection log attached as
> well.
>
> If you are still here, there were some curious cases too, e.g.:
> A bug bisected to a comment-only commit:
> https://groups.google.com/d/msg/syzkaller-bugs/1BSkmb_fawo/vz7GhBd0CQAJ
> A bug bisected to a release tag:
> https://groups.google.com/d/msg/syzkaller-bugs/38HP_pUXJ3s/ehD37HSxDAAJ
> And a fault-injection-provoked bug bisected to addition of the fault
> injection facility by me (which is, well, kinda expected):
> https://groups.google.com/d/msg/syzkaller-bugs/GYiA5CKTPXw/MA4mO01wDAAJ
>
> Thanks

A mini analysis of memory leaks bisection:
https://docs.google.com/spreadsheets/d/1WdBAN54-csaZpD3LgmTcIMR7NDFuQoOZZqPZ-CUqQgA/edit#gid=1421280815

Out of 12 leak bisections that happened so far only 2 are semi-correct:
1. The bug is too old, so syzbot just proved that it happens back to
the horizon (v4.1):
https://syzkaller.appspot.com/bug?id=ecc7f04cd94b5c062c000865d43bfb682d718b8e
2. The bug requires both leak detection and fault injection, was
bisected to the commit that allows them to work together:
https://syzkaller.appspot.com/bug?id=58c436c13ed984480edba66a224daff9c184de12
Both results are not too useful.

The remaining 10 were all diverged due to other unrelated memory leaks
and other non-leak bugs. It seems the main 2 reasons for this:
1. Lots of leaks are old (kernel is under-tested with KMEMLEAK).
2. Lots of unrelated bugs.
It's unclear how much KMEMLEAK potential for false positives is in
play. For example, lots of bisections are diverged by "memory leak in
batadv_tvlv_handler_register", but this is a true bug reported at:
https://syzkaller.appspot.com/bug?id=0654529ad3cc1d67a6d9812d8b75489c03dfb983
However, some are diverged by e.g. "memory leak in __neigh_create" and
"memory leak in copy_process" and these were not reported as separate
leaks, so either false positives or true leaks fixed in previous
releases.

I am going to turn off leak bisection for now (easiest way to raise
average bisection precision).
Maybe when we get overall bug levels down, and in particular number of
memory leaks, then newly-introduced leaks will be at least as
bisectable as other bug types. But this will probably require at least
several years of active work.
