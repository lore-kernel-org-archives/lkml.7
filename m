Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29784C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8672084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfDBSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:25:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbfDBSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:25:15 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32IJMlH050627
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 14:25:14 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbmtm8rb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:25:13 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 2 Apr 2019 19:25:12 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 19:25:09 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32IP8lD23855210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 18:25:08 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0ECFAE05F;
        Tue,  2 Apr 2019 18:25:07 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B8FEAE067;
        Tue,  2 Apr 2019 18:25:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 18:25:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: [PATCH 1/5] media: platform: Aspeed: Remove use of reset line
Date:   Tue,  2 Apr 2019 18:25:00 +0000
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040218-0072-0000-0000-00000414860D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183363; UDB=6.00619524; IPR=6.00964110;
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:25:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0073-0000-0000-00004BB009D1
Message-Id: <1554229504-5661-2-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset line is toggled by enabling the clocks, so it's not necessary
to manually toggle the reset as well.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/media/platform/aspeed-video.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 692e08e..55c55a6 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -14,7 +14,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -208,7 +207,6 @@ struct aspeed_video {
 	void __iomem *base;
 	struct clk *eclk;
 	struct clk *vclk;
-	struct reset_control *rst;
 
 	struct device *dev;
 	struct v4l2_ctrl_handler ctrl_handler;
@@ -483,19 +481,10 @@ static void aspeed_video_enable_mode_detect(struct aspeed_video *video)
 	aspeed_video_update(video, VE_SEQ_CTRL, 0, VE_SEQ_CTRL_TRIG_MODE_DET);
 }
 
-static void aspeed_video_reset(struct aspeed_video *video)
-{
-	/* Reset the engine */
-	reset_control_assert(video->rst);
-
-	/* Don't usleep here; function may be called in interrupt context */
-	udelay(100);
-	reset_control_deassert(video->rst);
-}
-
 static void aspeed_video_off(struct aspeed_video *video)
 {
-	aspeed_video_reset(video);
+	/* Disable interrupts */
+	aspeed_video_write(video, VE_INTERRUPT_CTRL, 0);
 
 	/* Turn off the relevant clocks */
 	clk_disable_unprepare(video->vclk);
@@ -507,8 +496,6 @@ static void aspeed_video_on(struct aspeed_video *video)
 	/* Turn on the relevant clocks */
 	clk_prepare_enable(video->eclk);
 	clk_prepare_enable(video->vclk);
-
-	aspeed_video_reset(video);
 }
 
 static void aspeed_video_bufs_done(struct aspeed_video *video,
@@ -1464,7 +1451,9 @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
 		 * Need to force stop any DMA and try and get HW into a good
 		 * state for future calls to start streaming again.
 		 */
-		aspeed_video_reset(video);
+		aspeed_video_off(video);
+		aspeed_video_on(video);
+
 		aspeed_video_init_regs(video);
 
 		aspeed_video_get_resolution(video);
@@ -1619,12 +1608,6 @@ static int aspeed_video_init(struct aspeed_video *video)
 		return PTR_ERR(video->vclk);
 	}
 
-	video->rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(video->rst)) {
-		dev_err(dev, "Unable to get VE reset\n");
-		return PTR_ERR(video->rst);
-	}
-
 	rc = of_reserved_mem_device_init(dev);
 	if (rc) {
 		dev_err(dev, "Unable to reserve memory\n");
-- 
1.8.3.1

