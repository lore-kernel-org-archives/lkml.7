Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA5AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ/gZaik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDZNdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:33:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44077 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:33:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id d24so2602331otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tej5jESshTVv0aym01xqA2/I/b4wPINcqNXZwVn3us=;
        b=uQ/gZaikg/ajGneKizm6XgTmI0RD3bZasUlUCaqWvuv3O3tS8ZBfFwf33o0Asl/OOW
         seIqin7ynG3eEUvz0Znn9051GpjNVUvGNQ4mDDKShussZxDy9ruJPQOn6Wz7Fh/oNUCi
         xcgG6LhZ1nmD1xNwu1JVjfI7BasXG9tB9BEP2O508BRfjJwX12FOnK6RJt1sl003DSbA
         f562iu6AqopYyCpnmBjH17DUhjnRAcl76yE8X9WpHXz9aiZzr289L6lPKyiE2vuogHi9
         klzE2XIKl+uBsNXlRksrkMYWQGfJ6Ptygkf6NRc5BXdhFsW8P4qLsAvn1JgZT4L0i/Co
         BC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tej5jESshTVv0aym01xqA2/I/b4wPINcqNXZwVn3us=;
        b=T/ng5PcwtzvOP3xyJSbWBcU11pRaj6TVYywlSqWf/PkAoCq6LxyZsWO1sbyhuy4OA+
         0zjEoG91S3l9yfX8MF0XNGv4So2Q/qPiydv/x3eFiG21j1SHpnEWEfZL5e7KDHtpBhXK
         zB+qZuFLgcbMW4CUiNrUSZgQNIuvTU+n5PFjgO3CQWmRDB7UAn3MIS46nwJ67kYdDja4
         ctMqUC5nhHOINanCpSUORkb8F491iBKXRaMfRQBQrFWwJH3KylQXa7L4KPH5dWGI+Dzf
         6vS9CMa2gbVj9oxRgw2YM5Lx+B7Ddy5YAT5oJTz06Bp7XfVb++nv+xMlMmuL6VmhwZUA
         V1Nw==
X-Gm-Message-State: APjAAAWz0ABWIP0o47wFJHQN9C8r3DRt+8ylgO5CovslMBLvoSb13Ri8
        KUtSHOPJsgnj/8zo4BsqqTFypasPYGCGhvUPsCRA4Q==
X-Google-Smtp-Source: APXvYqzss1Tgb5LK8ctZch+oggVhP88l0MqGw69vrusNMhysIF2cuvTumrXqJyUZE73hrMa6+hA57OM79yEn6XWqevI=
X-Received: by 2002:a9d:7a54:: with SMTP id z20mr1752200otm.230.1556285631958;
 Fri, 26 Apr 2019 06:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com> <20190425121410.GC1144@dhcp22.suse.cz>
 <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com> <20190426053135.GC12337@dhcp22.suse.cz>
In-Reply-To: <20190426053135.GC12337@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 26 Apr 2019 15:33:25 +0200
Message-ID: <CAG48ez1MGyAd5tE=JLmjkFqou-VvsQHcJ5TU5f8_L43km9eoYA@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 7:31 AM Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 25-04-19 14:42:52, Jann Horn wrote:
> > On Thu, Apr 25, 2019 at 2:14 PM Michal Hocko <mhocko@kernel.org> wrote:
> > [...]
> > > On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> > > > From: Matthew Garrett <mjg59@google.com>
> > > >
> > > > Applications that hold secrets and wish to avoid them leaking can use
> > > > mlock() to prevent the page from being pushed out to swap and
> > > > MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> > > > can also use atexit() handlers to overwrite secrets on application exit.
> > > > However, if an attacker can reboot the system into another OS, they can
> > > > dump the contents of RAM and extract secrets. We can avoid this by setting
> > > > CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
> > > > firmware wipe the contents of RAM before booting another OS, but this means
> > > > rebooting takes a *long* time - the expected behaviour is for a clean
> > > > shutdown to remove the request after scrubbing secrets from RAM in order to
> > > > avoid this.
> > > >
> > > > Unfortunately, if an application exits uncleanly, its secrets may still be
> > > > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > > > killer decides to kill a process holding secrets, we're not going to be able
> > > > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > > > to request that the kernel clear the covered pages whenever the page
> > > > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > > > will only work on 64-bit systems.
> > [...]
> > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > index 21a7881a2db4..989c2fde15cf 100644
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -92,6 +92,22 @@ static long madvise_behavior(struct vm_area_struct *vma,
> > > >       case MADV_KEEPONFORK:
> > > >               new_flags &= ~VM_WIPEONFORK;
> > > >               break;
> > > > +     case MADV_WIPEONRELEASE:
> > > > +             /* MADV_WIPEONRELEASE is only supported on anonymous memory. */
> > > > +             if (VM_WIPEONRELEASE == 0 || vma->vm_file ||
> > > > +                 vma->vm_flags & VM_SHARED) {
> > > > +                     error = -EINVAL;
> > > > +                     goto out;
> > > > +             }
> > > > +             new_flags |= VM_WIPEONRELEASE;
> > > > +             break;
> >
> > An interesting effect of this is that it will be possible to set this
> > on a CoW anon VMA in a fork() child, and then the semantics in the
> > parent will be subtly different - e.g. if the parent vmsplice()d a
> > CoWed page into a pipe, then forked an unprivileged child, the child
>
> Maybe a stupid question. How do you fork an unprivileged child (without
> exec)? Child would have to drop priviledges on its own, no?

Sorry, yes, that's what I meant.
