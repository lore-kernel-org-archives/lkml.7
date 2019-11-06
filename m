Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3707C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980C02166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6UlB+Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbfKFVck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:32:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39223 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:32:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so5387465plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 13:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nlf0rW8YMaJI3hbbUU1xaIyWPo21KwOubstHCGTGWEw=;
        b=p6UlB+FaZrAgnMFREh/yTO6OkfgcyKeaZ6bo8a3QAZdwHPKnTavuZWsepUGByDzDyk
         FmxmzNwGsIM03cFt5IdOM///C+udVWm+er46+h0U9r7fn/wIa1BPFgTRgYskbbT3egl9
         fDSS0JeSSx2Jp4oLIxsDS3d7SDO6rLBfhJ6Prey4lGcz9EoS4M99QofjDMrRrQUNs1TT
         UhYGwynu889ijzztQscu1jc5QN93q/edSirXWRTB/7XifcHOT4Q2yTSZ7RjKdoY3Sk2L
         ATFkHSZYoQtp/j0da+HNKsN5gD3/5xSTwKeYncZbENFI/XCNdDXjUltpFWPvo992/EFH
         ggig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nlf0rW8YMaJI3hbbUU1xaIyWPo21KwOubstHCGTGWEw=;
        b=r78Tx/y1SaICVokKQnBaWKxPkMwXjw20X+t53av1x1mnhRA3GYTA88LceO96RASfgM
         FrDU1srLHVPSO+lfYo5bUMXppTNMSVTlucjbU52PENOlNllfjBJ+iG/0SGmM2XuB23UI
         IVWY9F+g4z9HUrY8S9YpLWdOna+RNOECZs54lE1CgstsX73EWW4AhNEke+f86tREtu07
         NHHOxiCWo+XjBg7PdSMoOsKICsv/YP5b7V6yTUC/u8+PDWS3BXm6ZSznYvZEu8+TUzCw
         YVagpBnFvnPSsl96jDcJo1XRLEqmb1P4wu+Ix8P8L6wLsz9CzrE+R8fLazFY3a41J/Ws
         6DcQ==
X-Gm-Message-State: APjAAAV5lHPBuH8Jx59FfVz+13Et8BtnFEMVsTLDV+V1U7Ebuv0vnKcc
        +zeb8KbHz0FQ+0JwJeTDdPFoFQ==
X-Google-Smtp-Source: APXvYqwyi8rwFGE4QcTT3ILp9LCRu0U/bFplVLnOtuXl5xCvRUgVBWUk37wyEFxIQKLftcQ4BZC2LA==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr4832657plq.161.1573075959127;
        Wed, 06 Nov 2019 13:32:39 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 70sm26310202pfw.160.2019.11.06.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 13:32:38 -0800 (PST)
Date:   Wed, 6 Nov 2019 13:32:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20191106073521.GC8314@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911061330030.155572@chino.kir.corp.google.com>
References: <20191001083743.GC15624@dhcp22.suse.cz> <20191018141550.GS5017@dhcp22.suse.cz> <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz> <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com> <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
 <20191029151549.GO31513@dhcp22.suse.cz> <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org> <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com> <20191105130253.GO22672@dhcp22.suse.cz> <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com>
 <20191106073521.GC8314@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019, Michal Hocko wrote:

> > I don't see any 
> > indication that this allocation would behave any different than the code 
> > that Andrea experienced swap storms with, but now worse if remote memory 
> > is in the same state local memory is when he's using __GFP_THISNODE.
> 
> The primary reason for the extensive swapping was exactly the __GFP_THISNODE
> in conjunction with an unbounded direct reclaim AFAIR.
> 
> The whole point of the Vlastimil's patch is to have an optimistic local
> node allocation first and the full gfp context one in the fallback path.
> If our full gfp context doesn't really work well then we can revisit
> that of course but that should happen at alloc_hugepage_direct_gfpmask
> level.

Since the patch reverts the precaution put into the page allocator to not 
attempt reclaim if the allocation order is significantly large and the 
return value from compaction specifies it is unlikely to succed on its 
own, I believe Vlastimil's patch will cause the same regression that 
Andrea saw is the whole host is low on memory and/or significantly 
fragmented.  So the suggestion was that he test this change to make sure 
we aren't introducing a regression for his workload.
