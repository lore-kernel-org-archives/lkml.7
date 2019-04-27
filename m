Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F2C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2221707
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329438;
	bh=HB86TdKubOitt8MMA3LIoAod3tgHlFxwZHUSCaArdFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kEX3C2gYhaWjreqAbT0pupq3+A/Jzuhk8FzXWVE8C3kI7rL//SkpTt6xRhJFLt60h
	 Xo5tyme7+0iUYs/zpDTuekXjciVAFPYYgqOPWEduSsMIgmIjC+t1OeckICLEfva26g
	 eA9hXjkRbi7U91HKfD+BbhO1hc3wwgXpxjCk71Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfD0Bn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbfD0Bnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76A0215EA;
        Sat, 27 Apr 2019 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329434;
        bh=HB86TdKubOitt8MMA3LIoAod3tgHlFxwZHUSCaArdFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVMKiUDvl5OH5gWiLrtx1OkqvcgRfFFjm6HMQouc8UHw5ZXOMrsCEHcB0cKCojL7y
         xGQeKTPuO3tu7r4UHZbAIP/ElUOeJLs66S6BonpZOtHySNLmLHlMoO+i0+K+uRf12c
         2sBLqc5MOJyPLoYe8L+ouW0SocaIwcPQN7qZO0Es=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.9 16/16] mm: add 'try_get_page()' helper function
Date:   Fri, 26 Apr 2019 21:43:24 -0400
Message-Id: <20190427014325.8704-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014325.8704-1-sashal@kernel.org>
References: <20190427014325.8704-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 88b1a17dfc3ed7728316478fae0f5ad508f50397 ]

This is the same as the traditional 'get_page()' function, but instead
of unconditionally incrementing the reference count of the page, it only
does so if the count was "safe".  It returns whether the reference count
was incremented (and is marked __must_check, since the caller obviously
has to be aware of it).

Also like 'get_page()', you can't use this function unless you already
had a reference to the page.  The intent is that you can use this
exactly like get_page(), but in situations where you want to limit the
maximum reference count.

The code currently does an unconditional WARN_ON_ONCE() if we ever hit
the reference count issues (either zero or negative), as a notification
that the conditional non-increment actually happened.

NOTE! The count access for the "safety" check is inherently racy, but
that doesn't matter since the buffer we use is basically half the range
of the reference count (ie we look at the sign of the count).

Acked-by: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 11a5a46ce72b..e3c8d40a18b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -777,6 +777,15 @@ static inline void get_page(struct page *page)
 		get_zone_device_page(page);
 }
 
+static inline __must_check bool try_get_page(struct page *page)
+{
+	page = compound_head(page);
+	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+		return false;
+	page_ref_inc(page);
+	return true;
+}
+
 static inline void put_page(struct page *page)
 {
 	page = compound_head(page);
-- 
2.19.1

