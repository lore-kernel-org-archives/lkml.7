Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40267C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A6620449
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD2rzW6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFNF6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:58:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43338 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfFNF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:58:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so1070259ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFXNxbR5qtxNXi2nY5hSY49xeuHs2429UMIo2iWWl0g=;
        b=hD2rzW6+JswYVvwbKP+ETgzs+PloQRvs6H+EadUYpU/Oro1P+HHue6bgtuazPDg3gK
         stuJfFJXi5+gnnWcvhtxSaUN3NgUEt6xiRprMP6iXljZvONiXwrdE3eIhXuN3F65jqvj
         GDdqmqA4QbwtfVNGWRe5tEbx32S/rr8Z5fQh9bOdjhFyY0JSJuUKOSHoKQcwCLE6dXEF
         8H1Ah0D76X6ToKxVMaSjQ6P3BfUoC5IDA1zBe7kuIrdrloFC94pCsg2+UXs3ll7h5odz
         2CIf2h8rEBW6fQQpVQ6fPQTVx78raNLKckBefIUx83lDXGiAmD7qaIEG60q0jLmManM3
         aAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFXNxbR5qtxNXi2nY5hSY49xeuHs2429UMIo2iWWl0g=;
        b=lisu+nlxZCkaZ9l03wpLTqlgmNFl3IzijlpQMtqfaWRYZAjOEe6hej1QtouGwvwq0Q
         Q3qdOkFfmymd0vm1/psdlT7ZZRjA3gBXFvy+b0TrErGJydMA617N2qhcY/OCzc/3MbGK
         P3nwC2bBhQoFqH4vt42DWeJOn+sAUGlmWSk4lUaB4UbbDLAQAI8uG6J9Fp+G3SKH10Xo
         3jcwl6Pdv7fDRab/oK35z5QyCmOM7/p1g4fH8elQTrfyyH46IyJRuVw1KmmwgVcBVMup
         h9Q7EVe0YB+4XWws5U3zpDTUZWqsGJCvwgDk4D/7jEqKdauBVlFMqqMfMKuwX1bchyaV
         PQAg==
X-Gm-Message-State: APjAAAWwFwV8xRL33IUGc8UczgiWc5nAIqNbFNR7pa9pfw4AE0X/cEAN
        QcjaTCj3M03HM3yD93oCYRW8bxPZPD50e7ofV0WOjA==
X-Google-Smtp-Source: APXvYqzeksM7lw+9eRlJ79HkAyW5J8Xn00aCwvC2H55C68XUPO5raXUWhnglWIySJoN7qdrhKGK/PKFdGYxBJR4f23E=
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr1081203ljj.67.1560491923075;
 Thu, 13 Jun 2019 22:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org> <d803283e-5e69-5deb-fe94-3f2e45fb95af@schaufler-ca.com>
In-Reply-To: <d803283e-5e69-5deb-fe94-3f2e45fb95af@schaufler-ca.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 11:28:31 +0530
Message-ID: <CAFA6WYN0u1nrxp1rok+GMi_wVH44FD9QKhoqOPvUNC0_f+kULw@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 at 22:10, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/13/2019 3:30 AM, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This series also adds some TEE features like:
>
> Please expand the acronym TEE on first use. That will
> help people who don't work with it on a daily basis
> understand what you're going on about.
>

Sure will take care of this. BTW, its Trusted Execution Environment (TEE).

-Sumit

> >
> > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> >
> > Patch #3 enables support for private kernel login method required for
> > cases like trusted keys where we don't wan't user-space to directly access
> > TEE service to retrieve trusted key contents.
> >
> > Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
> >
> > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > found here [1].
> >
> > Looking forward to your valuable feedback/suggestions.
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/3082
> >
> > Sumit Garg (7):
> >   tee: optee: allow kernel pages to register as shm
> >   tee: enable support to register kernel memory
> >   tee: add private login method for kernel clients
> >   KEYS: trusted: Introduce TEE based Trusted Keys
> >   KEYS: encrypted: Allow TEE based trusted master keys
> >   doc: keys: Document usage of TEE based Trusted Keys
> >   MAINTAINERS: Add entry for TEE based Trusted Keys
> >
> >  Documentation/security/keys/tee-trusted.rst      |  93 +++++
> >  MAINTAINERS                                      |   9 +
> >  drivers/tee/optee/call.c                         |   7 +
> >  drivers/tee/tee_core.c                           |   6 +
> >  drivers/tee/tee_shm.c                            |  16 +-
> >  include/keys/tee_trusted.h                       |  84 ++++
> >  include/keys/trusted-type.h                      |   1 +
> >  include/linux/tee_drv.h                          |   1 +
> >  include/uapi/linux/tee.h                         |   2 +
> >  security/keys/Kconfig                            |   3 +
> >  security/keys/Makefile                           |   3 +
> >  security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
> >  security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
> >  13 files changed, 737 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/security/keys/tee-trusted.rst
> >  create mode 100644 include/keys/tee_trusted.h
> >  create mode 100644 security/keys/tee_trusted.c
> >
