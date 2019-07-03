Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42890C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC9A2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120187;
	bh=XuULE2W5LNN8hF80bdQNe3UzqVbSKA2dya2PvImWKUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1EhfAuzRW2hHq3AxqeP9LN6Xb7H1M8xUwJUnRi2ZcrwQrhCWXE6P8fD8lxGwIB7KP
	 vaekgP2fglAv2aEJAJltka4n+BlSK1YyOLrgREMkbQSrDUMCAmt43LqPLclYPuwCS0
	 v6Q8f3MkhdaUh9u5T42auLjgBIDr6O2fKwwaqs+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfGCCQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbfGCCQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:16:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505B121881;
        Wed,  3 Jul 2019 02:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120183;
        bh=XuULE2W5LNN8hF80bdQNe3UzqVbSKA2dya2PvImWKUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZnh/vSCKELIgOhTFLbaVy4VfUvA2QR2ACd8bOR99zA3wHl8i5NU0zkb/flSepJw8
         PLxOpHEKLMY94MHCCJF1qUYU6nFp2FAPDVSQ2BeqTozYjW5/kkDLx8The5bNZf1WQK
         itzMJYYr6UO+gcLFZ6bKahjGZhouTC6+5OtkHiMg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 39/39] linux/kernel.h: fix overflow for DIV_ROUND_UP_ULL
Date:   Tue,  2 Jul 2019 22:15:14 -0400
Message-Id: <20190703021514.17727-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit 8f9fab480c7a87b10bb5440b5555f370272a5d59 ]

DIV_ROUND_UP_ULL adds the two arguments and then invokes
DIV_ROUND_DOWN_ULL.  But on a 32bit system the addition of two 32 bit
values can overflow.  DIV_ROUND_DOWN_ULL does it correctly and stashes
the addition into a unsigned long long so cast the result to unsigned
long long here to avoid the overflow condition.

[akpm@linux-foundation.org: DIV_ROUND_UP_ULL must be an rval]
Link: http://lkml.kernel.org/r/20190625100518.30753-1-vkoul@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2d14e21c16c0..4330cecd2237 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -92,7 +92,8 @@
 #define DIV_ROUND_DOWN_ULL(ll, d) \
 	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
 
-#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))
+#define DIV_ROUND_UP_ULL(ll, d) \
+	DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
 
 #if BITS_PER_LONG == 32
 # define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
-- 
2.20.1

