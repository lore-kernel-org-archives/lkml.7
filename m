Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B3C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63237208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="m6y4j+Yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfF0SGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:06:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46516 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF0SGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:06:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so7915137edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GNTzyha5uolkaXE/AKF7PBU/m2fQYAR8jso3b3bQxho=;
        b=m6y4j+YlgNsr629H/6PD1n/d7eQF/bkBheIl52SPCTGjhkZInu9kwhWyV6xo8kNYKD
         yW9xvLn6tcc/UhZ1t9w/7oCSIK6Vc7cAeNF1ujw0cWYoJ9L/EQaeAzVlDBsh5qQ+HxLB
         cH8PNBx5HRUIS74qnr91FI0M1RH074hNCCfXwE6ggsWmq6s/U7RoOlHwvpFF7HgPvyyw
         mjUyDP0Ghj3HoGxJp9lxEM2ZpSP6k9xFp1U/VO4rny6J3/W+RU9TtSfWSvoedcg/FZM3
         kNrp0BPWz4YjtLT0DHh2S/BgmzEt18f4tLKDNfLy9n9rAu/D4lhFEBrdEyZkl6qjrCpG
         +NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GNTzyha5uolkaXE/AKF7PBU/m2fQYAR8jso3b3bQxho=;
        b=N/kzz3zpvYkGFJZuvujpL6tWTKHhuG/OGy1M6cy/kQZYFddWLAp2hJPou8DgSEg+CA
         +gyqKHoYRVEYQiGNs9mU7fD1RGX74THgCZGOp/tLbXmG0SW4xBgSqXhej+h4dLy8cesb
         X3+nWZ4Qk8XflrdoSLFHqkccliM5mw8GjBm9gIosF/+cutbBRAgSNn9F9DkuZMPWJGou
         mcUAp2okxM+EkNZspDw12Os3r+85eLfWI6B5X1N4ehYwlFs31Za1vLhW/ptZB+rRfC5Z
         EFImmre343PxgQ1oa7+RYl9WsBZeeZ1h+SOQ4fk/exDM3MBWm52SRhfmhGep9d6eiifu
         YENA==
X-Gm-Message-State: APjAAAVwAaYLFydy1WsYGFDdJjzX3hJt01nIzLpFlQys3e2nOTcUuagl
        +5xY37e85BcHfQF5UbSAuQBx5g==
X-Google-Smtp-Source: APXvYqzGenvzx0Y0XnRI9xMYTAF7M9wkR56sl8+MbNVoy/EGzYm6e5vo9AYG/tf+nQsmZ+uVL9oupw==
X-Received: by 2002:a50:ac46:: with SMTP id w6mr6202710edc.238.1561658763449;
        Thu, 27 Jun 2019 11:06:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d36sm934170ede.23.2019.06.27.11.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:06:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E28C7103747; Thu, 27 Jun 2019 21:06:01 +0300 (+03)
Date:   Thu, 27 Jun 2019 21:06:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190627180601.xcppuzia3gk57lq2@box>
References: <20190627115405.255259-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627115405.255259-1-minchan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 08:54:00PM +0900, Minchan Kim wrote:
> - Problem
> 
> Naturally, cached apps were dominant consumers of memory on the system.
> However, they were not significant consumers of swap even though they are
> good candidate for swap. Under investigation, swapping out only begins
> once the low zone watermark is hit and kswapd wakes up, but the overall
> allocation rate in the system might trip lmkd thresholds and cause a cached
> process to be killed(we measured performance swapping out vs. zapping the
> memory by killing a process. Unsurprisingly, zapping is 10x times faster
> even though we use zram which is much faster than real storage) so kill
> from lmkd will often satisfy the high zone watermark, resulting in very
> few pages actually being moved to swap.

Maybe we should look if we do The Right Thing™ at system-wide level before
introducing new API? How changing swappiness affects your workloads? What
is swappiness value in your setup?

-- 
 Kirill A. Shutemov
