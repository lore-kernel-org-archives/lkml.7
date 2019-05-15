Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32890C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052E2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFv0sQvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEOAt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:49:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37113 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:49:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id r10so674978otd.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/1dfnZvzmXyrAvmLqG8QuEKEEuBLjYOpAGmByOmcw20=;
        b=RFv0sQvmISAFd9Ve2FjMlX11/QOSAOV+YV9EFixhjjqagkW5Rl16XKucfQ8FEimzrw
         zWNCH83bLqJ/pEKJDdQLEIygK45lIH4oR1RpCJOyQKYEocfjkblbEkcjFckiHU43oBFo
         EMRq00C5bYAGzoV7CuJKL2kwribUEJikiHcaiO7oGamTgweIULopvfimyI6ECAj9+jij
         E/M5KYjQYi1BcFCnTNsyUTNkGFoll8OdhkkLklO0c2FANIBK+XfMozRecxy6mime+RrI
         B3ssMGSNcSWJXxJmuC+kJ18q40m3lqe24nIAuygz1JeFtXv60+dZPI1NOpbPLViGRhDA
         7/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/1dfnZvzmXyrAvmLqG8QuEKEEuBLjYOpAGmByOmcw20=;
        b=i+oANJ5hXGk3BJeus4LJwmvzn56mWTo14+FveIG9izEdyvGqV2WPiASXM2yC1DsGqM
         kD4W5TESld4ba6a+XW9xTAyfpiox3nYO8DYJ9jhHq65PREwv0plbWvt+sRnnvO9GwuAi
         AdzyTY0PUBa5tzmegvv0RuYIAD7Rvn/hb8EovChqXPLugLG8YUR5y+0ru0TDa6hvvFzk
         JZdBohJHFiCQ1s0y37RZXhhZ5VCaJLtuXfwIySSmrcdGKq6nROj6JSl9Zxxa6EymLM0M
         TOZYxygOwe/LEWNMU2nZsiFfHVl25TU49pJSh6vc0IWz3wff2YtcH95iiurtVNnjtKUi
         pzrQ==
X-Gm-Message-State: APjAAAXH4SbnUSZ+RFCWx3bibN+qJX9GAs0OvwbgdGe5JWdvc8eA5xv0
        UK+eyOT5aAtcoE2mjt85CCmql2CfLeFjv8t5FXs=
X-Google-Smtp-Source: APXvYqzk7v2yFXq2EBQuAvscQ5ewNjVlUAKstnHwHAVlx48z8B9NF1ZYHulrWQGeJcLpHj6vQIs3i5xIW3NdLJvc4I4=
X-Received: by 2002:a9d:458c:: with SMTP id x12mr3117938ote.211.1557881365991;
 Tue, 14 May 2019 17:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190514131654.25463-1-oleksandr@redhat.com> <20190514131654.25463-4-oleksandr@redhat.com>
 <20190514132249.h233crdsz3b7akys@atomlin.usersys.com>
In-Reply-To: <20190514132249.h233crdsz3b7akys@atomlin.usersys.com>
From:   Timofey Titovets <nefelim4ag@gmail.com>
Date:   Wed, 15 May 2019 03:48:50 +0300
Message-ID: <CAGqmi77dtid9M8fZuWimeiWMw8r9Awu579mo8UsaVGTECwxRwA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] mm/ksm: introduce force_madvise knob
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

Reviewed-by: Timofey Titovets <nefelim4ag@gmail.com>

=D0=B2=D1=82, 14 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 16:22, Aaron Tomlin=
 <atomlin@redhat.com>:
