Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58011CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1460B2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="of2Rqi1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfKDQY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:24:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52526 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:24:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA4GOJYc048603;
        Mon, 4 Nov 2019 10:24:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572884659;
        bh=h7fAAmgCYgA9BJLRQcWv51AQbcBIhG2REXp2EloKlLk=;
        h=From:To:CC:Subject:Date;
        b=of2Rqi1epxBgHInzi0tATDyTD5PG/Jj1KwpJH1g43fN6IpKV1pULiS5rs2n5VUwzl
         bG2fiqgv4vaCt6JJ4YBjrw9uvZkYwMt+5FF2J4JiCIyAIa9bilBdRqMm52pMK1W63I
         8mHnA2Pp9d6dkK07hcQavK/urawb/GKczlcGjNAo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA4GOJK2055065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Nov 2019 10:24:19 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 4 Nov
 2019 10:24:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 4 Nov 2019 10:24:03 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA4GOGOm011098;
        Mon, 4 Nov 2019 10:24:16 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <colin.king@canonical.com>,
        <treding@nvidia.com>
Subject: [PATCH] reset: Free struct reset_control_array in reset_control_array_put()
Date:   Mon, 4 Nov 2019 18:24:15 +0200
Message-ID: <9c8c5c337a9351a561a4bf18f2faa1e9a01b50e6.1572884515.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak in devm_reset_control_array_get(). Free also the
struct reset_control_array pointer in reset_control_array_put() not
only the reset-controls stored in it.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/reset/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 213ff40dda11..85d9676ee969 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -748,6 +748,8 @@ static void reset_control_array_put(struct reset_control_array *resets)
 	for (i = 0; i < resets->num_rstcs; i++)
 		__reset_control_put_internal(resets->rstc[i]);
 	mutex_unlock(&reset_list_mutex);
+
+	kfree(resets);
 }
 
 /**
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

