Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A52C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AED216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed48aOZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbfHFOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:54:13 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38810 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732024AbfHFOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:54:13 -0400
Received: by mail-ua1-f66.google.com with SMTP id j2so6945253uaq.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uvULGp1ehQoSmPrEiVP/M3/oGZ8fYVuLJ335Bn5PpFs=;
        b=Ed48aOZ5j6nT/dtVv/GAtNCJDj2Y6SOrZ2m2P4e9bDvOTXYQMeUqvTPD8JihOCTORa
         /irekEVryct63qTQoaOdrZdqdexMEEryJ1tUPZLExH9sUib/KKJpVAXtXlxcjF38UjfL
         arMW1RzMRYKMtERM0yAO+D1t3ruRuqrOO0P+qbrTTdXfkTcYkIZoa4qnAtBWJ/5mrsUq
         O1wE4S+RxSLNF7JBi2vvXr05Rlkqagf2aCTNp/3HyNxvyw07Nq1wqHnvniTI5PQhZuNk
         2hfsZ5KFsxcSMKUFp7/ij2bAwOtu8FDlzyMYvSWDifkcoh5eQoJVD9ubHFeIJ6bc0c2m
         bBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uvULGp1ehQoSmPrEiVP/M3/oGZ8fYVuLJ335Bn5PpFs=;
        b=XjoDEpW06dsP5Y3VD4D/pzdlU9V5xn1q4iSadNOTLjBmYDedVdZzk/qCtPmFMWL6Cy
         +ABoqxbaYAVabC1aO5wQMLeS45CEOCDiiRLS8ne1uIwk5hf3d5HDmONYWMqdhZdXD0Zu
         GXeTKMwIQkkA6Y8I0CJqn0exy4FCtUFPjj1iZlHFj67iFreVZTq48E+GM5yfJ5oaVhuf
         MbUvaEl3ULtIisPOSrRGcPHX7IbAZ/DUEvJTJ7i2P0uaFeh1NhOxEkTLnJahZWy1uVwT
         ashfW0mSuUv5Jhad93n9PTeUCAv6ogKykqbwa1Vk8tiPF8f6k1+84I0dI/AukZxMw7fO
         SoOQ==
X-Gm-Message-State: APjAAAW+T5Kd99FFZPR4flzVHBwnGQLwhJ3LrowtFaA/NvzRBFjZf5+s
        6wvl4nHj0v5oyxpaMVbeBQWOjXc3ASZog8KD3tM=
X-Google-Smtp-Source: APXvYqz5RlQpnTg5vbJ7r6mVEyHAMw9NN6Rt/D5U956sQumpAHTHPDXJBO8i7kxg6dL/LfyJV+S4wmwy06f68hNOEH4=
X-Received: by 2002:ab0:208c:: with SMTP id r12mr2400372uak.27.1565103252167;
 Tue, 06 Aug 2019 07:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
 <20190805112437.GF7597@dhcp22.suse.cz> <0821a17d-1703-1b82-d850-30455e19e0c1@suse.cz>
 <20190805120525.GL7597@dhcp22.suse.cz> <CACDBo562xHy6McF5KRq3yngKqAm4a15FFKgbWkCTGQZ0pnJWgw@mail.gmail.com>
 <20190805201650.GT7597@dhcp22.suse.cz>
In-Reply-To: <20190805201650.GT7597@dhcp22.suse.cz>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Tue, 6 Aug 2019 20:24:03 +0530
Message-ID: <CACDBo54kBy_YBcXBzs1dOxQRg+TKFQox_aqqtB2dvL+mmusDVg@mail.gmail.com>
Subject: Re: oom-killer
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pankaj.suryawanshi@einfochips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug, 2019, 1:46 AM Michal Hocko, <mhocko@kernel.org> wrote:
>
> On Mon 05-08-19 21:04:53, Pankaj Suryawanshi wrote:
> > On Mon, Aug 5, 2019 at 5:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 05-08-19 13:56:20, Vlastimil Babka wrote:
> > > > On 8/5/19 1:24 PM, Michal Hocko wrote:
> > > > >> [  727.954355] CPU: 0 PID: 56 Comm: kworker/u8:2 Tainted: P     =
      O  4.14.65 #606
