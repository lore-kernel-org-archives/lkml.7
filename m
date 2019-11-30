Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D66C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4452075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBo+ojo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfK3NpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 08:45:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45331 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfK3NpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 08:45:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so24538719lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EX4Yje1/DqSKTDoH2ZOXvXZz8HHNkGdgnUsG/hOKdBw=;
        b=LBo+ojo5F0qFie+DSdwph9KLg/o3L7MwcHZlKwFmgJev7vHe1yPc5GNfJAfvPYzRFP
         /QwdYwpfx+aiYOh970+jo4hXH2lYVMpel3gU+DHFjlotq9HIbNZizAULaBsQys6G8dws
         gZv5FoeQvDtlY4P5wN1yN5Q2F/Bn/qYwdi/zpx2TPfICYcsbdVucTdTzGHdBTl1a+aC7
         VBz7/TnxIM/hbxRtxB1O1fJpLRga1/qi8gwAyRsaVt9J0XgO02dO4JDZk/tFzAfvkkmG
         liZYdkxJMt+F9fIEEuKpnqnMJr1yOu/QQVUzpsMj1oiib/nTNG9lvCI67L3xGM1WqgwT
         REKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EX4Yje1/DqSKTDoH2ZOXvXZz8HHNkGdgnUsG/hOKdBw=;
        b=gV5iDuW76YIREOvqi575IFiL1MiVvYw6cqMlx6K0TSPBzaO4xSBEGvJyLM2j0BOlYu
         JJhcaBJZRaHm9YVGiA/Rmp2mRLp1SoZg4KCnqPFhYm6U1co2dB1+W2mqP6blsGLEMBpP
         mgLjy65G+GmD5EGgBmGWkiYDTSwodIz4FRwnULXQztXn+7p4IpJGVRnt1NwY+x4iTuBu
         xc5OGxjVe0WVyu3sD+UwWkexij7UxNhwpvcrmmuX54FQRagP4WFJ92+AW5HKFdAoyg88
         cGLwCf28czysCPVur5ptW0MwW+rTeOX80DsF9OlzdEKbq7QF26DeMljgyg7lY/BGF/rK
         YYhg==
X-Gm-Message-State: APjAAAV6Wh/YxhrO2pqELZTgLtyjEMEAqTzDqG/WfpFbMS4Eu/GEfxRQ
        iSnYn3nRt2d7EFX4Xi/pPMME1CSKQnA=
X-Google-Smtp-Source: APXvYqwffFXBV9levaCaoyAjZ6N3Xlb4xld38P9iySjZzBogdDca34FfBCP1vIsuhp7sEPVvV8yrzw==
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr11141071lfp.88.1575121504733;
        Sat, 30 Nov 2019 05:45:04 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a18sm11758745ljp.33.2019.11.30.05.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 05:45:03 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 30 Nov 2019 14:44:55 +0100
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>,
        Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: sleeping function called from invalid context in
 __alloc_pages_nodemask
Message-ID: <20191130134455.GA27399@pc636>
References: <000000000000c280ba05988b6242@google.com>
 <CACT4Y+Z_E8tNtt5y4r_Sp+dWDjxundr4vor9DYxDr8FNj5U90A@mail.gmail.com>
 <77abfacd-cfd0-5a8d-4af7-e5847fb4e03a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77abfacd-cfd0-5a8d-4af7-e5847fb4e03a@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 09:48:34PM +0900, Tetsuo Handa wrote:
> On 2019/11/30 16:57, Dmitry Vyukov wrote:
> > On Sat, Nov 30, 2019 at 8:35 AM syzbot
> > <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    419593da Add linux-next specific files for 20191129
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12cc369ce00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com
> > 
> > +Daniel, kasan-dev
> > This is presumably from the new CONFIG_KASAN_VMALLOC
> 
> Well, this is because
> 
> commit d005e4cdb2307f63b5ce5cb359964c5a72d95790
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Nov 19 11:45:23 2019 +1100
> 
>     mm/vmalloc: rework vmap_area_lock
> 
> @@ -3363,29 +3369,38 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>                 va = vas[area];
>                 va->va_start = start;
>                 va->va_end = start + size;
> -
> -               insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>         }
> 
> -       spin_unlock(&vmap_area_lock);
> +       spin_unlock(&free_vmap_area_lock);
> 
>         /* insert all vm's */
> -       for (area = 0; area < nr_vms; area++)
> -               setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
> +       spin_lock(&vmap_area_lock);
> +       for (area = 0; area < nr_vms; area++) {
> +               insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
> +
> +               setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
>                                  pcpu_get_vm_areas);
> +       }
> +       spin_unlock(&vmap_area_lock);
> 
>         kfree(vas);
>         return vms;
> 
> made the iteration atomic context while
> 
> commit 1800fa0a084c60a600be0cc43fc657ba5609fdda
> Author: Daniel Axtens <dja@axtens.net>
> Date:   Tue Nov 19 11:45:23 2019 +1100
> 
>     kasan: support backing vmalloc space with real shadow memory
> 
> @@ -3380,6 +3414,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> 
>                 setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
>                                  pcpu_get_vm_areas);
> +
> +               /* assume success here */
> +               kasan_populate_vmalloc(sizes[area], vms[area]);
>         }
>         spin_unlock(&vmap_area_lock);
> 
> tried to do sleeping allocation inside the iteration.
There was a patch that fixes an attempt of "sleeping allocation" under
the spinlock from Daniel:

https://lkml.org/lkml/2019/11/20/22

--
Vlad Rezki
