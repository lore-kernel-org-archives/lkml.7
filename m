Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643EBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289D720748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="QYExPAle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfL2OCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:02:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38156 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2OCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:02:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so12248399wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVdSh5eigGfpfZbcGPOwFmTu1bT8ccSTdspsY1KsgDw=;
        b=QYExPAlecIZL1gnZxQC2xAYNOQMYgcCITRyrl9YRy7vqXB90bkcdXQ0PNNPKj+EfIY
         XbxHnw6z/MYyt8nlFYs49bKYSGMGMdpvYQ4QZkCFEDPLndQdvuyJElvqaxMHi909zBA1
         Yn5uZ2Ws6avDpxFA76+O6cfBw5jIPVmBer4XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVdSh5eigGfpfZbcGPOwFmTu1bT8ccSTdspsY1KsgDw=;
        b=YGjQ+/vpJRAqNAT1A/gmgM8boW+XhAm6/8yVVyr/MhZcelWaphDWFtZ9P2/zOqjbC3
         Ym+htSnyA0k+P+TiE31b+gEHGHXqGgh+g4SGY1DgJpy/36z28DBRXfaPA0GVvKdslZ9g
         QPdwVRdv36pimrOpHVHrF9zmshiZdYs001tT0Ajtsar8w5MJ3sLsf54QJzN1Ycfcp+E+
         6tt0O+xnqVQ98PfymYEO8pvtlPfDc77kX5lHo1ewwjLL3R+2hLWPLWQZ4nsTWjNqc3mI
         5jec97/l8eKYL4LedbjdyurbOCOfsCBDgr0+SYZt/tfruGPKEjwa14G8/tTBFvDoDc3x
         fYBg==
X-Gm-Message-State: APjAAAWHU90cbG5NIuFp4VkByAqt6fZHY8Py2MMdXq79/W4//UI3uti5
        KX7426+nan4VmrdQCPs4PfsLMg==
X-Google-Smtp-Source: APXvYqzNnjbex6gASub1IyimjZc4FxGDCLJz7YROfS76oah0trC8AF8rFLAB3RLixdYFxjp7xmhazg==
X-Received: by 2002:a1c:5444:: with SMTP id p4mr28918356wmi.33.1577628162525;
        Sun, 29 Dec 2019 06:02:42 -0800 (PST)
Received: from localhost ([185.69.145.27])
        by smtp.gmail.com with ESMTPSA id d16sm44864362wrg.27.2019.12.29.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:02:41 -0800 (PST)
Date:   Sun, 29 Dec 2019 14:02:40 +0000
From:   Chris Down <chris@chrisdown.name>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
Message-ID: <20191229140240.GB612003@chrisdown.name>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <20191218140952.GA255739@chrisdown.name>
 <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
 <20191219112618.GA72828@chrisdown.name>
 <1E6A7BC4-A983-4C65-9DA9-4D3A26D4D31D@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1E6A7BC4-A983-4C65-9DA9-4D3A26D4D31D@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

teawater writes:
>In the memory-constrained and complex multitasking environment such as an Android system may require more complex performance priority.
>For example, the tasks of app in the font, they need high priority because low priority will affect the user experience at once.
>The tasks of app in background should have lower priority than the first one.  And sometime, each app should have different priority.  Because some apps are frequently used.  They should have high priority than other background apps.
>The daemons should have lower priority than background apps.  Because most of them will not affect the user experience.

In general I don't think it's meaningful to speculate about whether it would 
help or not without data and evidence gathering. It would really depend on how 
the system is composed overall. Is this a real problem you're seeing, or just 
something hypothetical?

If there is a real case to discuss, we can certainly discuss it. That said, at 
the very least I think the API needs to be easier to reason about rather than 
just exposing mm internals, and there needs to be a demonstration that it 
solves a real problem and existing controls are insufficient :-)

Thanks,

Chris
