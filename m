Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712D72186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljgbET/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfB1EQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:16:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46102 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB1EQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:16:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id j135so15444028oib.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 20:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8smFLNpcnmFXFu5vDuT2M6WyocpA2OuXfU4g5q5Ewc=;
        b=ljgbET/ZSia03zmgk1BDXZ1TSlWjTPCR/FbLhHSohot6+iIPXCC4PRRmzfiCYCPoJi
         VojG3mK85yVDd2Z+N8LZIzjGDeYjLBNl0DzpilGWh3IHJu4mnM51J2A6NhUqyUSBuzH9
         aKc5y8VnEv7SIrTLu1Ed2R1fYrUCpgwyq2QlIi+SvViz9+TlYUKKOpc2dfCXerqTnCIb
         vW/35f4M8ks04pOTt9dVZSAXGl2z3HkWq0Ft5yrxJ/pWeY01uQ86EDXHM4OA3/ooQ/xJ
         m2IlK1vy8bYIG+KxJ69ZDXBickv+a2QDRrUFsnCrua0T8IHW1BGJE0XX0v0iJXywpv2l
         zzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8smFLNpcnmFXFu5vDuT2M6WyocpA2OuXfU4g5q5Ewc=;
        b=QGvWWKmb2HqcQEUgSQB0ZHBOS57Dd+jHNlHACxs5g6aDiOoTKmY1nJ11OyiiLnhLFG
         OhC9u9UmpAPcS0Jj/rUL4UVnWdYgoFkdxgeQc7gwCJZ/DndlSyheHdi7QsQUlWKLYazV
         fcq9+B0KvKOe1Aaq/9McV6gsfCGSlaIVZJaCiTFtfbrM+NCEn2u9stUGDqTaN+YeYe0s
         K2PrzYRTRBF7VuYYP8ec9yO4OsaQ/16YaOv94ZINN1EAVkH5EQh/mtQ0MsB4BibhvTgV
         EGIdvYIOcZfSU/j8JW4G5vQ3rf/LDo/WYvAXJ5eGL8JDsSAXoDkFmtg6m8W4mNdOlCFN
         nRHw==
X-Gm-Message-State: AHQUAubyFOHFnaYg0wMo2EuuHO4Qwa/Ryrq5uhOWkQQGf6HSUe/dN/eY
        W/uetW/ixFPoP8PNN3Q57e7wTWygN/m3+pQVUA1iYQ==
X-Google-Smtp-Source: AHgI3IYLBw4fAcNn8X+URZDWm1wzX8NUif/7OUZRYGul2ztacPZNBUDEJRMPJGtLJO5LJQ0pPUmuc6IJahKa7kEGPes=
X-Received: by 2002:aca:56ca:: with SMTP id k193mr1779712oib.59.1551327359659;
 Wed, 27 Feb 2019 20:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com> <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
 <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
In-Reply-To: <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 27 Feb 2019 20:15:48 -0800
Message-ID: <CAFd5g47opWmu21VzGySW80Ehpa=vMgtVQ+mdY9YC9hvMPGkfAg@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:46 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/19/19 10:34 PM, Brendan Higgins wrote:
> > On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > <snip>
> >> I have not read through the patches in any detail.  I have read some of
> >> the code to try to understand the patches to the devicetree unit tests.
> >> So that may limit how valid my comments below are.
> >
> > No problem.
> >
> >>
> >> I found the code difficult to read in places where it should have been
> >> much simpler to read.  Structuring the code in a pseudo object oriented
> >> style meant that everywhere in a code path that I encountered a dynamic
> >> function call, I had to go find where that dynamic function call was
> >> initialized (and being the cautious person that I am, verify that
> >> no where else was the value of that dynamic function call).  With
> >> primitive vi and tags, that search would have instead just been a
> >> simple key press (or at worst a few keys) if hard coded function
> >> calls were done instead of dynamic function calls.  In the code paths
> >> that I looked at, I did not see any case of a dynamic function being
> >> anything other than the value it was originally initialized as.
> >> There may be such cases, I did not read the entire patch set.  There
> >> may also be cases envisioned in the architects mind of how this
> >> flexibility may be of future value.  Dunno.
> >
> > Yeah, a lot of it is intended to make architecture specific
> > implementations and some other future work easier. Some of it is also
> > for testing purposes. Admittedly some is for neither reason, but given
> > the heavy usage elsewhere, I figured there was no harm since it was
> > all private internal usage anyway.
> >
>
> Increasing the cost for me (and all the other potential code readers)
> to read the code is harm.

You are right. I like the object oriented C style; I didn't think it
hurt readability.

In any case, I will go through and replace instances where I am not
using it for one of the above reasons.
