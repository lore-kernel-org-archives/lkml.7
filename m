Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1344C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B830F21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yON6aSpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbfJ2P1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:27:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37627 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbfJ2P1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:27:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id g50so20789962qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IaX9sKsjpPdSSUy9AahNEhXIeFC3ruEZOj8gXqHdNOc=;
        b=yON6aSptlWxQnB1NOO3MIdAVC5s9k6tL+2+axo3G/mV3WZQvPJyiy0ooi4nGW5E9HW
         E/he2s1tMULMYHKQctEfszNGnxx8BhhocSBiqqfEajny2czIY+z6W5VIvoBDmKer/Grm
         dUAwUvW54hV3lOYtPJhD3Y4T6TdZ2D38x9XhZkcD/mPUjrWe9jCrwV4VjiroYwFmDd6W
         F0RoKT+6tPvf6FOdvD8WzKrFIEbgdXjVgR+3lQhEgqAagm5zoW8zhe3cwXvZiBSCkf+j
         vTzShxaiPBorZ1NjksCiWvGoVJTfXDgNrxu76KS3tgM9/dFkw+kO0UlGa1q1E0xx6f+C
         sY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IaX9sKsjpPdSSUy9AahNEhXIeFC3ruEZOj8gXqHdNOc=;
        b=lr0JfpF1uQRhC/JZDyqrzeeqzlyZZcSRCZCQZhIRL4px24tRkoLDeMeZmljb8uSzGL
         UJbN0bxWZf1N80J3QP1GcZ25ON1MviPPvXu2mkl8UH/P7BfXBCStDPbAq28AX06Z6g/l
         B9DQgZmiZIx024ObxPzASxR4SRDoMBVxfWG12E6F0xnYy7aPT/6vbDXGBMOf2T75qSjI
         zlpNWvbd0D10e0XX7DiXN0FxQKydX1Fdad3X+mM0h8YqgY2m2gNxLWSq63Ef/ryT6qL8
         lf1g6n25bOAT89P/6Br9hGvC6ohlILitjz6BCaHEZIKJQQmebXgCt5AcbcmsZYiN0ENd
         y/7A==
X-Gm-Message-State: APjAAAUuGUVU6rHH+8yYP1E9otJ3H+C6iL5nhtcjV3e3iO2YNTjENDuQ
        Z2l7GAfA6iFUtSgQ7t291mFiXA==
X-Google-Smtp-Source: APXvYqxNlKt3WrThbG7XbGaAd4zpBqVJ+bOempozXCLm9LT2jgDE9M88gCm6ijCz3K1Ul1o1a7VTZw==
X-Received: by 2002:ac8:72cd:: with SMTP id o13mr5000311qtp.303.1572362862156;
        Tue, 29 Oct 2019 08:27:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7081])
        by smtp.gmail.com with ESMTPSA id x9sm5041806qtp.83.2019.10.29.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:27:41 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:27:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v2] mm: add page preemption
Message-ID: <20191029152740.GB33522@cmpxchg.org>
References: <20191026112808.14268-1-hdanton@sina.com>
 <20191029084153.GD31513@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029084153.GD31513@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 09:41:53AM +0100, Michal Hocko wrote:
> As already raised in the review of v1. There is no real life usecase
> described in the changelog. I have also expressed concerns about how
> such a reclaim would work in the first place (priority inversion,
> expensive reclaim etc.). Until that is provided/clarified
> 
> Nacked-by: Michal Hocko <mhocko@suse.com>

I second this.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
