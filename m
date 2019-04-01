Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFD4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FE320830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140254;
	bh=Pn9ei5vMXH0ED/kHYl/Cv/TG13p8zU5TJNgMwbr1XbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=la2Z3SYTVw2PgddAp4vsMYEO6WmRlmSo2aaU7MOpMkqOe9jmB+3URsy5Gs3bnGKtZ
	 drNzQ4685lHCkjS5VNd+13L/cBkQT6TM/Y3FNlVOdXmBMBjyEJBMAmAeDW1CmpNAcL
	 o1VKpa0zpNsd1X6xejhNiVqET5UNPSkJqErXSbPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfDARhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbfDARh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79A22070B;
        Mon,  1 Apr 2019 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140246;
        bh=Pn9ei5vMXH0ED/kHYl/Cv/TG13p8zU5TJNgMwbr1XbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSEZQhFXB6yRanKo8cqGBh9aGRcfTmtGDL+VIbcMexKdF8KSemIBrD90o8cLG/vKT
         aY7XZB+dbG5ZHcegOIxZA+Ck4/MkpOoXyBHBQCtHCz521i8Ta0P7X4QkDDfKNQ9zMj
         4wp0rMqdA+Iw+lJDB9jc/QahEzkf+OwyFaZuv1MU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Jin Qian <jinqian@android.com>, Alan <alan@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 18/50] staging: goldfish: audio: fix compiliation on arm
Date:   Mon,  1 Apr 2019 19:03:01 +0200
Message-Id: <20190401170043.477152296@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4532150762ceb0d6fd765ebcb3ba6966fbb8faab ]

We do actually need slab.h, by luck we get it on other platforms but not
always on ARM. Include it properly.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/goldfish/goldfish_audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index f200359c4443..57e931d0c940 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
 #include <linux/uaccess.h>
+#include <linux/slab.h>
 #include <linux/goldfish.h>
 
 MODULE_AUTHOR("Google, Inc.");
-- 
2.19.1



