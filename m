Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C348CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 23:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E5720820
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 23:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fvmToX7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJSXKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 19:10:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39028 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfJSXKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 19:10:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so8010549otr.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 16:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6V+goadp04lgp/6ouBZ08nnuiR9ZWMieowK64fMJJPo=;
        b=fvmToX7RhHX15J5XNflMsTcTNnjDjUc+03b9RJ9IzDfHKW+ha2Pvtrwen5Kj1hOVkI
         7IvzLMfYo5WOsYQPNi1pPjq83hd4BPzrAhD+byEiWhCrqKCHnBfBplkdJANy4Y4xfq9O
         F3MKgd81AdNmz99JPnxqi1dEPJFyfFURzhByULjZd/ddnWi4WsnzwkMfvQAwaCI/KUEQ
         Z/tWnSRMlDqgrueeSLcbfZ5u6IT3Fm3M0RHUENJiofrHx3m6DS6MUS1VXmTvZS+yvbtv
         WMnb9Tp1XzNtcPKkniBWTGF+U3d3aBQm2aSL/r2CtFbkVSW40/sMTmF22l/5SsbiKR38
         7oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6V+goadp04lgp/6ouBZ08nnuiR9ZWMieowK64fMJJPo=;
        b=PLx58od3RWkzymawB/n60qe7CG6LtPXCRnEXhjCKabAQ7vmmLOK/klF0t8f5yqgYhN
         WR1fVnd9kXgITa3F/UuBrWDjSWm4kCIpnP4se8k1BTz2rsLFUWAHmGmczWSiidDE/Lyx
         P0o8qyOmz3hDPHrgxKJpkvweDldt74Ve/RPr4SbDiC73LtujIp8rmmO2UJSsgsUtZFnG
         c1LZACZwJHGJoSmecylrIVxHd2O2vIc7UtAqcUfOdis5PoNfpt4X4rJiKvBgl+RtBgqs
         uMiiujURJi5wSN2W+R2WCEAIM+FbeF/joLGkTC29vNVngl5bTEuGy4qNkxM6ezuJMguv
         cxwQ==
X-Gm-Message-State: APjAAAU8+Rn238GHYf7vBnIJas3L7yZZUnXEWnVex4UGPyeru1WpywLb
        o4qL+fMdDDFKlMEYpj1mNiAM3tODym5dO6DxXTbS4A==
X-Google-Smtp-Source: APXvYqwVmgrM8/hkJM+rSC4kzo3Uext5IYl8OOxkbKEkTk91yIuX8Rv6+rZQ8op0qxcaadFmv/oFPnRqVJ8/JKRoTzw=
X-Received: by 2002:a9d:7843:: with SMTP id c3mr12157037otm.71.1571526612232;
 Sat, 19 Oct 2019 16:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191019205003.GN32665@bombadil.infradead.org>
In-Reply-To: <20191019205003.GN32665@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 19 Oct 2019 16:09:59 -0700
Message-ID: <CAPcyv4jj-BqhPj3vB5=G7YfGPvBgugEZ39gf+3Wwn6BC1fAUJw@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Smits <jeff.smits@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 1:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Oct 19, 2019 at 09:26:19AM -0700, Dan Williams wrote:
> > Check for NULL entries before checking the entry order, otherwise NULL
> > is misinterpreted as a present pte conflict. The 'order' check needs to
> > happen before the locked check as an unlocked entry at the wrong order
> > must fallback to lookup the correct order.
> >
> > Reported-by: Jeff Smits <jeff.smits@intel.com>
> > Reported-by: Doug Nelson <doug.nelson@intel.com>
> > Cc: <stable@vger.kernel.org>
> > Fixes: 23c84eb78375 ("dax: Fix missed wakeup with PMD faults")
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  fs/dax.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index a71881e77204..08160011d94c 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -221,10 +221,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
> >
> >       for (;;) {
> >               entry = xas_find_conflict(xas);
> > +             if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> > +                     return entry;
> >               if (dax_entry_order(entry) < order)
> >                       return XA_RETRY_ENTRY;
> > -             if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> > -                             !dax_is_locked(entry))
> > +             if (!dax_is_locked(entry))
> >                       return entry;
>
> Yes, I think this works.  Should we also add:
>
>  static unsigned int dax_entry_order(void *entry)
>  {
> +       BUG_ON(!xa_is_value(entry));
>         if (xa_to_value(entry) & DAX_PMD)
>                 return PMD_ORDER;
>         return 0;
>  }
>
> which would have caught this logic error before it caused a performance
> regression?

Sounds good will add it to v2.
