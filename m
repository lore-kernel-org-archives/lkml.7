Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EFC205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557209183;
	bh=OkguQ2WeWIjVh6M1SZeupriyFW1SzIcqKq+Ry66EB7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=trd26h8gu0yyjXhYPujXO+xLc1cURV4tvAxBx3QBzzBzU0+rMtKe/nhhqYedpptQk
	 qHh+8gglD6nFNptBjvQhPr1Hz0eowMAI7Mpvv+85DfNVtNe7THbjfyrVny6Fu8wDKw
	 qIzY/UqmfuvegMx8lWZk3ytAHK9GUxEnWV6LQK4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEGGGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfEGFdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:33:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B9220C01;
        Tue,  7 May 2019 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207230;
        bh=OkguQ2WeWIjVh6M1SZeupriyFW1SzIcqKq+Ry66EB7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwlGZ6aOB4E0OoCXB9jNaifvsvP+Hhgxoe/NyAT/Z6YmOtyA16h4Vzkx51ThWAqu/
         a8N6IPsr3TYomdZHz1qDkrRmbTbTJUukSLrV2pPa6BG4Snwp7wjj0dtS+TfMi/O5Nv
         Xq4n/PtSUoPfJPgAOA9qaAdP88KXZ/EgHydY+obc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Christian Rund <Christian.Rund@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 39/99] s390/pkey: add one more argument space for debug feature entry
Date:   Tue,  7 May 2019 01:31:33 -0400
Message-Id: <20190507053235.29900-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 6b1f16ba730d4c0cda1247568c3a1bf4fa3a2f2f ]

The debug feature entries have been used with up to 5 arguents
(including the pointer to the format string) but there was only
space reserved for 4 arguemnts. So now the registration does
reserve space for 5 times a long value.

This fixes a sometime appearing weired value as the last
value of an debug feature entry like this:

... pkey_sec2protkey zcrypt_send_cprb (cardnr=10 domain=12)
   failed with errno -2143346254

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reported-by: Christian Rund <Christian.Rund@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 2f92bbed4bf6..097e890e0d6d 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -51,7 +51,8 @@ static debug_info_t *debug_info;
 
 static void __init pkey_debug_init(void)
 {
-	debug_info = debug_register("pkey", 1, 1, 4 * sizeof(long));
+	/* 5 arguments per dbf entry (including the format string ptr) */
+	debug_info = debug_register("pkey", 1, 1, 5 * sizeof(long));
 	debug_register_view(debug_info, &debug_sprintf_view);
 	debug_set_level(debug_info, 3);
 }
-- 
2.20.1

