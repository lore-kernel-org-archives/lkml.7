Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC41C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057C2214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="MSya7p2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfIPMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:38:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55516 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfIPMin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:38:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so9941390wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IiRM+xKsPPNK785AJHQsNvEaX+ovm8iVciZ5WRWgrGo=;
        b=MSya7p2w88scUXvlz98XKL839WdwgzcdR4e2c1DXE4eOQlRenBDSNNLPDRs0IBHpyK
         QN8EbT057HBSioqhR9FYeO0Kzf/hShNdk2kw542WUi50aQmeioCsaZx88eXedEeRTIT2
         dEKaZ48m4fdmYRxVbnMGpxN38KOvJC0NWuGoEmPYUK4W1bYYktiL1iud1/mJ3IDDt+Ti
         X3LT0yXq5unvXzHMeEH/7s4j1UwqOD1/S7MkM/DnOm2/lmtchE0TwQMiMyP8gADA/H6b
         CcqZZOuKH+QSi4QB0YKHaLZr5zqRyf5BBcyrLdCGN6ng9Yzsen3x3+elBxwh6Z+OpK0e
         K+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IiRM+xKsPPNK785AJHQsNvEaX+ovm8iVciZ5WRWgrGo=;
        b=gdE393opExdjjBk+1pWqq3bqwguzUeDk0mQC1tv3sw6mTMvWhq5CilUo77qj6Bpp34
         LctPa667l+MIzB1cxaidxL0nYCpLX69gLZUwd8Ax1S6oUR8j6LCA54eeg91Wl5D7PP++
         lZJtyqjXSfRw2Osh1gbLPSqPwejOzR5/lHZSYKWXieYSE64z0hki6F2qTMe1d2fhb2LV
         wGzPhEX7mLntB03SB1vUDPHnoOlcQwz3kb9NnV6Bow0uJ5hhNOez6Jva8Lo9IsNcjwR3
         tvfGvqzrzjpt1n9Gq9RtsPctKf+Ub3JyOqJBu7v4qNyG/qVuQLOE9B/mD47Fd1N0FOG7
         GSVw==
X-Gm-Message-State: APjAAAW0tJ2qei8UgpiEUJP9LBscL2LDifyv6juXhMM7UBTeU3FwiV7+
        7kM+fSXH75u6j6p3fur3RjXs8w==
X-Google-Smtp-Source: APXvYqz2RN/K97dd9WIaMIXyQ8k7wcTOQ5AtOTodcCyzrtMA1lfpcmF3AAoV82XONyqEDdGcS7KH9Q==
X-Received: by 2002:a1c:e008:: with SMTP id x8mr13412322wmg.85.1568637521851;
        Mon, 16 Sep 2019 05:38:41 -0700 (PDT)
Received: from localhost (p4FC6B710.dip0.t-ipconnect.de. [79.198.183.16])
        by smtp.gmail.com with ESMTPSA id m16sm10785101wml.11.2019.09.16.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:38:41 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:38:40 +0200
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 04/14] mm: vmstat: convert slab vmstat counter to
 bytes
Message-ID: <20190916123840.GA29985@cmpxchg.org>
References: <20190905214553.1643060-1-guro@fb.com>
 <20190905214553.1643060-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905214553.1643060-5-guro@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:45:48PM -0700, Roman Gushchin wrote:
> In order to prepare for per-object slab memory accounting,
> convert NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat
> items to bytes.
> 
> To make sure that these vmstats are in bytes, rename them
> to NR_SLAB_RECLAIMABLE_B and NR_SLAB_UNRECLAIMABLE_B (similar to
> NR_KERNEL_STACK_KB).
> 
> The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> so it will fit into atomic_long_t we use for vmstats.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Maybe a crazy idea, but instead of mixing bytes and pages, would it be
difficult to account all vmstat items in bytes internally? And provide
two general apis, byte and page based, to update and query the counts,
instead of tying the unit it to individual items?

The vmstat_item_in_bytes() conditional shifting is pretty awkward in
code that has a recent history littered with subtle breakages.

The translation helper node_page_state_pages() will yield garbage if
used with the page-based counters, which is another easy to misuse
interface.

We already have many places that multiply with PAGE_SIZE to get the
stats in bytes or kb units.

And _B/_KB suffixes are kinda clunky.

The stats use atomic_long_t, so switching to atomic64_t doesn't make a
difference on 64-bit and is backward compatible with 32-bit.

The per-cpu batch size you have to raise from s8 either way.

It seems to me that would make the code and API a lot simpler and
easier to use / harder to misuse.
