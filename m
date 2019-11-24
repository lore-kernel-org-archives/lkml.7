Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B7C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 03:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B81920714
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 03:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DDcy7HCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKXDie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 22:38:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37098 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKXDie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 22:38:34 -0500
Received: by mail-oi1-f195.google.com with SMTP id 128so2051145oih.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 19:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bh1aHdYDRSuy1cqsFnjQSoB8H/BTadJ3WbQDfyJeyo8=;
        b=DDcy7HCiW4uxxRJ+HLA1pdHzn60CxNSOECSOvKR3pi8JXKhP705g5MTrvZoiGHQBK7
         Bj65re2eHhSVvQBx0Glpw2EOvnVZwCGEuyy95UdQhKMXIQ8PtixX1FS6gy7d4XQ2A51K
         kda8H8QwJ+Bkb5i1cWhgTQd8GGg30e0TeZuSpaWAEaQQPSmXgtJwaZSXTHGeR5x+TuE3
         I+9EOuLMznWx+Pe9QX9erEveQdWkGmjw22g1PYMfva9lcVy6kn+BDpEcJlO/j8lI45Dq
         5dlWtKtP+NVXSq+QHxWqF0D/G6P9vtrEvjsMV1K+1zaAgAfhWof3/SxiCjwp5sSXZV38
         tcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bh1aHdYDRSuy1cqsFnjQSoB8H/BTadJ3WbQDfyJeyo8=;
        b=faqXjxNmmTmpTPtSOJ4VPSw8USyfNGJcdn131WbchSbxV56aKsZ/zn8XEU0PeTs+IV
         QLaASyxHEBCJMy91T/UgAn3HOAVuv29bhYPuWB4Epjt35hnj8yqha79f829o3mwA9nPi
         PCyv5of+haCRXF4naCoSHnDnllDKbljutEmeIqyDC+5yCUMWVNNCJXi5oI+qUguGEphj
         xo/bAfR95v1Bpov6XtvBQL5C9wM/MP6zmqDWMIdD+xEiG9mdx1rQuVZPFYSJBAcbMWmZ
         U1KY/yEfjyJyWfRXh7jw+GSpFj5T8bBBOwk439+RyZ/TOPsEBqhSC8s1om3OVyHKJWwg
         AoVw==
X-Gm-Message-State: APjAAAXR0vbbwH7T6PvdF0uimbrfcYWV4hsA453x68Vz2+tBckHffDpR
        /x7Nl07b7wOOBe7ZtRJ+B3k3VyjrcvOpQkC6boeErw==
X-Google-Smtp-Source: APXvYqwiQJv+l7hi8NcBC2oEZCV3NVvhW7a5CxKdJznaDcZVAyJGmUY+HGwOeLCL/LE9aOUK3Svxkx3emFRRLkLH7iM=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr18717951oic.149.1574566713131;
 Sat, 23 Nov 2019 19:38:33 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
 <20191123092552.1438bc95@lwn.net> <alpine.DEB.2.21.9999.1911231523390.14532@viisi.sifive.com>
 <CAPcyv4hmagCVLCTYmmv0U8-YD5BEoQPV=wtm5hbp3MxqwZRQUA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1911231546450.14532@viisi.sifive.com>
 <CAPcyv4hBNfabaZmKs0XF+UT9Py8zJqpNdu5KsToqp305NASKNA@mail.gmail.com> <alpine.DEB.2.21.9999.1911231637510.14532@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911231637510.14532@viisi.sifive.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 23 Nov 2019 19:38:21 -0800
Message-ID: <CAPcyv4iqTR8s0v8jH7haWCBQAzhZinUEsypiH7Ts9FCf+F9Bvg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 4:42 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sat, 23 Nov 2019, Dan Williams wrote:
>
> > I took a look, and I think the content would just need to be organized
> > into the proposed sections. The rules about what level of ratification a
> > specification needs to receive before a patch will be received sounds
> > like an extension to the Submit Checklist to me. So I'd say just format
> > your first paragraph into the Overview section and the other 2 into
> > Submit Checklist and call it good.
>
> I'm fine with doing that for this patch.
>
> Stepping back to the broader topic of the maintainer profile patches, one
> comment there: unless you're planning to do automated processing on these
> maintainer profile document sections, it's probably better to let
> maintainers format their own profile documents as they wish.
>
> Just to use the arch/riscv document as an example: the last two
> paragraphs, to me, don't belong in a "submit checklist" section, since
> that implies that the text there only needs to be read before patches are
> submitted.  We'd really prefer that developers understand what patches
> we'll take before they even start developing them.
>
> I imagine we wouldn't be the only ones that would prefer to create their
> own section headings in this document, etc.

I'm open to updating the headers to make a section heading that
matches what you're trying to convey, however that header definition
should be globally agreed upon. I don't want the document that tries
to clarify per-subsystem behaviours itself to have per-subsystem
permutations. I think we, subsystem maintainers, at least need to be
able to agree on the topics we disagree on. Would it be sufficient if
I just clarified that "Submit Checklist Addendum" also includes
guidance about which patches are out of scope for submission in the
first instance?
