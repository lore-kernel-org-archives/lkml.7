Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD81C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A56321855
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGRRSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:18:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39854 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbfGRRSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:18:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TXDOr4u_1563470282;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXDOr4u_1563470282)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 01:18:09 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [v3 PATCH 0/2] mm: mempolicy: fix mbind()'s inconsistent behavior for unmovable pages
Date:   Fri, 19 Jul 2019 01:17:52 +0800
Message-Id: <1563470274-52126-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog
v3: * Adopted the suggestions from Vastimil.  Saved another 20 lines.
      Using flag in struct queue_pages looks not outperform renumbering retval
      too much since we still have to return 1 to tell the caller there are
      unmovable pages.  So just renumber the retval.
    * Manpage is not very clear about shared pages when MPOL_MF_MOVE is
      specified, just leave it as it is for now till it gets clarified.
v2: * Fixed the inconsistent behavior by not aborting !vma_migratable()
      immediately by a separate patch (patch 1/2), and this is also the
      preparation for patch 2/2. For the details please see the commit
      log.  Per Vlastimil.
    * Not abort immediately if unmovable page is met. This should handle
      non-LRU movable pages and temporary off-LRU pages more friendly.
      Per Vlastimil and Michal Hocko.


Yang Shi (2):
      mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
      mm: mempolicy: handle vma with unmovable pages mapped correctly in mbind

 mm/mempolicy.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 26 deletions(-)
