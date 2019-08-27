Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665B5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FBD20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfH0GbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:31:24 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:48284 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfH0GbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:31:23 -0400
IronPort-SDR: koe654zV2us8Fq+4v0e+5o2AXVLN6ncxJs2tcCSFznxhMwagur02ppjBR+9jUngBShytyhV16c
 G+JlTAh/oyhQi/G2vu1Xr/ElRJmrsLM3s5hXMmKG/WkxxpIseCeudfzKZLrQGsSkxr5I7LNBFD
 sqQAb1jHIJBQMKXPt8W5iOHMOb0CWImtMPOnh/a/vIpZQC/m9pXiOdowRjMX+HN6Hz68rJcPD9
 KK5cxgRyjj8INSJraiNFJ06/3UnXzmHXI7crNfe4W/diry1dqc+Ly4NNTchbAwhea6MiJ6TZ+5
 tyw=
X-IronPort-AV: E=Sophos;i="5.64,436,1559548800"; 
   d="scan'208";a="40784644"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 26 Aug 2019 22:31:22 -0800
IronPort-SDR: VjYOOVeV3ar3cLY+iZ6nEMyZTPscW6FYwNSCsGRafIYMvc1eN35xJ/WA4R6+UejQ8kX5NdmEGP
 9UM0b8kC47os6o3DnHZxH/MSW8io9BFjN7QsZo7J8YIJenjD0RBKfBWm8cRJoehGVqfm5NPQfw
 sxOHf/qyz+8H0PW6h3DftWxTvxnpSxFd4Jd1ENUPfcxxoAKCPAI+RmASJYEaZY0J1JYTHvrV1Z
 hq5YN5x4F/Gv+5sPGlXOt6j+Y03iTgaEIKCsfRq7amJm1CWSNK0gOV/GMAV9Fi9WoiBlDI4RHX
 hko=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <george_davis@mentor.com>
Subject: [PATCH v2 41/49] Input: Atmel: improve error handling in mxt_update_cfg()
Date:   Tue, 27 Aug 2019 15:31:22 +0900
Message-ID: <20190827063130.20969-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190827063130.20969-1-jiada_wang@mentor.com>
References: <20190827063130.20969-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepak Das <deepak_das@mentor.com>

mxt_update_cfg() failed to propagate the error
code from mxt_init_t7_power_cfg() so return the error code.

Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 59533753a431..716b91e6fd66 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2183,7 +2183,9 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	dev_info(dev, "Config successfully updated\n");
 
 	/* T7 config may have changed */
-	mxt_init_t7_power_cfg(data);
+	ret = mxt_init_t7_power_cfg(data);
+	if (ret)
+		dev_warn(dev, "Power Config failed to update\n");
 
 release_mem:
 	kfree(cfg.mem);
-- 
2.19.2

