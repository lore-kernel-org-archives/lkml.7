Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868ADC33CA4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C85120721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgAIU7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:59:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbgAIU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:59:31 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009KwF0e073070;
        Thu, 9 Jan 2020 15:59:19 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe98mn1sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 15:59:19 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 009Ktqt9026365;
        Thu, 9 Jan 2020 20:59:18 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 2xajb7guh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 20:59:18 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009KxHHw54657306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 20:59:17 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E30AC05B;
        Thu,  9 Jan 2020 20:59:17 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E034AC059;
        Thu,  9 Jan 2020 20:59:16 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.211.92.233])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 20:59:16 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com
Subject: [PATCH v5 08/12] soc: aspeed: xdma: Add reset ioctl
Date:   Thu,  9 Jan 2020 14:58:59 -0600
Message-Id: <20200109205903.27036-9-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109205903.27036-1-eajames@linux.ibm.com>
References: <20200109205903.27036-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_05:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of the XDMA engine need a way to reset it if something goes wrong.
Problems on the host side, or user error, such as incorrect host
address, may result in the DMA operation never completing and no way to
determine what went wrong. Therefore, add an ioctl to reset the engine
so that users can recover in this situation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/soc/aspeed/aspeed-xdma.c | 36 ++++++++++++++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 4950068a6ff5..8c6408ff253b 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -619,6 +619,41 @@ static __poll_t aspeed_xdma_poll(struct file *file,
 	return mask;
 }
 
+static long aspeed_xdma_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long param)
+{
+	unsigned long flags;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	switch (cmd) {
+	case ASPEED_XDMA_IOCTL_RESET:
+		spin_lock_irqsave(&ctx->reset_lock, flags);
+		if (ctx->in_reset) {
+			spin_unlock_irqrestore(&ctx->reset_lock, flags);
+			return 0;
+		}
+
+		ctx->in_reset = true;
+		spin_unlock_irqrestore(&ctx->reset_lock, flags);
+
+		if (ctx->current_client)
+			dev_warn(ctx->dev,
+				 "User reset with transfer in progress.\n");
+
+		mutex_lock(&ctx->start_lock);
+
+		aspeed_xdma_reset(ctx);
+
+		mutex_unlock(&ctx->start_lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
 {
 	int rc;
@@ -712,6 +747,7 @@ static const struct file_operations aspeed_xdma_fops = {
 	.owner			= THIS_MODULE,
 	.write			= aspeed_xdma_write,
 	.poll			= aspeed_xdma_poll,
+	.unlocked_ioctl		= aspeed_xdma_ioctl,
 	.mmap			= aspeed_xdma_mmap,
 	.open			= aspeed_xdma_open,
 	.release		= aspeed_xdma_release,
diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
index 2efaa6067c39..3a3646fd1e9e 100644
--- a/include/uapi/linux/aspeed-xdma.h
+++ b/include/uapi/linux/aspeed-xdma.h
@@ -4,8 +4,12 @@
 #ifndef _UAPI_LINUX_ASPEED_XDMA_H_
 #define _UAPI_LINUX_ASPEED_XDMA_H_
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
+#define __ASPEED_XDMA_IOCTL_MAGIC	0xb7
+#define ASPEED_XDMA_IOCTL_RESET		_IO(__ASPEED_XDMA_IOCTL_MAGIC, 0)
+
 /*
  * aspeed_xdma_direction
  *
-- 
2.24.0

