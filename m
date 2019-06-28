Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B49CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF82063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF1IDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfF1IDD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BC50308FC20;
        Fri, 28 Jun 2019 08:02:59 +0000 (UTC)
Received: from krava (unknown [10.40.205.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id DBA351A7DB;
        Fri, 28 Jun 2019 08:02:55 +0000 (UTC)
Date:   Fri, 28 Jun 2019 10:02:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 0/7] perf diff: diff cycles at basic block level
Message-ID: <20190628080255.GA3427@krava>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 08:03:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:22:57PM +0800, Jin Yao wrote:
> In some cases small changes in hot loops can show big differences.
> But it's difficult to identify these differences.
> 
> perf diff currently can only diff symbols (functions). We can also expand
> it to diff cycles of individual programs blocks as reported by timed LBR.
> This would allow to identify changes in specific code accurately.
> 
> With this patch set, for example,
> 
>  $ perf record -b ./div
>  $ perf record -b ./div
>  $ perf diff -c cycles
> 
>  # Event 'cycles'
>  #
>  # Baseline                                       [Program Block Range] Cycles Diff  Shared Object     Symbol
>  # ........  ......................................................................  ................  ..................................
>  #
>      48.75%                                             [div.c:42 -> div.c:45]  147  div               [.] main
>      48.75%                                             [div.c:31 -> div.c:40]    4  div               [.] main
>      48.75%                                             [div.c:40 -> div.c:40]    0  div               [.] main
>      48.75%                                             [div.c:42 -> div.c:42]    0  div               [.] main
>      48.75%                                             [div.c:42 -> div.c:44]    0  div               [.] main
>      19.02%                                 [random_r.c:357 -> random_r.c:360]    0  libc-2.23.so      [.] __random_r
>      19.02%                                 [random_r.c:357 -> random_r.c:373]    0  libc-2.23.so      [.] __random_r
>      19.02%                                 [random_r.c:357 -> random_r.c:376]    0  libc-2.23.so      [.] __random_r
>      19.02%                                 [random_r.c:357 -> random_r.c:380]    0  libc-2.23.so      [.] __random_r
>      19.02%                                 [random_r.c:357 -> random_r.c:392]    0  libc-2.23.so      [.] __random_r
>      16.17%                                     [random.c:288 -> random.c:291]    0  libc-2.23.so      [.] __random
>      16.17%                                     [random.c:288 -> random.c:291]    0  libc-2.23.so      [.] __random
>      16.17%                                     [random.c:288 -> random.c:295]    0  libc-2.23.so      [.] __random
>      16.17%                                     [random.c:288 -> random.c:297]    0  libc-2.23.so      [.] __random
>      16.17%                                     [random.c:291 -> random.c:291]    0  libc-2.23.so      [.] __random
>      16.17%                                     [random.c:293 -> random.c:293]    0  libc-2.23.so      [.] __random
>       8.21%                                             [div.c:22 -> div.c:22]  148  div               [.] compute_flag
>       8.21%                                             [div.c:22 -> div.c:25]    0  div               [.] compute_flag
>       8.21%                                             [div.c:27 -> div.c:28]    0  div               [.] compute_flag
>       5.52%                                           [rand.c:26 -> rand.c:27]    0  libc-2.23.so      [.] rand
>       5.52%                                           [rand.c:26 -> rand.c:28]    0  libc-2.23.so      [.] rand
>       2.27%                                         [rand@plt+0 -> rand@plt+0]    0  div               [.] rand@plt
>       0.01%                                 [entry_64.S:694 -> entry_64.S:694]   16  [kernel.vmlinux]  [k] native_irq_return_iret
>       0.00%                                       [fair.c:7676 -> fair.c:7665]  162  [kernel.vmlinux]  [k] update_blocked_averages
> 
>  '[Program Block Range]' indicates the range of program basic block
>  (start -> end). If we can find the source line it prints the source
>  line otherwise it prints the symbol+offset instead.
> 
>  v6:
>  ---
>  Remove the 'ops' argument in hists__add_entry_block. No functional change.
> 
>  Changed patches
>   perf util: Add block_info in hist_entry 
>   perf diff: Use hists to manage basic blocks per symbol

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
