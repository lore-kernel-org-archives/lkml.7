Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B05C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AD921744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642298;
	bh=psl8kJoeKTkFyv9dkoUnqIpetpwk3tdC55aWKYKxqUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CdyVZiWfvGwlwPLlwyZpR35ha/fjU9N8RIo56OEy86X4Bj+nPz3yONRc5ILegr+Rs
	 UAOaF39Ni1MAdpAxAAgkCeQFvRgSh0Dbo+K2er+WD+cS50LtrUF5w0F57jM2K9FoLD
	 mo4XqLSfHOweFSJN5fH5n4wcf2E9wtrtY5WYSc5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfL2R6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbfL2R6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F696208C4;
        Sun, 29 Dec 2019 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642290;
        bh=psl8kJoeKTkFyv9dkoUnqIpetpwk3tdC55aWKYKxqUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZrgJ9GAXsrk/I5CGO6P/WOV5X18X5asQ8Su8HgvlmTmitKzQWAAREpXi/K7B4YA2
         ztZZGIpQXHfhYFSi5MOpok375WX3eMKYkSpRLgghUX1lB0O7StLV22gB9oLawquTqk
         JsckQ39ymAfYLYgnifpW4P7qcrAHVPnVGP9sStZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Pisati <paolo.pisati@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 378/434] selftests: net: tls: remove recv_rcvbuf test
Date:   Sun, 29 Dec 2019 18:27:11 +0100
Message-Id: <20191229172727.211163615@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

[ Upstream commit 6dd504b0fd1039c6e5d391e97cf5c4ee592aefcb ]

This test only works when [1] is applied, which was rejected.

Basically, the errors are reported and cleared. In this particular case of
tls sockets, following reads will block.

The test case was originally submitted with the rejected patch, but, then,
was included as part of a different patchset, possibly by mistake.

[1] https://lore.kernel.org/netdev/20191007035323.4360-2-jakub.kicinski@netronome.com/#t

Thanks Paolo Pisati for pointing out the original patchset where this
appeared.

Fixes: 65190f77424d (selftests/tls: add a test for fragmented messages)
Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.20.1



