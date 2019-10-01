Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D3FC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7421A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/KpykF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfJALw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:52:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42753 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfJALw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:52:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so11584003ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=map1rpU0/cD9gXOET53DgrlZNojNxK6aWgK6fvWXqpc=;
        b=j/KpykF8HK1HAPP3YK3Ga0rxbpyRdC1zKFDmYZpXHHgonsQfvXw5g6lmmkbCEVsmWT
         9xBLqyMGFmGewgPTWFdoTcsjlEKf7QTqLMUIIl3GgA0uMS6ERIM/WJM6hf0hd+EQ4cr1
         luGD+T4vEWDN+oIF4yWdrHgobbP9gugLCo/DNqCtrknl0g+Vs5Rrez0IVbmIfVqmlUGA
         4JFPdp3zaTkqQ8A5Zgv0AUb3XolHJOiOUNlNBshuXKSN95MJv4YmRvZTg9wtJo2XJCty
         K2NZMbK4pgr4B2SxKYRXKzPjYh+YRwqIqVggAlOdWLCDNwU2S8CA5JX33ioS3/7OMqjH
         a9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=map1rpU0/cD9gXOET53DgrlZNojNxK6aWgK6fvWXqpc=;
        b=EcaUBJQq8JEyjGG3/X20hywal8bmvQ2gT706LJMJ9LxRNVOOzgXHgN9VjsQfSR6S5V
         /IO8Y0zg5r5PuwuUJQVMz4XUHeUH+ZeM6TgIVJo3J2R5MuNW7x1G4McoKDBbM8nYSXts
         wF6UPxUdlwntUrjsLwmq85FPpRISboTcqSF0+JxKIuOv8Aj5wQtVjDA0oSiguuIBo7j3
         S4Us+5Fp1K9+XbvaRupdUE21fFunP+9lcBSLUKnx0PTSkGHnFWbhfMx/pCHb5bw0Ok89
         n5hqBhBNnhSfuqBmCdx23XnpU8+BLoh6uGl78omQ19aVLcdLqBgbwj09pcWFOZ2WCawc
         85lQ==
X-Gm-Message-State: APjAAAUtHs3KKkKb38FEvuKTOVAoeOw1h3y4YhdRgrcX8d1YB0skO27F
        RIPo2ii1NijquqYAKHsgj6U=
X-Google-Smtp-Source: APXvYqwjH3pc5NC1W6yESS7isGkfsKjk3Dndlk89YH/u0lAjuNWt9DJtP30SByQHzwK9IBwh1ySjOg==
X-Received: by 2002:a17:906:2cc8:: with SMTP id r8mr23357659ejr.197.1569930744998;
        Tue, 01 Oct 2019 04:52:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d13sm3095529edb.14.2019.10.01.04.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 04:52:24 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:52:23 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        dan.j.williams@intel.com, mhocko@suse.com,
        mgorman@techsingularity.net, richard.weiyang@gmail.com,
        hannes@cmpxchg.org, arunks@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix struct member name in function comments
Message-ID: <20191001115223.tqalvsgu6wjm36sb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190927144049.GA29622@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927144049.GA29622@haolee.github.io>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:40:49PM +0000, Hao Lee wrote:
>The member in struct zonelist is _zonerefs instead of zones.
>
>Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> include/linux/mmzone.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>index 3f38c30d2f13..6d44a49b3f29 100644
>--- a/include/linux/mmzone.h
>+++ b/include/linux/mmzone.h
>@@ -1064,7 +1064,7 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
> /**
>  * for_each_zone_zonelist_nodemask - helper macro to iterate over valid zones in a zonelist at or below a given zone index and within a nodemask
>  * @zone - The current zone in the iterator
>- * @z - The current pointer within zonelist->zones being iterated
>+ * @z - The current pointer within zonelist->_zonerefs being iterated
>  * @zlist - The zonelist being iterated
>  * @highidx - The zone index of the highest zone to return
>  * @nodemask - Nodemask allowed by the allocator
>-- 
>2.14.5

-- 
Wei Yang
Help you, Help me
