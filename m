Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA41C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D1E20879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558681890;
	bh=xpNn3uDwi5in7WsQGi/e8aUm1uTtyA2uJgZVykMf5Sc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XqrabfZxPXCBL77AjY9b7OmCdH0mGap5rZNIDu3S3zE14U56QGnghHZsAF2wjv2bB
	 L7hkztE04A8wwEYNbc8Gm533G9V2n3KClLPQY0SYKNXNhTg/Nh233xerQTK6Ql00mx
	 ncphddPVLYdgxgJFJ6ghIkTxlz0IlJQFHcTUGzE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389069AbfEXHL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:11:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42020 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389017AbfEXHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:11:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id 33so1572422pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPddsqOMs2VFumlMiCjin9Z1IsRX+oIN+Nj3UNKXTpY=;
        b=Gp4WWZMYEuzlwJFvJxISKLJquTk97gcRLbwoEQU1LvnFsvoU2PSKpd/msdC88GNqBZ
         Znhtvou2ePOH+4oP4WcGLHIu/HWkk3UPx/PXT4FvoY3k8sUF05/Uu3LEkQbJUovLwNX8
         sLtbG+q2+rNlyBZ+ve0DUiuQaxTZqncX1tfKRGmjnXosqvi6psoa4eMFOneVl4V2dIC1
         AkZgEeoZgFd+uKvFE6Ncy/xt0/egWkxHseYk7DASMtq504NetI0Qzxx24dNoUiz4tR9k
         BmkCGzglOBFwAgHDJ71VmgxWcs8lJy2eUTKhx8xBzk6yccYJDrJMi7lKvKxUQU7PtJjo
         RrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MPddsqOMs2VFumlMiCjin9Z1IsRX+oIN+Nj3UNKXTpY=;
        b=ZBpaOdVix1F5jzxOKnEd5HSXFnjTYO0d+XLgH2ItcbASkeQkXGnQg9Af36HF4yK566
         yo4TDlrJ2l6TeY+WWP/ictiBS5SPrbLG5NBjtwi1+W7mzCkfQuosnUj5dSqELQhVNcXi
         MmBZIIJInYFmQcq7/5mu06uowmnrkWPzIJeS98QkcOFuf8EicInh3Gv6BHcvzesi311U
         d9yao9MUgg9O542WZQU+0OdB7w59bx+dhtcq4VgjXuiHbLexl+FjQR1xGT2alDJ6+c5Y
         JxrSlaOxFUj3xLmFYnMp6WuQKFxJKALYTCstJiOBAuFHEryq9jc2oI15WZHQI/oyp4GF
         Nqcg==
X-Gm-Message-State: APjAAAWa5DQWjIGPhFx+VwKN47qQ5rvVKnbLTdIbvdlA6Cs55c3x87Bu
        Y7PTAYEIUGy0aE9EsqtopNV8QVOG
X-Google-Smtp-Source: APXvYqxT7GhpKmzpTZu1aHFmsEQEzMslywhpxvZoC6f5svrrMHno2g/tsm4jOn5ESJHrsIhXxFw21w==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr6954384pji.125.1558681885882;
        Fri, 24 May 2019 00:11:25 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e5sm1179689pgh.35.2019.05.24.00.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 00:11:24 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>, stable@kernel.org,
        Wu Fangsuo <fangsuowu@asrmicro.com>
Subject: [PATCH] mm: fix trying to reclaim unevicable LRU page
Date:   Fri, 24 May 2019 16:11:14 +0900
Message-Id: <20190524071114.74202-1-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was below bugreport from Wu Fangsuo.

