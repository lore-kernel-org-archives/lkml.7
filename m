Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF28EC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE221537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="f8QwnyQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfFMUVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:21:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41709 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfFMUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:21:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id 107so430400otj.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8C1DPfN32M3hy89DclQbm10r/6nHw68ntXJVKpP7b9Y=;
        b=f8QwnyQT51rXgqH07uWM2kqXhbWRJNnV74LW/yRvR2x776SPj5Pfk2O+kG2AmGkO8T
         trYSPptgpa5/GXF/WDtITF1+EbHojK5NlrUWtkmk/zSrRfZi5l9VktyZN13ffa5Hc6Ev
         0msFAvfYWphm24CFoDY7wyxaucG4FVHRbGTisLD6oBUXsztdH3fUW9TN5VMHOpT3cvr0
         sCPmY0lNjqi+LcWw5XMhpewNnmhVYTSePA2WSDRkeUne9k6nQVV9YwwkLBcNkm4aAYQp
         hwiX33VeD0WOTvpFOoQcm71sdbaOX7SnxHZ9aM2nx+Itu4NnNsqFxSwSt5OwJVwaJq25
         COoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8C1DPfN32M3hy89DclQbm10r/6nHw68ntXJVKpP7b9Y=;
        b=NhaT63PKelC5o4/EOgExGN+AWBvZ39Q+C5B5AxymeZwReL92a+r4ZpnTYxZojAR1aW
         NflTY6Og7QSDGBK4KSmU2voEXRc59H1G3IC/uISxp/kmVq5QRlUXr5jm8DOo/ob3nSy9
         OrVS5uEl7Qqu6/9OEMyml2Cc5WQ6f2Clz9V4no6JwYdAioTSd1GhDY7+cIOtcCpAJXjY
         BzlpHyI8HKStRLfoo2xTOlbnnzN54fhqkaqaTnk2QGGWz1A48k3vo+GWSb1/+6NyVCoZ
         YlTS7NtZil1/my1fh9Bma/ItuncOdloNDK1aKiWuvr6xjFG1MpeU0Ah9VGSL9zgCE119
         HVTA==
X-Gm-Message-State: APjAAAVA8c5Cc/hkXKvIOF2lvfUbN7rtACHREREv7GUtD93DdNqLe5lB
        hQ4KFa/iJI87+M1BdnWGRWIGAJwu8nlpp08Be9AArg==
X-Google-Smtp-Source: APXvYqyjtP3QbVJvzI3dCCMhA8qeDJqydQ8D7TK+PF2b5eiWZzF3IhMkwvK4lONxsyfmaoM/M+8Dcj6PJdtpVy6CFmg=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr1406727otk.363.1560457298006;
 Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
In-Reply-To: <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 13:21:27 -0700
Message-ID: <CAPcyv4hx=ng3SxzAWd8s_8VtAfoiiWhiA5kodi9KPc=jGmnejg@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        nouveau@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:18 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
>
>
> On 2019-06-13 12:27 p.m., Dan Williams wrote:
> > On Thu, Jun 13, 2019 at 2:43 AM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> Hi Dan, J=C3=A9r=C3=B4me and Jason,
> >>
> >> below is a series that cleans up the dev_pagemap interface so that
> >> it is more easily usable, which removes the need to wrap it in hmm
> >> and thus allowing to kill a lot of code
> >>
> >> Diffstat:
> >>
> >>  22 files changed, 245 insertions(+), 802 deletions(-)
> >
> > Hooray!
> >
> >> Git tree:
> >>
> >>     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup
> >
> > I just realized this collides with the dev_pagemap release rework in
> > Andrew's tree (commit ids below are from next.git and are not stable)
> >
> > 4422ee8476f0 mm/devm_memremap_pages: fix final page put race
> > 771f0714d0dc PCI/P2PDMA: track pgmap references per resource, not globa=
lly
> > af37085de906 lib/genalloc: introduce chunk owners
> > e0047ff8aa77 PCI/P2PDMA: fix the gen_pool_add_virt() failure path
> > 0315d47d6ae9 mm/devm_memremap_pages: introduce devm_memunmap_pages
> > 216475c7eaa8 drivers/base/devres: introduce devm_release_action()
> >
> > CONFLICT (content): Merge conflict in tools/testing/nvdimm/test/iomap.c
> > CONFLICT (content): Merge conflict in mm/hmm.c
> > CONFLICT (content): Merge conflict in kernel/memremap.c
> > CONFLICT (content): Merge conflict in include/linux/memremap.h
> > CONFLICT (content): Merge conflict in drivers/pci/p2pdma.c
> > CONFLICT (content): Merge conflict in drivers/nvdimm/pmem.c
> > CONFLICT (content): Merge conflict in drivers/dax/device.c
> > CONFLICT (content): Merge conflict in drivers/dax/dax-private.h
> >
> > Perhaps we should pull those out and resend them through hmm.git?
>
> Hmm, I've been waiting for those patches to get in for a little while now=
 ;(

Unless Andrew was going to submit as v5.2-rc fixes I think I should
rebase / submit them on current hmm.git and then throw these cleanups
from Christoph on top?
