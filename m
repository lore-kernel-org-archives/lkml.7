Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD140C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE96020578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207581;
	bh=Xr2lq4+YQIty+EgsKo1pDRwS9bE6NkkxmsNUf3Zmo5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=03WhQlnu9ncisrJUE+L2cmm7VrLpK+c/9yQ4X/RZqEdnKKP2+2KtgFhfcZT4IP++L
	 IyslHJzu/s0xOosFwTBtjxx27eAvOsx8hiUt8iZxHx2aGy9FkWIypWt9ueLVd5H0F+
	 anV4vUZ3zdSR7+GHY0zCpgAFi7pqkizbDbv5FqJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfEGFjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbfEGFjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:39:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6401620578;
        Tue,  7 May 2019 05:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207577;
        bh=Xr2lq4+YQIty+EgsKo1pDRwS9bE6NkkxmsNUf3Zmo5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdH2GT6XVaGEkPOFDUxoiwY1j9h6ysCuyfRQ6rNgpIwxnHqvtOQo18wSchcQ0nmqd
         9YattNngqtGGJtKJy9FolJv2t3AtF9anKMKzEDh398wTR5O/4Y90f0mKMjst8S8QN7
         DavOx9pjGF8sox4CxCpAFV1KNSEOhBEuboKNK1VU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 35/95] sparc64: Export __node_distance.
Date:   Tue,  7 May 2019 01:37:24 -0400
Message-Id: <20190507053826.31622-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 2b4792eaa9f553764047d157365ed8b7787751a3 ]

Some drivers reference it via node_distance(), for example the
NVME host driver core.

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/mm/init_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 984e9d65ea0d..76977296dc9c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1383,6 +1383,7 @@ int __node_distance(int from, int to)
 	}
 	return numa_latency[from][to];
 }
+EXPORT_SYMBOL(__node_distance);
 
 static int __init find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 {
-- 
2.20.1

