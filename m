Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B24CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B742070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C98ZSUR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504224AbfJXTBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:01:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40143 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390493AbfJXTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:01:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so12312120pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lGCdcxYn0fhxI/F+Acv75O+uiNWd2Mq3qhp7qlP+npM=;
        b=C98ZSUR/4d7JgbXxedGADnm9ri1iP+4j59mYVyshMzIB+sPNTq05Zx/Wvh2qYBb58q
         1F+xh7GoGea48bavabDj0ISu0sjYZC2Ueu8LRYU3BQ0EuXp1Zpj0MTybaPsAxY6GG6NQ
         Rt+ON+PG2M2hpYS+huhURc4FwH8K5579hZhS1gKlJAhfIRoLZUwoxFDC3QpM+RCWWAUL
         jrMDguCosKTJyInDGKkATia4svm81xLkg79QnHUUAEyUxHNLoCyEjliw6+QTloDbmEwJ
         GqyzRY6gUVfwF4Vf9si1UNdIc8179Q+i1bFZwYIFnMJ1d9/h5yG2EToWNYkRZ1KZU0D5
         uAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lGCdcxYn0fhxI/F+Acv75O+uiNWd2Mq3qhp7qlP+npM=;
        b=ngOXMkJaXToWVGBgLyr1+6TLlXx4wCXQ10CakTXnnLqSOpYyUTyLUbjJINPdcGGDZV
         JcFB1yM0FSvzrLdX+NNcZIxDa6dZqOBeboBp9OTnB/cfORONHIcyzFMTJi1n0jjWvMek
         hAZ2MkYkj2cdLDHsviYCDzTyP1nEIVeJbPp/JVZi+lviA6/faXGT06IhX0UOiKtsFeZi
         VBaEJ9MdL92u31pZQupbRI4VuPRMWVjZxSu30SockPpnKBFuv2N8KM7KyYgqk8DhkkJW
         5qKYG0ZKAc3rmY1yafgNTUoStAzYTzGojEtwBhDAssrOGnRDkx/qfhERbC+7wQKB9UDm
         eyxw==
X-Gm-Message-State: APjAAAWl0NFKvsjMJTSuYMv1tvi1Q/btpg3AFpPGzozn4qmjIA4fWdG5
        FJqe12AErn008cRA9T0noLgPXQ==
X-Google-Smtp-Source: APXvYqzMMHkwWVYf0svd1U4v301GL37PukLhZ41swJwynvJ3Hp2SER4PxVa6VktAX8Ez3A4qBWK+uA==
X-Received: by 2002:a17:902:d698:: with SMTP id v24mr17062393ply.340.1571943699729;
        Thu, 24 Oct 2019 12:01:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j12sm3453005pjz.12.2019.10.24.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 12:01:38 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:01:38 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal
 users
In-Reply-To: <20191023102737.32274-2-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1910241201250.130350@chino.kir.corp.google.com>
References: <20191023095607.GE3016@techsingularity.net> <20191023102737.32274-1-mhocko@kernel.org> <20191023102737.32274-2-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> /proc/pagetypeinfo is a debugging tool to examine internal page
> allocator state wrt to fragmentation. It is not very useful for
> any other use so normal users really do not need to read this file.
> 
> Waiman Long has noticed that reading this file can have negative side
> effects because zone->lock is necessary for gathering data and that
> a) interferes with the page allocator and its users and b) can lead to
> hard lockups on large machines which have very long free_list.
> 
> Reduce both issues by simply not exporting the file to regular users.
> 
> Reported-by: Waiman Long <longman@redhat.com>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>
