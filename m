Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B532068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402364;
	bh=XNoYKvz5jYsa7e1+etOwz3MmWT1KcokIq3KV72exAlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Ieq0CcBBgDFuJ4lbVLKBSB1ffCXQB8WQ9VtrJABn4ZszT5T04kNipfxnTpjP1KYo
	 dkT93KHCjG/bJ3Qn3WA/j9jXL+rfHcrkW9HB4DOjlRU/y+E/4voB+k8AsP7BgxzyA9
	 xLxJCm+UhjkmVwvRqnXJQzGKYBjSUx7aSDhv+EAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKVF7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfKVF5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBF12070A;
        Fri, 22 Nov 2019 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402271;
        bh=XNoYKvz5jYsa7e1+etOwz3MmWT1KcokIq3KV72exAlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zT6LoFEq7oQ8nFUoTzO2mdykMejI3zGJXQCmw2Spia2wvqIYGBqK6FvSsAutt4/Ru
         2G4ikiCGlZB+TCCcWb10lBgB3U3gRpH5vfQKomJes1a7HhxK0JFIbMW8hsY3IWSFd5
         UKeGXtXlJWZKh+YptXO3CrHh6PHD+vDfeZ0tPRFI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bert Kenward <bkenward@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 111/127] sfc: initialise found bitmap in efx_ef10_mtd_probe
Date:   Fri, 22 Nov 2019 00:55:29 -0500
Message-Id: <20191122055544.3299-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bert Kenward <bkenward@solarflare.com>

[ Upstream commit c65285428b6e7797f1bb063f33b0ae7e93397b7b ]

The bitmap of found partitions in efx_ef10_mtd_probe was not
initialised, causing partitions to be suppressed based off whatever
value was in the bitmap at the start.

Fixes: 3366463513f5 ("sfc: suppress duplicate nvmem partition types in efx_ef10_mtd_probe")
Signed-off-by: Bert Kenward <bkenward@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index cc3be94d05622..2d92a9fe4606c 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -5918,7 +5918,7 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 static int efx_ef10_mtd_probe(struct efx_nic *efx)
 {
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_PARTITIONS_OUT_LENMAX);
-	DECLARE_BITMAP(found, EF10_NVRAM_PARTITION_COUNT);
+	DECLARE_BITMAP(found, EF10_NVRAM_PARTITION_COUNT) = { 0 };
 	struct efx_mcdi_mtd_partition *parts;
 	size_t outlen, n_parts_total, i, n_parts;
 	unsigned int type;
-- 
2.20.1

