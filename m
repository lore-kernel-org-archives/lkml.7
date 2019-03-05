Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98243C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E57F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCEQt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:49:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40719 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfCEQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:49:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so9627450qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 08:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8L6L0RbmJb0lQrN/0Bpz9tVd7ocWMIQA1VbY3g4sDMU=;
        b=R3AAp5F/9mthGc+AiLeRXExTR/1hSR+0U1d9jynlxBgxAJCtUOSyPzMzWgElJXDXPo
         UtGABOadAnsXM++C4u/3BVSmG7zKSMFt0SAsk08ToaTR8mfSilAhJt4A2/qsY0BR/qVO
         P/c61+8rHeI8IM01eL/A8VXvZ0WLGzoNsb+Vc3kwwcfXkxiC4bCT0pvVN/e7zNhIaJnL
         bwIJ3xTPWAqfd0p2djQT3/R8KCD76ymMbY9MVeJr2me7TbeA9Rl7ArXRk0YbQzlkbUm9
         VNl7sZsfHLQ+hRaS7dGTx4Wl/+H2b3NJmcundpSN8AkzR31G0LClolZcuSX+IlgBMaDi
         xgnw==
X-Gm-Message-State: APjAAAW9don6XzE23vgxSxnwCh8PQP+cPnJJC9tJg4Qe4NBlSU1e+Rkz
        nbM0wpj4ES4MSRfi7SkW+gIrxElvFmV0CLd6Zj5t5ATX
X-Google-Smtp-Source: APXvYqyfZkt57zvTDkoJO/07zRfgreh/snR4kbOv812iEXrNnCshb3yxF5W0ITjOLWtPslCN7rokBCR211aesnhlg1g=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr2713413qve.180.1551804595883;
 Tue, 05 Mar 2019 08:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20190305133057.3998926-1-arnd@arndb.de> <35654e1a-d066-0581-749f-7e3b65023988@oracle.com>
 <9a285a75-b9ea-37a9-b5bd-ba2a068dd944@suse.com>
In-Reply-To: <9a285a75-b9ea-37a9-b5bd-ba2a068dd944@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 17:49:38 +0100
Message-ID: <CAK8P3a03_v849mauL5SvX=5n1DGnaii9XeGJJF7Z1rO+n2H+xg@mail.gmail.com>
Subject: Re: [PATCH] [v2] xen: avoid link error on ARM
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 3:57 PM Juergen Gross <jgross@suse.com> wrote:
> On 05/03/2019 14:43, Boris Ostrovsky wrote:
> > On 3/5/19 8:30 AM, Arnd Bergmann wrote:

> >> @@ -809,15 +789,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
> >>              goto out;
> >>
> >>      if (xen_feature(XENFEAT_auto_translated_physmap)) {
> >> -            struct remap_pfn r = {
> >> -                    .mm = vma->vm_mm,
> >> -                    .pages = vma->vm_private_data,
> >> -                    .prot = vma->vm_page_prot,
> >> -            };
> >> -
> >> -            rc = apply_to_page_range(r.mm, kdata.addr,
> >> -                                     kdata.num << PAGE_SHIFT,
> >> -                                     remap_pfn_fn, &r);
> >> +            rc = xen_remap_vma_range(vma, kdata.addr, kdata.num << PAGE_SHIFT);
> >
> > I wonder whether drivers/xen/xlate_mmu.c might be a good place for these
> > routines.
>
> Hmm, probably. This would require a stub in the header to avoid
> problems in case of CONFIG_XEN_AUTO_XLATE not defined, though
> (the #ifdef is already there).
>
> I think this is the cleanest solution.

Putting it into xlate_mmu.c was my first attempt, but I was not sure how to
solve the dependency on CONFIG_XEN_AUTO_XLATE. So
xen_feature(XENFEAT_auto_translated_physmap)) would be guaranteed
to return false if CONFIG_XEN_AUTO_XLATE is disabled?

       Arnd
