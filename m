Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8163CA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06712070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="HMVTbJkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633673AbfJRL5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:57:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34516 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbfJRL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:57:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so9190577wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6S4QPdslNwXJAT/BzhXiwb/xgOF459OGorhnXxejhGA=;
        b=HMVTbJkk9qjWX9SCv0zwplnx41NHOdvK+yyQqGaeUD+6fThO8c+yQuOmOIN2jTTvfX
         boef4TvOOtbxHfeJfZhXiGsiWCa6sVvLgfQaUvDIqTarlLkzhOv8EvlOrXO35VqiGL7P
         IoInL3KVRCFMkEhFYtIarRMX7zD2ri4hB8AQm9oCKNFzw0sjalHG0xt3CWrWXLNRjqKJ
         cQnc9WPoQxLRRXxEToycFHs9aXLLXFtpZiwWhTv9HiL1dk9mp7NRobfSPXer6KrO6prv
         wRVkc6e5opCScNLWoniQDp9FLq+hcSJb16dEgTvGzH6u1KbSPSzIwDzmG1GdadjhYF6j
         IlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6S4QPdslNwXJAT/BzhXiwb/xgOF459OGorhnXxejhGA=;
        b=T4pO0PAkE2DCePHsxwWx8WkcflJl9E8xEk5a0G1dRrA6Itr5OiGKKCRqFKDzWktqcS
         SKlBWwAhQoF7aiOyispkuRwVK3iXJH0/LDuVqk2GaNw0KztQSitEb5NTL83lShIzwb9C
         EQ++/+kU74z1dDSTqv9/YUzBWo4yrTcPuGfHhcEWn/hmrFHCUeekkcbRDLdo8ua2qffi
         kUCNcXjmvOoFw84cmZO4YJKsObOcKNJwnT/dbqiTaAELX9edxzOFnC6n8Grn+2lqPuYO
         VoJDhyRQ4PZ0KVNjs/aFl0ZWqYrWwvclhYTsY0UENO4cou6D6lwu6FA7mBn/FMQSAlRU
         57Bw==
X-Gm-Message-State: APjAAAVGg4nDvdKRS5KpVha89/DbI59B6grl6k0aCDyn6WUkIw8RSuda
        WoUjkcBeNrj0SYopd0r1YrbQvg==
X-Google-Smtp-Source: APXvYqyq4GEgr4bS0K22PWXa3JBmuDezMa0I/c5p28Wl8P+VWeHQLNJ5J9bC/gyLyV3VVXcu5HTjYw==
X-Received: by 2002:a1c:3c07:: with SMTP id j7mr1164875wma.122.1571399865258;
        Fri, 18 Oct 2019 04:57:45 -0700 (PDT)
Received: from localhost (97e34ace.skybroadband.com. [151.227.74.206])
        by smtp.gmail.com with ESMTPSA id l18sm7320849wrn.48.2019.10.18.04.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 04:57:44 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:57:43 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm, pcpu: Make zone pcp updates and reset internal
 to the mm
Message-ID: <20191018115743.GG4065@codeblueprint.co.uk>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-4-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct, at 11:56:06AM, Mel Gorman wrote:
> Memory hotplug needs to be able to reset and reinit the pcpu allocator
> batch and high limits but this action is internal to the VM. Move
> the declaration to internal.h
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/mm.h | 3 ---
>  mm/internal.h      | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Matt Fleming <matt@codeblueprint.co.uk>
