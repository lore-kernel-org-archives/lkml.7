Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6811C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891320665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfGHN2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:28:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43577 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbfGHN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:28:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so13218394qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=xmpQG/YvPNoLqkL4mczESC7OrNcoM8yKqZCuImT3btc=;
        b=m6h7YhqWcMAR4d8M1yC1bhQ0jLClW09ULkYYMp5QZpBZsfdH9Y9i/fEh8OQklc7T1z
         TeX2Q299cfb3KMAdJkJJGR5s+PbV4OYDi9UiN3EFAfr3Tk+dIiiOHY2FjhSS7iJOMDAT
         2nuIsbmYaaQKNq3nWmCrwUVSpacWPVU6ipIoXiunikbtreLuQG+neJxKtNgMh7AqkUDN
         8UfqXND5NVy6G9cNFbWg6hk3Rlu0h4wTptwLXW7LxdY2bbHAO6bD9Izbs9pf84wXV9Hr
         dv6s3Zg/4JJRlrm88hQSLLtrknytKDUWh20NQQadjtQ2CGNNGZfVZBzNI0h0qKCzqrHl
         1U2A==
X-Gm-Message-State: APjAAAWBTMLbZTNKG+7Gb+wbl63NTKV0QgKdMmNPNThYenAIGocEAvx2
        ZLzUMeTsoTGQkNneGpAdt+PBK3PMbrQBw4AoEgo=
X-Received: by 2002:a37:76c5:: with SMTP id r188mt13444332qkc.394.1562592482848;
 Mon, 08 Jul 2019 06:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190708124120.3400683-1-arnd@arndb.de>
In-Reply-To: <20190708124120.3400683-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 15:27:45 +0200
Message-ID: <CAK8P3a2pn4s1aLWAd+riKHO9RGgu20u=62Ds1fWg1OCQEGiiOw@mail.gmail.com>
Subject: Re: [PATCH] vmscan: fix memcg_kmem build failure
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_MEMCG_KMEM is disabled, we get a build failure
> for calling a nonexisting memcg_expand_shrinker_maps():
>
> mm/vmscan.c:220:7: error: implicit declaration of function 'memcg_expand_shrinker_maps' [-Werror,-Wimplicit-function-declaration]
>                 if (memcg_expand_shrinker_maps(id)) {
>                     ^

I see now that a fix for this is already in today's linux-next, please ignore
my patch.

      Arnd
