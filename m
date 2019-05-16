Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60574C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B482087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6xNrQHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfEPQGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:06:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39881 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEPQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:06:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id r7so3941084otn.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4VKFuY3dBhk8M0E31KTPJJ8MMHDVcscAUiCzod5h4g=;
        b=H6xNrQHksO0mY+GD8TjSIB/dl7gXte6ptfd1KwGU7WS9fv6i/tgp5PRwV1QwuOcLn8
         EQgegFWR1awHjfSGP4+gjgXMyl3Gl62XXSb7Mm7Nf1RXzKuaEetJoPJs6GSuS0KBL9vl
         Wub95qd5nDDIuDpLobcQrJAeLZp5nVs+LMne3mcxV43wLSgIfXzXurgIQYOiBUs8VKq4
         KUB/9oEuCvZV97lXvc2ABvfckVlCEpI9+rGFlz3y2hfmc98QPPAyHhjTuVHOdOUM3Bkm
         UOJay+FnLHdEk6rocRtjzEXrvs47hR0q26+/2U1SS5+d0iEBJ8VXwWGOZJ51SarUWMvq
         4fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4VKFuY3dBhk8M0E31KTPJJ8MMHDVcscAUiCzod5h4g=;
        b=JzoVi0XfxsNFw3eYEtngySwsr7a4VN1ndM36p4JN3Db+NB30Ca41Z1YwOhUEGybG7K
         0HMMlTzlsVQxiCG50bKjSxvgrKrAXC2glHjV949rv5N0TWPXbn4fR1PB3Fxu0kdXnmfV
         5suBo6+4rDvHuUYTveN0WhrQtmAEtwU6FSf2NWa2rwhIaX1xoDnBzPNfFBF+AXFYY1zz
         Hjd/Q47hLvqf8YgO18u4eFtpZWkIBEepwT5d32x//UE7NyjmGxZpstYTeFhQ/oc4ZISK
         2ZBDTVLlGbUk9j09jUMlSeFotpexEcDRxLIEtECysnPCDpaDfEDi4SANLYuavpNEKhU2
         qntw==
X-Gm-Message-State: APjAAAUGi+i9my2BO793rnrVeCIFblTqzhsTumMwrmIK6PYFkEZszIOx
        lZljSJ79cP00h3yYqLlpGnr95A0sSLX+c9jxz4QTbw==
X-Google-Smtp-Source: APXvYqzler3soQWaPkgJTqHADqwjhXm5FObYmA+iecGHRrkmAWqb4Fk8pHSH7Qj3lDCx4Ml5SA54wKgEPHxudDIXDq4=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr6353382otk.183.1558022810319;
 Thu, 16 May 2019 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190516094234.9116-1-oleksandr@redhat.com> <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com> <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
In-Reply-To: <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 18:06:24 +0200
Message-ID: <CAG48ez0teQk+rVnRmr=xcM8PJ_8UZC3hSi7PABx-qunz+5=DGg@mail.gmail.com>
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

On Thu, May 16, 2019 at 4:20 PM Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
> On Thu, May 16, 2019 at 12:00:24PM +0200, Jann Horn wrote:
> > On Thu, May 16, 2019 at 11:43 AM Oleksandr Natalenko
> > <oleksandr@redhat.com> wrote:
> > > Use previously introduced remote madvise knob to mark task's
> > > anonymous memory as mergeable.
> > >
> > > To force merging task's VMAs, "merge" hint is used:
> > >
> > >    # echo merge > /proc/<pid>/madvise
> > >
> > > Force unmerging is done similarly:
> > >
> > >    # echo unmerge > /proc/<pid>/madvise
> > >
> > > To achieve this, previously introduced ksm_madvise_*() helpers
> > > are used.
> >
> > Why does this not require PTRACE_MODE_ATTACH_FSCREDS to the target
> > process? Enabling KSM on another process is hazardous because it
> > significantly increases the attack surface for side channels.
> >
> > (Note that if you change this to require PTRACE_MODE_ATTACH_FSCREDS,
> > you'll want to use mm_access() in the ->open handler and drop the mm
> > in ->release. mm_access() from a ->write handler is not permitted.)
>
> Sounds reasonable. So, something similar to what mem_open() & friends do
> now:
>
> static int madvise_open(...)
> ...
>         struct task_struct *task = get_proc_task(inode);
> ...
>         if (task) {
>                 mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
>                 put_task_struct(task);
>                 if (!IS_ERR_OR_NULL(mm)) {
>                         mmgrab(mm);
>                         mmput(mm);
> ...
>
> Then:
>
> static ssize_t madvise_write(...)
> ...
>         if (!mmget_not_zero(mm))
>                 goto out;
>
>         down_write(&mm->mmap_sem);
>         if (!mmget_still_valid(mm))
>                 goto skip_mm;
> ...
> skip_mm:
>         up_write(&mm->mmap_sem);
>
>         mmput(mm);
> out:
>         return ...;
>
> And, finally:
>
> static int madvise_release(...)
> ...
>                 mmdrop(mm);
> ...
>
> Right?

Yeah, that looks reasonable.
