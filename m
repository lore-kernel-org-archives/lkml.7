Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28888C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002EE2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfCUT0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:26:18 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59721 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUT0S (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Mar 2019 15:26:18 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 21 Mar 2019 20:26:16 +0100
Received: from localhost.localdomain (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 21 Mar 2019 19:04:43 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     manfred@colorfullife.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -next 1/2] ipc/mqueue: remove redundant wq task assignment
Date:   Thu, 21 Mar 2019 12:02:15 -0700
Message-Id: <20190321190216.1719-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already store the current task fo the new waiter before calling
wq_sleep() in both send and recv paths. Trivially remove the redundant
assignment.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/mqueue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 127ba1e8950b..be3f599e90ed 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -617,8 +617,6 @@ static void wq_add(struct mqueue_inode_info *info, int sr,
 {
 	struct ext_wait_queue *walk;
 
-	ewp->task = current;
-
 	list_for_each_entry(walk, &info->e_wait_q[sr].list, list) {
 		if (walk->task->prio <= current->prio) {
 			list_add_tail(&ewp->list, &walk->list);
-- 
2.16.4

