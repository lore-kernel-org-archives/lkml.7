Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B99EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A86B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA+H+dIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbfDRRYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:24:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41649 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:24:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id v7so2201180oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnhma/byPGgq0RL10uJei+AuHtvIepl5bKIlskRenx4=;
        b=vA+H+dIkmDL0AWkK1xQ8a129naPeYHOC4RTobvzacHD0C/uVabFi116d7RkmVjpMuJ
         2J6cCDlHzUQyNBFvi/D2O5ZRWMBn4uek7e+LS4Ze1XcRYQuEz3q01reCdq893X60kU1R
         x9rguaqhQtMO9LZMaa9cBgWcuTx2RHNcXaRCV+4f9rAPRR0DIDCRqFBTuaeWDQZCFiLi
         NCmOBJk0/a1eAS9leKh6vqApP5Mma97q3HzmZFXQ8Ndxs6KsqTV9J39t9P/5NLiwdVcI
         pTkOIuVkzc47Pn0mi+sG3AUQtQaFWuxeHgX12TL0/zJecsSNxFAkixH5YQ7/udaU45M7
         KrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnhma/byPGgq0RL10uJei+AuHtvIepl5bKIlskRenx4=;
        b=MDq/wW6NO55KZQrbBGcJ9IcuJ+H7bY+yIEdYVSgZCqnUT0FH33DgLoFhm16+iT2P/b
         Tksn7DeBE1P1OimTaOFUGgr4jtwDCDm5cj9ctBoeKD6awpE32tZ4Vx0BsaifYT9UMQzA
         4ptpK3xP5LdgZ1QvwI/rxzXAz8L+HVXe4i2UkO/rzD7b0SC/QPAfFlcbnW0nCR1k6Aes
         LccCk5M0mfkA0eJeA5vzzZ6+MYHBML0CT+CAsKLng5kNsQ8UHR1xqzP4vBS3aVNPvfhk
         nqAG7ArHeYmHcO5EnaZgja0r2ohBlo9LpIWzyS7eF7Sd2N7g7wNKNL3eSt+aTWuJ+RPh
         MF3Q==
X-Gm-Message-State: APjAAAU0Bem6/eWy3nLTpBtIcYYqD1Bi7e7pZWCm6MvvROkDNFcq68au
        2Z0V2BwQyiMiQ5N4nUfNQ69AdC3MfX/L4fBwXQ2wRJKl
X-Google-Smtp-Source: APXvYqxT27fOifiKF0CC4wXlUUyiz4/i6WMwdUtzUMXr4N4B/TlmMW+tm6qsE1uAYlYHtw/4I5qtQ8ukrO3gnGC1w/A=
X-Received: by 2002:aca:e18b:: with SMTP id y133mr2839331oig.157.1555608245443;
 Thu, 18 Apr 2019 10:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com> <20190417130940.GC32622@redhat.com>
In-Reply-To: <20190417130940.GC32622@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 18 Apr 2019 19:23:38 +0200
Message-ID: <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Florian Weimer <fweimer@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/16, Joel Fernandes wrote:
> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > >
> > > Could you explain when it should return POLLIN? When the whole process exits?
> >
> > It returns POLLIN when the task is dead or doesn't exist anymore, or when it
> > is in a zombie state and there's no other thread in the thread group.
>
> IOW, when the whole thread group exits, so it can't be used to monitor sub-threads.
>
> just in case... speaking of this patch it doesn't modify proc_tid_base_operations,
> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are going to use
> the anonymous file returned by CLONE_PIDFD ?

I don't think procfs works that way. /proc/sub-thread-tid has
proc_tgid_base_operations despite not being a thread group leader.
(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
be hit trivially, and then the code will misbehave.

@Joel: I think you'll have to either rewrite this to explicitly bail
out if you're dealing with a thread group leader, or make the code
work for threads, too.
