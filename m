Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C29C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA46321924
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353732;
	bh=qtfPSf5XdBg0WP4w6wOZQEFPEjvRITY3Jf5D6oN0y44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OLctDUH701mygmevRCt+pcO7KmfUEQ72Tnu4CGL5syZhkKXHwmZTTEOu/eJ5/s8e3
	 TAneBjvTGQet861iTq17c3tQoey87xs+IUAyfgPx9YMEmjfYlTgB+3y/Cih7mu+QrS
	 sRQoczTVD0OSCUOcC1j9WH3YRgN0l8UGvToU/Txc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfKJCmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfKJCmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:42:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D6321882;
        Sun, 10 Nov 2019 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353724;
        bh=qtfPSf5XdBg0WP4w6wOZQEFPEjvRITY3Jf5D6oN0y44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nztg3SLtobSi7ImkzpS1Bl9dXpnQbYkkxrvQ85dni3f06qN9RG7DtbUzxUjSXfzqB
         qtS1shxMGyJMzgeCmN1Y01MT8/eOR9q8163Ws644EN10YwZHPjL+B/pipz+Kvq+jfo
         pv0132foX+xk5G4dn1+19vKRdBMVCgq9IdkmPeS8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 055/191] s390/zcrypt: enable AP bus scan without a valid default domain
Date:   Sat,  9 Nov 2019 21:37:57 -0500
Message-Id: <20191110024013.29782-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Halil Pasic <pasic@linux.ibm.com>

[ Upstream commit 1c472d46283263497adccd7a0bec64ee2f9c09e5 ]

The AP bus scan is aborted before doing anything worth mentioning if
ap_select_domain() fails, e.g. if the ap_rights.aqm mask is all zeros.
As the result of this the ap bus fails to manage (e.g. create and
register) devices like it is supposed to.

Let us make ap_scan_bus() work even if ap_select_domain() can't select a
default domain. Let's also make ap_select_domain() return void, as there
are no more callers interested in its return value.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Michael Mueller <mimu@linux.ibm.com>
Fixes: 7e0bdbe5c21c "s390/zcrypt: AP bus support for alternate driver(s)"
[freude@linux.ibm.com: title and patch header slightly modified]
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/ap_bus.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 3be54651698a3..027a53eec42a5 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1223,11 +1223,10 @@ static struct bus_attribute *const ap_bus_attrs[] = {
 };
 
 /**
- * ap_select_domain(): Select an AP domain.
- *
- * Pick one of the 16 AP domains.
+ * ap_select_domain(): Select an AP domain if possible and we haven't
+ * already done so before.
  */
-static int ap_select_domain(void)
+static void ap_select_domain(void)
 {
 	int count, max_count, best_domain;
 	struct ap_queue_status status;
@@ -1242,7 +1241,7 @@ static int ap_select_domain(void)
 	if (ap_domain_index >= 0) {
 		/* Domain has already been selected. */
 		spin_unlock_bh(&ap_domain_lock);
-		return 0;
+		return;
 	}
 	best_domain = -1;
 	max_count = 0;
@@ -1269,11 +1268,8 @@ static int ap_select_domain(void)
 	if (best_domain >= 0) {
 		ap_domain_index = best_domain;
 		AP_DBF(DBF_DEBUG, "new ap_domain_index=%d\n", ap_domain_index);
-		spin_unlock_bh(&ap_domain_lock);
-		return 0;
 	}
 	spin_unlock_bh(&ap_domain_lock);
-	return -ENODEV;
 }
 
 /*
@@ -1351,8 +1347,7 @@ static void ap_scan_bus(struct work_struct *unused)
 	AP_DBF(DBF_DEBUG, "%s running\n", __func__);
 
 	ap_query_configuration(ap_configuration);
-	if (ap_select_domain() != 0)
-		goto out;
+	ap_select_domain();
 
 	for (id = 0; id < AP_DEVICES; id++) {
 		/* check if device is registered */
@@ -1468,12 +1463,11 @@ static void ap_scan_bus(struct work_struct *unused)
 		}
 	} /* end device loop */
 
-	if (defdomdevs < 1)
+	if (ap_domain_index >= 0 && defdomdevs < 1)
 		AP_DBF(DBF_INFO,
 		       "no queue device with default domain %d available\n",
 		       ap_domain_index);
 
-out:
 	mod_timer(&ap_config_timer, jiffies + ap_config_time * HZ);
 }
 
-- 
2.20.1

