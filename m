Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9BB21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576853286;
	bh=Tbquh1Fj1o2WG2c/z313x7NCjA3H4GBJz8gcqT1tAcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=naI0+nQsvmrzfvK4yPMzAvrf1r4UZPvdzD4vq7lQjI0AUPorV24/XN4qXL/T/BiKD
	 /dajkwGTZDMtNzsOmB4S+oUlW0gynIwKGcc3FMRIKooNC5ybEvt5uxn/6bBIYqLog8
	 TrXl6ekRg2hZDwgLy4RfUfZ7CrsTAp6aQKxJND80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLTOsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfLTOr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:47:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A3524680;
        Fri, 20 Dec 2019 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576853278;
        bh=Tbquh1Fj1o2WG2c/z313x7NCjA3H4GBJz8gcqT1tAcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxwfSws05OI5Be+aGh0cEVrycj4alyc445GgDtnqRgHnLv4F58JI1aD8zV24ETQxK
         zmfuJ9YSi0+9nw8jNlS029d4OAZKcZyzPK2EHbDsDN2Gk8iclreTOqDF5ApjAA18p2
         g7GpBMMZQTy03v95P+kSqY49MRo9DXVGZiK9G1H4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Nicholas Tsirakis <niko.tsirakis@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>, xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 4.4 11/11] xen/balloon: fix ballooned page accounting without hotplug enabled
Date:   Fri, 20 Dec 2019 09:47:43 -0500
Message-Id: <20191220144744.10565-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220144744.10565-1-sashal@kernel.org>
References: <20191220144744.10565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit c673ec61ade89bf2f417960f986bc25671762efb ]

When CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not defined
reserve_additional_memory() will set balloon_stats.target_pages to a
wrong value in case there are still some ballooned pages allocated via
alloc_xenballooned_pages().

This will result in balloon_process() no longer be triggered when
ballooned pages are freed in batches.

Reported-by: Nicholas Tsirakis <niko.tsirakis@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index cfab1d24e4bcc..1c789056e7e84 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -392,7 +392,8 @@ static struct notifier_block xen_memory_nb = {
 #else
 static enum bp_state reserve_additional_memory(void)
 {
-	balloon_stats.target_pages = balloon_stats.current_pages;
+	balloon_stats.target_pages = balloon_stats.current_pages +
+				     balloon_stats.target_unpopulated;
 	return BP_ECANCELED;
 }
 #endif /* CONFIG_XEN_BALLOON_MEMORY_HOTPLUG */
-- 
2.20.1

