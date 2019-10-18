Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62A7222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qaiuU0Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408509AbfJRNcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:32:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43020 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbfJRNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:32:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so4717072lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=syfG/SB9c17JrhI1N+k3VpvBr6cBzB/Bcv38TbgnCxM=;
        b=qaiuU0GoVjsz/FcEqLxFFZ8qZsTLE3jHdRFi++Ifuafz0dbtwSO+XYhUrSxl2sf4Vh
         3nBdCnCbfb2bAfDAegfpRX3zsvhPjlZCAKt3qS/w9rrf6QVThLrKDZG3yLeCGfhVkG3E
         +CN7Gjmezq3qLL7oDOQwbe0tRoGLZzFVVk3CzWbrbVFWRkS435+D0a9f1iAlRqar60LU
         SKqys5I2rTnXWhAYMHS3JAUCn7Oeuij/i5Ga51hMeAEKGkpZOn2b4J4xNSHm4BE93Nie
         qvJR3macVG00ZvCX2a+l++KLa83rTMENA7yJbLjdDhpKEC/GcjBfsk0R+/OE+gAP0NMQ
         2nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=syfG/SB9c17JrhI1N+k3VpvBr6cBzB/Bcv38TbgnCxM=;
        b=AW0f6mdMp09mw04autWIHr6umfMeJx21VY+lX0izMfGzcrOV60tRp9GP2wrRjT0jlK
         FgeqmIxPcCD722dGfpXC3yELjM8ScBTu+HD3LCfBZqL56UJ5LY0bl4g+oR/6Kj0t+2fH
         53TQWtdNo3w724TtPOIeNxDPRAL2nVwq64q6j2eDGgwHiEIJ59/9gvbESkkQJ2P2Si/H
         MFsOQLfCnKbMmnGULYVCr4NT5ceDad3DArv/FjvfPROYdZM6IE+KxeUL6n/f45rbqO9M
         PuTkz32byE0eQoaQP4aaVMLnAGgLPtmdKX/9/KVfs9VFF7QXmWlD7jeSpizPrcMKrcKg
         ajJQ==
X-Gm-Message-State: APjAAAU9UxI8TVOarqxUVV+LhYDmNU56sPQWhqjnb7uVcChpRBIgh0tK
        vbb6ytgKw3kso1OJ6z+1/3Tk0g==
X-Google-Smtp-Source: APXvYqwrxtLRmt+8UAyTlIHQEatVXYuACllCoLjAk0nlKHS8TfYkWurnoaWInEMJmJg0RIhdnUw+sw==
X-Received: by 2002:ac2:4196:: with SMTP id z22mr6088549lfh.171.1571405553345;
        Fri, 18 Oct 2019 06:32:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 77sm2273995ljj.84.2019.10.18.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 06:32:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 13348100D76; Fri, 18 Oct 2019 16:32:31 +0300 (+03)
Date:   Fri, 18 Oct 2019 16:32:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        matthew.wilcox@oracle.com, kernel-team@fb.com,
        william.kucharski@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/5] mm/thp: allow drop THP from page cache
Message-ID: <20191018133231.vifgnueulyo57vpy@box>
References: <20191017164223.2762148-1-songliubraving@fb.com>
 <20191017164223.2762148-5-songliubraving@fb.com>
 <CAHbLzkoTT4p9u__EdFgt7_47NHOV5r=nB8EmvBx+1TcyzX5RJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoTT4p9u__EdFgt7_47NHOV5r=nB8EmvBx+1TcyzX5RJg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:46:38PM -0700, Yang Shi wrote:
> On Thu, Oct 17, 2019 at 9:42 AM Song Liu <songliubraving@fb.com> wrote:
> >
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >
> > Once a THP is added to the page cache, it cannot be dropped via
> > /proc/sys/vm/drop_caches. Fix this issue with proper handling in
> > invalidate_mapping_pages().
> >
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Tested-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > ---
> >  mm/truncate.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 8563339041f6..dd9ebc1da356 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -592,6 +592,16 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
> >                                         unlock_page(page);
> >                                         continue;
> >                                 }
> > +
> > +                               /* Take a pin outside pagevec */
> > +                               get_page(page);
> > +
> > +                               /*
> > +                                * Drop extra pins before trying to invalidate
> > +                                * the huge page.
> > +                                */
> > +                               pagevec_remove_exceptionals(&pvec);
> > +                               pagevec_release(&pvec);
> 
> Shall we skip the outer pagevec_remove_exceptions() if it has been done here?

It will be NOP and skipping would complicate the code.

-- 
 Kirill A. Shutemov
