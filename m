Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27502C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078421726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMGtnVyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfCaCfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 22:35:25 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45705 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfCaCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 22:35:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so4598580oia.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlMJg4yWnpLZFMd4RJOv7kwwDZAwp1zKNiaOdaLll+E=;
        b=lMGtnVyHrRJMnsz0kWbg3+dRaRE8wZ7N0nWFFfAoJdE4JGHcK01QX+fu/7vPo5DC30
         68qJgS64pLys3QUaKf5Lu9ZR01iQ8pNdLpgfB3fFFSC567Zi0mPkZF0NAsqZzd1KlrQb
         LqtkEf9Ct+bzMLNUlY13uVKJ/yp0qlqshdxtxYlnSY8IbXxcjpZ/JTgIFpNF38S3undD
         0hCogXcaOQKd6pghv1YLzatLgWCmj46aIsoCkjQRrWO21L8yrIVWZU0kwWEsCLgxI0+3
         ZR/6YUDX77GCz8Cxfb8KKSSTurpY4HfgNnDapZNGupbnQ+VOM2nE+z2d9wsDYM07KvIS
         ooGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlMJg4yWnpLZFMd4RJOv7kwwDZAwp1zKNiaOdaLll+E=;
        b=Nol4kd6W6ZUzrT8J7PiZtB3nsTNncBAS/YU4X5zxMTNrjE75anLojonhsL2VAQ8k96
         u5Y4hurZJucNsV+2kiU2mnP8uCztvVOlbdJtnsXUeO4TuqdKulqpztEwVpQL/U0BG/xD
         o4ccydvatJPyM0l/J/vIujSLn8t1awMy9EaNBdb1+jBg6+mlHuy4GDp8ruXbBcYe5WsV
         fqaPvbQhABKa/j0pvO1DG2nVbTT93HwhAwe3nX8mEP+oQ2n71ifzw49fGgQo3zvr8ESN
         8jPpZgp4OTJtzNXzrzeeX6mpz2O7l+PqyJ5HimhsAu9rBFgkmRIA4S+SzNipcICgdzr9
         bmRQ==
X-Gm-Message-State: APjAAAW6bkFHTzXHe7H+5XuWWTzm+MwPcGHp8HsAOpj94JyfcQEnzJTp
        nUXisd+w/QyLkpLhhbJfte5qCxzpGAUc5zDaaW6o2g==
X-Google-Smtp-Source: APXvYqynrUNepmojanfwL2zpam+LqOjOgoVfeO9K1e1QqshIi5J2tXyEKonrPnq21TPv74C5s+BlLCHm6GiS6IVOBz0=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr8790357oih.39.1553999724637;
 Sat, 30 Mar 2019 19:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com> <20190331010716.GA189578@google.com>
In-Reply-To: <20190331010716.GA189578@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 31 Mar 2019 04:34:57 +0200
Message-ID: <CAG48ez387kGbD_dLqEbZ1U9rKFbfP0EF9cMVjQT6nwc9=Y9CNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 3:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> As I said I don't really care about "pidfd" solving any racing issues with
> /proc/<pid>/* accesses - because I still find it hard to imagine that the pid
> number can be reused easily from the time you know which <pid> to deal with,
> to the time when you want to read, say, the /proc/<pid>/status file.

There have been several Android security bugs related to PID reuse.

> I am yet
> to see any real data to show that such overflow happens - you literally need
> 32k process deaths and forks in such a short time frame

This seems very inaccurate to me.

The time frame in which the PID has to wrap around is not the time
between process death and use of the PID. It is the time between *the
creation* of the old process and the use of the PID. Consider the
following sequence of events:

 - process A starts with PID 1000
 - some time passes in which some process repeatedly forks, with PIDs
wrapping around to 999
 - process B starts an attempt to access process A (using PID 1000)
 - process A dies
 - process C spawns with PID 1000
 - process B accidentally accesses process C

Also, it's probably worth clarifying that here, "processes" means "threads".

If there are a lot of active processes, that reduces the number of
times you have to clone() to get the PID to wrap around.

> and on 64-bit, that
> number is really high

Which number is really high on 64-bit? Checking on a walleye phone,
pid_max is still only 32768:

walleye:/ # cat /proc/sys/kernel/pid_max
32768
walleye:/ #

> that its not even an issue. And if this is really an
> issue, then you can just open a handle to /proc/<pid> at process creation
> time and keep it around. If the <pid> is reused, you can still use openat(2)
> on that handle without any races.

But not if you want to implement something like killall in a
race-free way, for example.
