Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7FC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95117216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="cJY93XdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbfI3NEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:04:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38758 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbfI3NEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:04:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id l21so8557501edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X92OS/YmMaYZnmIebA59VUdwEwr03gpB8PIctXgbJZ4=;
        b=cJY93XdHuqF+imwwh62tcdky9RZEwqCQpzVJai8K40Gou9OtqAcoT7MhKJQ6O5Cc/A
         LjXpPigLgUd03NnABftRxqMgDJuRqWC40hRxzdmit4MTcsraNw3RQuiNTWzh+FIcITZG
         1ty/HtNKR+IyYN6Wb47vn6iIVymFi08uQ/8gC1i7u5vjh/U8gbBs1OsiYyWW0EDD9R6w
         52sqJtJlSwFRHLc02izDHy/P3KZF38xTMZ5jeCIyG7+C/R369yWNWcpIhXrrPL7hEFxw
         VS0GMqx8XiuLt9dflM3IPCNeRygSUUlKdWEqNxtWdjkg96I3mY84D+bSsiq+qjp6XJPB
         m8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X92OS/YmMaYZnmIebA59VUdwEwr03gpB8PIctXgbJZ4=;
        b=sdFlCp9xCWXtEB5ZKuPT794yYy118t1A1PX6PPVA3UHX9whMpxBc4fwZotmsVi9yAs
         19fmWJ+kakhmv1mz4GrEkQYLTHQmXh4zcf/cBXTjBWzYhLKQz6QHPAbA4E3UASqMy3zW
         csfRLs8yVeTCdijk4ULga8lBYrWMJk588iSokiwWXIGs+Xcuaigsewe+1szwR1Wkv/Jd
         4GEgnmdJ3cIGpBP2cNb4GHCccqKHEium9PYjajhe7uLh18kxFHlzJM7O/6HzLatMRVr1
         xdW/Phh+G5o70ZA+z7kMXRScuSNyyENAUSwYhnnhJF1yi/11CdZ61wQmC+RxRsBwqJul
         fvEA==
X-Gm-Message-State: APjAAAWIMf4gBnxnuTrVdqRvErluvmbnEkEZSNRRpdNQj5UNndCoPSx7
        rJWaSBBPDEIJb4lBFeDd5EENK2FTIS0=
X-Google-Smtp-Source: APXvYqzelB36HojuzAqNfWSyrjONv3COCBUzGnQRje/uJA4lFQXG93gbJIZP+wzSdnBe8CIKycKesw==
X-Received: by 2002:a50:ab83:: with SMTP id u3mr19213587edc.228.1569848639143;
        Mon, 30 Sep 2019 06:03:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a50sm2437505eda.25.2019.09.30.06.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 06:03:58 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3569C1020E6; Mon, 30 Sep 2019 16:03:57 +0300 (+03)
Date:   Mon, 30 Sep 2019 16:03:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
Message-ID: <20190930130357.ye3zlkbka2jtd56a@box>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <20190927121754.kn46qh2crvsnw5z2@box>
 <CAHk-=whfriLqivyRtyjDPzeNr_Y3UYkC9g123Yi_yB5c8Gcmiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whfriLqivyRtyjDPzeNr_Y3UYkC9g123Yi_yB5c8Gcmiw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 09:39:48AM -0700, Linus Torvalds wrote:
> On Fri, Sep 27, 2019 at 5:17 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > > Call it "walk_page_mapping()". And talk extensively about how the
> > > locking differs a lot from the usual "walk_page_vma()" things.
> >
> > Walking mappings of a page is what rmap does. This code thas to be
> > integrated there.
> 
> Well, that's very questionable.
> 
> The rmap code mainly does the "page -> virtual" mapping.  One page at a time.
> 
> The page walker code does the "virtual -> pte" mapping. Always a whole
> range at a time.

Have you seen page_vma_mapped_walk()? I made it specifically for rmap code
to cover cases when a THP is mapped with PTEs. To me it's not a big
stretch to make it cover multiple pages too.

> So I think conceptually, mm/memory.c and unmap_mapping_range() is
> closest but I don't think it's practical to share code.
> 
> And between mm/pagewalk.c and mm/rmap.c, I think the page walking has
> way more of actual practical code sharing, and is also conceptually
> closer because most of the code is about walking a range, not looking
> up the mapping of one page.

I guess it's matter of personal preferences, but page table walkers based
on callback always felt wrong to me.

-- 
 Kirill A. Shutemov
