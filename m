Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8DC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2725E2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJiWydjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfJDN7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:59:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfJDN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:59:05 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so13745353iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEWV9BhBdurpPqvh7FtS6h4jnWtzbMLEuK0kv71xj8c=;
        b=aJiWydjKnntivyzs2i2J3vj6LJmpwv4UabJT55mvn74jjjR/yXPzbUnTg+M1rbIM7m
         Ut//ecuCcDZiLZSr141Qhu22YtpFN/0/THkYoffjgnUxUKsQ6a2H0HKnWiddV1wlO/Ga
         eavLiC9O5RfnvzaBH367+z8FYp5XWsG1xi20xXCJaMYeDTylPW9vGJnQhYNcXjwtASjX
         jCXTK0gyKIoQpkN0j57KIMdSWJjGTr1yW67an3hYju7XMl+EGY/ADHcI/orgHGs8Llp7
         cDwIzSMGhHbYRHSU2p/n1FP2dYKFX5FaLgTa5QmHY7s8cgDlqMigbnII4hV8c3sfgSkR
         CbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEWV9BhBdurpPqvh7FtS6h4jnWtzbMLEuK0kv71xj8c=;
        b=t8FQf+rH4OW9q3AJ9MPLpxSRUjnQiEY2kszzWeEm/yNEz23MGWWQKoAtIrAEmtzRVH
         kuxKaLG2Ux1Kml/8HvyaM2eI76InIgFmCs004CYDjARJN7+OjcZBsdJx16QAOsM3McwS
         BxulOW1pvWRwpHecSXc6Og+8VpaI1EMgYJCZTOuoHdQFqNA0D2j3Ncy7hJOnQHeJMe7m
         7nKszaoCNUsVsoF0Q1zSpzkA0Y77wFhfzl4OugwnXfgoIJpyqZo8a08e0jgczE0PxtrM
         NGdtJs5ZHpbfgUDOTAmWuVcMA/aZoZYfgdwEZqUSov7jizkVNJaofqh4yrV7kDN/V/Ap
         Jkiw==
X-Gm-Message-State: APjAAAXbqhEhSrATgl+rrqvgFriBIG2DbVh/PnEv+rH7MuQuwp9NMLpg
        OLnzl5w5zw52s6uiODl53jXPPtKyqAtLNOcJcv4=
X-Google-Smtp-Source: APXvYqzxOYvd5zFEclXdsUmbY63Ktx5ijrpM0Rt5lg+zvqDaDW540phh1l5LkoN7zsDs7OSoPpDYsQMvJzKy8gQbioY=
X-Received: by 2002:a92:3314:: with SMTP id a20mr15204996ilf.276.1570197544161;
 Fri, 04 Oct 2019 06:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190926160433.GD32311@linux.ibm.com> <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
 <20190928073331.GA5269@linux.ibm.com> <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
 <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
 <20191002073605.GA30433@linux.ibm.com> <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
 <20191003053451.GA23397@linux.ibm.com> <20191003084914.GV25745@shell.armlinux.org.uk>
 <20191003113010.GC23397@linux.ibm.com> <20191004092727.GX25745@shell.armlinux.org.uk>
 <bc05540f2aa46cff5d6239faab83446401ba7b5f.camel@pengutronix.de>
