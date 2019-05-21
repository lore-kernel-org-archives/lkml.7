Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B59AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF84D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558414913;
	bh=SBlJXfUBXXFK65r3s5xX8606kKlKlqk3uqfNMpr45i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1sVRORO1u3rJKsWDcKl6ixJXAiKWtYjXL2qDM7w9PuCyWX4QdzyKsso8be6s4DT9i
	 0v6LpygHh+Q62FHKoQFDEz6MSJZIYz/2D5Skmk4R2WooqHC+6MU5OxJDxBxc90rr+Y
	 fK49/LOYdMXZLEIbH3Ch0+NymLSg2ymoYDLjzZJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfEUFBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:01:52 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46028 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfEUFBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:01:51 -0400
Received: by mail-pf1-f173.google.com with SMTP id s11so8378989pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QoDuJHrLBQ/xwGBwHKCt2IBJytG8/Ex5Sv/y0ADsw9A=;
        b=j6GM2Wd15hhYbHOpmjGikLz1Yeo8XKNvknmNfEyF4ygPaaXBNSh6MEOembaOV6xba5
         5lgIbRbxvKNW2MBKsDZ5qYikCnCq5FQlHcx3r5v2Xt3nzvJlEkPTkTY0vitEKORsfrLJ
         t0G+0bT2uvVuXYIeWA/clAlNGdGrDJHUxBPTWTRWcM+epfdoB9ifCLdS8BYINhPU1y5o
         74BaFoZ8ibyH+goPRw9iMY3cLhpRHuTt7b1qYg1e4Abi3JU/xfbsu1CimUBvZAX41rNv
         QurGjtazYmaLBIhndMYwtMMP9u3pAYR0PlvWjv6zwenkmsbJgigfQD6WYqpWgtn7tqTd
         11jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QoDuJHrLBQ/xwGBwHKCt2IBJytG8/Ex5Sv/y0ADsw9A=;
        b=iwoaeUJD574V6JthGsDBcPK0GnFCzoVf3dxFIQweZHCvrGV8lN4LMbMKFESFhw1BJf
         VxeD6Fz1y9HTnfP1J6sUfwqJTEAbLAnd1/dJGhK8b23niueElhrHz3d1KJxECNgexFkU
         9uIyIUWVOHxl0CEorRxuwxbmts+Iz3xG+wgLJFutn8a+x6F/Zt3y11SCcdlrw8u3qae2
         7MwRMyp1sm1Gafxy+gT7zRFZ02JNf5cpcfCA77DDT4+aXEN42LuNUHk6oihx3G6jT0HY
         nz1sr6D8jFZV9Zl2sXOLnKA8UO2xivDB9Q2nkmzXU6cQa6ZbmKK6wC+t7rwmQB3EQ77N
         GSsA==
X-Gm-Message-State: APjAAAWw8d9OuRcy8n/Do+T4X2qSnzV2fNhFgQceJvjRogpNTtnchRUE
        nv70AdSck97vNbygGw0DWTuG3Afg
X-Google-Smtp-Source: APXvYqyJH0J5FSk3fdPjh9d4XeRJ+4EEk9eUbgIyEI9pQ/tWso7pSHIofovJWiwS4/R/xQ1KB0n76Q==
X-Received: by 2002:aa7:8f2f:: with SMTP id y15mr74227321pfr.124.1558414910967;
        Mon, 20 May 2019 22:01:50 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id p13sm12382900pfq.69.2019.05.20.22.01.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 22:01:49 -0700 (PDT)
Date:   Tue, 21 May 2019 14:01:44 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521050144.GK10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521014452.GA6738@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521014452.GA6738@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 06:44:52PM -0700, Matthew Wilcox wrote:
> On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > and MADV_FREE by adding non-destructive ways to gain some free memory
> > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > kernel that memory region is not currently needed and should be reclaimed
> > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > kernel that memory region is not currently needed and should be reclaimed
> > when memory pressure rises.
> 
> Do we tear down page tables for these ranges?  That seems like a good

True for MADV_COLD(reclaiming) but false for MADV_COOL(deactivating) at
this implementation.

> way of reclaiming potentially a substantial amount of memory.

Given that consider refauting are spread out over time and reclaim occurs
in burst, that does make sense to speed up the reclaiming. However, a
concern to me is anonymous pages since they need swap cache insertion,
which would be wasteful if they are not reclaimed, finally.
