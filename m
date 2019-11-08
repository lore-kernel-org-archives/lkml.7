Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8FDFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADF520869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfKHVPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:15:30 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:46059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbfKHVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:15:29 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MWjUc-1iQvSV0sdk-00X7z7; Fri, 08 Nov 2019 22:15:15 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org
Subject: [PATCH 13/23] y2038: socket: remove timespec reference in timestamping
Date:   Fri,  8 Nov 2019 22:12:12 +0100
Message-Id: <20191108211323.1806194-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IYjzYvve4HwgUd3LWF3hcYp3XGsNmdTj+aFo75G76y0fsDG/owT
 ArX9Fi9VGH6tv0x2woDwVeV2R1dyaK92WLIrAqWENK5veUYsaDwJLWeK+JhypYxcISRcRJC
 cjsePdvza6eEmh7shkRvT11+XeE7Jl86ZUT3hXuYyPzgHwwInuDwicN5DrCsWFhJKtCuPjh
 Lj4cBfFfvsY9G33VIjgMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JlPu9h1gens=:OPJRztXUGTZz2MC1IDn4A0
 suSnrJB6u9/B1GtIPFzBJHmgAdvL1Ct0kLw5rVLgbNe47vdnDYTiED7S0hvkBpgaiQzWUt9Ip
 ArswN/3rSOq7zFwVqlEVHIbP8d1BuiAHsyN8e5RindxJOiycaVSaS5Y1oi32Os/qbDSIkkuyK
 sjRLh0S4aQrFAqwpgD/7HZ31JUu+hXWwpuQmgYDFO+5Oq2fQTaiIDPJKbcnwBUfzbPIpEQGvO
 +FhnKSj8eztpH5p5pZ8YqN8n7PrVujwmZ/xWiV3ZVLFUaN5Z8H7RDPq8+KaXaCyWR1inurjel
 qfA9vXCz7LaCygipg5Mu6BQNgHEkyr2ykhEYce7S3bd0fQdlvRQsrWBf54nRfGnAfuv1QzPSn
 IQnplaQckYXxGOp7fAXNZHyND4yIGxQsOiBmKpShA4rbqt2xnUt4N6o9mp1eaQ6L6SrKcUCCZ
 8cy5eeTJypxnGCop2Q7rR8oKvS3WGPBfiNifrh+hLaeYFQLAiuHeUQnAwUj2oKFkNyhZqswTk
 driyMfXxKWergCWqDajaV4fEwBIiay2ni+WsHR5BMPVxguf7j9YhQE3Qg2u5gSKWl2N/1JKYj
 r/VPkNJXvNAoqY2eDo04u4k9QjOW5nabavScLniw7jFoH9rtmDQ/XpyKX2CVmD4vSvux2fl2V
 PAQL+KTlL3Dqaa0gijc2BT2Aw1RHLMexVwKfAaHELJj5dH0p3V6hndkwLHoUjnRVQeEZIeuj8
 DNrnzhYmF0hLP4xMa375H6hJeDfTtbeHQzNltykTUCMTaRo/aii/4J4tLhM7seeBDbGA8ag+p
 RPvMp7BA6rRrvkZRXDcmQkb6omOI8f/hRxqsxjnXZfzNB8LKJI5oRPfP/tyZKC6FccGPlUMll
 1f4KMOnfZr+BcbtIkimw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the 'struct timespec' definition and the
timespec64_to_timespec() helper function, change over the in-kernel
definition of 'struct scm_timestamping' to use the __kernel_old_timespec
replacement and open-code the assignment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/errqueue.h | 7 +++++++
 net/core/scm.c                | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.h
index 28491dac074b..0cca19670fd2 100644
--- a/include/uapi/linux/errqueue.h
+++ b/include/uapi/linux/errqueue.h
@@ -37,9 +37,16 @@ struct sock_extended_err {
  *	The timestamping interfaces SO_TIMESTAMPING, MSG_TSTAMP_*
  *	communicate network timestamps by passing this struct in a cmsg with
  *	recvmsg(). See Documentation/networking/timestamping.txt for details.
+ *	User space sees a timespec definition that matches either
+ *	__kernel_timespec or __kernel_old_timespec, in the kernel we
+ *	require two structure definitions to provide both.
  */
 struct scm_timestamping {
+#ifdef __KERNEL__
+	struct __kernel_old_timespec ts[3];
+#else
 	struct timespec ts[3];
+#endif
 };
 
 struct scm_timestamping64 {
diff --git a/net/core/scm.c b/net/core/scm.c
index 31a38239c92f..dc6fed1f221c 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -268,8 +268,10 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_inter
 	struct scm_timestamping tss;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(tss.ts); i++)
-		tss.ts[i] = timespec64_to_timespec(tss_internal->ts[i]);
+	for (i = 0; i < ARRAY_SIZE(tss.ts); i++) {
+		tss.ts[i].tv_sec = tss_internal->ts[i].tv_sec;
+		tss.ts[i].tv_nsec = tss_internal->ts[i].tv_nsec;
+	}
 
 	put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
 }
-- 
2.20.0

