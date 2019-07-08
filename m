Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CABC606AA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486B920656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfGHKfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:35:46 -0400
Received: from swift.blarg.de ([138.201.185.127]:34415 "EHLO swift.blarg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfGHKfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:35:46 -0400
Received: by swift.blarg.de (Postfix, from userid 1000)
        id 1097840363; Mon,  8 Jul 2019 12:35:44 +0200 (CEST)
Date:   Mon, 8 Jul 2019 12:35:44 +0200
From:   Max Kellermann <max@blarg.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Kernel 5.1.15 stuck in compaction
Message-ID: <20190708103543.GA10364@swift.blarg.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one of our web servers got repeatedly stuck in the memory compaction
code; two PHP processes have been busy at 100% inside memory
compaction after a page fault:

   100.00%     0.00%  php-cgi7.0  [kernel.vmlinux]  [k] page_fault
            |
            ---page_fault
               __do_page_fault
               handle_mm_fault
               __handle_mm_fault
               do_huge_pmd_anonymous_page
               __alloc_pages_nodemask
               __alloc_pages_slowpath
               __alloc_pages_direct_compact
               try_to_compact_pages
               compact_zone_order
               compact_zone
               |          
               |--61.30%--isolate_migratepages_block
               |          |          
               |          |--20.44%--node_page_state
               |          |          
               |          |--5.88%--compact_unlock_should_abort.isra.33
               |          |          
               |           --3.28%--_cond_resched
               |                     |          
               |                      --2.19%--rcu_all_qs
               |          
                --3.37%--pageblock_skip_persistent

ftrace:

           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: _cond_resched <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: rcu_all_qs <-_cond_resched
           <...>-962300 [033] .... 236536.493919: compact_unlock_should_abort.isra.33 <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: pageblock_skip_persistent <-compact_zone
           <...>-962300 [033] .... 236536.493919: isolate_migratepages_block <-compact_zone
           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493919: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493920: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493920: node_page_state <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493920: _cond_resched <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493920: rcu_all_qs <-_cond_resched
           <...>-962300 [033] .... 236536.493920: compact_unlock_should_abort.isra.33 <-isolate_migratepages_block
           <...>-962300 [033] .... 236536.493920: pageblock_skip_persistent <-compact_zone
           <...>-962300 [033] .... 236536.493920: isolate_migratepages_block <-compact_zone
           <...>-962300 [033] .... 236536.493920: node_page_state <-isolate_migratepages_block

Nothing useful in /proc/PID/{stack,wchan,syscall}.

slabinfo/kmalloc-{16,32} are going through the roof (~ 15 GB each),
and this memleak-lookalike triggering the oomkiller all the time is
what drew our attention to this server.

Right now, the server is still stuck, and I can attempt to collect
more information on request.

Max
