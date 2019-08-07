Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE6BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6848217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8c7LUNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbfHGUiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:38:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36405 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbfHGUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:38:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so89862418qtc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JnfmvZ/QcYu98dNScUIPb4GqbadlayALh7C9ra9pyek=;
        b=B8c7LUNKNlZdnbVtnDPnClulOqJvhEKi/10aIP/4G8L4X6S3+qhU9kla5p7GTfn2D4
         IcEyJUOaijl5bh5Y9o+seprK9/DXAiLRpgyVO/UY7zqW4Y9mUTM1fvMqODM9KN3bjLkD
         mrLcXhV/PJ0FTFxivuGvBSmTurobtwme2xhfAa4TZDrk3RoDE+4zJEH+KfS4bPU+T9/S
         aSbXnWdGsHwZxLVNqc56pywauNawGOaowOVQwBJ2rTWgjE0Z5f6C5lB50dwin7J1fnJN
         dyCBYMD4Fg0Z+lv0qeI3L8+fXaQj+wrzIYqp1vzytsQvwu6OAESRkgg9EZ0OZxGnM703
         eA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnfmvZ/QcYu98dNScUIPb4GqbadlayALh7C9ra9pyek=;
        b=ZYmisazJ9MN3wRv9OlF87Bwg/zaD4vgTVuaM28ooA2TljZ5FQZbUdyS7fxKJ4ORtK2
         902b+gWEnMzxkktgg10Jybk2y3f6C+2W5ygIHfi60mYFAO70U1MEPEISAcDiglgTdKgH
         yeKavepxwpwO/L3OCwGMcfepP72A4lnxpmgOmq1wcZ6r/Ccxe6teD85Ifdd6j/KeFBN/
         ChgD4LHMeqFoqN8OujJBzsiH0eUDyPf1PFjKkj5iFe0BbDaRHgTK7Jd2CzuLj4Cw7bBK
         uAHvVuZZwEyF39fp7Pgj6U5S6dS9izOj7i3JMiiEt485MRY2NqkgmIuzOuEnqiu00euc
         r9dA==
X-Gm-Message-State: APjAAAVHxFRjrqFwiqAkVVOQr/M0KCRyOMxZgW38zYIkDYF6l5bHXk7Q
        tWMoPNT1hMZ7cMF8ItwCR7Y=
X-Google-Smtp-Source: APXvYqz9ftmvL04MNXRDrGb5NZ92hJgLeNENYrxotRrciCc8vUCRZ1g4XxyquBoH7o6F6eZfXZT6ag==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr9939429qti.72.1565210299795;
        Wed, 07 Aug 2019 13:38:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.208.151])
        by smtp.gmail.com with ESMTPSA id i5sm36780060qtp.20.2019.08.07.13.38.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 13:38:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F9C240340; Wed,  7 Aug 2019 17:38:13 -0300 (-03)
Date:   Wed, 7 Aug 2019 17:38:12 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 0/3] Perf uninitialized value fixes
Message-ID: <20190807203812.GA20129@kernel.org>
References: <20190724234500.253358-1-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724234500.253358-1-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 04:44:57PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> These patches are all warnings that the MSAN (Memory Sanitizer) build
> of perf has caught.
> 
> To build perf with MSAN enabled run:
> make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
>  -fsanitize-memory-track-origins"
> 
> (The -fsanitizer-memory-track-origins makes the bugs clearer but
> isn't strictly necessary.)
> 
> (Additionally, llvm might have to be installed and clang might have to
> be specified as the compiler - export CC=/usr/bin/clang).
> 
> The patches "Fix util.c use of uninitialized value warning" and "Fix 
> annotate.c use of uninitialized value error" build on top of each other
> (the changes in Fix util.c use of uninitialized value warning must be
> made first).
> 
> When running the commands provided in the repro instructions, MSAN will
> generate false positive uninitialized memory errors. This is happening
> because libc is not MSAN-instrumented. Finding a way to build libc with
> MSAN will get rid of these false positives and allow the real warnings
> mentioned in the patches to be shown. 

So this is because I'm not running a glibc linked with MSAN? Do you have
any pointer to help building glibc with MSAN? I want to do that inside a
container so that I can use these sanitizers, thanks,

[root@quaco ~]# perf record -o - ls / | perf --no-pager annotate -i -  --stdio
==29732==WARNING: MemorySanitizer: use-of-uninitialized-value
==29733==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0xcc136d in add_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6
    #1 0xcc075e in setup_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:146:2
    #2 0x71298d in main /home/acme/git/perf/tools/perf/perf.c:512:2
    #0 0xcc136d in add_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6
    #1 0xcc075e in setup_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:146:2
    #2 0x71298d in main /home/acme/git/perf/tools/perf/perf.c:512:2
    #3 0x7f45b9e29f32 in __libc_start_main (/lib64/libc.so.6+0x23f32)
    #4 0x447dcd in _start (/home/acme/bin/perf+0x447dcd)

  Uninitialized value was created by a heap allocation
    #3 0x7fd6433cff32 in __libc_start_main (/lib64/libc.so.6+0x23f32)
    #4 0x447dcd in _start (/home/acme/bin/perf+0x447dcd)

  Uninitialized value was created by a heap allocation
    #0 0x4507d2 in malloc /home/acme/git/llvm/projects/compiler-rt/lib/msan/msan_interceptors.cc:916:3
    #1 0x7f45b9e7fc47 in __vasprintf_internal (/lib64/libc.so.6+0x79c47)

SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6 in add_path
Exiting
    #0 0x4507d2 in malloc /home/acme/git/llvm/projects/compiler-rt/lib/msan/msan_interceptors.cc:916:3
    #1 0x7fd643425c47 in __vasprintf_internal (/lib64/libc.so.6+0x79c47)

SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6 in add_path
Exiting
[root@quaco ~]#
 
> Numfor Mbiziwo-Tiapo (3):
>   Fix util.c use of uninitialized value warning
>   Fix annotate.c use of uninitialized value error
>   Fix sched-messaging.c use of uninitialized value errors
> 
>  tools/perf/bench/sched-messaging.c |  3 ++-
>  tools/perf/util/annotate.c         | 15 +++++++++++----
>  tools/perf/util/header.c           |  2 +-
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
