Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA16FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534BF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0cc8pNLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfKGAWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:22:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36407 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfKGAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:22:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so421552pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krnlyvjs+KeSr0Hw/FRyxkzA1g9k1qVle5bXbv5R+yw=;
        b=0cc8pNLTRY4uYn+HWKMYisOJ/XkVQI6HNMfotIlKRVv9t1mag0CmVviq468ziCwLou
         yG/6iyhWwop7qXtxNBa3R2bkVrC5ya4ByPrnnQO82kosOkwh0aCb/kDYyCQttFGHyR66
         JNgcpdVEWlPTpyc9tVpRmfmc3p03TYtdGths7wywJ743cw9M0GNvhMUrvOnGakSdOujC
         bMdsT6XUMaTkLsdgdZh9CwP/N1MKXeugZXggeNwXV7NJp2fbd4x7G27Cz76UqAUBqycW
         JliOIOAX2QJPXR06sTd4LGTRY3H7vWudrkFCQ633AwBThq4FB59u+7dDOEbPAwhnM8W4
         lOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=krnlyvjs+KeSr0Hw/FRyxkzA1g9k1qVle5bXbv5R+yw=;
        b=MGa8d49Jo+wnKjC1aw4IofZgwim7f+VYCusnI2WEvtCHMibWLzjKQapQqituQxR0dE
         UHctTMWVB2E8eeM82Y/DXXR3EC4Wb8xfZHbPvoa53TPLhJRR/9+xpHYpilslyVQxz/iR
         ksT4CB+VlxUUDvHd6Dc4YRdABYCeGVM1iC8lptudN4lFn8gxnK/k0qUkQOSUsiPBR2N3
         Neoj0D2xYj1+/qeK2wzGE3DYmFj1bib+jeMkmJjFJ1Tzc6BfzVMC9o+xsFKwdsi9jLbQ
         ATWVHduq3R8rs3J0EAL9GzGdb37oRUVvlpEmvWiCC3bpjOgOJMYyqBY5ECG6hUtd0P5m
         gswA==
X-Gm-Message-State: APjAAAUi1YSVLSAvyKV6O9ggUpm14SLO3e2Yg624+25MyV1/rFYbOcnN
        s/MbQtKyglhAQG1t+SH+PDQxBQ==
X-Google-Smtp-Source: APXvYqxaSZ1IFWRdCcONVtAyfoKIOk4ZuFIAmG6rRcLaVQuR4vW9ssqMnLmOUI4tX9rIPwwL6y5XiQ==
X-Received: by 2002:a62:1ac6:: with SMTP id a189mr185546pfa.96.1573086126591;
        Wed, 06 Nov 2019 16:22:06 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::2:deb0])
        by smtp.gmail.com with ESMTPSA id z25sm145364pfa.88.2019.11.06.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:22:05 -0800 (PST)
Date:   Wed, 6 Nov 2019 16:22:04 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, stable@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191107002204.GA96548@cmpxchg.org>
References: <20191106225131.3543616-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106225131.3543616-1-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:51:30PM -0800, Roman Gushchin wrote:
> We've encountered a rcu stall in get_mem_cgroup_from_mm():
> 
>  rcu: INFO: rcu_sched self-detected stall on CPU
>  rcu: 33-....: (21000 ticks this GP) idle=6c6/1/0x4000000000000002 softirq=35441/35441 fqs=5017
>  (t=21031 jiffies g=324821 q=95837) NMI backtrace for cpu 33
>  <...>
>  RIP: 0010:get_mem_cgroup_from_mm+0x2f/0x90
>  <...>
>  __memcg_kmem_charge+0x55/0x140
>  __alloc_pages_nodemask+0x267/0x320
>  pipe_write+0x1ad/0x400
>  new_sync_write+0x127/0x1c0
>  __kernel_write+0x4f/0xf0
>  dump_emit+0x91/0xc0
>  writenote+0xa0/0xc0
>  elf_core_dump+0x11af/0x1430
>  do_coredump+0xc65/0xee0
>  ? unix_stream_sendmsg+0x37d/0x3b0
>  get_signal+0x132/0x7c0
>  do_signal+0x36/0x640
>  ? recalc_sigpending+0x17/0x50
>  exit_to_usermode_loop+0x61/0xd0
>  do_syscall_64+0xd4/0x100
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The problem is caused by an exiting task which is associated with
> an offline memcg. We're iterating over and over in the
> do {} while (!css_tryget_online()) loop, but obviously the memcg won't
> become online and the exiting task won't be migrated to a live memcg.
> 
> Let's fix it by switching from css_tryget_online() to css_tryget().
> 
> As css_tryget_online() cannot guarantee that the memcg won't go
> offline, the check is usually useless, except some rare cases
> when for example it determines if something should be presented
> to a user.
> 
> A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
> css_tryget() instead of css_tryget_online() in task_get_css()").
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: stable@vger.kernel.org
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

The bug aside, it doesn't matter whether the cgroup is online for the
callers. It used to matter when offlining needed to evacuate all
charges from the memcg, and so needed to prevent new ones from showing
up, but we don't care now.
