Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E82C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B2E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="M+ReO8ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCSXK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:10:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39903 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCSXK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:10:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so418191qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6FWypQkapP8gnmtBtLQAKuuE6zk0IbVIm8LRbFhdYXc=;
        b=M+ReO8agDfxcUZE1BC6jIroXPpA/3rFDw7WL2eBF6QPi8+fe4q1yfE3cc0ZNNln0tP
         3Dutwt74X0Mb9BEPu7GbrMZZWOuKVdH78KU+HAbkslsG02wo4iK6ObbXFZIoJvse5hPt
         +mNSLNRsZHvFLQ4ytrymOevkVA91aSIXV02lVyagkwxkXhUuYamp7vkRAOrO2Z+riYjx
         7iDcO0ceMht3+Sfv53hEyNRAiX3hMmxRqjcgVLTi/UdEAQ7Fpt8Na61DjVKqaRKcg0ZT
         c6uHvd7we28+D1ALMCmPsoULQb1zPqsGc8VZi23DjfCjNIdsYvHONVsI2or/qGNiNMh1
         BQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6FWypQkapP8gnmtBtLQAKuuE6zk0IbVIm8LRbFhdYXc=;
        b=Zy+1x0UVxRVWBeA+trapVSD5xkaTLeMJ5AYnl91WPVReOpWA4am2tYFJr9+UUD9yt2
         Bn+1yT0UgCZ0PXV+MtC/J+btCdb52gMdnxdVPydGW5SzQdyo84uGae/+2Zw1FffReY0P
         zjWp+qvPf/lzntSrtXU9VW1JiRp10mlRDHNEE/MTJQynAYqX6dWGtE1niK5d4A6OXdrD
         dpOOjUpH6ZVhVmBsTqLLeP44FmFDCi16JPFBTVtwMvNKNwUMzTgk6EhNb4QlNlv6P2pB
         KkjoFCMmRlR2T/8IOO1CJ+eyBvXf51dvV6meYCGer3H6lmC7Nz4oGNm5ZxXGVAl7/nO9
         1tDA==
X-Gm-Message-State: APjAAAVHy6D37uieRYl9rR6il0NMyeaB+I74o7NLKLMH1f0CvIrE7zcl
        yJ6Fa/08+ksB+E77B17umEViFQ==
X-Google-Smtp-Source: APXvYqxwNsa8SsSdl8LqERXal6FHQWmFo7gdTiOZy3amFeU+WySgqgoRQgKFw4lJtMZx/FhDpN1fcQ==
X-Received: by 2002:ac8:2850:: with SMTP id 16mr4256446qtr.84.1553037028006;
        Tue, 19 Mar 2019 16:10:28 -0700 (PDT)
Received: from brauner.io ([38.127.230.10])
        by smtp.gmail.com with ESMTPSA id j10sm59557qth.14.2019.03.19.16.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 16:10:27 -0700 (PDT)
Date:   Wed, 20 Mar 2019 00:10:23 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190319231020.tdcttojlbmx57gke@brauner.io>
References: <CAKOZueuauUXRyrvhzBD0op6W4TAnydSx92bvrPN2VRWERX8iQg@mail.gmail.com>
 <20190316185726.jc53aqq5ph65ojpk@brauner.io>
 <CAJuCfpF-uYpUZ1RO99i2qEw5Ou4nSimSkiQvnNQ_rv8ogHKRfw@mail.gmail.com>
 <20190317015306.GA167393@google.com>
 <20190317114238.ab6tvvovpkpozld5@brauner.io>
 <CAKOZuetZPhqQqSgZpyY0cLgy0jroLJRx-B93rkQzcOByL8ih_Q@mail.gmail.com>
 <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:48:32PM -0700, Daniel Colascione wrote:
