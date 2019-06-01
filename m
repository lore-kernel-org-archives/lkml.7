Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAAC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED7B275E5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNxIuFfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFASUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:20:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46547 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFASUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:20:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id 203so10088661oid.13;
        Sat, 01 Jun 2019 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWx6MQzQE4d9FxjAfU5qOJWaQtdEeoEO6IrZ5ikxpno=;
        b=aNxIuFfRRjc9d3Qb8Ag45l/A5tMmew8xu11x18kJaZzAVT9AJuXg6LP+qTVx8ZrZjC
         P0VkkQM2nQkQsXytM4Lps3bR70t4fPeAjP1Xl9jdgbmWoxRIt6HRdKlDDaVS0RgXXrYo
         dSs1CNFw+FAWQ62wj3PgHZ5MsT6qois2/Dw+EgCIaECgCPsycxkHftvZBRDTI+qV/hQV
         VhK72+NTxXrPeOsaVkDIlhQ+8t6Q2Y84HB/KG3Ti9Wl6FKfAnY7qxxxKZVZjvuWk+KBP
         Ox5vw4AmVGvrJ69BYAK8hmytjP2ohPqvADAWsaG4LFm8nAc50uvgJWrmj4mAKyGIQRmR
         N2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWx6MQzQE4d9FxjAfU5qOJWaQtdEeoEO6IrZ5ikxpno=;
        b=OBkehScHGRq5Fl3ZIM3uz9WTejPbm2v2t905gzXQ7eFZtEwRfY3ifnF2OsZwor/YZH
         BTnAKgr1j+gQMF1ClQ3Cij7TpPjryqtj6nGddMxf4/bHwIGGjTzQPkYwzk4W+sWSlfyb
         gQhvbLICRKaVmpgAD5D4s1wKMcI3bhJHhEGXCPp6n72C9whaSwBi43J0c59oVGNm8DLw
         MpoYwj5KCaigHZ66UVMzuSq0wFpjnKngDF7/n92aEtmO2nuW81zvPrDHtrLixCwgfWxf
         Hin15msby37vcjZAJ/VMJml6ECtjApo+0S0G0+qKogtlLlg5PUi7YWOKlXdjRXWM3XzT
         IbvA==
X-Gm-Message-State: APjAAAUpS3jqFKmRE+PEfzUVB2gC5cWY/6xpd4v39OTI95SMckzT25/a
        7uunWR4TMKEcoNfrso6oenp+09NPVZhxtf9oZ4g=
X-Google-Smtp-Source: APXvYqyzvEpxKsWc6IPayUJ5FA7GW4m5iwr8d/uYNF5XWg4sgOiEfQxMUpXPiuj2+Cl6ae9saYw/C+offW50sOMQV4s=
X-Received: by 2002:aca:5416:: with SMTP id i22mr2804277oib.103.1559413231407;
 Sat, 01 Jun 2019 11:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190531195016.4430-1-albertvaka@gmail.com> <20190531195016.4430-2-albertvaka@gmail.com>
 <20190531170046.ac2b52d8c4923fdeedf943cc@linux-foundation.org>
In-Reply-To: <20190531170046.ac2b52d8c4923fdeedf943cc@linux-foundation.org>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Sat, 1 Jun 2019 20:20:05 +0200
Message-ID: <CAAQViEsp0LjUcgR-at-ufdC7rnWARNBeqjqOSx6r3wJBcQkGiQ@mail.gmail.com>
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

On Sat, Jun 1, 2019 at 2:00 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 31 May 2019 21:50:15 +0200 Albert Vaca Cintora <albertvaka@gmail.com> wrote:
>
> > Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> > The handler for this entry is a custom function that ends up calling
> > proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
> > and it gets mounted under /proc/sys/user/.
> >
> > Inotify watches are a finite resource, in a similar way to available file
> > descriptors. The motivation for this patch is to be able to set up
> > monitoring and alerting before an application starts failing because
> > it runs out of inotify watches.
> >
> > ...
> >
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -118,6 +118,26 @@ static void put_ucounts(struct ucounts *ucounts)
> >       kfree(ucounts);
> >  }
> >
> > +#ifdef CONFIG_INOTIFY_USER
> > +int proc_read_inotify_watches(struct ctl_table *table, int write,
> > +                  void __user *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +     struct ucounts *ucounts;
> > +     struct ctl_table fake_table;
>
> hmm.
>
> > +     int count = -1;
> > +
> > +     ucounts = get_ucounts(current_user_ns(), current_euid());
> > +     if (ucounts != NULL) {
> > +             count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
> > +             put_ucounts(ucounts);
> > +     }
> > +
> > +     fake_table.data = &count;
> > +     fake_table.maxlen = sizeof(count);
> > +     return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
>
> proc_dointvec
> ->do_proc_dointvec
>   ->__do_proc_dointvec
>     ->proc_first_pos_non_zero_ignore
>       ->warn_sysctl_write
>         ->pr_warn_once(..., table->procname)
>
> and I think ->procname is uninitialized.
>
> That's from a cursory check.  Perhaps other uninitialized members of
> fake_table are accessed, dunno.
>
> we could do
>
>         {
>                 struct ctl_table fake_table = {
>                         .data = &count,
>                         .maxlen = sizeof(count),
>                 };
>
>                 return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
>         }
>
> or whatever.  That will cause the pr_warn_once to print "(null)" but
> that's OK I guess.
>
> Are there other places in the kernel which do this temp ctl_table
> trick?  If so, what do they do?  If not, what is special about this
> code?
>
>

I copied this 'fake_table' trick from proc_do_entropy in
drivers/char/random.c exactly as it is. It is also used in other
places with slight variations.

Note that, since we are creating a read-only proc file,
proc_first_pos_non_zero_ignore is not called from __do_proc_dointvec,
so the uninitialized ->procname is not accessed.

Albert
