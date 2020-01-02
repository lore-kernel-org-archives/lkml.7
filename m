Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80510C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4809A2253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003556;
	bh=KcelGyWJAYZ6r/myYq/loWbcnlucF4JKI0LqQ0izcgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pK15MeQgKl/l2hDacHHYzChe1M/sHtgpiPLGMJjlSVVnOpueDJwI2kvHJjd+W8+pf
	 mSVIZLdukm6CFxb1Tq8EGnDqVqNPiOhM+7UpGHJu/o4G10ELYGC2EW0JyIrveBvIKO
	 yaVtdb+f69aEe3buvo8pRZWH4SfbsUBkWWxuUT1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgABWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgABWTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:19:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ABA12253D;
        Thu,  2 Jan 2020 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003550;
        bh=KcelGyWJAYZ6r/myYq/loWbcnlucF4JKI0LqQ0izcgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDpwJCma5+6TJYgpokpAeUC5SKj3XiGW2wMRwSrtVpra7NJ7GPXZfs/HhNzHCY/R+
         oA9juyCqI5oinOQR8bg6r0vym5/snWSvEa0Dbcw8b7VSMeQ4YZDbVhIvEAddBtKjLX
         M0/UxE87VKeyh+MbO5QyOcl1OlBCGJHfFblUAvsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/114] dma-debug: add a schedule point in debug_dma_dump_mappings()
Date:   Thu,  2 Jan 2020 23:06:28 +0100
Message-Id: <20200102220030.772529004@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9ff6aa027dbb98755f0265695354f2dd07c0d1ce ]

debug_dma_dump_mappings() can take a lot of cpu cycles :

lpk43:/# time wc -l /sys/kernel/debug/dma-api/dump
163435 /sys/kernel/debug/dma-api/dump

real	0m0.463s
user	0m0.003s
sys	0m0.459s

Let's add a cond_resched() to avoid holding cpu for too long.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index c007d25bee09..3a2397444076 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -442,6 +442,7 @@ void debug_dma_dump_mappings(struct device *dev)
 		}
 
 		spin_unlock_irqrestore(&bucket->lock, flags);
+		cond_resched();
 	}
 }
 
-- 
2.20.1



