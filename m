Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B940FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C5F206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfFELoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfFELoT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 517BA2F8BCF;
        Wed,  5 Jun 2019 11:44:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 632BD5F7C2;
        Wed,  5 Jun 2019 11:44:09 +0000 (UTC)
Date:   Wed, 5 Jun 2019 13:44:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 6/7] perf diff: Print the basic block cycles diff
Message-ID: <20190605114408.GA5868@krava>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-7-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559572577-25436-7-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 05 Jun 2019 11:44:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:36:16PM +0800, Jin Yao wrote:
> perf record -b ./div
> perf record -b ./div
> 
> Following is the default perf diff output
> 
>  # perf diff
> 
>  # Event 'cycles'
>  #
>  # Baseline  Delta Abs  Shared Object     Symbol
>  # ........  .........  ................  ....................................
>  #
>      49.03%     +0.30%  div               [.] main
>      16.29%     -0.20%  libc-2.23.so      [.] __random
>      18.82%     -0.07%  libc-2.23.so      [.] __random_r
>       8.11%     -0.04%  div               [.] compute_flag
>       2.25%     +0.01%  div               [.] rand@plt
>       0.00%     +0.01%  [kernel.vmlinux]  [k] task_tick_fair
>       5.46%     +0.01%  libc-2.23.so      [.] rand
>       0.01%     -0.01%  [kernel.vmlinux]  [k] native_irq_return_iret
>       0.00%     -0.00%  [kernel.vmlinux]  [k] interrupt_entry
> 
> This patch creates a new computation selection 'cycles'.
> 
>  # perf diff -c cycles
> 
>  # Event 'cycles'
>  #
>  # Baseline         Block cycles diff [start:end]  Shared Object     Symbol
>  # ........  ....................................  ................  ....................................
>  #
>      49.03%        -9 [         4ef:         520]  div               [.] main
>      49.03%         0 [         4e8:         4ea]  div               [.] main
>      49.03%         0 [         4ef:         500]  div               [.] main
>      49.03%         0 [         4ef:         51c]  div               [.] main
>      49.03%         0 [         4ef:         535]  div               [.] main
>      18.82%         0 [       3ac40:       3ac4d]  libc-2.23.so      [.] __random_r
>      18.82%         0 [       3ac40:       3ac5c]  libc-2.23.so      [.] __random_r
>      18.82%         0 [       3ac40:       3ac76]  libc-2.23.so      [.] __random_r
>      18.82%         0 [       3ac40:       3ac88]  libc-2.23.so      [.] __random_r
>      18.82%         0 [       3ac90:       3ac9c]  libc-2.23.so      [.] __random_r
>      16.29%        -8 [       3aac0:       3aac0]  libc-2.23.so      [.] __random
>      16.29%         0 [       3aac0:       3aad2]  libc-2.23.so      [.] __random
>      16.29%         0 [       3aae0:       3aae7]  libc-2.23.so      [.] __random
>      16.29%         0 [       3ab03:       3ab0f]  libc-2.23.so      [.] __random
>      16.29%         0 [       3ab14:       3ab1b]  libc-2.23.so      [.] __random
>      16.29%         0 [       3ab28:       3ab2e]  libc-2.23.so      [.] __random
>      16.29%         0 [       3ab4a:       3ab53]  libc-2.23.so      [.] __random
>       8.11%         0 [         640:         644]  div               [.] compute_flag
>       8.11%         0 [         649:         659]  div               [.] compute_flag
>       5.46%         0 [       3af60:       3af60]  libc-2.23.so      [.] rand
>       5.46%         0 [       3af60:       3af64]  libc-2.23.so      [.] rand
>       2.25%         0 [         490:         490]  div               [.] rand@plt
>       0.01%        26 [      c00a27:      c00a27]  [kernel.vmlinux]  [k] native_irq_return_iret
>       0.00%      -157 [      2bf9f2:      2bfa63]  [kernel.vmlinux]  [k] update_blocked_averages
>       0.00%       -56 [      2bf980:      2bf9d3]  [kernel.vmlinux]  [k] update_blocked_averages
>       0.00%        48 [      2bf934:      2bf942]  [kernel.vmlinux]  [k] update_blocked_averages
>       0.00%         3 [      2bfb38:      2bfb67]  [kernel.vmlinux]  [k] update_blocked_averages
>       0.00%         0 [      2bf968:      2bf97b]  [kernel.vmlinux]  [k] update_blocked_averages
> 

so what I'd expect would be Baseline column with cycles and another
column showing the differrence (in cycles) for given symbol

> "[start:end]" indicates the basic block range. The output is sorted
> by "Baseline" and the basic blocks in the same function are sorted
> by cycles diff.

hum, why is there multiple basic blocks [start:end] for a symbol?

thanks,
jirka
