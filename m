Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDF520828
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xC44Ga7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCTAUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:20:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42665 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCTAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:20:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so521786otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RnMBtikaXl7CNIq06JeyQDH720IPf6TuGSxsVbdcOY8=;
        b=xC44Ga7pi5Alb5AHzgTOYHLrZzCQ1gQMDGOMT0TUcS3VeOB9zlLyT7nUyw6w8PPcLr
         dn5G74X92KOUotxVsgKVoiZqo6WiIhPU1pmdgQ+OOmxifgXA5vNOnpPaMEWkOHl4BNaI
         d+e+CsgO6QY2hdthwkmuT4sxhZYgKrKyHXa5CNDvAMYTlPhPcYyFU45eIWCGbBLLCyYA
         7nUKKpvlg5YMKwzW1hPpHOSqqQs88OUplrwOjsW4YyjgYJODdjcw4R5/BcXgPgd4kwBA
         qqmPQrtXlDirootQ85Bvw9flHEZ5z4yuRMVs/bTxh74/QI0uYtIgqIUj20Dnb9VP0J77
         CSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnMBtikaXl7CNIq06JeyQDH720IPf6TuGSxsVbdcOY8=;
        b=Yn1WMjzYqnO3yvCNY/Shze0FZzHATA3iQEbouHglI/w69RQVu5G9lnVi/LPG0vG2eW
         sEdS/pKzONjFGcb/fGVIERwU4kP0yIFyzGCzBm2Ay1b4xOecqDrgfXph2OFObtRvZUvo
         QQmlVfH6iWxzxLjhWD4j+Zzfa3ZIUFIUnWdrPeeD5SGwUIcj/GWiDbk/HKh3+2OkbBjt
         Ex9qfuFwPcGNqgLRDYDmGHg2vw1GYp64bPg2BR4lkARNGbvavc0wU4NbY+ITAvbt7Ad1
         PqtFuhvUdcE7AyvWDySXZK7u8iUdxIKjpFkWzYFSIR/1d+83Y1X74YBxt8xt/BsHU7kP
         ahPg==
X-Gm-Message-State: APjAAAWZs6l73xPa0tYz3gjinul2DwhZNZ804fiGmTTrVWw5xfkINcYu
        8qWechUIAlKeCbRUeU1QP/v5psbZyhU8i9mCGYsC4Q==
X-Google-Smtp-Source: APXvYqxjcI6kl6gsVvMv5j5K+gU6BLBF8kBoBhDKtl6e3oqOMBw2b18tT9fRmIoYEK6AecF404b79NTHBv461C3Twq0=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr3019821otf.98.1553041212574;
 Tue, 19 Mar 2019 17:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com>
In-Reply-To: <1553040398.4899.149.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 17:20:01 -0700
Message-ID: <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
>
> < snip >
>
> > +/*
> > + * request_trusted_key - request the trusted key
> > + *
> > + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> > + * manages both trusted/encrypted key-types, like the encrypted key type
> > + * data, trusted key type data is not visible decrypted from userspace.
> > + */
> > +static struct key *request_trusted_key(const char *trusted_desc,
> > +                             const u8 **master_key, size_t *master_keylen)
> > +{
> > +     struct trusted_key_payload *tpayload;
> > +     struct key_type *type;
> > +     struct key *tkey;
> > +
> > +     type = key_type_lookup("trusted");
>
> The associated key_type_put() will need to be called.

Yes.

>
> > +     if (IS_ERR(type)) {
> > +             tkey = (struct key *)type;
> > +             goto error;
> > +     }
> > +     tkey = request_key(type, trusted_desc, NULL);
> > +     if (IS_ERR(tkey))
> > +             goto error;
> > +
> > +     down_read(&tkey->sem);
> > +     tpayload = tkey->payload.data[0];
> > +     *master_key = tpayload->key;
> > +     *master_keylen = tpayload->key_len;
> > +error:
> > +     return tkey;
> > +}
> > +
>
>
>
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index 696f1c092c50..9045b62afb04 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
> >  found_kernel_type:
> >       return ktype;
> >  }
> > +EXPORT_SYMBOL_GPL(key_type_lookup);

This needs to be moved to patch1.

> Only the kernel is calling key_type_lookup().  Why does
> key_type_lookup() need to be exported?

This patch series adds several new callers outside of keys-subsystem
core that need this export, the first one being encrypted-keys itself
in patch1.

drivers/nvdimm/security.c:57:   type = key_type_lookup("encrypted");
fs/ecryptfs/keystore.c:1627:    type = key_type_lookup("encrypted");
security/integrity/evm/evm_crypto.c:361:        type =
key_type_lookup("encrypted");
security/keys/encrypted-keys/encrypted.c:440:   type =
key_type_lookup("trusted");
