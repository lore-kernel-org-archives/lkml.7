Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B23C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BF92186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WvyL0m/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfCTFsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:48:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38181 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTFsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:48:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so1057308ote.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qJukMqPOXlOntnKVHc2i+5O7P3xckugGqjBWj80qMA=;
        b=WvyL0m/nA84rJBWJKycrFf+U0cztPiz3IxTa6pnkeaLH6wnucVQ2EL/lDwRutBOkdA
         4fh9+EA/p03OA/UT1wY254adwW3kJn08lQeDuVqm9bT+j6bQ1PaJSN9EQPZcCF9CJ5Y5
         CnBFM34ETqJ//roM3nrJkSW4Rt6Ssol2zrHJj1LMEkwUP4a/tx7r8rmwnZURhyKIttqp
         Na7F91/YCHEpMhf8q4TPSNmGXS1H3JFebBNfAvZZWRgGxAa4KSsKZjrtlYmMFUvAYtcJ
         YWRSBbkU5Ho8rlm0HUBCOqONUaF78Lke4/l2d66uiZUdY4rwcmIIQZFZVVSm8C6X9Pq0
         qllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qJukMqPOXlOntnKVHc2i+5O7P3xckugGqjBWj80qMA=;
        b=jA605pVuNWJENNmH81SX4rXnoxoYYXqyzqWuT0ITpeUIywAnCEOC2flwdrABhhrAYN
         o6oAk2zrn7dOrZ99vj9w1PovdpoZH/3wephbbBF3zP3xRPNmcSKVDjIKM2H6Gqc0eIe7
         yJKeHLkIzFW5lJNEJ3BpQgS3OB9rkJR/Jno2Xx7MZgik9dM6F4fOAqut1gNov3au1g//
         haEDABqemIPJ6R9Y4yu0paRb5Gfm1dZ6abYif6+ntjnbPW0uGlIqLGoCqvqth1FEp7gQ
         CZthlDjONfNRfxT0tot73BwgV3FEvQ0r4Aeyq9Dly02xXtjIYx0A2TgwCtcMbKQX4MTx
         SEOQ==
X-Gm-Message-State: APjAAAUrqGduCZ2qh5soBx9hUJf9KZTwBfruvv//8Ae4kzAp2j17L+MT
        jKFB+D/p+RRaCUorzCRkU8m64ISnLfvkKgl4Nn6FVg==
X-Google-Smtp-Source: APXvYqx2le/akO3fDrcySnn7+BLmySGuFUIsqGwKXHRv3JBXf1ZloUl7I7GfeVRcLCf60DkjLjoWqetgvyHtNF4iUPs=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr4306404otb.353.1553060903309;
 Tue, 19 Mar 2019 22:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com> <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
 <1553049331.4899.177.camel@linux.ibm.com>
In-Reply-To: <1553049331.4899.177.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 22:48:11 -0700
Message-ID: <CAPcyv4gySHayfwtp1PgxEoM-T_s_1A4RTcnXefx5iRLn9g=D5w@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 7:36 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> > >
> > > < snip >
> > >
> > > > +/*
> > > > + * request_trusted_key - request the trusted key
> > > > + *
> > > > + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> > > > + * manages both trusted/encrypted key-types, like the encrypted key type
> > > > + * data, trusted key type data is not visible decrypted from userspace.
> > > > + */
> > > > +static struct key *request_trusted_key(const char *trusted_desc,
> > > > +                             const u8 **master_key, size_t *master_keylen)
> > > > +{
> > > > +     struct trusted_key_payload *tpayload;
> > > > +     struct key_type *type;
> > > > +     struct key *tkey;
> > > > +
> > > > +     type = key_type_lookup("trusted");
> > >
> > > The associated key_type_put() will need to be called.
> >
> > Yes.
>
> I don't know if defining a key_type_lookup() wrapper, perhaps named
> is_key_type_available(), would help.  Both key_type_lookup() and
> key_type_put() would be called.  The existing code could then remain
> the same.
>

Maybe, but something still needs to pin the hosting module. I think
this means that the first call to key_type->instantiate() pins the
hosting module, and the ->destroy() of the last key for the key_type
unpins the module. It does mean that the ->destroy() method is no
longer optional.
