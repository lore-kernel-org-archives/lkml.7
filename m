Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75BBC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAA322303
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cFizdKjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRUwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:52:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33351 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfKRUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:52:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id y39so21919891qty.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wF8dAQ1iBmtjAKVyWqtOo18AFkp8cJSHW5qL0Tql1gA=;
        b=cFizdKjNblrM9pzSQ/2fHMOquDVEhNIGZlQjpXW1fPigQ1iAqdBbfn0uBwZII7Egjh
         Y3N3A9TxlqPZnvzq/oSRwHEyqUyAym3zxJFA5/2Qx0HyQ10Kj+L8/HnbPqFlC/PLpxzI
         KErp8Ulh04eV047AZRTA2HzUlLSHoWEmPPh0H9ERRlXiXXpPshFjmaArAXuoBlVvjCOj
         k5mWzCyRRC6SAJeScUI/ml3LScttWyjRYcaashMysWMrcJLuVdtb99wy+/N0B0+5qXAc
         s6uoecRtKGJiLL0jaF/2MrutzFaWSU5wg3LS2tLBzDcK2QvQL3c5JlYgFs42W12FyAu+
         ERyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wF8dAQ1iBmtjAKVyWqtOo18AFkp8cJSHW5qL0Tql1gA=;
        b=E8NKJvyI1yy6FqZ6jAjh8tXEz7Ea0tuZLujdpxPLbhpJVyqPQCZ7SzpWYe2cQa7A5l
         kGstBvcU1Ey2nhIMkwnfbixBAPPJrC9EEo+jL6kIgTeh4dRCcEI/SDP+6Bw3mCAAHK+5
         bgF55l0g0kmSQHk2VPEvL8N66LkLDAdIJ0KsejEjGUwKBi/1czoPoVQQFiQ4HB6nMMMg
         PrRQm0fjJkZP3Qf6c267AL9UQlgswqr7diKQoV/MUHMm/i2zyGpZAf9SUVh2BDvaSY6N
         iQBUoDwG16yA9cJz8yRObk8EctqSsTZQDO6W+QR6QOucvMxjp9Hp+3aJyx7GwgY3bvB5
         3axg==
X-Gm-Message-State: APjAAAXhZVCE/Q2IuveA5YvzTTDkwjE4LiZdmslrftX8KZCzcNqDZrYW
        C7dIEOYGrK2F9IB9cfpbMRK8Oc3E2oU=
X-Google-Smtp-Source: APXvYqxRI+aaNBjQe2GeWbyPxDWRDrPycVcSjg/+2tN6gpSXgiYFLJur4KAM0FeIoScMd28yoX9RWw==
X-Received: by 2002:ac8:4816:: with SMTP id g22mr29724969qtq.112.1574110337500;
        Mon, 18 Nov 2019 12:52:17 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p59sm11014913qtd.2.2019.11.18.12.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 12:52:16 -0800 (PST)
Message-ID: <1574110334.5937.142.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm/vmscan: fix some -Wenum-conversion warnings
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Nov 2019 15:52:14 -0500
In-Reply-To: <20191118182853.GC372119@cmpxchg.org>
References: <1573848697-29262-1-git-send-email-cai@lca.pw>
         <20191118182547.GA372119@cmpxchg.org> <20191118182853.GC372119@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-18 at 13:28 -0500, Johannes Weiner wrote:
> On Mon, Nov 18, 2019 at 01:25:49PM -0500, Johannes Weiner wrote:
> > On Fri, Nov 15, 2019 at 03:11:37PM -0500, Qian Cai wrote:
> > > The -next commit "mm: vmscan: enforce inactive:active ratio at the
> > > reclaim root" [1] introduced some Clang -Wenum-conversion warnings,
> > > 
> > > mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
> > > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > > [-Wenum-conversion]
> > >         inactive = lruvec_page_state(lruvec, inactive_lru);
> > >                    ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
> > > mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
> > > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > > [-Wenum-conversion]
> > >         active = lruvec_page_state(lruvec, active_lru);
> > >                  ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
> > > mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
> > > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > > [-Wenum-conversion]
> > >         file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> > >                ~~~~~~~~~~~~~~~~~                ^~~~~~~~~~~~~~~~~
> > > 
> > > Since it guarantees the relative order between the LRU items, fix it by
> > > using NR_LRU_BASE for the translation.
> > > 
> > > [1] http://lkml.kernel.org/r/20191107205334.158354-4-hannes@cmpxchg.org
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Thanks Qian!
> > 
> > Andrew, this is a fix for "mm: vmscan: enforce inactive:active ratio
> > at the reclaim root". Could you please fold this into that?
> 
> nvm, I see you already picked it up. Thank you!

Hmm, I don't see Andrew picked it yet.
