Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694492075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCKD6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:58:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:37052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfCKD6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:58:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F110BACA8;
        Mon, 11 Mar 2019 03:58:21 +0000 (UTC)
Date:   Sun, 10 Mar 2019 20:58:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, jgg@mellanox.com, arnd@arndb.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Message-ID: <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
Mail-Followup-To: Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        jgg@mellanox.com, arnd@arndb.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190310183051.87303-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190310183051.87303-1-cai@lca.pw>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019, Qian Cai wrote:

>atomic64_read() on ppc64le returns "long int", so fix the same way as
>the commit d549f545e690 ("drm/virtio: use %llu format string form
>atomic64_t") by adding a cast to u64, which makes it work on all arches.
>
>In file included from ./include/linux/printk.h:7,
>                 from ./include/linux/kernel.h:15,
>                 from mm/debug.c:9:
>mm/debug.c: In function 'dump_mm':
>./include/linux/kern_levels.h:5:18: warning: format '%llx' expects
>argument of type 'long long unsigned int', but argument 19 has type
>'long int' [-Wformat=]
> #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                  ^~~~~~
>./include/linux/kern_levels.h:8:20: note: in expansion of macro
>'KERN_SOH'
> #define KERN_EMERG KERN_SOH "0" /* system is unusable */
>                    ^~~~~~~~
>./include/linux/printk.h:297:9: note: in expansion of macro 'KERN_EMERG'
>  printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
>         ^~~~~~~~~~
>mm/debug.c:133:2: note: in expansion of macro 'pr_emerg'
>  pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
>  ^~~~~~~~
>mm/debug.c:140:17: note: format string is defined here
>   "pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
>              ~~~^
>              %lx
>
>Fixes: 70f8a3ca68d3 ("mm: make mm->pinned_vm an atomic64 counter")
>Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
