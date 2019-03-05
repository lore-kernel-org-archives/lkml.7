Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E738BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687B206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfCEJUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:20:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42518 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfCEJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:20:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id y140so4408195qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 01:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuQDmdlDB4T/qm7whKZMpvwgUt7ayRtb8FeCM8b7o0A=;
        b=Pt55yMarIepBRrUXHsYytV2XohwZ2vZKXUBlGN7N8xuP20FP8H+uuaN/4j97x1TDb5
         MiXz25v1SAvUiD4xl04yGvsW5ctRmygqx7JlyXeOZw3WHfLjyvlsoeHunH5mKwsISZPC
         wcBGPviUUQFL8F3BuvdzkbyCLXlSMEJeZIUNQaI0gsBerFZQXFNtpULZvK0KlwAq/+qR
         mX3xPoOWBCN6V4rW1IPsZzlGy2DO4WQEf8SBXIYmaVUvxoHi4L8pyoHO+XxV2UKUktHJ
         TwlSGqU2YhrekZGKSsjTFnqRhPWr7UtUqKeFRgQbE/TQQ8tamq/0/ClvInDrmwwbV01C
         bPCw==
X-Gm-Message-State: APjAAAVW6bixSLzeZzjuoL0E+jaXyWGyGYLQ58AqLjtyFCn8O7blbSuE
        GqXospWeyqzE9EZkGLeWLX+gz0ShxuGGpvbt0aw=
X-Google-Smtp-Source: APXvYqzKCQnWRdo3BOL2SeRyL8xlhZE86jsuwNKPXOkrHvnu2c6NAhCxxsaLXdNFTx5t5xsWDqij/mss3tRYHqSAkvQ=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr943700qkf.107.1551777601289;
 Tue, 05 Mar 2019 01:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20190304204826.2414365-1-arnd@arndb.de> <0eaa0d35-0be8-0053-1dcb-feb61d441bd2@suse.com>
 <CAK8P3a3vbjOzKAD6zce09Gc438tW=nYuMAJCE0MrODhBjO71xg@mail.gmail.com> <a1ff4ef4-f20f-ff0c-f779-0c8a3c1acd39@suse.com>
In-Reply-To: <a1ff4ef4-f20f-ff0c-f779-0c8a3c1acd39@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 10:19:42 +0100
Message-ID: <CAK8P3a0qaeyYfKdPXdu8NXmXKVuYvr2NWXkYjnpb+UZzuRD5=w@mail.gmail.com>
Subject: Re: [PATCH] xen: avoid link error on ARM
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Matthew Wilcox <willy@infradead.org>,
        Paul Durrant <paul.durrant@citrix.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 10:05 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 05/03/2019 09:34, Arnd Bergmann wrote:
> > On Tue, Mar 5, 2019 at 7:39 AM Juergen Gross <jgross@suse.com> wrote:
> >
> >>
> >> Can we avoid that ifdef in the Makefile?
> >>
> >> I'd rather have an architecture independant builtin driver added which
> >> is always included for CONFIG_XEN. This would allow to move redundant
> >> stuff from arch/*/xen/ into it (e.g. xen_vcpu_id).
> >>
> >> So: rename mm.c to xen-builtin.c, use:
> >>
> >> obj-$(CONFIG_XEN) += xen-builtin.o
> >
> > Sure, I'm happy to change the naming and the Makefile logic. The way you
> > suggested sounds fine to me, but it will make the xen code slightly bigger
> > even if that code is not used. We could also have a silent Kconfig symbol
> > that turns this on and still avoid the ifdef:
> >
> > obj-$(CONFIG_XEN_BUILTIN) += xen-builtin.o
>
> That was my first thought.
>
> But looking through arch/[arm|x86]/xen/enlighten.c I found several
> global variables defined the same way. I'd like to merge those, too.
>
> So my preference is a common source for all this stuff.

Ok, makes sense. I've prepared that patch now and will send it
after some more build testing.

        Arnd
