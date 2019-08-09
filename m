Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1DBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15982171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olyPnxjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437199AbfHIQ10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:27:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55540 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfHIQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:27:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79GRIaX068444;
        Fri, 9 Aug 2019 11:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565368038;
        bh=hejhV7p35tABFvLqhdiGyN6o5tkE6x3rXXh80KuLZxc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=olyPnxjTYspFa2lTlq6wq3nFOp8orHB0zNOLMdX60uTyyibXGhVj1omuuYp35mu6K
         rAp4IyJkbhbO74Iz3K3Xj+jex+dGtlD0KaY+OO+xfMwgtpIL5khaiGFavroPKk+0aF
         S+1KZMEVsl4Pw2U3IysD3WZbc4JwLdEB4N7CVOAw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79GRID0035097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 11:27:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 11:27:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 11:27:18 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79GRIqC032436;
        Fri, 9 Aug 2019 11:27:18 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x79GRIZ10563;
        Fri, 9 Aug 2019 11:27:18 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] samples/rpmsg: Introduce a module parameter for message count
Date:   Fri, 9 Aug 2019 11:27:10 -0500
Message-ID: <20190809162710.823-3-s-anna@ti.com>
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

The current rpmsg_client_sample uses a fixed number of messages to
be sent to each instance. This is currently set at 100. Introduce
an optional module parameter 'count' so that the number of messages
to be exchanged can be made flexible.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 samples/rpmsg/rpmsg_client_sample.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index b9a99e621a5c..ae5081662283 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -14,7 +14,9 @@
 #include <linux/rpmsg.h>
 
 #define MSG		"hello world!"
-#define MSG_LIMIT	100
+
+static int count = 100;
+module_param(count, int, 0644);
 
 struct instance_data {
 	int rx_count;
@@ -33,7 +35,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 			     true);
 
 	/* samples should not live forever */
-	if (idata->rx_count >= MSG_LIMIT) {
+	if (idata->rx_count >= count) {
 		dev_info(&rpdev->dev, "goodbye!\n");
 		return 0;
 	}
-- 
2.22.0

