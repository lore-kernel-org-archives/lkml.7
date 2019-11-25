Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF66C2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574671196;
	bh=VCHefT6+BGkHE+xsXkO2s1fr4n91uFK/Em17qcnGqdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0F1ycQ8zRSKCj9BDgYsE4d6inVgd5MuMZ5lt7xY9iib+yeR9v2C7x/S2IDmQTqjTT
	 R7+O9StGuSoAN2a2kZYLnhPrTR5nxmXnEIRQe1mx17r2BdWTBTPlv4D4N2TPJTh77f
	 l6BvCx/W4/iBU6vOZEc0Wi4a1c5rX/g8iviEFFls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKYIjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:39:52 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41513 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:39:52 -0500
Received: by mail-wr1-f44.google.com with SMTP id b18so16804837wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 00:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmi3FFpEMjxH2pQOzK7VtFWqIDlUJcVRTt+PG/Ao1YA=;
        b=MQNM9P0QxBG7tuJa2OVI85UT13tcm16mRgo0nrtMpi6uzb+YoGMZqNwwdY7VIeBNJU
         1ag0c5/3goRQyF53YZiT9tZmPtsKwDaMzMq5FWp5wZAWzLBzG+UtB3+FlxqSf7D9stoR
         xJZmHWkUJ4sNAl2wf74cTvNAyRaa0LPwoduKveVamcSQ+5iWPxoHMB6ggI1RiMIgeYPm
         BtT0zcxCgq7beqnRKgNbjsw62BL2wJ19oPgktc4uZ6E+TJ7wmwj3LU5XO0PFKtTanyR0
         gYf+Bwl8wW3rCXkDH19yHIP8mbDYRQnq5jvAVw6Df0rT24DhYppylxoRNobBIIpyANU4
         Zliw==
X-Gm-Message-State: APjAAAU1SQqn+mtP8/ac3Bm3/HBQTH5gF18L8xINH8nMUPULa6Um/rXN
        bQgHYNphFOfMXSPPG+skxg6l1c3K
X-Google-Smtp-Source: APXvYqw6YeAH3uHA8/eC+Aqtv3oqzCXGmJ9WB4eAojMlR0L5fIXZdineUWYUKCpBuHZW4+ru3n4kcg==
X-Received: by 2002:a5d:570f:: with SMTP id a15mr10976373wrv.316.1574671190076;
        Mon, 25 Nov 2019 00:39:50 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w188sm8105785wmg.32.2019.11.25.00.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 00:39:48 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:39:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Pengfei Li <fly@kernel.page>,
        "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>,
        akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191125083948.GC31714@dhcp22.suse.cz>
References: <20191121151811.49742-1-fly@kernel.page>
 <2019112215245905276118@gmail.com>
 <20191122232847.3ad94414.fly@kernel.page>
 <1574438002.9585.24.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574438002.9585.24.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-11-19 10:53:22, Qian Cai wrote:
[...]
> ZONE_MOVABLE is broken for ages (non-movable allocations are there all the time
> last time I tried) which indicates there is very few people care about it, so it
> is rather weak to use that as a justification for the churns it might cause.

People do care about ZONE_MOVABLE and if there is a non-movable memory
sitting there then it is a bug. Please report that.
-- 
Michal Hocko
SUSE Labs
