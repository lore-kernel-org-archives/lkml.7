Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02606C341B2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95724689
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLMUvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:51:25 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:51:24 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MyseC-1hjtrs3ojy-00vwQi; Fri, 13 Dec 2019 21:51:15 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, cluster-devel@redhat.com
Subject: [PATCH v2 03/24] dlm: use SO_SNDTIMEO_NEW instead of SO_SNDTIMEO_OLD
Date:   Fri, 13 Dec 2019 21:49:12 +0100
Message-Id: <20191213204936.3643476-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JgGd8/iX9DERj/M5iCtB2a26MaoOZ9mjFnqSnunVh+f26nRMB2x
 LJwHidIBih58zaeiqD+QWZvmjmJvr5LBgkn4Oc8KHhhUGMhjVldx6278u3WX2GeGR9jv0pY
 CNJhdcI6Y0D76LueyfFCHDEKlSN3sWitDbT8Z4iI2W7uq7ARkybx5Zp6VhwMbIjrgBJzTxZ
 WQkKtr7kPtxyMi9vGaZdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tYDJc1dkaTc=:tLbuj+9nUfY1i2EKGWn7GZ
 asfdqauWEzm2ka5/EYjlY0E9PbE8iOKaSbLg2BFxOKsfiJQIGvd7X+Z/6Qvnf+wqY4oVBdYK8
 iTCFvER5Xc3h/QTte16lPmsHKvV6H/U3Psa1A/kdDQhwIsxA0Yf1vzGIIa0Ykyy3uqwat+spS
 IlFK1EExs+ln1uqESiCFvCQz1a73wVOpOCTFtIoPjfgfE57XOtJ9WVXHD0KSLuhMAUDb6aYJu
 GI+/JftgWouszmdndBdpapd6kQM5r4QwqMR22GQH5gdaKNQFogidIwfofy8Abc3xU0gDnK3RW
 kM5bacedZQiRpjSy8qX5U7VQGJkk8RtVIpmqB5YDmF9T148xPhkuFfYaB5nrhNM6wiunjhiQi
 9L7iAC42YiZGX8O2UbYN+TYJD6hxF561Qthbs/RG0g3u1gibbhfmsg0TH7wgzQo88kTtVIyws
 nNS9SXYeBYMZQRZkmIJrOAwY4ltzBqXZx6/meGWXhGtNTh7A3HYnJbLXa7vR5asmcJkzY+utF
 9mwmZndOfA0HZ+UnZR0P1hrTJ31aUgHKcDanBJNVWEjH9wQgUkhiqBMDNeKGWHaguGGp4vxJY
 slemB5GF87BacNA4Au6ltVXAUEcpiivAJDR1G1xCjD63y80AoES2khvMsM6u7K65nV6e4psNy
 +y70+iddiCoC39+SN3p8e8vjpa2gn6H7NDAjjT+lMolE40SVsJHsyxsxwgYid1qe7vkDQpBtF
 QOxn5+ej3Olx0Hp2eLz+P2K0ROVJYA/yYmm9RilFnS+XX31lIcQpaTCuOP2Lt5vd+RR0b61a8
 Z72PP6//0lRcQpMqV0qf4c+yhrdi3u7SNe8WGRKWjeZuOwFdfwaI8/Qapw1NfoZLLHEHjH2RY
 hb59rbY0ZGX73P63fWuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate one more use of 'struct timeval' from the kernel so
we can eventually remove the definition as well.

The kernel supports the new format with a 64-bit time_t version
of timeval here, so use that instead of the old timeval.

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/dlm/lowcomms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 3951d39b9b75..cdfaf4f0e11a 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1035,7 +1035,7 @@ static void sctp_connect_to_sock(struct connection *con)
 	int result;
 	int addr_len;
 	struct socket *sock;
-	struct timeval tv = { .tv_sec = 5, .tv_usec = 0 };
+	struct __kernel_sock_timeval tv = { .tv_sec = 5, .tv_usec = 0 };
 
 	if (con->nodeid == 0) {
 		log_print("attempt to connect sock 0 foiled");
@@ -1087,12 +1087,12 @@ static void sctp_connect_to_sock(struct connection *con)
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_NEW, (char *)&tv,
 			  sizeof(tv));
 	result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
 				   0);
 	memset(&tv, 0, sizeof(tv));
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_NEW, (char *)&tv,
 			  sizeof(tv));
 
 	if (result == -EINPROGRESS)
-- 
2.20.0

