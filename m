Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D72920835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jWNy2+OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCTBhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:37:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33994 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCTBhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:37:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id u12so548510oiv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQvOfL9VyCeC/ulxOcrUXP8emythXo3occMiKkN1eL8=;
        b=jWNy2+OLXCqPThI08aYWVzcOtoczw4Z0AtZocBSl7v/f/G8kMKQnnpYy9Kht3UdoUZ
         s0/dYjZYi6yiml6Ul5WkY/NlJKVSlaY4eeuNZ6La43gbYhcwqVrn43Rdh6IDcg44bhlI
         GlcZSp+3qUoXJir2RWriOuQXSJZELwNxZT6gA8TLHbgXxzwLI34qH3+d9RdZPLZu1GnU
         nHn4Fv2TRBdvC/Iz08XOOAKKOuwXrdToi6C1qhvZ4ynnwqZlCCvMPLHDZ0I8/GrCBBQy
         RanBS3C4mBS5MxUxn2ZN7kfaKBErWBYLYtsN0rL7wqf+Iab55OvtgEQzYtz8DzriCCS1
         OalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQvOfL9VyCeC/ulxOcrUXP8emythXo3occMiKkN1eL8=;
        b=PduJInDIwbohvyXYk3WfZc3TBNj4daodUTGNmqTLJdCL8oXl9MKQ4zMJlnl33aUugY
         pYxvcPi03HasQRDFJD6ja5VhrM7U2BHhMji6H9bYR7mx93m9EHmh9BPI81v80xeK5hVv
         aL9aSerqdrKnamq/c1BJcHIbjs9fclBK6QM6zfzEjp0r7NadOJW4mdvxrRjsJhrZFfKI
         VGc1/mHp1ILz3GM2nuad9VFEHvdaZme5aP85g6Z/3BUtDkbNg28C2Q7wx6PPCf3OGhJ/
         5QofOCmhL0+zHp8WwMfGZhJwFjDh3vgQ/PeZi8rKet344BeCHY+1ot9klzMfpyI7AdRB
         I7LA==
X-Gm-Message-State: APjAAAUoF7yp982brVV/iHQ4gVIV41Csaq4gT+tclJsvMaq519X+Yp6v
        sk/Ak6Qo7XzNSqGaoizMHPuKlGY6SqOTHpNRxj1m2vL8gLU=
X-Google-Smtp-Source: APXvYqy4sf3uvMJ0n8GfXAIPYZ5UatmhRVLd+ouJrJzFH73/vdb3aTjumGydnULa3gvFiSuWGwQZ/a6H+A4eqx3cFNo=
X-Received: by 2002:aca:df57:: with SMTP id w84mr3578973oig.105.1553045860543;
 Tue, 19 Mar 2019 18:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com> <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
 <1553044252.4899.165.camel@linux.ibm.com> <CAPcyv4jB0HW8mB_wdMDQ3FO6jW-B-WdTELq2UeM4ZnSienoccQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jB0HW8mB_wdMDQ3FO6jW-B-WdTELq2UeM4ZnSienoccQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 18:37:29 -0700
Message-ID: <CAPcyv4g+cA=itBjFJj4JCKopBdHrFXg7Bbg5KYF2=qYPAdAMfw@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 6:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Mar 19, 2019 at 6:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> > >
> > > > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > > > index 696f1c092c50..9045b62afb04 100644
> > > > > --- a/security/keys/key.c
> > > > > +++ b/security/keys/key.c
> > > > > @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
> > > > >  found_kernel_type:
> > > > >       return ktype;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(key_type_lookup);
> > >
> > > This needs to be moved to patch1.
> > >
> > > > Only the kernel is calling key_type_lookup().  Why does
> > > > key_type_lookup() need to be exported?
> > >
> > > This patch series adds several new callers outside of keys-subsystem
> > > core that need this export, the first one being encrypted-keys itself
> > > in patch1.
> >
> > It's needed, because they could be compiled as kernel modules, not
> > builtin (eg. EVM).
> >
>
> Right, but now I realize a problem. The side effect of having direct
> module dependencies to the key_type_{encrypted,trusted} symbols is
> that module reference counting is handled automatically.
>
> So, I need to respin this with some explicit try_module_get() and
> module_put() added otherwise the encrypted_keys facility can be
> removed while active keys are instantiated.

...and now I'm wondering if this refactoring is getting too big and
should wait for v5.2. In the meantime apply my small fix for v5.1

https://patchwork.kernel.org/patch/10858649/
