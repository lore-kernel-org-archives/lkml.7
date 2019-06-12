Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E45C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20DB208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LuS7gSaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfFLTEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:04:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42658 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfFLTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:04:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so16481280otn.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm+mSktMwQOzdmDjQttzxop/Se9urlLSubyC93GJpJ4=;
        b=LuS7gSaW0BGRMk1yfudUHtAoBYQKvzFNUXxlwVYlUwgLqve/5odOm96fueOy+dk3wr
         JnCiH0mwRbkEKhYD/7ByaJvEVvjj8dH87169XEup7OtRPolTcWrSxYG6e7VXkVvpJGRv
         i5nX7zOQlFCF5BNAJfa/lM72KUtF+3Uciofl+omm6sZ9CouKcHFPCV5P8xf0VbWwOwFt
         /woNTQkJ63ZEwhtinkhqDXqjZT7SafFqxlRydcZSgojOlxu/sZug3q+uoerJmx3Zg3p2
         +N/1xX+vYJB3A/GuFz8kc7M9zhPlE2hJTAEsNRMWc6lHVEsqlD5vPB6vXjqrwyHo5DUT
         Xpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm+mSktMwQOzdmDjQttzxop/Se9urlLSubyC93GJpJ4=;
        b=pvCdaqUZPG5P5ww8mss6x7tlTv154LCWzroeckgX+Qg1YLZv7oGq5gEQrBMryW22+L
         EiJ+M9r8Nc0+ieZ3M1AB191AezhhjmAuGNj7v+rSd93FhOTxpRcjuddCHjgmi79wlA22
         uD9j8MvE1RDFDBHoRWwW8lwrbddUF7BczMFoHIQ6nWJuUS7rR0F0PPMkdvib7zKkqZQj
         cNqz+GEp/cTh7hw8/83Hww9mXWn8Vx1J/D0dckJ+3b95AseuSBe4P2QzyjBXQGxR05rW
         Oj6Vyb+2XiCCWt2+FEQEYHtWXQeOJ9G5byPvJMsoqzkcrl3Uxqlp/UbAFCXjkSWEGq1o
         jCZA==
X-Gm-Message-State: APjAAAWWWcP8SP0IEuV6dAgEi/32U50qghvu5eA3ZKZyra+JA/7cGsMb
        RHcatP6Nj1koo3g1zbZPUK9n3V+pbLNEdLpY7zQyUg==
X-Google-Smtp-Source: APXvYqxvJTu577fQoKcjkYpWtOb5YYd/YL44ZHZzH9wLurkBS4Udi6HfEgZVwQ1tDKxNk2V77DLY+1ueAa7R3cyNUO0=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr9613478otk.363.1560366263877;
 Wed, 12 Jun 2019 12:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560364493.git.mchehab+samsung@kernel.org> <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
In-Reply-To: <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Jun 2019 12:04:12 -0700
Message-ID: <CAPcyv4g08r6bK_SyTjzKFRM7=wpTQLdmHqRSGh7r-e9YD4tq5Q@mail.gmail.com>
Subject: Re: [PATCH v1 29/31] docs: nvdimm: convert to ReST
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

Hi Mauro,

On Wed, Jun 12, 2019 at 11:38 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Rename the mtd documentation files to ReST, add an

s/mtd/nvdimm/

> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.

Looks ok, but I was not able to apply this one in isolation to give it
a try. Am I missing some pre-reqs compared to v5.2-rc4?
