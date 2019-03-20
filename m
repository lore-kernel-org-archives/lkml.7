Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8350C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4742190A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553108352;
	bh=jp8AbSaqwT21JnyYDjKNO3C8evoJ6yy8quSVRfFSrac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B8OkjokrNkBxE/NSOAwNbR2KJ5HbZ9vO0Rabm+stUKBGtvcrt4sgnzY6MKF9XuTn/
	 Q7EHurCLtqkI+/PEaMJvKbIUY78Ggn2eAAgjMa4EXTSZ8Kj5KanjSu5AhX1xTl/ZtN
	 bicVhE6uXToSecOFrw5Lmpu+Q/wBbDNws6CB+WPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCTS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfCTS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:59:10 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3333218D4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553108350;
        bh=jp8AbSaqwT21JnyYDjKNO3C8evoJ6yy8quSVRfFSrac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mRIf6w3QFh3e9I8TEAE+h2PxblsGDwAvz/vvD8Akc66cH92WI1V37lsdfwOx4+xnd
         JLwYPXQAmxsZPJPnkaIC9PuN/GyDZDVoR3K3um+rtpcmpAB1nH7GpqTGRQs+2gFosD
         MPn8HQc+0pW04uhAeiyRhhiaezb/4rABISJifUvM=
Received: by mail-wm1-f42.google.com with SMTP id n19so338877wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:59:09 -0700 (PDT)
X-Gm-Message-State: APjAAAUsWbzqRTiYcZByaEtL1yu3uuwje4weGAi5CoJt+olPZo8a4rCC
        38fcZiPwcP+Uq3+XykNwbUFo+cm37JYH94nMG723/Q==
X-Google-Smtp-Source: APXvYqxwIcCiG/Gdmna67jJuGq9jz6L0ZUfjptg7uIOTyqb3ubKH2KDCqdqte/JGYbWypFZXNpHHzKgiEzukbcTdOzM=
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr9266896wme.108.1553108348098;
 Wed, 20 Mar 2019 11:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221415.baov7x6zoz7hvsno@brauner.io> <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io> <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org> <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com> <20190320185156.7bq775vvtsxqlzfn@brauner.io>
In-Reply-To: <20190320185156.7bq775vvtsxqlzfn@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Mar 2019 11:58:57 -0700
X-Gmail-Original-Message-ID: <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
Message-ID: <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
Subject: Re: pidfd design
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:52 AM Christian Brauner <christian@brauner.io> wrote:
>
> You're misunderstanding. Again, I said in my previous mails it should
> accept pidfds optionally as arguments, yes. But I don't want it to
> return the status fds that you previously wanted pidfd_wait() to return.
> I really want to see Joel's pidfd_wait() patchset and have more people
> review the actual code.

Just to make sure that no one is forgetting a material security consideration:

$ ls /proc/self
attr             exe        mountinfo      projid_map    status
autogroup        fd         mounts         root          syscall
auxv             fdinfo     mountstats     sched         task
cgroup           gid_map    net            schedstat     timers
clear_refs       io         ns             sessionid     timerslack_ns
cmdline          latency    numa_maps      setgroups     uid_map
comm             limits     oom_adj        smaps         wchan
coredump_filter  loginuid   oom_score      smaps_rollup
cpuset           map_files  oom_score_adj  stack
cwd              maps       pagemap        stat
environ          mem        personality    statm

A bunch of this stuff makes sense to make accessible through a syscall
interface that we expect to be used even in sandboxes.  But a bunch of
it does not.  For example, *_map, mounts, mountstats, and net are all
namespace-wide things that certain policies expect to be unavailable.
stack, for example, is a potential attack surface.  Etc.

As it stands, if you create a fresh userns and mountns and try to
mount /proc, there are some really awful and hideous rules that are
checked for security reasons.  All these new APIs either need to
return something more restrictive than a proc dirfd or they need to
follow the same rules.  And I'm afraid that the latter may be a
nonstarter if you expect these APIs to be used in libraries.

Yes, this is unfortunate, but it is indeed the current situation.  I
suppose that we could return magic restricted dirfds, or we could
return things that aren't dirfds and all and have some API that gives
you the dirfd associated with a procfd but only if you can see
/proc/PID.

--Andy
