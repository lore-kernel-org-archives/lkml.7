Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE99FFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7E2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfKHVfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:35:01 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733060AbfKHVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:55 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLzSD-1iBFNN1WBV-00Hvwr; Fri, 08 Nov 2019 22:34:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Richard Fontana <rfontana@redhat.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Windsor <dwindsor@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH 04/16] dlm: use SO_SNDTIMEO_NEW instead of SO_SNDTIMEO_OLD
Date:   Fri,  8 Nov 2019 22:32:42 +0100
Message-Id: <20191108213257.3097633-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uHa/QjAGTByeAkpaDyB/vmnZ68MBZaHn8BbKmiyg4MIyd5kOgr/
 oPvkjfCzukaGEqPfPs46BihWpfl4F/gQJ3kQGEB+v25O7LUWaxKwPkPAcNHU8h+MQbnVZAN
 hd62BomG6NZ5ED6zjrQMrcCfz99gcXhaVP2VS/iuTaIzr8doR+4KM9eIgD8Ug2xmWNmrivZ
 JpWyIOQrq1vNgXmSWjp0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qd/hYklCPQw=:UXlIHNa+YNOfgmM92uODnY
 g60pWnm0PQin6NlohRtJRMf0RxVHPW8A/DGP+UHxznP/Ger+UlSBqc2mbMr0hiW0ds3eyJVPh
 OhSJFdBuRA22S+jqbdejdgkWLcJ/202e43Vy6IjyKOyOrRMy6FDKP+bM/frQA6NFGduzOfvFy
 4lQxVB6UfEWFmsIV7Y4srgYNNUlK4Qp1BuOFcA206mOMH2dKzCOfEQCtRnz7XZqSvmuBUyRxm
 72YtEOhqf+OV5PWrRo0MBLhSWamU8PWM4ZZK85PKCx8AG4RelG3GAFLXH23v/AG3gFDspXUBJ
 8WQnlWqDch6EfdHCBcykfnayrAsX0d5zpRL3hrDAIQP2WRb6g+p2wV9Ktu2yW+6RsYM1YcJiR
 eAIVUFE4MuzRm3uvYjcGnJ3/UEjBiPrQOqkbgoN8mKPbNmFddlukm3WSrUza/gUpQR7i/7dw9
 1d9x706JHtWe4fwEM8IzLGSYbkjiWuBJnxGLavzbPfXwvMYzV4x52IJxGbWVdu6DqNNNENbWw
 SUsk2UlFELckfxqSsK6Agai0whttWZ7nw60jpxXzeqJ3OiwHy+o/f3o/X5etTlxaHcnaD/1KW
 ztWcZ2okEcUFPNbVrOjKvg85SIqZq3ns/6iamtrEjhHPpCRqk2qGgsw71obLWVv2nssAtg17m
 vixTARz6rY5KMGRim7d+ffqBUmtFXeeTuNlOlLwPymIjHmeTALMTBHUMJUn9cVBNtBsziCiR9
 MPzcK0XbjKvQoazaLhrBabqX5LKRsUQs+NTs7t6b/MHfgx6NC9wMcWiPdQBPuDmKuO55EddN0
 zFxE3gb5DxTIPtjdhxPCslQ8VcNyjsEwsGIOsr/uxsNKCRaDgfWpC9xqsqg7kTWMzyADnSB0s
 UmKbhjv3Lbk+snafAvhA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate one more use of 'struct timeval' from the kernel so
we can eventually remove the definition as well.

The kernel supports the new format with a 64-bit time_t version
of timeval here, so use that instead of the old timeval.

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

