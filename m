Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFD12075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfCRJrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:47:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:41336 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfCRJ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:01 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h5oYk-00054y-Ad; Mon, 18 Mar 2019 12:27:54 +0300
Content-Transfer-Encoding: 7bit
Subject: [PATCH REBASED 0/4] mm: Generalize putback functions
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, ktkhai@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 12:27:53 +0300
Message-ID: <155290113594.31489.16711525148390601318.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This is resending of the patchset, rebased on next-20190318).

Functions putback_inactive_pages() and move_active_pages_to_lru()
are almost similar, so this patchset merges them in only function.

v3:   Replace list_del_init() with list_del()
v2.5: Update comment
v2:   Fix tracing. Return VM_BUG_ON() check on the old place. Improve spelling.
---

Kirill Tkhai (4):
      mm: Move recent_rotated pages calculation to shrink_inactive_list()
      mm: Move nr_deactivate accounting to shrink_active_list()
      mm: Remove pages_to_free argument of move_active_pages_to_lru()
      mm: Generalize putback scan functions


 .../trace/postprocess/trace-vmscan-postprocess.pl  |    7 +
 include/linux/vmstat.h                             |    2 
 include/trace/events/vmscan.h                      |   13 +-
 mm/vmscan.c                                        |  148 +++++++-------------
 4 files changed, 68 insertions(+), 102 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
