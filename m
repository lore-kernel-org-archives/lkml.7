Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C75FC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706F220862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQIJnd3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEPQKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:10:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35367 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfEPQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:10:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so3975259otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMHMBrMd0YNkJT0fsHTTWNRBFmrV68S4uDG6Stq2kXM=;
        b=oQIJnd3cJFOTGWU+mhqQw5xZ/48tAUVBLW2xsdnHW75CFgSaesak+3DGKJkRVnnlf5
         f7vp8/QSuZL0RRyYca0jxJkcPCNSvi7RRnbKm5rO4uvFQinoZkfWxKegO3545xUKi6Tm
         yDlWfRiGkBs9X7KKIzePsKsJBYU4Mhp9dgLaLpepquR4TXbJgz+SyjP4Cb13IfAyCjJc
         yGAprbbVJ9x317dpUPRsbFj1RHmcJ2iqPoNfYLSKY45Sx4cye8fqfTTAzGmIRMznduug
         6Zyh7c9l0qYmroDn3xiUT/EZlGqq0eanNec/JAobiVm74MfwZM1Br1PUonCZzlOV+vwq
         1QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMHMBrMd0YNkJT0fsHTTWNRBFmrV68S4uDG6Stq2kXM=;
        b=kpnZloqW1GvPmGq4z+zzbJwfBo16ijk9Bi0FjfiqwOtYIKPNBpPP2S0AyAiCcEItBZ
         LBHjFf+gEWRuhF2vcjF4xO5Zi+4aGlDGyvkwKpe6r90zvzpeDLhnq3Iodo0dMPwQPJFX
         YKI5h3USRxdgmw2NW3GEaJuSpZTBGtqillJQjW1BjqlABFhG7S8AHzUQo+cwacnY06Wi
         5EE3D52EJSB7j3eIJW61sHUgBhKh3glDx/d2iOWfpXfunHTOIFJxa5alShg8LcWlz2Ls
         ca8Pvrjjn6pL2nsLKYPs+AMmiXFS+gKEXlg0wRrVh35aD5oY6q6svIxDtHIBHuWZ1YY9
         v0gA==
X-Gm-Message-State: APjAAAVqBuVjTw/0/hnEMYoPUB/QR+50LB7lsnIQL2066f7YG76ak5Js
        Jp1Y9eDneL6DmOCQmBQe1eZ4xGdEUT//sFhLi4yAsQ==
X-Google-Smtp-Source: APXvYqxWTgXDP+q+BEeyCjiZ3kodMX94OZctQK+ZcHZRSQLNXJRMtNIbRJ4iu9fxZKt8FJF85O7xJzJohWCE0aKFlNM=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr6367258otk.183.1558023010974;
 Thu, 16 May 2019 09:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516094234.9116-1-oleksandr@redhat.com> <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
 <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain> <20190516144323.pzkvs6hapf3czorz@butterfly.localdomain>
In-Reply-To: <20190516144323.pzkvs6hapf3czorz@butterfly.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 18:09:44 +0200
Message-ID: <CAG48ez0-ytaDNVa7TiMaa4nR-nMEh_ZgND-sXjiw+RzZFmMqhw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 4:43 PM Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
> On Thu, May 16, 2019 at 04:20:13PM +0200, Oleksandr Natalenko wrote:
> > > [...]
> > > > @@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
> > > >  static ssize_t madvise_write(struct file *file, const char __user *buf,
> > > >                 size_t count, loff_t *ppos)
> > > >  {
> > > > +       /* For now, only KSM hints are implemented */
> > > > +#ifdef CONFIG_KSM
> > > > +       char buffer[PROC_NUMBUF];
> > > > +       int behaviour;
> > > >         struct task_struct *task;
> > > > +       struct mm_struct *mm;
> > > > +       int err = 0;
> > > > +       struct vm_area_struct *vma;
> > > > +
> > > > +       memset(buffer, 0, sizeof(buffer));
> > > > +       if (count > sizeof(buffer) - 1)
> > > > +               count = sizeof(buffer) - 1;
> > > > +       if (copy_from_user(buffer, buf, count))
> > > > +               return -EFAULT;
> > > > +
> > > > +       if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))
> > >
> > > This means that you also match on something like "mergeblah". Just use strcmp().
> >
> > I agree. Just to make it more interesting I must say that
> >
> >    /sys/kernel/mm/transparent_hugepage/enabled
> >
> > uses memcmp in the very same way, and thus echoing "alwaysssss" or
> > "madviseeee" works perfectly there, and it was like that from the very
> > beginning, it seems. Should we fix it, or it became (zomg) a public API?
>
> Actually, maybe, the reason for using memcmp is to handle "echo"
> properly: by default it puts a newline character at the end, so if we use
> just strcmp, echo should be called with -n, otherwise strcmp won't match
> the string.
>
> Huh?

Ah, yes, other code like e.g. proc_setgroups_write() uses strncmp()
and then has an extra check to make sure everything trailing is
whitespace.
