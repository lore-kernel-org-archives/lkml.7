Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850BAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5572083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UnRnfO0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF1Qcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:32:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35338 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1Qck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:32:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so4704410oii.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSSGw8NEH11ewDdufk/0bURDdPjPPEZM8INGXLUnbI4=;
        b=UnRnfO0Nkq0CWLy0+jnDM8ue7U956sKozY+AKoPt5xRTIRRw6jIBvwQFZkI8xtiY7l
         bn5QpKa/NwVVD/pzCkjRzlhwk7NyOe2D2TKYDVR0YHpUx+sRdCvEqqY44do86XDzWfLx
         XfWTtUhAU8VqhOwhesKkvAgbJb83oJXyq/rK/aUyL2ErWSKQ6Xxk74bZsh9+wV5pJLj4
         fRPeMkH08JPr+B4SWknFZnL81j2AE0gCsftdycEsCOqC+3DPt4F3qdoRXs8mXU5CoqC+
         GTCP4pL7SsstbHnRYi6+AKdXAib6v9FqeSbLi5gJDoFvHqzgvrQYghU6hOGYbYqO5aCE
         7iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSSGw8NEH11ewDdufk/0bURDdPjPPEZM8INGXLUnbI4=;
        b=rv+VRvBNnJavuZU29NFlbY7Hjiohv24IRgUYbgukRhak+lRmDZFYCsonXgTLh6FMNH
         4xwKAhYa7ETFDU/4YrWqNlqrjl72cnEHOxRDu5iiC2Lr1fuqbgWCD1pKTghZokw/x211
         vfIPHhM8k18j/Ks2cNcawiMwBL8XZ+dL1aixNPCjZQCUQaUlNhgnFtEQZiQpPo9z08W/
         6c5iGIjAqypGHozSo/N8f0hy7HSXO5Gb1ZN0kF6DqUFe2ujdeUdt3EbXyq8mzD8DlhRO
         1CReEA8H9dOGf/5YWODdnlOndL+pHViREl426qyJ6vRAHlgNanfUiHpwXsHxHFlcfdsi
         BJKQ==
X-Gm-Message-State: APjAAAVzYcifLLrZywmr8QAb5g8axITzghUy79vR8Rz59T7aN9rmaeQ4
        Gsj/Zeg9PMXUHZv7fzzMXCzzRHWPbNGMx3Y+AgO3Sg==
X-Google-Smtp-Source: APXvYqxih5y3ClRM05oqB9q9VPsU0VTaOI1Z60yEi/NkQKAhhvUNxdezdMDupWBvEeRdmvEWNaxGW0AWHHTUwFYwhGw=
X-Received: by 2002:aca:1304:: with SMTP id e4mr2181365oii.149.1561739560073;
 Fri, 28 Jun 2019 09:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561723979.git.mchehab+samsung@kernel.org> <951fdc9197ffd04cf77168d47685e1299f7d9d73.1561723980.git.mchehab+samsung@kernel.org>
In-Reply-To: <951fdc9197ffd04cf77168d47685e1299f7d9d73.1561723980.git.mchehab+samsung@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 09:32:29 -0700
Message-ID: <CAPcyv4jnz+Cz4sXEDHPiX77BV1piBkbh7LHgs-rUf39NAB7_gw@mail.gmail.com>
Subject: Re: [PATCH 30/43] docs: nvdimm: convert to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:21 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Rename the nvdimm documentation files to ReST, add an
> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Dan Williams <dan.j.williams@intel.com>
