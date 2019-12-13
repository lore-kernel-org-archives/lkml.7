Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D731B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLMKja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:39:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54275 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:39:29 -0500
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1ifiM0-0000S0-7i; Fri, 13 Dec 2019 10:39:24 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paolo Pisati <paolo.pisati@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] selftests: net: tls: remove recv_rcvbuf test
Date:   Fri, 13 Dec 2019 07:39:02 -0300
Message-Id: <20191213103903.29777-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test only works when [1] is applied, which was rejected.

Basically, the errors are reported and cleared. In this particular case of
tls sockets, following reads will block.

The test case was originally submitted with the rejected patch, but, then,
was included as part of a different patchset, possibly by mistake.

[1] https://lore.kernel.org/netdev/20191007035323.4360-2-jakub.kicinski@netronome.com/#t

Thanks Paolo Pisati for pointing out the original patchset where this
appeared.

Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Fixes: 65190f77424d (selftests/tls: add a test for fragmented messages)
Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/net/tls.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 13e5ef615026..0ea44d975b6c 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -722,34 +722,6 @@ TEST_F(tls, recv_lowat)
 	EXPECT_EQ(memcmp(send_mem, recv_mem + 10, 5), 0);
 }
 
-TEST_F(tls, recv_rcvbuf)
-{
-	char send_mem[4096];
-	char recv_mem[4096];
-	int rcv_buf = 1024;
-
-	memset(send_mem, 0x1c, sizeof(send_mem));
-
-	EXPECT_EQ(setsockopt(self->cfd, SOL_SOCKET, SO_RCVBUF,
-			     &rcv_buf, sizeof(rcv_buf)), 0);
-
-	EXPECT_EQ(send(self->fd, send_mem, 512, 0), 512);
-	memset(recv_mem, 0, sizeof(recv_mem));
-	EXPECT_EQ(recv(self->cfd, recv_mem, sizeof(recv_mem), 0), 512);
-	EXPECT_EQ(memcmp(send_mem, recv_mem, 512), 0);
-
-	if (self->notls)
-		return;
-
-	EXPECT_EQ(send(self->fd, send_mem, 4096, 0), 4096);
-	memset(recv_mem, 0, sizeof(recv_mem));
-	EXPECT_EQ(recv(self->cfd, recv_mem, sizeof(recv_mem), 0), -1);
-	EXPECT_EQ(errno, EMSGSIZE);
-
-	EXPECT_EQ(recv(self->cfd, recv_mem, sizeof(recv_mem), 0), -1);
-	EXPECT_EQ(errno, EMSGSIZE);
-}
-
 TEST_F(tls, bidir)
 {
 	char const *test_str = "test_read";
-- 
2.24.0

