Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF466C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B604020665
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CS6BO+r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEaERV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:17:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34744 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEaERV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:17:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id u64so6762795oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b7zMtPyyoD7Z9H0ZcAMOMDecBLUC3B4wOXIPVDeoac=;
        b=CS6BO+r0JW9ceL73927ELSkUvJTEKgXX5d2GEA9im/bil/5XILFxf2n+JoVpDxAOQg
         p56uLAxZzgOfT0XX0L20Vm5uXC0SUX5RuImjl8jA820vIjcXM8U+KaCcdTSJ2YzayXm5
         ZUgMZ9kBllyvxZiqB6VnZORFA0fvmvRsC5pPOpXZ/w9W6WVqD55gBeW2Hz6ohgTEyc4w
         Dq2w3csJ0lnkSAzAvNlNOyD4zHirgUaJ1ds2y/C0e4G9GrZEDD88y1aN5TaFgceavrGg
         vpL/4OC1IOPY4HHqpSusL5qd2VVww8l+sTRupWy8p8rLplToV7VLd9ZoGdQGLY0xyhev
         VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b7zMtPyyoD7Z9H0ZcAMOMDecBLUC3B4wOXIPVDeoac=;
        b=Uzqvj6YCpCGovJAQO9ytPQKO6tY3dziEjDBsEAG0LyT6K9wOlfIeb7lNCAAjOi1ENP
         GYhT0+LB3Ql+48MyboCYhTxtfBkKpQAZ12OiQgQEv74BUDZ4sG6P5y7scMpMHUz9ydl5
         ADS15OCl5HS681flpItB6eRwYcMtdgNdW39RlF9Vgh1MGrLAY39a/N98IxfTIuf7m4Kw
         bT/Jk/tvHcKJ1VJ3wmhlol9wOLqitI0vo1Vwd1mGA2jh/KsBVa8SnUhERN/oZHnIxoQC
         Ihqm2n6aYODvSfKA6OIY/9CFjCgtbSZOl2D5JuG9+Ourus7F7OjG3CqlpEsOkzDSXD5h
         nlrA==
X-Gm-Message-State: APjAAAUAkjyGWPLDAEwi8S93Vdf0y3aDG3czZxMFUhlhNUqFsWI7b3y3
        0+gpgiqE0+sIkMy4dRb5D+pRMWTdk2JT78qQ64q4xw==
X-Google-Smtp-Source: APXvYqwzamlHcYCuE3bgAAH931eEoiZhZTHrMpm39gRZfwR3xH7d4NpA97rBUXSRJY8nTk5JwxAjuIV9SwroNgxQ3Wk=
X-Received: by 2002:aca:6087:: with SMTP id u129mr4677154oib.70.1559276240560;
 Thu, 30 May 2019 21:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com> <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
In-Reply-To: <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 May 2019 21:17:09 -0700
Message-ID: <CAPcyv4jJjCwbWJH648x04Cms1kXY2Cd36bxpgmDGRh+5Van1fQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 12:22 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-05-08 11:05 a.m., Logan Gunthorpe wrote:
> >
> >
> > On 2019-05-07 5:55 p.m., Dan Williams wrote:
> >> Changes since v1 [1]:
> >> - Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)
> >>
> >> - Refresh the p2pdma patch headers to match the format of other p2pdma
> >>    patches (Bjorn)
> >>
> >> - Collect Ira's reviewed-by
> >>
> >> [1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
> > This series looks good to me:
> >
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >
> > However, I haven't tested it yet but I intend to later this week.
>
> I've tested libnvdimm-pending which includes this series on my setup and
> everything works great.

Hi Andrew,

With this tested-by can we move forward on this fix set? I'm not aware
of any other remaining comments. Greg had a question about
"drivers/base/devres: Introduce devm_release_action()" that I
answered, but otherwise the feedback has gone silent.
