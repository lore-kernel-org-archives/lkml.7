Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E80C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E6207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569602409;
	bh=NKyJm/eDMEI/d+lsw/BFZuFVPCPvUMbDCEKMAac7GJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MrB8wyvOwjBahAP8VGcE2rSVxDhgr/h3zP/C2hzV5TYqHZX9ZDudETtQccp5Iy6uh
	 eBusH1OmSk90x+DWwWXO2mGC6ZIKvbq3kHoTSo5MC9Y/xp85czhUpoKEdq6W23r5Ta
	 v9RyZQxtjx966e0QJWCIL2bklITMsojRDZaq+Jhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfI0QkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:40:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43749 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0QkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:40:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so2387838lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xikpq9YYpaESAspYkHi86qdMdW/0HQNg7LvP7+WL5BI=;
        b=IbzOc3i8Qh0m8AF1EsRhezxjzpKCXsufVYfdSoXZLVLOVoGXeqKHkqV7wBluqDOwbT
         MCp9ANQ3eaGMUd8ZEHipocDweq22Nvp//cUG/Wnjk17KiGBd1UpAGJPuLeiMx8y+mZqx
         jxeglbySlcyzMuq1nYuuyMtVfExCtAU9niysk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xikpq9YYpaESAspYkHi86qdMdW/0HQNg7LvP7+WL5BI=;
        b=a4ojgoaqVxgJjwkcVy4vWQci5jZlyw1/FJYbPInn5c60rxJtwuE7K1kDUarBn8wzSU
         KE+imXs00nfxd4FEljbPUwp2EJRg+3AG2lhWvbvsMTrdcYiI6q1IqYAqqKqBw91jJew6
         J/rq2mV2QyHoAORR9MmXj63VIGNYPF+xPxaJ/bhzbjOstdLS2zaBtS0IaDrHTfea4mxN
         UE5FxmaHzpqWGHUYFxwIEYo171KagSquveZZysWLdJtJhmFNyuv6aa4rNFIXNZ7OgX9E
         FkmLVjaFc9ETedPBSxRnsUYu1MPP/xQknzXeH9wk+C4ML2+ZtHLvcHzwbRTqr66/UiSQ
         x5qA==
X-Gm-Message-State: APjAAAVksS5pbRe94k6zsqM5lqMk/bvg96EQpcdXozcKkvu4X1cWPPEB
        D0G6uqPtPSQhzEkjZoAD3Po/8pWd9HA=
X-Google-Smtp-Source: APXvYqw1YCIculcpsttNcLn9q7XR/kW+wzHt1wW/nbQ4zZttV+Ig9MCk6NA1MzQKPEpKF8tWsrn/eA==
X-Received: by 2002:a05:6512:304:: with SMTP id t4mr3541345lfp.15.1569602406174;
        Fri, 27 Sep 2019 09:40:06 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c3sm562829lfi.32.2019.09.27.09.40.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:40:05 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x80so2417026lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:40:04 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr3381847lfh.29.1569602404666;
 Fri, 27 Sep 2019 09:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org> <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org> <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <20190927121754.kn46qh2crvsnw5z2@box>
In-Reply-To: <20190927121754.kn46qh2crvsnw5z2@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 09:39:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfriLqivyRtyjDPzeNr_Y3UYkC9g123Yi_yB5c8Gcmiw@mail.gmail.com>
Message-ID: <CAHk-=whfriLqivyRtyjDPzeNr_Y3UYkC9g123Yi_yB5c8Gcmiw@mail.gmail.com>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:17 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> > Call it "walk_page_mapping()". And talk extensively about how the
> > locking differs a lot from the usual "walk_page_vma()" things.
>
> Walking mappings of a page is what rmap does. This code thas to be
> integrated there.

Well, that's very questionable.

The rmap code mainly does the "page -> virtual" mapping.  One page at a time.

The page walker code does the "virtual -> pte" mapping. Always a whole
range at a time.

The new code wants a combination of both.

It very much is about walking ranges - as in mm/pagewalk.c. It's just
that it walks potentially multiple ranges, based on where the address
space is mapped.

I think it has way more commonalities with the page walking code than
it has with the rmap code. But yes, there is some of that "look up
mappings based on address space" in there too, but it's the least part
of it

And as Thomas pointed out, it also has commonalities with
unmap_mapping_pages() in mm/memory.c. In many ways that part is the
closest.

I'd say that from a code sharing standpoint, mm/rmap.c is absolutely
the wrong place. It's the furthest away from what Thomas wants to do.

The mm/pagewalk.c code has the most actual code that could be shared,
and the addition would be smallest there.

And conceptually the closest analogue in terms of what it _does_ is
unmap_mapping_range() in mm/memory.c, but I see no room for sharing
actual code there unless we completely change how we do
zap_page_range() and add a lot of configurability there (which we
don't want, because page table teardown at exit is really a pretty
critical operation - I commonly see copy_page_range() and
zap_page_range() on profiles if you have things like script-heavyu
traditional UNIX loads).

So I think conceptually, mm/memory.c and unmap_mapping_range() is
closest but I don't think it's practical to share code.

And between mm/pagewalk.c and mm/rmap.c, I think the page walking has
way more of actual practical code sharing, and is also conceptually
closer because most of the code is about walking a range, not looking
up the mapping of one page.

               Linus
