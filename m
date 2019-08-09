Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9009A20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ybXgvvzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437071AbfHIQ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:27:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfHIQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:27:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79GRHmd008862;
        Fri, 9 Aug 2019 11:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565368037;
        bh=ycgZGu5jizhkdNlgseKrh0xuvw11PVPMLsg9Kj5tN+w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ybXgvvzX349Gw1IsgaEQY0uV4oCn6ib/HczFWW7kF1QJ4xMNBF1QT/Fi8jo8LX5B9
         oq1E/oPW3fqup2kSp3TKnbKqh5tl4spWMvv5FvvAjILqNo2dGRY/QPBkt495Axx2n/
         OnDwGeBqfCLJ76FotwO1fSr9+XU5089WJlYyj0/k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79GRHR5029802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 11:27:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 11:27:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 11:27:17 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79GRHlg092929;
        Fri, 9 Aug 2019 11:27:17 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x79GRGZ10540;
        Fri, 9 Aug 2019 11:27:16 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] samples/rpmsg: Replace print_hex_dump() with print_hex_dump_debug()
Date:   Fri, 9 Aug 2019 11:27:09 -0500
Message-ID: <20190809162710.823-2-s-anna@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809162710.823-1-s-anna@ti.com>
References: <20190809162710.823-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the raw print_hex_dump() call in the rpmsg_sample_cb() function
with the equivalent print_hex_dump_debug() better suited for dynamic
debug. This switch allows flexibility of controlling this trace through
dynamic debug when enabled.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 samples/rpmsg/rpmsg_client_sample.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index 2a0695573b47..b9a99e621a5c 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -29,8 +29,8 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 	dev_info(&rpdev->dev, "incoming msg %d (src: 0x%x)\n",
 		 ++idata->rx_count, src);
 
-	print_hex_dump(KERN_DEBUG, __func__, DUMP_PREFIX_NONE, 16, 1,
-		       data, len,  true);
+	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data, len,
+			     true);
 
 	/* samples should not live forever */
 	if (idata->rx_count >= MSG_LIMIT) {
-- 
2.22.0