> On Tue, Mar 19, 2019 at 3:14 PM Christian Brauner <christian@brauner.io> wrote:
> > So I dislike the idea of allocating new inodes from the procfs super
> > block. I would like to avoid pinning the whole pidfd concept exclusively
> > to proc. The idea is that the pidfd API will be useable through procfs
> > via open("/proc/<pid>") because that is what users expect and really
> > wanted to have for a long time. So it makes sense to have this working.
> > But it should really be useable without it. That's why translate_pid()
> > and pidfd_clone() are on the table.  What I'm saying is, once the pidfd
> > api is "complete" you should be able to set CONFIG_PROCFS=N - even
> > though that's crazy - and still be able to use pidfds. This is also a
> > point akpm asked about when I did the pidfd_send_signal work.
> 
> I agree that you shouldn't need CONFIG_PROCFS=Y to use pidfds. One
> crazy idea that I was discussing with Joel the other day is to just
> make CONFIG_PROCFS=Y mandatory and provide a new get_procfs_root()
> system call that returned, out of thin air and independent of the
> mount table, a procfs root directory file descriptor for the caller's
> PID namspace and suitable for use with openat(2).

Even if this works I'm pretty sure that Al and a lot of others will not
be happy about this. A syscall to get an fd to /proc? That's not going
to happen and I don't see the need for a separate syscall just for that.
(I do see the point of making CONFIG_PROCFS=y the default btw.)

Inode allocation from the procfs mount for the file descriptors Joel
wants is not correct. Their not really procfs file descriptors so this
is a nack. We can't just hook into proc that way.

> 
> C'mon: /proc is used by everyone today and almost every program breaks
> if it's not around. The string "/proc" is already de facto kernel ABI.
> Let's just drop the pretense of /proc being optional and bake it into
> the kernel proper, then give programs a way to get to /proc that isn't
> tied to any particular mount configuration. This way, we don't need a
> translate_pid(), since callers can just use procfs to do the same
> thing. (That is, if I understand correctly what translate_pid does.)

I'm not sure what you think translate_pid() is doing since you're not
saying what you think it does.
Examples from the old patchset:
translate_pid(pid, ns, -1)      - get pid in our pid namespace
translate_pid(pid, -1, ns)      - get pid in other pid namespace
translate_pid(1, ns, -1)        - get pid of init task for namespace
translate_pid(pid, -1, ns) > 0  - is pid is reachable from ns?
translate_pid(1, ns1, ns2) > 0  - is ns1 inside ns2?
translate_pid(1, ns1, ns2) == 0 - is ns1 outside ns2?
translate_pid(1, ns1, ns2) == 1 - is ns1 equal ns2?

Allowing this syscall to yield pidfds as proper regular file fds and
also taking pidfds as argument is an excellent way to kill a few
problems at once:
- cheap pid namespace introspection
- creates a bridge between the "old" pid-based api and the "new" pidfd api
- allows us to get proper non-directory file descriptors for any pids we
  like

The additional advantage is that people are already happy to add this
syscall so simply extending it and routing it through the pidfd tree or
Eric's tree is reasonable. (It should probably grow a flag argument. I
need to start prototyping this.)

> 
> We still need a pidfd_clone() for atomicity reasons, but that's a
> separate story. My goal is to be able to write a library that

Yes, on my todo list and I have a ported patch based on prior working
rotting somehwere on my git server.

> transparently creates and manages a helper child process even in a
> "hostile" process environment in which some other uncoordinated thread
> is constantly doing a waitpid(-1) (e.g., the JVM).
> 
> > So instead of going throught proc we should probably do what David has
> > been doing in the mount API and come to rely on anone_inode. So
> > something like:
> >
> > fd = anon_inode_getfd("pidfd", &pidfd_fops, file_priv_data, flags);
> >
> > and stash information such as pid namespace etc. in a pidfd struct or
> > something that we then can stash file->private_data of the new file.
> > This also lets us avoid all this open coding done here.
> > Another advantage is that anon_inodes is its own kernel-internal
> > filesystem.
> 
> Sure. That works too.

Great.
