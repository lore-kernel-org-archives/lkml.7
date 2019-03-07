Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8763EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607B420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCGKc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:32:58 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:55893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCGKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:32:57 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MS1G7-1hVAVG2Dwx-00TRzg; Thu, 07 Mar 2019 11:32:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] peak_usb: fix clang build warning
Date:   Thu,  7 Mar 2019 11:31:55 +0100
Message-Id: <20190307103219.1539316-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MwzC7PHGmR/ZaFJettcRS7X4cH35yXFJbgHGX/earEEn3KFTJcO
 WexMVORtDuzJ4C3EKmyRRxLLptM8sU96ru45JXUh1rIeMSv7XG8PlD9s4x7B6/ErxIZlA33
 ErqoN+bDsaFHeXRhWfZJEhp3gy2GGbja7M+VpdJmkQTkdSE1gKqnOnBVS9b2gDRQFIX5+dg
 c4dOFqYVmB7Vwfq3bgKyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tQ5sTkHexPI=:m+uhnXGrITU6ocPc2ZUSxD
 fraZ+R/xw3p/DwQ4R7mC7J6L+cBmDwWROFiaJUyJdjO5fhwe4MjK5gwx82WYDh9lvk3M69Srl
 Xfm0aom0dRQCJy0fK65qIjq1ZXq8qWQYZQQvifvs6bih1cPtBLRg6pHOAtBQA54bSGn7ei6P9
 grcRfW1+EDxXc5U4xzDJy8rCdBBZmOC6vOmFAmfRb6anaRMMJWYVCla+BkkMupQ9CbGhQERb5
 1o5FmpjYcr3iBut/6Rl2KBSB8/FKyLP+Q/l1Sh+YZxZX5RPEw9wcFB/86z4Zu9skurcWlVMLL
 VHJuaBONHbugE4z2iCCHWBkrYeFLXo7v3ah0AxI4ZUuXIRZtlJmXUb8FhaD1Ir/QDwnl4X7jH
 VK5mz1+Y8FDFFfX6eW3Aml0pteQAxxQI8X4tDvilkDQaVMtVOx2csN9AHMkCECZeB8fjkJazq
 yfRvyhHyH7Z1NxTBBMXVk6pnwDqc65xqdaQsqjfoGzGs7E+q2uBYEUQRMyU5lzq1zlJNEr93C
 V+LKWM/5maNSB6ELsPcptXUorUE9V8bEfLMPgxxzb3WtYZvuBzLEiCz/QGeSoEfT5IpaGMqOL
 lLfcMShn6hCDOBczi5jpwkdKjUgSN+V6NwTDLqPRhJm1n468CHyP/jMTc+tg9Y8OeMnyam5A9
 6m7sM+JrNiCwGRAf3OKipXaLvY8XqzvQ9ihBSh4ab7Nw8oytpm4FKCAo+wJY0oAm6PUPgNg+e
 m6m1Quf8kDeIWumZvbBvGZuV+esHewxYqVHKrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang points out undefined behavior when building the pcan_usb_pro driver:

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]

Changing the function prototype to avoid argument promotion in the
varargs call avoids the warning, and should make this well-defined.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index d516def846ab..b388406ac0f5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -127,7 +127,7 @@ static u8 *pcan_msg_init_empty(struct pcan_usb_pro_msg *pm,
 /*
  * add one record to a message being built
  */
-static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, u8 id, ...)
+static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, int id, ...)
 {
 	int len, i;
 	u8 *pc;
-- 
2.20.0

