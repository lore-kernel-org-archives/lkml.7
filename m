Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB10CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC342183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mnkxq2H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCTBfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:35:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44540 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCTBfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:35:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so640987otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4zXDXP+dequDiEbKm3pStFQKpRoMp17/vh+4KWT3mc=;
        b=mnkxq2H0ovZc/AJfBvEHbJSLwgE2/T+Yo9JAOfRnfQ+4UUfQi6wwkq8ejm5eG7Fym1
         +NMHDEUhAG5HnxB+KeZ82SUZGepvOK9BCwjvpThgBCsgflbls6OiL8BMGBnbzNzzmzXR
         wuxz2stMCzuR8nYbrRAvjzd3PiPIyVzz37Z+5HsKqBIjesp1Q3sY6kVm4AljAnro/Zqn
         Yqd1Ce/avKuDGNM/ecTS3r/d7EGWS81zxol9WRupR/vlfivAMFxuWnSeR9ppqiZAdVpa
         6wPQeJUQYSRE4BrR933KIrLr5wDRKhvAzm+QQ15tAcUKqPuvQ3gBYHxvlozVeBg9cI4a
         t1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4zXDXP+dequDiEbKm3pStFQKpRoMp17/vh+4KWT3mc=;
        b=R1yL3Z7A1Ku3rhV/EAChu5cOHaUua6XbJrZxei3W30I+RNLTzPKmMGIsX2CkgNbhzw
         wdTPb96jfwCTNklwDtC9SdpukLVPI/qxvM/dE9oxJnF46eLnqbhZrwtB32B30hXu8q8L
         OO4YnMKbIHZbv5i8g01eWpSkW2dRaBXb2w7H74+YmCDGMTRyPDvB0Wf+K/cnYW3KWdwD
         wszkLnzX245ED1nai5Z+sDjPWX5X0qz8GQ+S6tQXG07NfznuPT0zBjpe9rfB8OwCOueH
         PmzA6UyNaQzC9ViBbTFX67Ekj+Vjcy8oneaflOrFRpzG+KpdukkauBOKz8jwPJNngdCc
         CZIw==
X-Gm-Message-State: APjAAAWiEZDeAPtSyc+iGXLQBsX5UVYpYv48/LYnuDvn1Rv4JiJA8Mjz
        SMwYCCGVN3v+7VZeZZmfAGu7elQiZo50Rj5K7HeEig==
X-Google-Smtp-Source: APXvYqzay65TZlw2cZ1SCtpvukoXsZekzHjAE01O5ld+hrjEvaWpa8Kar6PWaBgq766leALW5erq4HooamlPfgEB+Uw=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr3762854otb.353.1553045707061;
 Tue, 19 Mar 2019 18:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com> <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
 <1553044252.4899.165.camel@linux.ibm.com>
In-Reply-To: <1553044252.4899.165.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 18:34:56 -0700
Message-ID: <CAPcyv4jB0HW8mB_wdMDQ3FO6jW-B-WdTELq2UeM4ZnSienoccQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up request_trusted_key()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> >
> > > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > > index 696f1c092c50..9045b62afb04 100644
> > > > --- a/security/keys/key.c
> > > > +++ b/security/keys/key.c
> > > > @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
> > > >  found_kernel_type:
> > > >       return ktype;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(key_type_lookup);
> >
> > This needs to be moved to patch1.
> >
> > > Only the kernel is calling key_type_lookup().  Why does
> > > key_type_lookup() need to be exported?
> >
> > This patch series adds several new callers outside of keys-subsystem
> > core that need this export, the first one being encrypted-keys itself
> > in patch1.
>
> It's needed, because they could be compiled as kernel modules, not
> builtin (eg. EVM).
>

Right, but now I realize a problem. The side effect of having direct
module dependencies to the key_type_{encrypted,trusted} symbols is
that module reference counting is handled automatically.

So, I need to respin this with some explicit try_module_get() and
module_put() added otherwise the encrypted_keys facility can be
removed while active keys are instantiated.

> > drivers/nvdimm/security.c:57:   type = key_type_lookup("encrypted");
> > fs/ecryptfs/keystore.c:1627:    type = key_type_lookup("encrypted");
> > security/integrity/evm/evm_crypto.c:361:        type =
> > key_type_lookup("encrypted");
> > security/keys/encrypted-keys/encrypted.c:440:   type =
> > key_type_lookup("trusted");
> >
>
