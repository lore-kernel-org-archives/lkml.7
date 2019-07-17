Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86331C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE12208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="s+ad5D3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbfGQRg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:36:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40467 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfGQRg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:36:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so11496274pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kevqSiJxsbEDhmFvXT17QTCK6a0eC0i3z1ong8Uuwzo=;
        b=s+ad5D3HLMkro+DDkazkpKnGSOtq0joJ9Dhea4g9PK8M83SoVUqNCj+XFLDhLVFCXN
         LhSDJJlL9veZeJTb8HGu2EHXbdqc3MGn+X2TEylr3LuYoXWRGxc6OV9R31Lal6Ta7siR
         SC4Daabecb3ER5mJq2B/zliFco6r8xtP4X4XixA9e9wg2lQQ0up5OlWsFAEsVcbhUBnj
         sNGlA3yJuWKHnl/gK0iHUOIxG+SLTlurFGvUAQHqzNkSaw+w9MBJJuQY61aFmJwnd5JR
         NCZ7kpch6dnxKmD1mdMCexQZQPR+nirg656XJ2DuCckrTqzD6TBwz0PsSmeP83mAoanB
         yWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kevqSiJxsbEDhmFvXT17QTCK6a0eC0i3z1ong8Uuwzo=;
        b=e4Ht7qZODdwITQ/kLxSe/Gr5bwf/Gkl2BpgLu0PTzIHPm2f46Iy7f3w6IJOOZCSgfr
         S4zfebAfvGK/CK71iZZTsitcpN+kSqpCNkX9pUegiv9mgue4BPV2TP/Rotpw4dTvU/nZ
         izcCFfOLNhhpdKTMt12ZFE461EZ566/Kp8gZwQs+p6aqEkmJ5XEiR7bnTRvy/DAAfjHe
         59rqUHjjYyWs4wL0sdyUuNV4mkHHQR+7vruTsFH+8wZiRz1UTS4CNJFgH1L6bdqFzXk7
         0+7TmS2b8zKsgKNYpQctZy/TH2gyVs3hQKAoIm4AFyRrZBOFI0iPgchGUWI2eub5l8xw
         GbkQ==
X-Gm-Message-State: APjAAAVD+wL0Qd3plYkVJb45XczgmsFWNjrTx5/zZAc5gDV+pPy8Sjoh
        k7RrlKpz3b8bhNQ10qc5mMg=
X-Google-Smtp-Source: APXvYqyD6WnsaJ0bItM20gy/k7ygrcTP83wuDov/ycTiAnYjvD2WHzA2+KiUtWbJ3BsDF7phWpmP3Q==
X-Received: by 2002:a17:90a:2343:: with SMTP id f61mr46121179pje.130.1563384986821;
        Wed, 17 Jul 2019 10:36:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:4db])
        by smtp.gmail.com with ESMTPSA id g4sm33697577pfo.93.2019.07.17.10.36.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:36:26 -0700 (PDT)
Date:   Wed, 17 Jul 2019 13:36:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] mm/memcontrol: fix flushing per-cpu counters in
 memcg_hotplug_cpu_dead
Message-ID: <20190717173624.GA25882@cmpxchg.org>
References: <156336655741.2828.4721531901883313745.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156336655741.2828.4721531901883313745.stgit@buzz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 03:29:17PM +0300, Konstantin Khlebnikov wrote:
> Use correct memcg pointer.
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Oops, nice catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
