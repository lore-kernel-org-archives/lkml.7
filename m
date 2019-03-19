Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A09220989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MsTWk0hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCSBeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:34:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33113 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:34:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id q24so16249237otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gjlT8OQaj+zANY5Ff3tbHET/g62FgpUzmpkq4hhTUU=;
        b=MsTWk0hiLZWkz3w5cbGtEn6/21AsM7UXvSiGHO3hbB1yqk0i0GQOH5PcEPKBuzs+eI
         R+orEs9omeii5U7oAJYKW5tFP5+hQbs2PPnhevT45CEERXAmjZUrhgZB72d9/AOO2yYH
         SzSSYYvcpk8ZyCUAaoX/lT0hZuCBlYy96ar1PuGdU+ZFJQqreJ4xLF1UxzXHR15OQ+mn
         YE2EyZ5tu0jITFBuZt2ZB8ht3Pmxdk8lbICidFqn2IU1zWizyKpIBE7vDlLrVUFhCewm
         zlEionvIv3Ij3ak2FVML5/MEbl67bsQwPjtytYoCG7f7pEcICZWDZz7QN7XN5TJBHS1Z
         rEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gjlT8OQaj+zANY5Ff3tbHET/g62FgpUzmpkq4hhTUU=;
        b=pXV+FQ0YeZyVtT66o4qvu8t53wrktKakaLHPLhAv4vrxZymUFNfTbLM+pza9bnCnEd
         M4JGFk704UUtKk0CwfdkuvHjtDVs7DafJ8qU0H7vY5ur6jH71atc5UWqxVehA2rwcKaB
         22CNroogqbXXbjlMjAY+7WN8oOCbKSmINHCPXeP090tEM5W8ogZuq/XUV7FUqrW25axJ
         /7kr5YfSnwk8BqeqFyFh1w4TX2WJiRIIKffs1sV9RCybqwGLo4Gc3stet19QV0oIVSmO
         rPTIeB4qseRNy8vIQN06rEPWTuZc6lzeM6EnJU+UKwIigVbYJxKdruw0BeEgmm1BnOkq
         vQKg==
X-Gm-Message-State: APjAAAVzw0zWTihBGcNy57VCbajeBT7K1OeQmuYZHX98k5twmnuuwEiL
        Qw26F82JPUhXLbM4rGkICFT+zh5Toas8mG9jV0Q5JA==
X-Google-Smtp-Source: APXvYqwgJKKeXDu3lk7PMP+R0I/R3qio9pxR/e9b9rrZXdZuOvKU2J4lwua5yuCdjYYSds9PkmtBkydK0V/pCwA14l0=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr13325699ota.214.1552959254133;
 Mon, 18 Mar 2019 18:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1552955080.2785.26.camel@linux.ibm.com> <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
 <1552956989.2785.31.camel@linux.ibm.com>
In-Reply-To: <1552956989.2785.31.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 18:34:02 -0700
Message-ID: <CAPcyv4h7iPHT2qSgPYvw8o61cdwfzjpocSDj0YF7LSsxEoO3fA@mail.gmail.com>
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

Looks good to me. I fired it up with the export added and also included a:

    MODULE_SOFTDEP("pre: trusted");

...to encourage trusted.ko to be ready, if possible, for the lookup.
