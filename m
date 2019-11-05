Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE652C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA83C2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nlvsZjH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbfKESWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:22:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46952 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390482AbfKESWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:22:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so12333460qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pnwArkk6ewZsFBfzlCm3QSvIZcXfQdL2gI9zc05CV1E=;
        b=nlvsZjH1/v7T7M6TqgkCioCKmz1lID0W8fR+qzL+g/Xn3iWW1er+tjFVk9Gs9AP7dH
         ivEVfwM0ScPftyQepjpAECysvrOUJmwlSkPPqoL+SDeEXcKZ+fD+cAGmu1N0ws03mGmJ
         0Ix/asaCYyEIXt6+6bZ4X6q4F5jZzwoUPq1dGMVTjfKrwYzuHPMor6XGh7TjQj90Y5Xn
         5mqVt3wklr2TrMksiyqGLFvzKRCN6ihL3NmJnWov4k+0hy4qTaj2gQhuqOa+h7CdHJD3
         D83ltspXhmYuxNUYcBomVDahfBgFTsaTxWM6eaa6xBEeGagAsLvgX3VH6lxYeGvYyQID
         3Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnwArkk6ewZsFBfzlCm3QSvIZcXfQdL2gI9zc05CV1E=;
        b=bT9WcXOmtGLYPHVN83IZuM7mmSHpvz50+AVHwpIBGoBqDQ5adMr8MXw4BBP9W/hsKy
         WZoCc/P+SLYRvcL3PtOx+N3vZsciKoL3eP1CKMwMoYLSDlt7vlKilIb7CKKgCJBg3b7L
         5qqAbOHpve27M6UHewRl8hzBtwX40FHeLG9LcfxSnGlqusr9sd5AFH9Umi6oUkaHMXow
         F5LFFbgUELi+u2F8Zuj+KZDUmNss/5GSgamYQr6nBQGuofesxbYRtLEVGTaD8hLR9Wj/
         7RhuEyZCCfOf3DW2Je4WcLxIiBLYhvRyP0vRsN4l5tHVRwoVKna7Idi5tTcNBnFJHIEQ
         5rqg==
X-Gm-Message-State: APjAAAXoZI+yyl2vwJcnLxg7cMZG/Nee26osA8ByHrU0rdzo0iuAaVVp
        3Hp+6mkRJoMXq2/BFbEADR3roHfpbuJvBg==
X-Google-Smtp-Source: APXvYqzTE2dK5t9yErXB0WIlCJJUNmO9NqBx8CY3gyQ9my8nFV2bmkgGmd/egZlpvBU6xej+4vPoCg==
X-Received: by 2002:a05:620a:20de:: with SMTP id f30mr15185617qka.310.1572978133186;
        Tue, 05 Nov 2019 10:22:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5685])
        by smtp.gmail.com with ESMTPSA id o3sm14050216qta.3.2019.11.05.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:22:12 -0800 (PST)
Date:   Tue, 5 Nov 2019 13:22:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     snazy@snazy.de, Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191105182211.GA33242@cmpxchg.org>
References: <20191025120505.GG17610@dhcp22.suse.cz>
 <20191025121104.GH17610@dhcp22.suse.cz>
 <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
 <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 04:28:21PM +0100, Vlastimil Babka wrote:
> On 11/5/19 2:23 PM, Robert Stupp wrote:
> > "git bisect" led to a result.
> > 
> > The offending merge commit is f91f2ee54a21404fbc633550e99d69d14c2478f2
> > "Merge branch 'akpm' (rest of patches from Andrew)".
> > 
> > The first bad commit in the merged series of commits is
> > https://github.com/torvalds/linux/commit/6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
> > . a75d4c33377277b6034dd1e2663bce444f952c14, the commit before 6b4c9f44,
> > is good.
> 
> Ah, great you could bisect this. CCing people from the commit
> 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")

Judging from Robert's stack captures, the task is not hung but
busy-looping in __mm_populate(). AFAICS, the only way this can occur
is if populate_vma_page_range() returns 0 and we don't advance the
iteration position (if it returned an error, we wouldn't reset nend
and move on to the next vma as ignore_errors is 1 for mlockall.)

populate_vma_page_range() returns 0 when the first page is not found
and faultin_page() returns -EBUSY (if it were processing pages, or if
the error from faultin_page() would be a different one, we would
return the number of pages processed or -error).

faultin_page() returns -EBUSY when VM_FAULT_RETRY is set, i.e. we
dropped the mmap_sem in order to initiate IO and require a retry. That
is consistent with the bisect result (new VM_FAULT_RETRY conditions).

At this point, regular page fault would retry with FAULT_FLAG_TRIED to
indicate that the mmap_sem cannot be dropped a second time. But this
mlock path doesn't set that flag and we can loop repeatedly. That is
something we probably need to fix with a FOLL_TRIED somewhere.

What I don't quite understand yet is why the fault path doesn't make
progress eventually. We must drop the mmap_sem without changing the
state in any way. How can we keep looping on the same page?
