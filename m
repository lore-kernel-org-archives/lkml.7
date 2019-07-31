Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7818C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HI+gOcTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfGaN7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:59:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33395 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfGaN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:58:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so65721386ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uyQRZ6J/VGu+GRBY89f4/UdsO6g2H35LuTyha3NB8E=;
        b=HI+gOcTaURQ3MEznucBgmDHuKOk0Y5171KUM3l34LlAOPW6XZpG6qqsyz9j/P+Llgw
         jJwKIjSYVPTNi2/CIUILUJLlr3357zISH28+A2IjbBfvfscK9MyZe3j7F9SO33KsnikP
         nbobJ+27D1CIl/MzLH7uP5K+S6ZGhkPC2kZ1PGxTuJC7Bygn93iO0bJMXcpPh9OOr2gC
         Evf1SJ4kQOz1Hb3UszrvxYBu4Qmdheq6ChjQlD8fQgdiO//KgoS6f0dv2yyJ1MnmlqEQ
         DctMddNSq9454hzkxOJCQz85RQokoy+If4U4Fozfhoenl1YWS4I0iJyPohnPdALeHUU0
         wTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uyQRZ6J/VGu+GRBY89f4/UdsO6g2H35LuTyha3NB8E=;
        b=UBWrniKJwfmKtZghdur92nk3MMOLPqTZgJz7T64etgMC788a1P6RE0Q/fc+bf4oRed
         r2IGbEoHkL29WBcSUoiUBClsTA4TDJkbXRwdBXrnGTeq5oC4myjD7rP/C93hGHF6QJVi
         PQRU6pjmpau1qgEjKYaTU4eZ8h36VSgvtwpZeuz3+5nS7k1zb0A3G/Q/n2UeitQWUPdm
         TEj+Z/jRaM+gsGA71Bh49KxXGpx+RVMlZoTKVK1uHG9RYZp6upxOvZFVC1zvsup+IgyZ
         APdDdu4anvYgXmNQtH/5znDDrRXFwBX6iCJ21dBM6fV4am5sqrspBxDI8c9mYf7+OHTa
         o1Mg==
X-Gm-Message-State: APjAAAU2zMosyR5ZX2MxCyxXg3hw+cg+Aiwu2ukzPuRY6a9cyJZ+jeaX
        V5wdax/y29VMZmPr93tTQ7nm3/KJ0CFeMH5bPfAA4A==
X-Google-Smtp-Source: APXvYqy0Wt0sy2BNVrAcYeCI8ch73LVT0TjAvnK4Q5cvn/jHQarDv/IdlVkkeNuR9mCwu+8di8NX8a9uWp3ErIq3vbw=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr63175510ljw.76.1564581534527;
 Wed, 31 Jul 2019 06:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com> <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
In-Reply-To: <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Jul 2019 19:28:43 +0530
Message-ID: <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 at 15:51, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> To clarify a bit further - my thought was to support any type of trust
> source.

That could be very well accomplished via Trusted Keys abstraction
framework [1]. A trust source just need to implement following APIs:

struct trusted_key_ops ts_trusted_key_ops = {
       .migratable = 0, /* non-migratable */
       .init = init_ts_trusted,
       .seal = ts_key_seal,
       .unseal = ts_key_unseal,
       .get_random = ts_get_random,
       .cleanup = cleanup_ts_trusted,
};

> Remote, local or both. Just having one particular type of
> locally bound 'TEE' sounded very limited,

TEE is just one of trust source like TPM, we can have other trust
source as mentioned above.

> especially when nothing from
> the TEE execution side is really needed for supporting the kernel
> crypto. What you really need is the seal/unseal transaction going
> somewhere and where that somewhere is does not matter much.

Its only the seal/unseal operations that are provided by TEE driver
that hooks up under trusted keys abstraction layer.

> With the
> user mode helper in between anyone can easily add their own thing in
> there.
>

Isn't actual purpose to have trusted keys is to protect user-space
from access to kernel keys in plain format? Doesn't user mode helper
defeat that purpose in one way or another?

>

[1] https://lkml.org/lkml/2019/7/18/284

-Sumit

> --
> Janne
>
> On Wed, Jul 31, 2019 at 10:11 AM Janne Karhunen
> <janne.karhunen@gmail.com> wrote:
> >
> > Hi,
> >
> > Interesting, I wrote something similar and posted it to the lists a while back:
> > https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
> >
> > Since there are no generic 'TEEs' available, I implemented the same
> > thing as a generic protocol translator. The shared memory binding for
> > instance already assumes fair amount about the TEE and how that is
> > physically present in the system. Besides, the help from usage of shm
> > is pretty limited due to the size of the keydata.
> >
> >
> > --
> > Janne
> >
> >
> >
> >
> > On Tue, Jul 30, 2019 at 3:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This series also adds some TEE features like:
> > >
> > > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> > >
> > > Patch #3 enables support for private kernel login method required for
> > > cases like trusted keys where we don't wan't user-space to directly access
> > > TEE service to retrieve trusted key contents.
> > >
> > > Rest of the patches from #4 to #6 adds support for TEE based trusted keys.
> > >
> > > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > > found here [1].
> > >
> > > Also, this patch-set is dependent on generic Trusted Keys framework
> > > patch-set [2].
> > >
> > > [1] https://github.com/OP-TEE/optee_os/pull/3082
> > > [2] https://lkml.org/lkml/2019/7/18/284
> > >
> > > Changes in v2:
> > > 1. Add reviewed-by tags for patch #1 and #2.
> > > 2. Incorporate comments from Jens for patch #3.
> > > 3. Switch to use generic trusted keys framework.
> > >
> > > Sumit Garg (6):
> > >   tee: optee: allow kernel pages to register as shm
> > >   tee: enable support to register kernel memory
> > >   tee: add private login method for kernel clients
> > >   KEYS: trusted: Introduce TEE based Trusted Keys
> > >   doc: keys: Document usage of TEE based Trusted Keys
> > >   MAINTAINERS: Add entry for TEE based Trusted Keys
> > >
> > >  Documentation/security/keys/index.rst       |   1 +
> > >  Documentation/security/keys/tee-trusted.rst |  93 +++++++++
> > >  MAINTAINERS                                 |   9 +
> > >  drivers/tee/optee/call.c                    |   7 +
> > >  drivers/tee/tee_core.c                      |   6 +
> > >  drivers/tee/tee_shm.c                       |  16 +-
> > >  include/keys/trusted-type.h                 |   3 +
> > >  include/keys/trusted_tee.h                  |  66 +++++++
> > >  include/linux/tee_drv.h                     |   1 +
> > >  include/uapi/linux/tee.h                    |   8 +
> > >  security/keys/Kconfig                       |   3 +
> > >  security/keys/trusted-keys/Makefile         |   3 +-
> > >  security/keys/trusted-keys/trusted-tee.c    | 282 ++++++++++++++++++++++++++++
> > >  security/keys/trusted-keys/trusted.c        |   3 +
> > >  14 files changed, 498 insertions(+), 3 deletions(-)
> > >  create mode 100644 Documentation/security/keys/tee-trusted.rst
> > >  create mode 100644 include/keys/trusted_tee.h
> > >  create mode 100644 security/keys/trusted-keys/trusted-tee.c
> > >
> > > --
> > > 2.7.4
> > >
