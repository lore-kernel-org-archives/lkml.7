Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2725C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A6E2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sFNV1rDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCTP15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:27:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40426 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:27:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id x8so611486otg.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwGFYhBdhCtEeLruvXYmJbIFZgn7DMiOJ06MFTraeH0=;
        b=sFNV1rDos+zMO5kqopVV3XECY9zoXCbjNnFCXK8CI0XTjzXtUH66d8xnUN1wUa/Wae
         9zkM2X02/oFoTPfXkSk3h3UevXKllX45UdUpnaq4NIduDtkzio1B0dHmOpqkusq6nlYb
         WhnXQei/hPdnO7kDzLLl5J8esaloI2hbEf8QW3U2cxQ4sWkw+cryN7Q3WIKjWo2vo+Mf
         ce0WXl/oBL8xeqvFb0oJFyliABjD+RqaA6jHisbs6EXr3TR+UbaQlRKXeijKnUQ0sORy
         EWKT/zMxBJiEh2dv9uzcN/jnjPDFCZ2anKgt9OHJ3w8F83Rq9b+TcL/TJCB/t55adKke
         wE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwGFYhBdhCtEeLruvXYmJbIFZgn7DMiOJ06MFTraeH0=;
        b=FvifjLeL5N+iwzHbPB7lKirKRprMWuG0odAtikkTPpocBq/lp++xn9LhMyl2Yt3ZMM
         c6rOkaVJxJ1gkWz6jdBtXu8U737rNtyOp344eCdworqDceS5hUFn2MotEMPa56ofkFQI
         R6RKnIQfzK8ZeqsCsg59lohYw28fUPd2IfgKW09WNcn0D3XBTvvr4zj9Nk/GPqp8bpDb
         IS4JhmSPPRHBwBE+IRo4obhcp2RKIJ7UlcV3CpUUPYZf0YLjCqSt7lS/vZ6WwUv/CqQV
         vpsQgiDeFcTwZ20gWg9y05YRiF/2xuoyl4XJ51H0WWl11PWEic7HRcRKb9DG8As8895s
         i22Q==
X-Gm-Message-State: APjAAAXGnKljaJfbGHl02CefONJWfuslWeDZeiE+ByOV8t4VM7vSD0Vz
        b6Hw37UkQZvokqfdNHrhaffGG8RdfMm2z1H16s5G9A==
X-Google-Smtp-Source: APXvYqzlkMmLF2z1/XVtX8pFJV3ZHrl9Sirlql91t4jyuYJ0vzY/3CTg923hbtyyMLHYfFuxQNwde5wa7bmtSFtXTpc=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr5999831otb.353.1553095675863;
 Wed, 20 Mar 2019 08:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com> <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
 <1553049331.4899.177.camel@linux.ibm.com> <CAPcyv4gySHayfwtp1PgxEoM-T_s_1A4RTcnXefx5iRLn9g=D5w@mail.gmail.com>
 <1553083579.4899.239.camel@linux.ibm.com>
In-Reply-To: <1553083579.4899.239.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Mar 2019 08:27:45 -0700
Message-ID: <CAPcyv4jJMvzPnthHi=2qnXF3XanSk9j_WAMiiA2UP1tTyFJyxQ@mail.gmail.com>
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

On Wed, Mar 20, 2019 at 5:07 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-03-19 at 22:48 -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 7:36 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > > > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > >
> > > > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> > > > >
> > > > > < snip >
> > > > >
> > > > > > +/*
> > > > > > + * request_trusted_key - request the trusted key
> > > > > > + *
> > > > > > + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> > > > > > + * manages both trusted/encrypted key-types, like the encrypted key type
> > > > > > + * data, trusted key type data is not visible decrypted from userspace.
> > > > > > + */
> > > > > > +static struct key *request_trusted_key(const char *trusted_desc,
> > > > > > +                             const u8 **master_key, size_t *master_keylen)
> > > > > > +{
> > > > > > +     struct trusted_key_payload *tpayload;
> > > > > > +     struct key_type *type;
> > > > > > +     struct key *tkey;
> > > > > > +
> > > > > > +     type = key_type_lookup("trusted");
> > > > >
> > > > > The associated key_type_put() will need to be called.
> > > >
> > > > Yes.
> > >
> > > I don't know if defining a key_type_lookup() wrapper, perhaps named
> > > is_key_type_available(), would help.  Both key_type_lookup() and
> > > key_type_put() would be called.  The existing code could then remain
> > > the same.
> > >
> >
> > Maybe, but something still needs to pin the hosting module. I think
> > this means that the first call to key_type->instantiate() pins the
> > hosting module, and the ->destroy() of the last key for the key_type
> > unpins the module. It does mean that the ->destroy() method is no
> > longer optional.
>
> This sounds like it isn't a new problem.  Both issues need to be
> addressed, but I think we should differentiate between them and
> address them separately.
>
> In terms of the original nvdimm encrypted/trusted key problem, the
> above suggestion requires the least amount of change.  For v5.2, I
> would replace it with the full updated patch set.

I believe smallest amount of change is this single patch:

https://patchwork.kernel.org/patch/10858649/
