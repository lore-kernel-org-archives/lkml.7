Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12741C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D959A20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDISR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:17:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfDISR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:17:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4668E66971;
        Tue,  9 Apr 2019 18:17:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBF33619A2;
        Tue,  9 Apr 2019 18:17:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAK8P3a13NVbkJzzoZG_7HrDT9qGPR5ptbRUL=xH1oZ1a+5ksHw@mail.gmail.com>
References: <CAK8P3a13NVbkJzzoZG_7HrDT9qGPR5ptbRUL=xH1oZ1a+5ksHw@mail.gmail.com> <20190408124640.GA607@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Jie Zhang <jie.zhang@analog.com>,
        Mike Frysinger <vapier@gentoo.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_* symbols in UAPI headers?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3478.1554833845.1@warthog.procyon.org.uk>
Date:   Tue, 09 Apr 2019 19:17:25 +0100
Message-ID: <3479.1554833845@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 09 Apr 2019 18:17:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> > I just stumbled over the MAP_UNINITIALIZED defintion, initially
> > added by:
> >
> > commit ea637639591def87a54cea811cbac796980cb30d
> > Author: Jie Zhang <jie.zhang@analog.com>
> > Date:   Mon Dec 14 18:00:02 2009 -0800
> >
> >     nommu: fix malloc performance by adding uninitialized flag
> >
> > The defintion depends on CONFIG_MMAP_ALLOW_UNINITIALIZED, which
> > will never be set by userspace.  How is this supposed to work?
> >
> > Shoudn't we define the symbol unconditionally and just turn it
> > into a no-op in the implementation?

Yes.

> Right, good catch. That should work. It can probably be done
> by adding another check before the conditional, like:
> 
>        /* clear anonymous mappings that don't ask for uninitialized data */
>        if (!vma->vm_file &&
>            !(IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) &&
>              (flags & MAP_UNINITIALIZED))
>                memset((void *)region->vm_start, 0,
>                       region->vm_end - region->vm_start);

Sounds good.

> > There are a few similar issues, like struct elf_prstatus having
> > a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> > MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

Because the kernel code uses that header and that struct too, so you'd break
compilation of binfmt_elf_fdpic.c.  There is a way round it - and that's to
copy the struct into the non-UAPI backing header and delete the conditional
section from the UAPI one.  You'd have to stop the non-UAPI header from
#including the UAPI header, though, and you'd have to hope that no one is
trying to set it in userspace (gdb doesn't).

David
