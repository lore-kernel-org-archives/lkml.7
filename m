Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A8CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68011217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="mtx4zkyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfJ3SHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:07:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfJ3SHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:07:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id e4so2001146pgs.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAmQqO4bjeMP8pqof8/ZbpdZpz2QFcPnCQfgAz9Gnck=;
        b=mtx4zkyH5XIQgQbFqvvhGqBLpk59n9jvsGvwkO1VfmeSBi1fZTkm2jd/OJyjYb00UW
         s0eLLTypHsbreDef1db4Dqq/lLcoO7Y1Ijt4HNbZ+EeUGjZagKB9q7s2x6NaipcKhgx9
         4WhVOz5bRE5CSJI+LSDVZQr8gKMXGq4mhuGp3lThS3s7dZss+t7ixyPJXf19hzBOb0YI
         +ygYN0b1im2IVF2DbaB+QnHeBvBIZR00xvvEzU3MYvlmxAL9WkJsrGX3Cyc2l6CSlvE8
         qU59DasqpWmvC1rofTblT3lxM1r1aBj7PmMqmcv29+qRc0d/PeGv1uLHDUQB8T6MRMGg
         1M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAmQqO4bjeMP8pqof8/ZbpdZpz2QFcPnCQfgAz9Gnck=;
        b=AveBcpYuDSR519PUMoHvInjULKs/+7NF5ogj6KJQ7w6X2PoPY2fC5fz5dKr7yYp7kA
         YkYDOw0s2xavZ1PgdjNkOQLMynKAhqmiQpeuENUkj1NWK0CtggB81H/XsXe5j/i6erG0
         jDf3tXjD4lYXyzY4FNkxU+LajuDx+hTFdjKOozYGPnjRzZ6HcyWKeHwDvEd6kwFEKWMc
         7mRBFbUtaiKgiEvLhs+nAQ/cwr/tPEiPDBRoO92xKKG4updQ8k2e0h+lAHYukf4kB3Zl
         AZFPOxKZkxZZ+JbD1l5DAbXxkPjiPaVN35ISyYQmlDeeQLLZ25maJOy59hSYKgYxjf/Z
         udBg==
X-Gm-Message-State: APjAAAWVpEb0I3RJYnKepmX1Yh5YR9xJprGQuDhy8VqsDvRbqve0a+F6
        BOUo6ArcDwirQQNJUTf4FYfzhQ==
X-Google-Smtp-Source: APXvYqyuL6I1QOntSrYa2f/+wWesgVamPWyOs/9vuQ5B6aNOTIZp/FE+XjsshHgLyFI5Yj+uUd36SQ==
X-Received: by 2002:a63:352:: with SMTP id 79mr853183pgd.4.1572458820720;
        Wed, 30 Oct 2019 11:07:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::78bd])
        by smtp.gmail.com with ESMTPSA id c128sm573645pfc.166.2019.10.30.11.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:07:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 14:06:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: vmscan: memcontrol: remove
 mem_cgroup_select_victim_node()
Message-ID: <20191030180658.GA46103@cmpxchg.org>
References: <20191029234753.224143-1-shakeelb@google.com>
 <20191030174455.GA45135@cmpxchg.org>
 <20191030175302.GM31513@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030175302.GM31513@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:53:02PM +0100, Michal Hocko wrote:
> On Wed 30-10-19 13:44:55, Johannes Weiner wrote:
> > Also, I think we should use sc.gfp_mask & ~__GFP_THISNODE, so that
> > allocations with a physical node preference still do node-agnostic
> > reclaim for the purpose of cgroup accounting.
> 
> Do not we exclude that by GFP_RECLAIM_MASK already?

My bad, you're right. Scratch that, then. Thanks.
