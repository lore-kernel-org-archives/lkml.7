Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9CF222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="cOjoh6P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:25:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41711 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:25:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id o3so21316257qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v9if5fwr3paoI1B1+7DONdTrGfIC6DUmEh53tZeqqwE=;
        b=cOjoh6P7m4KW09CGfhiNgwSxU5Uor0QS63+fU5/Cbk0WqsjnlakOdwmfaWbalvDKqA
         0mA8+jpUq4KjivI53/E6KseHbpUhl4S/vzgpO7lLNqo/o7qJA+gScq1avKYSn72KEQ/R
         WJ60rA0ePyceU0fofd2Pi1BrJ9giAjU/47ZcmWs033JnlwB50bz7uhCRZ6wygaaMO+K8
         R1Hd5+NU4dbdVbyvHlyWtwaOBu6oRSqSAumJf8OHFUjRc5n0y0WymXPH00JGmWolIwq9
         5nC5xxHCJmlPEOT+RZ5tPhsR7Dk+XhVjN0p1YRKv7nSk2djVpyZnlJV+sJVxTwycbuvj
         RSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9if5fwr3paoI1B1+7DONdTrGfIC6DUmEh53tZeqqwE=;
        b=OMQk98QZ0Il3qcLrTtSbUL2O/UDFRzh9oKDcyxHVZRcaarpo/EDVtMu0448NgDA4iC
         9sUKYtU+qXRbT4aeg4+8bs0IY3mBa2U8jfktTuz28/Aob/8sB8z3iZK7l5zPXkFI7R6D
         HZzUvqgk+t18hyoveH0zfheFsE6CJ7VX3RmQdn3IIzUp+1+uQKxadvia4gv0vKzAo686
         H//sGnPBqdki+R8QVfXoEn0jMLA0ns7M+7GKSxKjUt1BVucOIfpU35v0nDRFvw7B+2OF
         4wxOQyNpAEYPtU10HOhb8AKW3vS3HR5D30Kjgt/hr/4x+Bjl7kch6qlQJJO3ab58IS5d
         SgDQ==
X-Gm-Message-State: APjAAAXpVd7GjRy6EB27RoTCamoGzrMvpyTDS9jdXd4QL/8o1lyaobJg
        k5DpDx2Hzy1WtuCV3V0ocYnSGg==
X-Google-Smtp-Source: APXvYqxRzso5xx3hWxY3ZUu1X3hwkPbmHoQ5nfY4eQP7njoYmvy2X34X//IjdVFIc386hMTUM/r/Kg==
X-Received: by 2002:aed:3702:: with SMTP id i2mr27264082qtb.312.1574101549183;
        Mon, 18 Nov 2019 10:25:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:1113])
        by smtp.gmail.com with ESMTPSA id y24sm8820684qki.104.2019.11.18.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 10:25:48 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:25:47 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/vmscan: fix some -Wenum-conversion warnings
Message-ID: <20191118182547.GA372119@cmpxchg.org>
References: <1573848697-29262-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573848697-29262-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 03:11:37PM -0500, Qian Cai wrote:
> The -next commit "mm: vmscan: enforce inactive:active ratio at the
> reclaim root" [1] introduced some Clang -Wenum-conversion warnings,
> 
> mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
> 'enum lru_list' to different enumeration type 'enum node_stat_item'
> [-Wenum-conversion]
>         inactive = lruvec_page_state(lruvec, inactive_lru);
>                    ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
> mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
> 'enum lru_list' to different enumeration type 'enum node_stat_item'
> [-Wenum-conversion]
>         active = lruvec_page_state(lruvec, active_lru);
>                  ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
> mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
> 'enum lru_list' to different enumeration type 'enum node_stat_item'
> [-Wenum-conversion]
>         file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
>                ~~~~~~~~~~~~~~~~~                ^~~~~~~~~~~~~~~~~
> 
> Since it guarantees the relative order between the LRU items, fix it by
> using NR_LRU_BASE for the translation.
> 
> [1] http://lkml.kernel.org/r/20191107205334.158354-4-hannes@cmpxchg.org
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Qian!

Andrew, this is a fix for "mm: vmscan: enforce inactive:active ratio
at the reclaim root". Could you please fold this into that?