7200 [  680.491097] c4 7125 (syz-executor) page:ffffffbf02f33b40 count:86 mapcount:84 mapping:ffffffc08fa7a810 index:0x24
7201 [  680.531186] c4 7125 (syz-executor) flags: 0x19040c(referenced|uptodate|arch_1|mappedtodisk|unevictable|mlocked)
7202 [  680.544987] c0 7125 (syz-executor) raw: 000000000019040c ffffffc08fa7a810 0000000000000024 0000005600000053
7203 [  680.556162] c0 7125 (syz-executor) raw: ffffffc009b05b20 ffffffc009b05b20 0000000000000000 ffffffc09bf3ee80
7204 [  680.566860] c0 7125 (syz-executor) page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page))
7205 [  680.578038] c0 7125 (syz-executor) page->mem_cgroup:ffffffc09bf3ee80
7206 [  680.585467] c0 7125 (syz-executor) ------------[ cut here ]------------
7207 [  680.592466] c0 7125 (syz-executor) kernel BUG at /home/build/farmland/adroid9.0/kernel/linux/mm/vmscan.c:1350!
7223 [  680.603663] c0 7125 (syz-executor) Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
7224 [  680.611436] c0 7125 (syz-executor) Modules linked in:
7225 [  680.616769] c0 7125 (syz-executor) CPU: 0 PID: 7125 Comm: syz-executor Tainted: G S              4.14.81 #3
7226 [  680.626826] c0 7125 (syz-executor) Hardware name: ASR AQUILAC EVB (DT)
7227 [  680.633623] c0 7125 (syz-executor) task: ffffffc00a54cd00 task.stack: ffffffc009b00000
7228 [  680.641917] c0 7125 (syz-executor) PC is at shrink_page_list+0x1998/0x3240
7229 [  680.649144] c0 7125 (syz-executor) LR is at shrink_page_list+0x1998/0x3240
7230 [  680.656303] c0 7125 (syz-executor) pc : [<ffffff90083a2158>] lr : [<ffffff90083a2158>] pstate: 60400045
7231 [  680.666086] c0 7125 (syz-executor) sp : ffffffc009b05940
..
7342 [  681.671308] c0 7125 (syz-executor) [<ffffff90083a2158>] shrink_page_list+0x1998/0x3240
7343 [  681.679567] c0 7125 (syz-executor) [<ffffff90083a3dc0>] reclaim_clean_pages_from_list+0x3c0/0x4f0
7344 [  681.688793] c0 7125 (syz-executor) [<ffffff900837ed64>] alloc_contig_range+0x3bc/0x650
7347 [  681.717421] c0 7125 (syz-executor) [<ffffff90084925cc>] cma_alloc+0x214/0x668
7348 [  681.724892] c0 7125 (syz-executor) [<ffffff90091e4d78>] ion_cma_allocate+0x98/0x1d8
7349 [  681.732872] c0 7125 (syz-executor) [<ffffff90091e0b20>] ion_alloc+0x200/0x7e0
7350 [  681.740302] c0 7125 (syz-executor) [<ffffff90091e154c>] ion_ioctl+0x18c/0x378
7351 [  681.747738] c0 7125 (syz-executor) [<ffffff90084c6824>] do_vfs_ioctl+0x17c/0x1780
7352 [  681.755514] c0 7125 (syz-executor) [<ffffff90084c7ed4>] SyS_ioctl+0xac/0xc0

Wu found it's due to [1]. Before that, unevictable page goes to cull_mlocked
routine so that it couldn't reach the VM_BUG_ON_PAGE line.

To fix the issue, this patch filter out unevictable LRU pages
from the reclaim_clean_pages_from_list in CMA.

[1] ad6b67041a45, mm: remove SWAP_MLOCK in ttu

Cc: <stable@kernel.org>	[4.12+]
Reported-debugged-by: Wu Fangsuo <fangsuowu@asrmicro.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d9c3e873eca6..7350afae5c3c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1505,7 +1505,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 
 	list_for_each_entry_safe(page, next, page_list, lru) {
 		if (page_is_file_cache(page) && !PageDirty(page) &&
-		    !__PageMovable(page)) {
+		    !__PageMovable(page) && !PageUnevictable(page)) {
 			ClearPageActive(page);
 			list_move(&page->lru, &clean_pages);
 		}
-- 
2.22.0.rc1.257.g3120a18244-goog

