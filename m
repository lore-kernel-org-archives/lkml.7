Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB5EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D527F20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oVd/aFT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfH0Mkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:40:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38386 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfH0Mkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:40:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id q64so9409033qtd.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fg5dTDj9nNOW1fDUKWxMeRbQa24xpz0MuzDuvvl85/4=;
        b=oVd/aFT4OGvaqgUa+ERXGkiTPyP9H61sqJzFeA+eF3i0znynerzDl3sCjc9vXWHG6V
         1q2h98E6uQsgopjPzposljceR3uWjjxOmXvyZCZRsYPDPXqbggKif7vUGe2Ae8ImyuAE
         akQFnF8aHnEhooEn2xKP2PJ7fxEaD7dZcMv0cdEq01SrIUaZF9qhTKUPSxiUkvUXOiMu
         1F4GUQBf3F+2EMU+/AQKWYeZt4HL0+zEmIU4Hc7MKU1MXgf/H+EPqyOb7ZXv1VkdOBya
         ctJHfAuTEJKD7fcz4QVRifAe/OGiCzjSCDTnSBzaRf//+I6XTxQ6ER2RYHMx9js5/UqE
         U4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fg5dTDj9nNOW1fDUKWxMeRbQa24xpz0MuzDuvvl85/4=;
        b=FSmu95M5E6/NNqmFlb8SSharrbJo+kAUXtJfzr/QYHVJ00Wk6ZJMx2b3JW5cuhfYou
         8YoHk6LyGz/MQ0Il7O+3ujjdSnBDl0Qs0NUPv/r6QjQiqge6GRKoMp52KhPM3MWFZPys
         8AK2FwwmrHJOYrAgpeuGoJbk3HAfV+EPdG3nAxLyTky6qi7RjX3ALrCYJYGE46882BsP
         vB21nBh9P47IibVS6eaz31wlMIwko+d7BItgaqygE2+5KZIYiznJ7b4WmfCHRdC+zEbU
         iong1lViFAaLbfOLRhqCNEZPb+n8GltZRDzisrtVpSqRIau1tKSZNXSH6M7RG0sSChyC
         eMEw==
X-Gm-Message-State: APjAAAU8VJzyRj0l1BIQUXPdjex2ch1Exh8cmo9vmdNUrdLyzxn8G+k4
        bGAfVnMo38TTy+xScPUdxKwqzA==
X-Google-Smtp-Source: APXvYqzfzdxOob+qZc357rY85pjADeB1djcezZUCEER8jc2w3oRegLtmOllcB4aikPZXb+csHQPo2g==
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr23020437qto.133.1566909635525;
        Tue, 27 Aug 2019 05:40:35 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n66sm8151153qkf.89.2019.08.27.05.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:40:34 -0700 (PDT)
Message-ID: <1566909632.5576.14.camel@lca.pw>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
From:   Qian Cai <cai@lca.pw>
To:     Edward Chron <echron@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Date:   Tue, 27 Aug 2019 08:40:32 -0400
In-Reply-To: <20190826193638.6638-1-echron@arista.com>
References: <20190826193638.6638-1-echron@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-26 at 12:36 -0700, Edward Chron wrote:
> This patch series provides code that works as a debug option through
> debugfs to provide additional controls to limit how much information
> gets printed when an OOM event occurs and or optionally print additional
> information about slab usage, vmalloc allocations, user process memory
> usage, the number of processes / tasks and some summary information
> about these tasks (number runable, i/o wait), system information
> (#CPUs, Kernel Version and other useful state of the system),
> ARP and ND Cache entry information.
> 
> Linux OOM can optionally provide a lot of information, what's missing?
> ----------------------------------------------------------------------
> Linux provides a variety of detailed information when an OOM event occurs
> but has limited options to control how much output is produced. The
> system related information is produced unconditionally and limited per
> user process information is produced as a default enabled option. The
> per user process information may be disabled.
> 
> Slab usage information was recently added and is output only if slab
> usage exceeds user memory usage.
> 
> Many OOM events are due to user application memory usage sometimes in
> combination with the use of kernel resource usage that exceeds what is
> expected memory usage. Detailed information about how memory was being
> used when the event occurred may be required to identify the root cause
> of the OOM event.
> 
> However, some environments are very large and printing all of the
> information about processes, slabs and or vmalloc allocations may
> not be feasible. For other environments printing as much information
> about these as possible may be needed to root cause OOM events.
> 

For more in-depth analysis of OOM events, people could use kdump to save a
vmcore by setting "panic_on_oom", and then use the crash utility to analysis the
 vmcore which contains pretty much all the information you need.

The downside of that approach is that this is probably only for enterprise use-
cases that kdump/crash may be tested properly on enterprise-level distros while
the combo is more broken for developers on consumer distros due to kdump/crash
could be affected by many kernel subsystems and have a tendency to be broken
fairly quickly where the community testing is pretty much light.
