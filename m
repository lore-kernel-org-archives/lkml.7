Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D045E20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCUYHS0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfGAH4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:56:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43963 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGAH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:56:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so6892885plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+twzjYVpRVjpacx4trZB94509DTZgYQcQMDYuMNcsR4=;
        b=NCUYHS0PUlBnq+9KUz6uY9duejMIwMu4rMg9X7onsD0fH/oIyThXHJHPrtnSc1V48K
         mwOXzdoJWMRsV/Nmapl5JdfEmmamY6OPDUoObkcs5JkIjL3NgtN2ASgrklfejqb7wpWm
         R/w9aVDSUub8VCFUBjyCa1wlgeejhnwrI+6NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+twzjYVpRVjpacx4trZB94509DTZgYQcQMDYuMNcsR4=;
        b=Z+A3/6/16T0e9/xIxssME8UuzUtxoesmjR02GO8qqITNlNErkmUIOVNmXQxxvQ3h5K
         w9DEEH0mo+GW8s1TGU6elwxRGfrnDVCjhakdBJzdCDWBbn/JeGRNZlYQEOMqYQFPJ2Pd
         +0XR/fPS7SPI5dE7uKIuMW9BhqpXLHSLfKkls5HKGg+Bvf1dTx/+08XeEavgdWer3n2w
         ABYt/frl/R54IS+cCYpVBORDUvyqFYF0sXDnoCLNUzYBe0pDNEFRYYrJhuDbN0hJyRJ5
         lJa4f+AZiwsG/V01nfUSGoxYxBPvR6V9juAVp31llIFpNYVzYssHBe6l+Oaby2aDuKxb
         kP1Q==
X-Gm-Message-State: APjAAAXOppBoSXEAVF7A8Go8GQw9oe7uNVm1O21yZOSrFTvSykrZipg1
        eafqBh3Fzi8yWPofXRp2ebOY
X-Google-Smtp-Source: APXvYqysC4YyV+eiee73csmXAhFAB6RLW8rCAw1OyNcYhUuZizAOjeak5niISZrBjh6iF1wgIBW1dw==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr28901036plp.59.1561967798535;
        Mon, 01 Jul 2019 00:56:38 -0700 (PDT)
Received: from google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id m13sm8127237pgv.89.2019.07.01.00.56.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 00:56:37 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:56:35 +0800
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190701075635.GA79748@google.com>
References: <20190619080835.GA68312@google.com>
 <20190628111627.GA107040@google.com>
 <20190628143201.GB17212@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628143201.GB17212@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:32:01AM -0400, Johannes Weiner wrote:
> On Fri, Jun 28, 2019 at 07:16:27PM +0800, Kuo-Hsin Yang wrote:
> > Commit 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache
> > workingset transition") introduced actual_reclaim parameter.  When file
> > refaults are detected, inactive_list_is_low() may return different
> > values depends on the actual_reclaim parameter.  Vmscan would only scan
> > active/inactive file lists at file thrashing state when the following 2
> > conditions are satisfied.
> > 
> > 1) inactive_list_is_low() returns false in get_scan_count() to trigger
> >    scanning file lists only.
> > 2) inactive_list_is_low() returns true in shrink_list() to allow
> >    scanning active file list.
> > 
> > This patch makes the return value of inactive_list_is_low() independent
> > of actual_reclaim and rename the parameter back to trace.
> 
> This is not. The root cause for the problem you describe isn't the
> patch you point to. The root cause is our decision to force-scan the
> file LRU based on relative inactive:active size alone, without taking
> file thrashing into account at all. This is a much older problem.
> 
> After the referenced patch, we're taking thrashing into account when
> deciding whether to deactivate active file pages or not. To solve the
> problem pointed out here, we can extend that same principle to the
> decision whether to force-scan files and skip the anon LRUs.
> 
> The patch you're pointing to isn't the culprit. On the contrary, it
> provides the infrastructure to solve a much older problem.
> 
> > Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> 
> Please replace this line with the two Fixes: lines that I provided
> earlier in this thread.

Thanks for your clarification, I will update the changelog.
