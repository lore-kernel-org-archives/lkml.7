Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE8821530
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207419;
	bh=5DznuNw7z9PLodnnVnROMbB57oFbzwhOIyEtlUp36dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJS91PCYP6NHSE2mIs/FFKgT6hZ6noiJo+DogUyR4BGgRq4ocryGLv3IwOuw3+nOX
	 yCXoIaKBDaD7pB9g4LJhf657thG+rqPB37p6ccFOOZYQyPLtgtdhyWT5XbyW1kRJ28
	 Z9jz5KM1v8bgpaHBt2HieCKzWzxbodjUK2nNYHEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfEGFg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfEGFgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:36:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23CC214C6;
        Tue,  7 May 2019 05:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207412;
        bh=5DznuNw7z9PLodnnVnROMbB57oFbzwhOIyEtlUp36dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tugsefIhg0d8tgBLPaFGKJqyt669v7FaCiuKL0vnlz6MN7QFyTfvyOdkGIkPNoepj
         vRgu3xgzG1IT1cCwVOWWQoX3pRMFViv7DCnjkzlEN4Q205DIidWiwOwP7w7Xy47rQa
         wfeB/HX9qE+bGzACuXhjeCUJyWSrEFHagL1jH/oY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Christian Rund <Christian.Rund@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/81] s390/pkey: add one more argument space for debug feature entry
Date:   Tue,  7 May 2019 01:35:00 -0400
Message-Id: <20190507053554.30848-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
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
index 1b4001e0285f..b16344479959 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -45,7 +45,8 @@ static debug_info_t *debug_info;
 
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

