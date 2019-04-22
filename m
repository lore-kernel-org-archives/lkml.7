Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3326FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963159;
	bh=2aHGkX89auTJONCNP1G7Ry9w4/jFDkD/L6QCf9959+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h7riXkHzWrIfccYSTzA8TXQDjHqIasyZLmLTYVVnctDPCvSWEltX92/Zn5YmHM41I
	 hZ7YZwSqfCjszM6i2eeUAxA6HS+dioP5YKBq6Hr5Z6osvLvGauWwdIMtpL3UT5MIYW
	 pvsJd2WlN5rH8fwOsqvECUId4GLW1ceM5Wy5VBGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfDVTrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbfDVTrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E436A21902;
        Mon, 22 Apr 2019 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962456;
        bh=2aHGkX89auTJONCNP1G7Ry9w4/jFDkD/L6QCf9959+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNwIDb4u9Wu1fiGAhublFDVmUPJ7hSYi7z4T3rxcEh0L1+3BNpU4p9e/5DMwfRiUG
         GfHdNhjfKmNJtuzZP42Ue6kDlh4mh0d8eQ8fULrtE7fOzbssdUQjh9/Zo0ep/SDCpP
         Mn9+vMFK82sthcMN8XgUsR5A4NmdV6/bKdsG8l2k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/43] s390/qeth: fix race when initializing the IP address table
Date:   Mon, 22 Apr 2019 15:46:50 -0400
Message-Id: <20190422194727.12495-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 7221b727f0079a32aca91f657141e1de564d4b97 ]

The ucast IP table is utilized by some of the L3-specific sysfs attributes
that qeth_l3_create_device_attributes() provides. So initialize the table
_before_ registering the attributes.

Fixes: ebccc7397e4a ("s390/qeth: add missing hash table initializations")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/s390/net/qeth_l3_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index a19f2dc69e8a..d9830c86d0c1 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3022,12 +3022,14 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc;
 
+	hash_init(card->ip_htable);
+
 	if (gdev->dev.type == &qeth_generic_devtype) {
 		rc = qeth_l3_create_device_attributes(&gdev->dev);
 		if (rc)
 			return rc;
 	}
-	hash_init(card->ip_htable);
+
 	hash_init(card->ip_mc_htable);
 	card->options.layer2 = 0;
 	card->info.hwtrap = 0;
-- 
2.19.1

