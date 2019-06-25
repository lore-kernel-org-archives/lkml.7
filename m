Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46BAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B4D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561457322;
	bh=SB0OifcBQQeaDTYy5h5HoqPRk/EuvqCl4qAhEEhDDoI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Fx8vtYmq0ACcaQzzsRWoVRUL6hs+eKEksa5Dnv/BOifLohXRIBXp3qoLAcsI8OYWc
	 LM9oj+PLysRw4YQK9dH8sgjRgU32dJIQeF+li3fPh/ksvUI4Oz0sE+zGCx4066MB0H
	 LM3APpQwMq2zqG4fw8MIzFsQoIs0QPXRhjYDurKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfFYKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfFYKIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:08:41 -0400
Received: from localhost.localdomain (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436FD20644;
        Tue, 25 Jun 2019 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561457320;
        bh=SB0OifcBQQeaDTYy5h5HoqPRk/EuvqCl4qAhEEhDDoI=;
        h=From:To:Cc:Subject:Date:From;
        b=sO8n/UqlxK/WthcAyh59xyqW3dNdUNJQMjxDdaWM9FBFlQroBZnBKecPVpKbf1U3I
         5IUlLiqbyvIK//yuz267HmhjHVcgwpHE6LS1iriSKljzRQYhulhQuFeDH1Fm4Dtgj0
         z/fXhQYiJsjww6GKLUjXswZ+LkCXAmlVj0VIxDkc=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] linux/kernel.h: fix overflow for DIV_ROUND_UP_ULL
Date:   Tue, 25 Jun 2019 15:35:18 +0530
Message-Id: <20190625100518.30753-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIV_ROUND_UP_ULL adds the two arguments and then invokes
DIV_ROUND_DOWN_ULL. But on a 32bit system the addition of two 32 bit
values can overflow. DIV_ROUND_DOWN_ULL does it correctly and stashes
the addition into a unsigned long long so cast the result to unsigned
long long here to avoid the overflow condition.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/kernel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 74b1ee9027f5..1214fb48cfc8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -93,7 +93,8 @@
 #define DIV_ROUND_DOWN_ULL(ll, d) \
 	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
 
-#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))
+#define DIV_ROUND_UP_ULL(ll, d) \
+	({ DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d)) })
 
 #if BITS_PER_LONG == 32
 # define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
-- 
2.20.1

