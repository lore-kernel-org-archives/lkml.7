Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD462075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WzL1+1C2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE0N3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:29:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfE0N3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:29:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so8549890wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+dXzPFPF0QC/08N8/jLGXcjGIV+v/pjQg8Lvb1aVuM=;
        b=WzL1+1C2hQtI9ONr/IqYQEZ+4v1XArIttWiAETlxVdn4U0Xd1Gr6peUX1hFoSTulxo
         DOB5jUtmPKC9AOLSl7nkNoLllSdcLbKe/8sQsKDi3f9Ak0liBKjC/S39b3sLyJdkJCc0
         5WKLezBgJUOPDVnZUgdTZyP85Qg4h94tAac+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+dXzPFPF0QC/08N8/jLGXcjGIV+v/pjQg8Lvb1aVuM=;
        b=oGBbBI7cyVXOOBWhCkPv198GojNdv5cSdZvFuwEetHE6tHjBf68Z70u3dljCsoc4ba
         Nm1mZi6qjAihWqkBzrQtudT3eoNmeDrycX6WWZjvpe1UPCNM4w0yFNgL/Z8x55P8794v
         kBXTX7H4wh06yEpcnd+FStrz6dmCHWlaRVHY9fnKmGTHxFesb5rWGCfrPOj6amn0QoIL
         2jPa0YN5za74Xx2W0psLouyssj85HkHFsMJd59a1q7yw419v/m1mJXXlElKw0FtMCsz4
         w2Yy3Ppu4nZRA4keymfg4zru1Dzqu5S9GDNdEz/F48zMpQoLb8tlOQj11trb2sMdWcS+
         OTmw==
X-Gm-Message-State: APjAAAWbMJdG1AXa/f6GwgIffr6q8Z78SlmB4K/ivw7glqjf/5SrqRaF
        ERW4NcUlXswGlMhY4g4JTCik5Q==
X-Google-Smtp-Source: APXvYqx3FVL85vZsOLhYUKwWkJDyaB5qlY0duEg6rDcbtKj+K4FAMYFxlrwC4j8WWJveRBfJUvOY6Q==
X-Received: by 2002:adf:8062:: with SMTP id 89mr3791540wrk.97.1558963744716;
        Mon, 27 May 2019 06:29:04 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id n10sm5377784wrr.11.2019.05.27.06.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 06:29:04 -0700 (PDT)
Date:   Mon, 27 May 2019 15:28:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm] mm, swap: Simplify total_swapcache_pages() with
 get_swap_device()
Message-ID: <20190527132857.GA1429@andrea>
References: <20190527082714.12151-1-ying.huang@intel.com>
 <20190527101536.GI28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527101536.GI28207@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But where do I find get_swap_device() and put_swap_device()?  I do not
> see them in current mainline.

You should see them in the -mm tree:

  https://ozlabs.org/~akpm/mmots/broken-out/mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch

or

  http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=87efc56527b92a59d15c5d4e4b05f875b276a59a

Thanks,
  Andrea
