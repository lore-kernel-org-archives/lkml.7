Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2790FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E930220644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlqMQuV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHMXbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:31:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36783 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMXbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:31:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id g4so3427529plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=D76e59tgTT4fezI865GZqOOIIhHiE8Pz1mvIdiTRYog=;
        b=QlqMQuV+hLDHY43nxqRuLY882x3N3q7FhzRdnEtDOkbYGGrf8gIuaIMb9Dy/XVkrSC
         QKfMtfAs3gYKOFmSMG4UESwnRiRKC1D8JpHMPFtxjjx3ke8KjRQnOEWCNs3yAwFUM+gN
         S4OEUPPh1H+2HFvBBiTIctOOU69HwlxYQ2LaE3axijBsYzFAgcufRlU5lYnWzXK/7k8v
         3mDs7onMy+HIZSEGXATbroj9J2Tq3JY4jRKQW+XEsGaZjJ5se4c+81n++TQQaQumrpHT
         qXOQHKEu28o8IpP8J3WuEco5Ba7RZIA31/U7FUzgNubTGu7xmsk3ZJs839mLPOXwxQBx
         6UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=D76e59tgTT4fezI865GZqOOIIhHiE8Pz1mvIdiTRYog=;
        b=bwh2PIlXtCvFQrm6kQRcDB3ory/olGi9MGka26jtsekDipwJqAxWc2PAkiXf/Fz0KK
         /yQnFeG7bfehBY6eFcaahPnM3IJfLgZaLyfy+eBR3WuBd2zgR8GWIkeyBFpHH89Xj0pM
         6U+Np74OcR+hOOV4nTUAov491d3XBh1FaSvjaFW1EcTb1nEn7CaKJSZv2qUB9/y2IejY
         9t65QzUcPd7w7mKsn/WS5NG9TTBRdx0BvMNhw/5bOr26kUVt8DosAeoAKzu5wndy8Cej
         K9R9+VTSYKz2q0tBEUMxQWi5u+0/1XnycVyjRcbITIYK2GtZwgU947XSYFtp5szeVRoU
         wJCg==
X-Gm-Message-State: APjAAAWySeWxJBY9C9FLzVlUvjNQtpxdOYNqvnC4X0t1fJXQDHz3oY34
        QpUAizp+Tcr4XEIyjqnpCp5sQBmpHVA=
X-Google-Smtp-Source: APXvYqye3wWNbrVXfL7AlwcDjxnVPIKFZs78APEFo8F+LDE4XyMBjtlCEd17D10uCu0tIqye0ruyMw==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr5825768plb.238.1565739096913;
        Tue, 13 Aug 2019 16:31:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u7sm109745096pfm.96.2019.08.13.16.31.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 16:31:36 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:31:35 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, page_alloc: move_freepages should not examine struct
 page of reserved memory
In-Reply-To: <20190813141630.bd8cee48e6a83ca77eead6ad@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1908131625310.224017@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com> <20190813141630.bd8cee48e6a83ca77eead6ad@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Andrew Morton wrote:

> > After commit 907ec5fca3dc ("mm: zero remaining unavailable struct pages"),
> > struct page of reserved memory is zeroed.  This causes page->flags to be 0
> > and fixes issues related to reading /proc/kpageflags, for example, of
> > reserved memory.
> > 
> > The VM_BUG_ON() in move_freepages_block(), however, assumes that
> > page_zone() is meaningful even for reserved memory.  That assumption is no
> > longer true after the aforementioned commit.
> > 
> > There's no reason why move_freepages_block() should be testing the
> > legitimacy of page_zone() for reserved memory; its scope is limited only
> > to pages on the zone's freelist.
> > 
> > Note that pfn_valid() can be true for reserved memory: there is a backing
> > struct page.  The check for page_to_nid(page) is also buggy but reserved
> > memory normally only appears on node 0 so the zeroing doesn't affect this.
> > 
> > Move the debug checks to after verifying PageBuddy is true.  This isolates
> > the scope of the checks to only be for buddy pages which are on the zone's
> > freelist which move_freepages_block() is operating on.  In this case, an
> > incorrect node or zone is a bug worthy of being warned about (and the
> > examination of struct page is acceptable bcause this memory is not
> > reserved).
> 
> I'm thinking Fixes:907ec5fca3dc and Cc:stable?  But 907ec5fca3dc is
> almost a year old, so you were doing something special to trigger this?
> 

We noticed it almost immediately after bringing 907ec5fca3dc in on 
CONFIG_DEBUG_VM builds.  It depends on finding specific free pages in the 
per-zone free area where the math in move_freepages() will bring the start 
or end pfn into reserved memory and wanting to claim that entire pageblock 
as a new migratetype.  So the path will be rare, require CONFIG_DEBUG_VM, 
and require fallback to a different migratetype.

Some struct pages were already zeroed from reserve pages before 
907ec5fca3c so it theoretically could trigger before this commit.  I think 
it's rare enough under a config option that most people don't run that 
others may not have noticed.  I wouldn't argue against a stable tag and 
the backport should be easy enough, but probably wouldn't single out a 
commit that this is fixing.