> > > > > [...]
> > > > >> [  728.029390] [<c034a094>] (oom_kill_process) from [<c034af24>]=
 (out_of_memory+0x140/0x368)
> > > > >> [  728.037569]  r10:00000001 r9:c12169bc r8:00000041 r7:c121e680=
 r6:c1216588 r5:dd347d7c > [  728.045392]  r4:d5737080
> > > > >> [  728.047929] [<c034ade4>] (out_of_memory) from [<c03519ac>]  (=
__alloc_pages_nodemask+0x1178/0x124c)
> > > > >> [  728.056798]  r7:c141e7d0 r6:c12166a4 r5:00000000 r4:00001155
> > > > >> [  728.062460] [<c0350834>] (__alloc_pages_nodemask) from [<c021=
e9d4>] (copy_process.part.5+0x114/0x1a28)
> > > > >> [  728.071764]  r10:00000000 r9:dd358000 r8:00000000 r7:c1447e08=
 r6:c1216588 r5:00808111
> > > > >> [  728.079587]  r4:d1063c00
> > > > >> [  728.082119] [<c021e8c0>] (copy_process.part.5) from [<c022047=
0>] (_do_fork+0xd0/0x464)
> > > > >> [  728.090034]  r10:00000000 r9:00000000 r8:dd008400 r7:00000000=
 r6:c1216588 r5:d2d58ac0
> > > > >> [  728.097857]  r4:00808111
> > > > >
> > > > > The call trace tells that this is a fork (of a usermodhlper but t=
hat is
> > > > > not all that important.
> > > > > [...]
> > > > >> [  728.260031] DMA free:17960kB min:16384kB low:25664kB high:297=
60kB active_anon:3556kB inactive_anon:0kB active_file:280kB inactive_file:2=
8kB unevictable:0kB writepending:0kB present:458752kB managed:422896kB mloc=
ked:0kB kernel_stack:6496kB pagetables:9904kB bounce:0kB free_pcp:348kB loc=
al_pcp:0kB free_cma:0kB
> > > > >> [  728.287402] lowmem_reserve[]: 0 0 579 579
> > > > >
> > > > > So this is the only usable zone and you are close to the min wate=
rmark
> > > > > which means that your system is under a serious memory pressure b=
ut not
> > > > > yet under OOM for order-0 request. The situation is not great tho=
ugh
> > > >
> > > > Looking at lowmem_reserve above, wonder if 579 applies here? What d=
oes
> > > > /proc/zoneinfo say?
> >
> >
> > What is  lowmem_reserve[]: 0 0 579 579 ?
>
> This controls how much of memory from a lower zone you might an
> allocation request for a higher zone consume. E.g. __GFP_HIGHMEM is
> allowed to use both lowmem and highmem zones. It is preferable to use
> highmem zone because other requests are not allowed to use it.
>
> Please see __zone_watermark_ok for more details.
>
>
> > > This is GFP_KERNEL request essentially so there shouldn't be any lowm=
em
> > > reserve here, no?
> >
> >
> > Why only low 1G is accessible by kernel in 32-bit system ?


1G ivirtual or physical memory (I have 2GB of RAM) ?
>
>
> https://www.kernel.org/doc/gorman/, https://lwn.net/Articles/75174/
> and many more articles. In very short, the 32b virtual address space
> is quite small and it has to cover both the users space and the
> kernel. That is why we do split it into 3G reserved for userspace and 1G
> for kernel. Kernel can only access its 1G portion directly everything
> else has to be mapped explicitly (e.g. while data is copied).
> Thanks Michal.


>
> > My system configuration is :-
> > 3G/1G - vmsplit
> > vmalloc =3D 480M (I think vmalloc size will set your highmem ?)
>
> No, vmalloc is part of the 1GB kernel adress space.

I read in one article , vmalloc end is fixed if you increase vmalloc
size it decrease highmem. ?
Total =3D lowmem + (vmalloc + high mem)
>
>
> --
> Michal Hocko
> SUSE Labs
