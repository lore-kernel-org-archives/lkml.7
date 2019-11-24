Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25DBC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B2F20714
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cB5mwcAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKXABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 19:01:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44489 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKXABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 19:01:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so9856133oih.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 16:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woOONoIQFVxkt21SOpo2EiodkEkWZhvsKLiAP/7iXdw=;
        b=cB5mwcAlEz5N8Q++7MtpoGtJMCRf5e2J4jWxSgD50GpgOzZ5H/55BmhN5W65ClZ7ee
         KUYiNXQEHMUCUuaObYkohxJf45HrExY6AikhGBLrDwzoXHy/Owg4zjMs7cmBJaKBSnvO
         YRUAQW8yEGTlQbQE8OXs+26ACEGSefijjB1ExjpFk3Kuh0RcQg1ZsL2zxABODygo7qrO
         G5d5GvJQytkMEHgbE+9/jECFUbQJIF3DdZRpKBrjxC4ge3/30U/hIYPkofX47wLu4mtM
         lbr3J+EysGgiLmB5cu1pU01YBzO/wI9Zs/lRmI0ffFUKRCJUkiFjsdE6ol1xxyzKIXgc
         PCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woOONoIQFVxkt21SOpo2EiodkEkWZhvsKLiAP/7iXdw=;
        b=h+OGjFSiaBAwvwd/PVs4OhGJOesd7qKjRcGXq0voF9WBQCXDWQoXYY4pr6b7pqxlE5
         Ssl0uEl8uQfj64ZAfFhgb/Su0Xf6FspNhFOMRj/OvoTxYw40BnQiVNVPCOkqPoXjE1Nl
         7xKRg1HfD+1ZMfO239fomlUwhO9mhH4dNVjh3YvfQJljf6dh8Kixrw/foiE4/GTgWq9i
         CXxJ2H1wX82GyHx15YYW9FmVbW5cGaGsnNul/ueH6/GE+eFNfWTZ9HGR4Xj3sER5Fh/8
         qakmbnQqK5L9vE0g/KCrvDjy1g4UWY5v8QDrE5QiNBvpjewakkYsx+YrHgNspqT42EoE
         H2oA==
X-Gm-Message-State: APjAAAWFrkQvpyYgvXy1pfIlqLm0zF3P7nVCoq4bU91KkVZ7PukGDp3N
        Ky0MYvWcPp9hWr30LTTzpQ6k79yoUtzO2qPIRo3/bw==
X-Google-Smtp-Source: APXvYqwMQpTIvHFrlW8fxxu156JT9NnpWLhNt6g4BECKYFzkCkhExI2nDlsUnUUdocxvVDaoXp/LGEZ7AjZQO7co3+0=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr18330976oic.149.1574553696828;
 Sat, 23 Nov 2019 16:01:36 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
 <20191123092552.1438bc95@lwn.net> <alpine.DEB.2.21.9999.1911231523390.14532@viisi.sifive.com>
 <CAPcyv4hmagCVLCTYmmv0U8-YD5BEoQPV=wtm5hbp3MxqwZRQUA@mail.gmail.com> <alpine.DEB.2.21.9999.1911231546450.14532@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911231546450.14532@viisi.sifive.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 23 Nov 2019 16:01:25 -0800
Message-ID: <CAPcyv4hBNfabaZmKs0XF+UT9Py8zJqpNdu5KsToqp305NASKNA@mail.gmail.com>
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

On Sat, Nov 23, 2019 at 3:50 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sat, 23 Nov 2019, Dan Williams wrote:
>
> > On Sat, Nov 23, 2019 at 3:27 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > > It looks like the main thing that would be needed would be to add the P:
> > > entry with the path to our patch-acceptance.rst file into the MAINTAINERS
> > > file, after Dan's patches are merged.
> > >
> > > Of course, we could also add more information about sparse cleanliness,
> > > checkpatch warnings, etc., but we mostly try to follow the common kernel
> > > guidelines there.
> >
> > Those could likely be automated to highlight warnings that a given
> > subsystem treats as errors, but wherever possible my expectation is
> > that the policy should be specified globally.
> >
> > > Is that summary accurate, or did I miss some additional steps?
> >
> > I'll go fixup and get the into patch submitted today then we can go from
> > there.
>
> I guess I'm still looking for guidance along the lines of my earlier
> question: what (if anything) would we need to change about the current
> patch to have it work with the maintainer profile documentation (beyond
> the "P:" entry in MAINTAINERS) ?

Oh, sorry, I just reacted to Jon's comments. I took a look, and I
think the content would just need to be organized into the proposed
sections. The rules about what level of ratification a specification
needs to receive before a patch will be received sounds like an
extension to the Submit Checklist to me. So I'd say just format your
first paragraph into the Overview section and the other 2 into Submit
Checklist and call it good.
