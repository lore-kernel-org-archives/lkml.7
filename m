Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D60C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEA6208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="brKoMC2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfFGUKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:10:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39659 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfFGUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:10:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so3000095otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlVygW5HX3gMOqI9iagu+o2KfHmRD4CVE+mKAqVQHDc=;
        b=brKoMC2YNPiZDdbuJUJptjoM9KaSU8S4ObGocQkg1KQo4JtkdYErEgLDttxwqmD1JH
         dL/IlNi9BXKIc8G2/scgxlh4GMR1LPlSwT1q5vcXHrdpTfXILVnLCPxnCBYk7gUFnfFF
         NdgiE59NbaWDqNP5wfElrVabi+k2yJJyvfJduho23fxEAZDaN8S5AlfdlL96Y1r7QtR1
         A3okrfILjOgYAttOW90Hvjo0YcQe/1HvRH2+1CnF6pxcSFE6miNDAwBkMxuMaeftbxpC
         eVrIbhAE3WWKVoxN2mrCw1iTp9wy3oCPHn39dU3YvYz4bSqNGMa2gZQYQQPeD7kvC730
         R67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlVygW5HX3gMOqI9iagu+o2KfHmRD4CVE+mKAqVQHDc=;
        b=olOhLO/QuUukWv20Zl/7aE76Bsrw4JeBJj1uV3GfDZPtQOojHQQZaocowp45VTWmKk
         voJlAPW2CJBO43km096RtGqY7yjYKdWJUdWoONdfxwDPODk9gurlaM3z2EkmaqkJf3AX
         OqyQzf1OY3qQNMQUh4j8ZiKmsxnOjFKUAFsY0o/XAkkgvPygegbIxf4Lx3o9sujRx/up
         wH5h/xRKFnnv0Yo/UqgUWPBRCUCnTBqzAx96tKHX7q+zZKIbVYvN45Azny4dF2rvZYPN
         TLHIrYtld3U752E8X++ybbbwPgeFK2o+4nE5jAuPu6GQ42cP0Y/YjUYNdpwRIPuhFCic
         riRA==
X-Gm-Message-State: APjAAAW1vT6JWBrCgJyRCzXyaFq9N79W14Rn2CdTw+saxBoUIRuvtNId
        QDozXa0McsMVixBaRvrO4AK/D0sfz8T5ly69Qziitw==
X-Google-Smtp-Source: APXvYqza6PFTcS6UhXtsr41/gRao+O5Nm4kLPIDhyAJGiSy5KNxsRBiCwJGc9Q8H+D6BnJ2xLKRvXnTj8YRz1komqIE=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr20388166otk.363.1559938209740;
 Fri, 07 Jun 2019 13:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
 <CAPcyv4hHs75hYs+Ye+NHHiU31C6CnBqCFdo=2c5seN7kvxKOrw@mail.gmail.com> <20190607125430.81e63cd56590ab3fea37a635@linux-foundation.org>
In-Reply-To: <20190607125430.81e63cd56590ab3fea37a635@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 13:09:58 -0700
Message-ID: <CAPcyv4iSndjxgQZq1HtsyY5=h837b-MY3FNDzAdrBGiKJGwOvw@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 12:54 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 6 Jun 2019 15:06:26 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Thu, Jun 6, 2019 at 2:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 05 Jun 2019 14:58:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > At namespace creation time there is the potential for the "expected to
> > > > be zero" fields of a 'pfn' info-block to be filled with indeterminate
> > > > data. While the kernel buffer is zeroed on allocation it is immediately
> > > > overwritten by nd_pfn_validate() filling it with the current contents of
> > > > the on-media info-block location. For fields like, 'flags' and the
> > > > 'padding' it potentially means that future implementations can not rely
> > > > on those fields being zero.
> > > >
> > > > In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> > > > section alignment, arrange for fields that are not explicitly
> > > > initialized to be guaranteed zero. Bump the minor version to indicate it
> > > > is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> > > > corruption is expected to benign since all other critical fields are
> > > > explicitly initialized.
> > > >
> > > > Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > The cc:stable in [11/12] seems odd.  Is this independent of the other
> > > patches?  If so, shouldn't it be a standalone thing which can be
> > > prioritized?
> > >
> >
> > The cc: stable is about spreading this new policy to as many kernels
> > as possible not fixing an issue in those kernels. It's not until patch
> > 12 "libnvdimm/pfn: Stop padding pmem namespaces to section alignment"
> > as all previous kernel do initialize all fields.
> >
> > I'd be ok to drop that cc: stable, my concern is distros that somehow
> > pickup and backport patch 12 and miss patch 11.
>
> Could you please propose a changelog paragraph which explains all this
> to those who will be considering this patch for backports?
>

Will do. I'll resend the series with this and the fixups proposed by Oscar.
