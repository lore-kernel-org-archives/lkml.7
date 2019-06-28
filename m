Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F675C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127B121743
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NJhiRaFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF1IpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:45:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33971 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfF1IpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:45:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so2634334pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cCBNQ/DLgtpUPdtAQUtvcyuKyE7Z8O611WKPmcesJs=;
        b=NJhiRaFTwbXgWwYMuOKzcTTAPu8tvSUXftkWjd2iiLgQl4WJT7WRsvULRO5tF8PluC
         Nn+xvF88SuY6E/ZeAT3axrY8RuBSq8aQZRGAiy3DZuNjp2jnGcFdj/vf3GXwc4KU26Zj
         mspXga43P9yxdB55hXqpNtLBeXU2cevRPgdoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cCBNQ/DLgtpUPdtAQUtvcyuKyE7Z8O611WKPmcesJs=;
        b=FrBda/QLzzIuj4bVXYrXh1RpR0ouSfHHO7RMlPf0Dw33zxZV7q2Ip+YoO4ty6sk8F0
         xUosfEl2/wdif0u4DFjl4lhfbqNeSdwjk6F0at7jmVe9ADqf88ZiVpRJluqi3HPmzUXF
         DnN3Pr1Tnkt1KZq6ndpX9gg7n1/iKSWVLwdwpFwPmOZo82oUQ7Dntn/0XAKypap8M/+0
         0JWVNuTf7pmsfpg+wvwu3iM1qc9KJ3kIZtZCzrH9ZPKveUyze47mv0WxNFgRvK3JVKRr
         yhj7mADdFLY5oiSgwHQHWdGv3GmOyLYjGygzmWGHJmJO5cztIgOjLTECD5QL6XudYMLV
         3OHA==
X-Gm-Message-State: APjAAAVCxm+lpT37g2h0SZUpT9HRG9t9FRFzK/DPtaauTSEu2Tkn+kqJ
        xYDr1RFaszwCfH/GbdsgeCTHTpIPrB6q
X-Google-Smtp-Source: APXvYqzcWsGydcd1oia93mChuGAQogjZoToWpbbXL8r2Y5MYqx/PPB/llrSa3dFB1zoTvtb0iZ0Rew==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr11674941pjq.102.1561711499289;
        Fri, 28 Jun 2019 01:44:59 -0700 (PDT)
Received: from google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id s20sm670784pfe.169.2019.06.28.01.44.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 01:44:58 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:44:55 +0800
From:   Vovo Yang <vovoy@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190628084455.GA59379@google.com>
References: <20190619080835.GA68312@google.com>
 <20190627184123.GA11181@cmpxchg.org>
 <20190628065138.GA251482@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628065138.GA251482@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:51:38PM +0900, Minchan Kim wrote:
> Hi Johannes,
> 
> On Thu, Jun 27, 2019 at 02:41:23PM -0400, Johannes Weiner wrote:
> > 
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Your change makes sense - we should indeed not force cache trimming
> > only while the page cache is experiencing refaults.
> > 
> > I can't say I fully understand the changelog, though. The problem of
> 
> I guess the point of the patch is "actual_reclaim" paramter made divergency
> to balance file vs. anon LRU in get_scan_count. Thus, it ends up scanning
> file LRU active/inactive list at file thrashing state.
> 
> So, Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> would make sense to me since it introduces the parameter.
> 

Thanks for the review and explanation, I will update the changelog to
make it clear.

> > forcing cache trimming while there is enough page cache is older than
> > the commit you refer to. It could be argued that this commit is
> > incomplete - it could have added refault detection not just to
> > inactive:active file balancing, but also the file:anon balancing; but
> > it didn't *cause* this problem.
> > 
> > Shouldn't this be
> > 
> > Fixes: e9868505987a ("mm,vmscan: only evict file pages when we have plenty")
> > Fixes: 7c5bd705d8f9 ("mm: memcg: only evict file pages when we have plenty")
> 
> That would affect, too but it would be trouble to have stable backport
> since we don't have refault machinery in there.
