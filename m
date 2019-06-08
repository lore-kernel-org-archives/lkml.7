Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA6CC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE712168B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfFHLug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:50:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38785 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfFHLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:50:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hZZrk-00030Y-3S; Sat, 08 Jun 2019 11:50:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: fsl-dpaa2/ethsw: fix memory leak of switchdev_work
Date:   Sat,  8 Jun 2019 12:50:31 +0100
Message-Id: <20190608115031.28126-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the default event case switchdev_work is being leaked because
nothing is queued for work. Fix this by kfree'ing switchdev_work
before returning NOTIFY_DONE.

Addresses-Coverity: ("Resource leak")
Fixes: 44baaa43d7cc ("staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet Switch driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e3c3e427309a..f73edaf6ce87 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1086,6 +1086,7 @@ static int port_switchdev_event(struct notifier_block *unused,
 		dev_hold(dev);
 		break;
 	default:
+		kfree(switchdev_work);
 		return NOTIFY_DONE;
 	}
 
-- 
2.20.1

