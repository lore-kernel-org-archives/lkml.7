Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B8EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UDiRo+5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCTB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:56:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45073 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCTB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:56:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so670448otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mjt64/4Dg8tXXPq4qIouJ6AST6YP3csE5amhML8nRXM=;
        b=UDiRo+5gulIZ4piTUd5JGrr0OodGu+LL17w1v5Sqv5EldV/P/DbVqJImy8QMvKHWc9
         76OU6onXSgYIfQkGBGiVrHWl6D2ybatsGYfuMz7JVTL16/n407R3BnOSr6rC1iXxVgSA
         U24bkRzunVlFMsOmo5ZBRHF1xGx6TbDEmV14m/ZoPk2R5kr+esxJ1BJroeNOPJkLZ/oT
         feQqbE6x3TNax5C2qHM0Tnh9cvKRRI+k7h6VKL61JTM9EQyNw24ZeDWXNB0cM9ByFqPl
         XElCmg3r5OwKqf30F3YUhYnzlEE8Yhs76a1rTanmsm9zwfc1d1qq0PXm0u7tTusUGxK6
         SheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mjt64/4Dg8tXXPq4qIouJ6AST6YP3csE5amhML8nRXM=;
        b=SY5yYQ7SvG7Mp8yPff+U33fvZLbJvEjBrgmNpediAvn3H/KjBnE0PxfhDqnQ6Ha0Qj
         X0BGOkmxieKwfTBoRkeR2mIKn67i1KvCr/dR9m0DIJb3MPgKu5GT38Dra6NPUQe3436p
         OPd/mp8125J93mI/jjNb13mhM6q/BZw43jMy5aSeQWXULEMlNJ/Hrr+CSt/Y/ta9Pd0A
         SQh9dBXcCechZUUdMdy1w0pXfS6/C7kY1qg2Qy6siiVlTDu1NioPi0aQtKqc1Rt1wdNM
         +l0fcvJSMRKL35iSAkJ170uCclJSVQJFoD6izgxlngrwTgT7wAvgglo6Ab1pk42EK3ox
         xR/Q==
X-Gm-Message-State: APjAAAUsS4CirPsOr1DrAFHW/dgt1/j1mP1OYCWDEEL1ftZ6K/wy7Jpd
        KuNE1m9Nar/Qj3d2K+/BM3Fl2SlBFv2FlrO73FMY7g==
X-Google-Smtp-Source: APXvYqwLFnEIj924tAXUWG3vprYH4ZAqxdyS7jUJntqARsqbY+zVnFKuX3+PZW7VtL2a04vgCmdBDu7Kn9/MpOryJ5o=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr3235163otf.98.1553046969929;
 Tue, 19 Mar 2019 18:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1552955080.2785.26.camel@linux.ibm.com> <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
 <1552956989.2785.31.camel@linux.ibm.com>
In-Reply-To: <1552956989.2785.31.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 18:55:59 -0700
Message-ID: <CAPcyv4hXKQcdLnKG6rPNOJr2wjq31uCCr+16S5Yu6S5A_5UGrA@mail.gmail.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 5:56 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:
> > On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com>
> > wrote:
> > >
> > > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > > Rather than fail initialization of the trusted.ko module, arrange
> > > > for the module to load, but rely on trusted_instantiate() to fail
> > > > trusted-key operations.
> > >
> > > What actual problem is this fixing?  To me it would seem like an
> > > enhancement to make the trusted module fail at load time if there's
> > > no TPM rather than waiting until first use to find out it can never
> > > work. Is there some piece of user code that depends on the
> > > successful insertion of trusted.ko?
> >
> > The module dependency chain relies on it. If that can be broken that
> > would also be an acceptable fix.
> >
> > I found this through the following dependency chain: libnvdimm.ko ->
> > encrypted_keys.ko -> trusted.ko.
> >
> > "key_type_trusted" is the symbol that encrypted_keys needs regardless
> > of whether the tpm is present.
>
> That's a nasty dependency caused by every key type module exporting a
> symbol for its key type.  It really seems that key types should be
> looked up by name not symbol to prevent more of these dependency issues
> from spreading.  Something like this (untested and definitely won't
> work without doing an EXPORT_SYMBOL on key_type_lookup).
>
> If it does look acceptable we can also disentangle the nasty module
> dependencies in the encrypted key code around masterkey which alone
> should be a huge improvement because that code is too hacky to live.
>
> James
>
> ---
> diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
> index dc3d18cae642..b98416f091e2 100644
> --- a/security/keys/encrypted-keys/masterkey_trusted.c
> +++ b/security/keys/encrypted-keys/masterkey_trusted.c
> @@ -19,6 +19,7 @@
>  #include <keys/trusted-type.h>
>  #include <keys/encrypted-type.h>
>  #include "encrypted.h"
> +#include "../internal.h"
>
>  /*
>   * request_trusted_key - request the trusted key
> @@ -32,8 +33,14 @@ struct key *request_trusted_key(const char *trusted_desc,
>  {
>         struct trusted_key_payload *tpayload;
>         struct key *tkey;
> +       struct key_type *type;
>
> -       tkey = request_key(&key_type_trusted, trusted_desc, NULL);
> +       type = key_type_lookup("trusted");
> +       if (IS_ERR(type)) {
> +               tkey = (struct key *)type;
> +               goto error;
> +       }
> +       tkey = request_key(type, trusted_desc, NULL);
>         if (IS_ERR(tkey))
>                 goto error;


This falls over with the need to pin the module while any key that
needs service from the hosting key_type operations might be live in
the system.

I could hang a "struct module *" off of the key_type so the host
module can be pinned, but that requires teaching all consumers of the
key_type module lifetime. Not impossible, but I think too big for a
fix, and I'd rather go with this local fixup to drop the dependency on
tpm_default_chip() successfully enumerating a TPM.
