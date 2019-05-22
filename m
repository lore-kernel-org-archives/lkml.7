Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADBDC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA420856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554758;
	bh=hBlKe4K4XFUtSs9+ogjc+xptZwgqZ4x7JVDLIJz+5so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alvmLWL0NGUAHwKzh/wFXqnbvRVv+WMIVRgGvN2k72oyTWpR/LTrM4Ze3SGV/usnj
	 647iBSu4YVJs31i5Io24RoKGAk/vH+r7WRYsVo8oodoXDlW03EkvIm985GiIcXNM5l
	 lNJCY0C6AmEO47JEb7Xkh5VB4da2SnERS88/I+3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfEVT0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbfEVTZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:25:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1165217D9;
        Wed, 22 May 2019 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553156;
        bh=hBlKe4K4XFUtSs9+ogjc+xptZwgqZ4x7JVDLIJz+5so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EeycQYkAzVFfGpAXmEWtoJ5Gyaq2LBH3FlWFH+5YeeVX16X+OW3vT5+FllDUsQM8
         WbRF3nAPj5iQ7ZkiM1/ZA5R456eGpl9XizjqbRzu/4zYzVGwFEgXb5VKpGqv6IjnKc
         U7VDsQVTgIGV9qn/pzKhiBGWEae7GGokOCGgQlmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shenghui Wang <shhuiw@foxmail.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 083/317] bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYNC branch of run_cache_set
Date:   Wed, 22 May 2019 15:19:44 -0400
Message-Id: <20190522192338.23715-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

[ Upstream commit 95f18c9d1310730d075499a75aaf13bcd60405a7 ]

In the CACHE_SYNC branch of run_cache_set(), LIST_HEAD(journal) is used
to collect journal_replay(s) and filled by bch_journal_read().

If all goes well, bch_journal_replay() will release the list of
jounal_replay(s) at the end of the branch.

If something goes wrong, code flow will jump to the label "err:" and leave
the list unreleased.

This patch will release the list of journal_replay(s) in the case of
error detected.

v1 -> v2:
* Move the release code to the location after label 'err:' to
  simply the change.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4dee119c36646..7adafe8488273 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1782,6 +1782,8 @@ static void run_cache_set(struct cache_set *c)
 	struct cache *ca;
 	struct closure cl;
 	unsigned int i;
+	LIST_HEAD(journal);
+	struct journal_replay *l;
 
 	closure_init_stack(&cl);
 
@@ -1939,6 +1941,12 @@ static void run_cache_set(struct cache_set *c)
 	set_bit(CACHE_SET_RUNNING, &c->flags);
 	return;
 err:
+	while (!list_empty(&journal)) {
+		l = list_first_entry(&journal, struct journal_replay, list);
+		list_del(&l->list);
+		kfree(l);
+	}
+
 	closure_sync(&cl);
 	/* XXX: test this, it's broken */
 	bch_cache_set_error(c, "%s", err);
-- 
2.20.1

