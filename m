Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AABF21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfCTUCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:02:40 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.250]:41109 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbfCTUCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:02:40 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 1BD1C26759
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:02:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6hQ7hRhsmYTGM6hQ7heNMQ; Wed, 20 Mar 2019 15:02:39 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=36344 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6hNj-003efl-Pz; Wed, 20 Mar 2019 15:02:37 -0500
Date:   Wed, 20 Mar 2019 15:00:10 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
Message-ID: <20190320200010.GA14527@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h6hNj-003efl-Pz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:36344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

In file included from drivers/mmc/host/usdhi6rol0.c:9:
drivers/mmc/host/usdhi6rol0.c: In function ‘usdhi6_timeout_work’:
./include/linux/device.h:1483:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/usdhi6rol0.c:1689:3: note: in expansion of macro ‘dev_err’
   dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
   ^~~~~~~
drivers/mmc/host/usdhi6rol0.c:1691:2: note: here
  case USDHI6_WAIT_FOR_CMD:
  ^~~~
drivers/mmc/host/usdhi6rol0.c:1711:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   usdhi6_sg_unmap(host, true);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/usdhi6rol0.c:1716:2: note: here
  case USDHI6_WAIT_FOR_DATA_END:
  ^~~~
drivers/mmc/host/usdhi6rol0.c: In function ‘usdhi6_stop_cmd’:
drivers/mmc/host/usdhi6rol0.c:1338:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (mrq->stop->opcode == MMC_STOP_TRANSMISSION) {
      ^
drivers/mmc/host/usdhi6rol0.c:1343:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/usdhi6rol0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index cd8b1b9d4d8a..b9712ac96be5 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host)
 			host->wait = USDHI6_WAIT_FOR_STOP;
 			return 0;
 		}
-		/* Unsupported STOP command */
+		/* fall through - Unsupported STOP command */
 	default:
 		dev_err(mmc_dev(host->mmc),
 			"unsupported stop CMD%d for CMD%d\n",
@@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 	default:
 		dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
 		/* mrq can be NULL in this actually impossible case */
+		/* fall through */
 	case USDHI6_WAIT_FOR_CMD:
 		usdhi6_error_code(host);
 		if (mrq)
@@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 		 * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
 		 * the page
 		 */
+		/* fall through */
 	case USDHI6_WAIT_FOR_DATA_END:
 		usdhi6_error_code(host);
 		data->error = -ETIMEDOUT;
-- 
2.21.0

