Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 01:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EF321726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 01:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ajP0Dzew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfCaBHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 21:07:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46985 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfCaBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 21:07:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so2954153pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 18:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yUwLfDBwsndnnuR7aaVt1KPshRkPUFmsH4buStY9+NQ=;
        b=ajP0DzewOi9IEOnCGMykOT0DOO/jjNtHJ92PDBrbQkenBnb18Pfw8H+gywRZqInqx2
         W0biYtdowIf/P4+L+RFVVbWLGQLlF3MgAG9PdS4QqZU7rnyRZgESXoS97nM9RkBqc6lT
         irwCumTyAgJfJ48vODPPMZQYyi8ZdSZ+Ia3Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUwLfDBwsndnnuR7aaVt1KPshRkPUFmsH4buStY9+NQ=;
        b=YJSsGimI7dInLsx+2wsKfSVNNjY3BdMEb2HFiN22ywnO96XfS9zQcNrGuydTBI1brY
         jg8Q0cBgkQNF7FS6Nv7eZNsXkXeeLmx8cbnev35zJYG3tcqOKkblJYo8f8VjtZrtt0QI
         4m+jvfTIgiCRfYaALpUdNjQOASi+t0wails+3gUrQ4zBRck1aXMr75hP9cInq5iQipiR
         4KqQGp/q20sUT1fSbLaMvk33bNvpmC05ulr3t1bMlJpzvelZ84gfScAuXmamfy5x+Hu9
         r9wZxmYTwbhkICog0lLECc7Xog+U8qiLI9MgExVo9sgbbxfjvbuO/CiOdUbhMBtL7xc6
         gyLA==
X-Gm-Message-State: APjAAAV2gupBO9ZjM7Tj1jyApNk5chvbtzFtPwwp5YfpM3tnDcLZc5/F
        9PCd12/Zhma1miKu2IWa3CItFQ==
X-Google-Smtp-Source: APXvYqyeAxbHVbFEEmMrhQZAbKd11Lbz2GBnK+VCWTG5G8W1e0b+PnTGeckO4q5DYTkYnyynVOMMQg==
X-Received: by 2002:a65:6497:: with SMTP id e23mr52429201pgv.21.1553994438271;
        Sat, 30 Mar 2019 18:07:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w123sm12981875pfw.72.2019.03.30.18.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 18:07:17 -0700 (PDT)
Date:   Sat, 30 Mar 2019 21:07:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
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
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190331010716.GA189578@google.com>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 09:18:12AM -0700, Linus Torvalds wrote:
> On Sat, Mar 30, 2019 at 9:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And no, we are *NOT* making pidfd_open() into some "let's expose /proc
> > even when it's not mounted" horror. Seriously. That's disgusting,
> > wrong, insecure and stupid.
> 
> And btw, this is not debatable. In fact, this whole discussion is
> making me feel like I should just revert pidfd, not because the code I
> merged is wrong, but because people are clearly intending to do
> completely inappropriate things with this.
> 
> Get your act together.  Stop hacking up garbage.
> 
>                Linus

I am supportive of Linus's view of keeping /proc separate from pidfd. I
didn't really care about "pidfd" solving any racing issues with /proc/<pid>/*
access.  My main interest in pidfd is because we can implement "waiting"
semantics in the future using something like a pidfd_wait call, which solves
one of the issues of Android's low-memory where it needs to be notified as
quickly as possible about a non-child process's death. Android Low memory
killer right now just keeps checking for /proc/<pid> 's existence which is
slow and more CPU intense for this.

As I said I don't really care about "pidfd" solving any racing issues with
/proc/<pid>/* accesses - because I still find it hard to imagine that the pid
number can be reused easily from the time you know which <pid> to deal with,
to the time when you want to read, say, the /proc/<pid>/status file. I am yet
to see any real data to show that such overflow happens - you literally need
32k process deaths and forks in such a short time frame, and on 64-bit, that
number is really high that its not even an issue. And if this is really an
issue, then you can just open a handle to /proc/<pid> at process creation
time and keep it around. If the <pid> is reused, you can still use openat(2)
on that handle without any races.

What I think will be most immediately valuable for Android in my opinion is
the pidfd_open() and pidfd_send_signal() syscalls, along with the future
pidfd_wait() that we're working on to solve the issue with Android's Low
memory killer I mentioned above.

Now, in relation to Daniel's concern with procfs, I feel we need to be clear
what is the meaning of a "pidfd" and it should consistently work across all
APIs no matter how pidfd is obtained. There shouldn't be like "if you obtain
pidfd using this method and it only works with these APIs", that's just plain
wrong IMO.

For example: with pidfd_open() or whatever that ends up being called is
available, the pidfd obtained is not tied to /proc. However, if one obtained
a pidfd using open("/proc/<pid>/", ..), then that pidfd *is* tied to /proc.
pidfd_send_signal will happily work on this "pidfd". Both these methods of
obtainings pidfd(s) make openat(2) work on them inconsistently. In one case
openat(2) fails, and in the other case it succeeds. I feel there should be no
ambiguity between how "pidfd" works with openat(2).  Either make openat(2)
never work on any "pidfd", or always make it work on it.

I would say, don't call a /proc/<pid> file descriptor as a "pidfd". Next, to
remedy all this, I feel pidfd_send_signal *should not* work on fds that are
obtained by opening of /proc/<pid> if we can agree those are not pidfds.
Only the ones obtained using the proposed pidfd_open (or pidfd_clone) should
be allowed to be used with pidfd_send_signal.

So I believe the call to tgid_pidfd_to_pid() from pidfd_to_pid in Christian's
patch 3/5 needs to go away.

+static struct pid *pidfd_to_pid(const struct file *file)
+{
+	if (file->f_op == &pidfd_fops)
+		return file->private_data;
+
+	return tgid_pidfd_to_pid(file); <-------- Should just return error
+}
+

I agree with Christian that lets not put pidfd_send_signal at risk. Let us
make the notion of a pidfd and the APIs that work on it *consistent* and make
it do just what we really need for our usescases. Which for Android, is,
pidfd_open/clone, pidfd_send_signal and pidfd_wait. I hope I added some
clarity around the usecases.

thanks,

 - Joel

