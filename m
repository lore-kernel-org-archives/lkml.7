Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D26C2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IikLogst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbfDRSog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:44:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37331 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389868AbfDRSoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:44:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so2383099lfl.4;
        Thu, 18 Apr 2019 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgKBWPZ5JhFFELhiC1+JLERcaxYfxu/FE7mY6DY8noc=;
        b=IikLogstHoyVLau0GkUESJoPGDXUaPFxuAdUrnwVA1Fpq90xXDTJpBPxax7RFBrg6p
         ZJdNC0NBuzOjRhTeoNkyUTNKN26wE/6pARrAYXHxIERElle7EdhVBRtu118kUHQcXEKZ
         85VoXC71bOMPflMyq4iEaZ/f0dze0XarWJu1CuVnhrwG8sZi/H/oiPbg65HHTRKCTGOj
         lR1mBIMt248ioBKuaBnpSqhirMtgdQPM2zEsjB0zwZJOCKivGdev05fCgjs2jbGGsEsk
         VYThSxJraQTKMWo73+sQnlSR/bkZ9jb6VhUs6qynfRAg0ggODiwOBKBP/X4n0jae2vPh
         AWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgKBWPZ5JhFFELhiC1+JLERcaxYfxu/FE7mY6DY8noc=;
        b=NxTNhGHaukpEh+VJAxpG4vLbHrwzPseVLBhYhdh+FJ6+UAuhjaEPRihVSMNgq4kwDf
         tPi5yhOcqIGKb8GnjDFQb+vuuIVUvOKjrkZl/DA02H1YmLEH6fLouS2VmphAIHKFZeU1
         vAjYBl2jieeX0LsB1ndcepKo6mhmUn31k+hAuj3Ldq1A75a7E/ABAxw9V9gfp3M/Et2k
         NOw+LYsoDxHqtrKekMjWQbIUHGbJIhrbKOJegLXZJNHPgN35DlzLmcCCSVKEN3pwE68l
         34+xxCo7hpSnq9PlSR1RB46uIxyPEFl1TYaVhF23mKohFMBEETxS/sTaPqnuPMjkyn6Q
         mnNQ==
X-Gm-Message-State: APjAAAV/juWbvAI95rBBQXihKPGiUFskuf2hfv3Xg/Gpa0VWm1TRnafp
        YkCcYAgB552rP+Y4YFH8OMs4+I5uxRwIQUFTF+4=
X-Google-Smtp-Source: APXvYqwuZSAeWQwMeMk1LysJrtLB9oRAQbX2X21Hrxxq1r+Rhbl4KR4fwAp6nEa2me6knyZLVnqxpXDIpJtEvZGCJKk=
X-Received: by 2002:a19:c113:: with SMTP id r19mr4161282lff.64.1555613072231;
 Thu, 18 Apr 2019 11:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
In-Reply-To: <20190416192051.GA184889@google.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Thu, 18 Apr 2019 19:44:33 +0100
Message-ID: <CAGLj2rELsr0PUgu41uZX_TKCpT-Q00X+cvgBhJ-U7RU3EBo5tA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, rostedt@goodmis.org,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, surenb@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Nadav Amit <namit@vmware.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:21 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > On 04/11, Joel Fernandes (Google) wrote:
> > >
> > > +static unsigned int proc_tgid_base_poll(struct file *file, struct poll_table_struct *pts)
> > > +{
> > > +   int poll_flags = 0;
> > > +   struct task_struct *task;
> > > +   struct pid *pid;
> > > +
> > > +   task = get_proc_task(file->f_path.dentry->d_inode);
> > > +
> > > +   WARN_ON_ONCE(task && !thread_group_leader(task));
> > > +
> > > +   /*
> > > +    * tasklist_lock must be held because to avoid racing with
> > > +    * changes in exit_state and wake up. Basically to avoid:
> > > +    *
> > > +    * P0: read exit_state = 0
> > > +    * P1: write exit_state = EXIT_DEAD
> > > +    * P1: Do a wake up - wq is empty, so do nothing
> > > +    * P0: Queue for polling - wait forever.
> > > +    */
> > > +   read_lock(&tasklist_lock);
> > > +   if (!task)
> > > +           poll_flags = POLLIN | POLLRDNORM | POLLERR;
> > > +   else if (task->exit_state == EXIT_DEAD)
> > > +           poll_flags = POLLIN | POLLRDNORM;
> > > +   else if (task->exit_state == EXIT_ZOMBIE && thread_group_empty(task))
> > > +           poll_flags = POLLIN | POLLRDNORM;
> > > +
> > > +   if (!poll_flags) {
> > > +           pid = proc_pid(file->f_path.dentry->d_inode);
> > > +           poll_wait(file, &pid->wait_pidfd, pts);
> > > +   }
> >
> > can't understand...
> >
> > Could you explain when it should return POLLIN? When the whole process exits?
>
> It returns POLLIN when the task is dead or doesn't exist anymore, or when it
> is in a zombie state and there's no other thread in the thread group.
>

Would using something other than POLLIN be an option (maybe POLLPRI)?
The convention is to use it to indicate readability on the descriptor,
and also possibly POLLHUP instead of POLLERR (the latter is less of a
problem, but FreeBSD also does the same, so it'd help with some
consistency for libraries wanting to use this, which aren't interested
in other sub states).

>
>  - Joel
>