In-Reply-To: <bc05540f2aa46cff5d6239faab83446401ba7b5f.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 4 Oct 2019 08:58:52 -0500
Message-ID: <CAHCN7xKgoMBxzwC03obFsoXS18yYHcikNaKFU40J=hYo_yUVDw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 8:23 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 04.10.2019, 10:27 +0100 schrieb Russell King - ARM
> Linux admin:
> > On Thu, Oct 03, 2019 at 02:30:10PM +0300, Mike Rapoport wrote:
> > > On Thu, Oct 03, 2019 at 09:49:14AM +0100, Russell King - ARM Linux
> > > admin wrote:
> > > > On Thu, Oct 03, 2019 at 08:34:52AM +0300, Mike Rapoport wrote:
> > > > > (trimmed the CC)
> > > > >
> > > > > On Wed, Oct 02, 2019 at 06:14:11AM -0500, Adam Ford wrote:
> > > > > > On Wed, Oct 2, 2019 at 2:36 AM Mike Rapoport <
> > > > > > rppt@linux.ibm.com> wrote:
> > > > > >
> > > > > > Before the patch:
> > > > > >
> > > > > > # cat /sys/kernel/debug/memblock/memory
> > > > > >    0: 0x10000000..0x8fffffff
> > > > > > # cat /sys/kernel/debug/memblock/reserved
> > > > > >    0: 0x10004000..0x10007fff
> > > > > >   34: 0x2fffff88..0x3fffffff
> > > > > >
> > > > > >
> > > > > > After the patch:
> > > > > > # cat /sys/kernel/debug/memblock/memory
> > > > > >    0: 0x10000000..0x8fffffff
> > > > > > # cat /sys/kernel/debug/memblock/reserved
> > > > > >    0: 0x10004000..0x10007fff
> > > > > >   36: 0x80000000..0x8fffffff
> > > > >
> > > > > I'm still not convinced that the memblock refactoring didn't
> > > > > uncovered an
> > > > > issue in etnaviv driver.
> > > > >
> > > > > Why moving the CMA area from 0x80000000 to 0x30000000 makes it
> > > > > fail?
> > > >
> > > > I think you have that the wrong way round.
> > >
> > > I'm relying on Adam's reports of working and non-working versions.
> > > According to that etnaviv works when CMA area is at 0x80000000 and
> > > does not
> > > work when it is at 0x30000000.
> > >
> > > He also sent logs a few days ago [1], they also confirm that.
> > >
> > > [1]
> > > https://lore.kernel.org/linux-mm/CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com/
> >
> > Sorry, yes, you're right.  Still, I've reported this same regression
> > a while back, and it's never gone away.
> >
> > > > > BTW, the code that complained about "command buffer outside
> > > > > valid memory
> > > > > window" has been removed by the commit 17e4660ae3d7
> > > > > ("drm/etnaviv:
> > > > > implement per-process address spaces on MMUv2").
> > > > >
> > > > > Could be that recent changes to MMU management of etnaviv
> > > > > resolve the
> > > > > issue?
> > > >
> > > > The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
> > > > hardware requires command buffers within the first 2GiB of
> > > > physical
> > > > RAM.
> > >
> > > I've mentioned that patch because it removed the check for cmdbuf
> > > address
> > > for MMUv1:
> > >
> > > @@ -785,15 +768,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
> > >                                   PAGE_SIZE);
> > >         if (ret) {
> > >                 dev_err(gpu->dev, "could not create command
> > > buffer\n");
> > > -               goto unmap_suballoc;
> > > -       }
> > > -
> > > -       if (!(gpu->identity.minor_features1 &
> > > chipMinorFeatures1_MMU_VERSION) &&
> > > -           etnaviv_cmdbuf_get_va(&gpu->buffer, &gpu-
> > > >cmdbuf_mapping) > 0x80000000) {
> > > -               ret = -EINVAL;
> > > -               dev_err(gpu->dev,
> > > -                       "command buffer outside valid memory
> > > window\n");
> > > -               goto free_buffer;
> > > +               goto fail;
> > >         }
> > >
> > >         /* Setup event management */
> > >
> > >
> > > I really don't know how etnaviv works, so I hoped that people who
> > > understand it would help.
> >
> > From what I can see, removing that check is a completely insane thing
> > to do, and I note that these changes are _not_ described in the
> > commit
> > message.  The problem was known about _before_ (June 22) the patch
> > was
> > created (July 5).
> >
> > Lucas, please can you explain why removing the above check, which is
> > well known to correctly trigger on various platforms to prevent
> > incorrect GPU behaviour, is safe?
>
> It isn't. It's a pretty big oversight in this commit to remove this
> check. It can't be done at the same spot in the code anymore, as we
> don't have a mapping context at this time anymore, but it should have
> moved into etnaviv_iommu_context_init(). I'll send a patch to fix this
> up.

If you CC me, I will test it and report my findings.

adam

>
> Regards,
> Lucas
>
