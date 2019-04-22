Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05A62064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963833;
	bh=2faHgYVM3TbxpuMg1quCd/XT0P4oE6ae6O2XOYs5oRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bn1stbbcVWFSCGYtxakDs0FDyP+W0AZ3X3dVhjsEJ7pV8KsH2x0tlhd9V4S/S9jdL
	 MOLI4475kz0oBisHZVCzQjj6IEY3TItpbYSiqmKjQ6nMh9Gqhd8edRV9MF8kUvtZKn
	 k89yQ9xRepXgzWxBAvUkYprAj/uPAishqtSTi+Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfDVUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfDVTmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545052175B;
        Mon, 22 Apr 2019 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962151;
        bh=2faHgYVM3TbxpuMg1quCd/XT0P4oE6ae6O2XOYs5oRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1Je6bzePgOsHIPXVKqA/vdqGoAinM7c9/RMiU9gyAY8xLPF5ywo948JCGgbmvmqY
         2rfji5A5qusQHJFwbXZp/J2r0/b/RZ0s4b2vlveTlSgYFVRarMXjX9HvzFKSe7xkI1
         NNjhLKWi80pdwt3bF4TzUD5Y1qQthoA6PjcZFZV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 21/98] s390/qeth: fix race when initializing the IP address table
Date:   Mon, 22 Apr 2019 15:40:48 -0400
Message-Id: <20190422194205.10404-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
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
index df34bff4ac31..f73ce96e9603 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2316,12 +2316,14 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
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
 	card->info.hwtrap = 0;
 	return 0;
-- 
2.19.1