>
> On Tue 2019-05-14 15:16 +0200, Oleksandr Natalenko wrote:
> > Present a new sysfs knob to mark task's anonymous memory as mergeable.
> >
> > To force merging task's VMAs, its PID is echoed in a write-only file:
> >
> >    # echo PID > /sys/kernel/mm/ksm/force_madvise
> >
> > Force unmerging is done similarly, but with "minus" sign:
> >
> >    # echo -PID > /sys/kernel/mm/ksm/force_madvise
> >
> > "0" or "-0" can be used to control the current task.
> >
> > To achieve this, previously introduced ksm_enter()/ksm_leave() helpers
> > are used in the "store" handler.
> >
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > ---
> >  mm/ksm.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index e9f3901168bb..22c59fb03d3a 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -2879,10 +2879,77 @@ static void wait_while_offlining(void)
> >
> >  #define KSM_ATTR_RO(_name) \
> >       static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
> > +#define KSM_ATTR_WO(_name) \
> > +     static struct kobj_attribute _name##_attr =3D __ATTR_WO(_name)
> >  #define KSM_ATTR(_name) \
> >       static struct kobj_attribute _name##_attr =3D \
> >               __ATTR(_name, 0644, _name##_show, _name##_store)
> >
> > +static ssize_t force_madvise_store(struct kobject *kobj,
> > +                                  struct kobj_attribute *attr,
> > +                                  const char *buf, size_t count)
> > +{
> > +     int err;
> > +     pid_t pid;
> > +     bool merge =3D true;
> > +     struct task_struct *tsk;
> > +     struct mm_struct *mm;
> > +     struct vm_area_struct *vma;
> > +
> > +     err =3D kstrtoint(buf, 10, &pid);
> > +     if (err)
> > +             return -EINVAL;
> > +
> > +     if (pid < 0) {
> > +             pid =3D abs(pid);
> > +             merge =3D false;
> > +     }
> > +
> > +     if (!pid && *buf =3D=3D '-')
> > +             merge =3D false;
> > +
> > +     rcu_read_lock();
> > +     if (pid) {
> > +             tsk =3D find_task_by_vpid(pid);
> > +             if (!tsk) {
> > +                     err =3D -ESRCH;
> > +                     rcu_read_unlock();
> > +                     goto out;
> > +             }
> > +     } else {
> > +             tsk =3D current;
> > +     }
> > +
> > +     tsk =3D tsk->group_leader;
> > +
> > +     get_task_struct(tsk);
> > +     rcu_read_unlock();
> > +
> > +     mm =3D get_task_mm(tsk);
> > +     if (!mm) {
> > +             err =3D -EINVAL;
> > +             goto out_put_task_struct;
> > +     }
> > +     down_write(&mm->mmap_sem);
> > +     vma =3D mm->mmap;
> > +     while (vma) {
> > +             if (merge)
> > +                     ksm_enter(vma->vm_mm, vma, &vma->vm_flags);
> > +             else
> > +                     ksm_leave(vma, vma->vm_start, vma->vm_end, &vma->=
vm_flags);
> > +             vma =3D vma->vm_next;
> > +     }
> > +     up_write(&mm->mmap_sem);
> > +     mmput(mm);
> > +
> > +out_put_task_struct:
> > +     put_task_struct(tsk);
> > +
> > +out:
> > +     return err ? err : count;
> > +}
> > +KSM_ATTR_WO(force_madvise);
> > +
> >  static ssize_t sleep_millisecs_show(struct kobject *kobj,
> >                                   struct kobj_attribute *attr, char *bu=
f)
> >  {
> > @@ -3185,6 +3252,7 @@ static ssize_t full_scans_show(struct kobject *ko=
bj,
> >  KSM_ATTR_RO(full_scans);
> >
> >  static struct attribute *ksm_attrs[] =3D {
> > +     &force_madvise_attr.attr,
> >       &sleep_millisecs_attr.attr,
> >       &pages_to_scan_attr.attr,
> >       &run_attr.attr,
>
> Looks fine to me.
>
> Reviewed-by: Aaron Tomlin <atomlin@redhat.com>
>
> --
> Aaron Tomlin



--=20
Have a nice day,
Timofey.
