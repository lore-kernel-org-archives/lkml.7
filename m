Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC39DFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866EA21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2OwwEKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394378AbfJPSrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:47:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46829 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394367AbfJPSrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:47:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so21060573oth.13;
        Wed, 16 Oct 2019 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqpn9jLsuGQEqSlT0lMK90g2SEuJLofAVojY6ZnVAuI=;
        b=s2OwwEKREPzFvs+B1awYEV+xH6cuEGMagr8uXdJ1qm2z9qHH7piEkped6uiXrcg/Qm
         NU9RotziDl/4l8PFz9khqLrfTS88mViE5C3FySXmZhSguZqAO/wXTJRW58ZG9IeCQ5Ay
         8ieSwd+3ZTsscxK2IfAidR3S49faEwcUf2MEPME337dQ2EBnVZ6RTCX6ZwdqwE/TNZIl
         sL6m/wd7ET/1e909sENJC6u95fcL5xnxtP3g2HbMOm1+ZNwVL6jTrY/TuiwK4uyxGETS
         4E5/wEQwSg8D4GUscCQFY2TTfZgfzBs4DMibCsOSjxGItOWFpEm0CNb7CY5ndoGxATey
         2Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqpn9jLsuGQEqSlT0lMK90g2SEuJLofAVojY6ZnVAuI=;
        b=hVhXp2rdQSwnVwuEpBmVt10SSTfVA+myX9dff2VDBOUoIsC+YfFhIhtQz/Pc5Vz/Cg
         Nm0CFUzO69GArFuw/4MRlXNMEoa1wPX7Z27xSSUYiFRjiDKETxpgrOqlY0NxFJ5CwOIp
         3CcuBZUqvXn/Ab7mhthvJDGgSfeQ+NvK66svrP3hYgVgLd46IBxV9NJokpYBTvbtQiYE
         RjS12Yh/s9uae397EVzSo5W+i4rn+y2JmCh3Sg32GmlwC7aT2CmptFeELZo6aEupZWko
         tLlfxwia7mlNuj5QsX+IIn4KdYXQXvcGZ9fV1S7yUyclHhPDGqdFXrBX9cb5DqdMhxDj
         oQDQ==
X-Gm-Message-State: APjAAAWRGt2ajFzNvSPt6D/5Y2kIlLBG5bNWxFTmieBTsugr+v32tAmD
        cOrbdsogUmSTtQF9lkiIr1idhkCQVByIGsMlwzM=
X-Google-Smtp-Source: APXvYqyd4YCThm6TrfST/FLSnkCN228UwGx/C4XLZ1NicXfr2rGX7y52xspzcKmLLUP1jsbPM9cPgsLdN6tRee0R+Xk=
X-Received: by 2002:a9d:6c48:: with SMTP id g8mr35712955otq.206.1571251650131;
 Wed, 16 Oct 2019 11:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190531195016.4430-1-albertvaka@gmail.com> <20190531195016.4430-2-albertvaka@gmail.com>
 <20190531170046.ac2b52d8c4923fdeedf943cc@linux-foundation.org> <CAAQViEsp0LjUcgR-at-ufdC7rnWARNBeqjqOSx6r3wJBcQkGiQ@mail.gmail.com>
In-Reply-To: <CAAQViEsp0LjUcgR-at-ufdC7rnWARNBeqjqOSx6r3wJBcQkGiQ@mail.gmail.com>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Wed, 16 Oct 2019 20:47:04 +0200
Message-ID: <CAAQViEtD3x58f7gVq3B1n=nM7BrzfpEFTKXmAZwpPBZ=ntgoyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kernel/ucounts: expose count of inotify watches in use
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rdunlap@infradead.org, mingo@kernel.org, Jan Kara <jack@suse.cz>,
        ebiederm@xmission.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jun 1, 2019 at 8:20 PM Albert Vaca Cintora
<albertvaka@gmail.com> wrote:
>
> On Sat, Jun 1, 2019 at 2:00 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 31 May 2019 21:50:15 +0200 Albert Vaca Cintora <albertvaka@gmail.com> wrote:
> >
> > > Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> > > The handler for this entry is a custom function that ends up calling
> > > proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
> > > and it gets mounted under /proc/sys/user/.
> > >
> > > Inotify watches are a finite resource, in a similar way to available file
> > > descriptors. The motivation for this patch is to be able to set up
> > > monitoring and alerting before an application starts failing because
> > > it runs out of inotify watches.
> > >
> > > ...
> > >
> > > --- a/kernel/ucount.c
> > > +++ b/kernel/ucount.c
> > > @@ -118,6 +118,26 @@ static void put_ucounts(struct ucounts *ucounts)
> > >       kfree(ucounts);
> > >  }
> > >
> > > +#ifdef CONFIG_INOTIFY_USER
> > > +int proc_read_inotify_watches(struct ctl_table *table, int write,
> > > +                  void __user *buffer, size_t *lenp, loff_t *ppos)
> > > +{
> > > +     struct ucounts *ucounts;
> > > +     struct ctl_table fake_table;
> >
> > hmm.
> >
> > > +     int count = -1;
> > > +
> > > +     ucounts = get_ucounts(current_user_ns(), current_euid());
> > > +     if (ucounts != NULL) {
> > > +             count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
> > > +             put_ucounts(ucounts);
> > > +     }
> > > +
> > > +     fake_table.data = &count;
> > > +     fake_table.maxlen = sizeof(count);
> > > +     return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
> >
> > proc_dointvec
> > ->do_proc_dointvec
> >   ->__do_proc_dointvec
> >     ->proc_first_pos_non_zero_ignore
> >       ->warn_sysctl_write
> >         ->pr_warn_once(..., table->procname)
> >
> > and I think ->procname is uninitialized.
> >
> > That's from a cursory check.  Perhaps other uninitialized members of
> > fake_table are accessed, dunno.
> >
> > we could do
> >
> >         {
> >                 struct ctl_table fake_table = {
> >                         .data = &count,
> >                         .maxlen = sizeof(count),
> >                 };
> >
> >                 return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
> >         }
> >
> > or whatever.  That will cause the pr_warn_once to print "(null)" but
> > that's OK I guess.
> >
> > Are there other places in the kernel which do this temp ctl_table
> > trick?  If so, what do they do?  If not, what is special about this
> > code?
> >
> >
>
> I copied this 'fake_table' trick from proc_do_entropy in
> drivers/char/random.c exactly as it is. It is also used in other
> places with slight variations.
>
> Note that, since we are creating a read-only proc file,
> proc_first_pos_non_zero_ignore is not called from __do_proc_dointvec,
> so the uninitialized ->procname is not accessed.
>

Friendly ping. I think the code is correct as it is for the reasons
explained above.

Best regards,
Albert
