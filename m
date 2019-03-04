Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C904C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107BC20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688467;
	bh=Rtg5ZJgvg9wnqrvSgpPHgoyozh2EyIjMxgznNYmk6zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qn3K8u+iKPFDS5wxVxE4eJFN+SaA+rWVX1ydoMg7PAKDCNPKob2TyXvFCNq+YqdZu
	 a3EXbXLpI7d0IypelV4V9WHVB8YZaZC74E33vO04laLaXI/512HNh4AVjmon9JDhOg
	 5v34/CNOP1Xvzl9QYyftX0WfJxM7W4/Blu1bBqtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfCDIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfCDIeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6E220823;
        Mon,  4 Mar 2019 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688462;
        bh=Rtg5ZJgvg9wnqrvSgpPHgoyozh2EyIjMxgznNYmk6zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxARladEMICTX2PKWGAWvt/wj+S7nozFHpOOA2/OqIdbahn92CprVfryjP0Nxpqw7
         2EUtqHLivjhgUay/D/RCKqSSA6BJcdP7dEOeAbrwTYhBxRajpWcLGIEUn4c6IhvF++
         sHBxCKrW89ZKj0IUoIAR/7WKJk09NRm40F+fFTS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 17/88] selftests: rtc: rtctest: fix alarm tests
Date:   Mon,  4 Mar 2019 09:22:00 +0100
Message-Id: <20190304081631.265441358@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fdac94489c4d247088b3885875b39b3e1eb621ef ]

Return values for select are not checked properly and timeouts may not be
detected.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rtc/rtctest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index e20b017e70731..dea4e3d6d9e18 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -145,15 +145,12 @@ TEST_F(rtc, alarm_alm_set) {
 
 	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
 	ASSERT_NE(-1, rc);
-	EXPECT_NE(0, rc);
+	ASSERT_NE(0, rc);
 
 	/* Disable alarm interrupts */
 	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
 	ASSERT_NE(-1, rc);
 
-	if (rc == 0)
-		return;
-
 	rc = read(self->fd, &data, sizeof(unsigned long));
 	ASSERT_NE(-1, rc);
 	TH_LOG("data: %lx", data);
@@ -202,7 +199,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 
 	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
 	ASSERT_NE(-1, rc);
-	EXPECT_NE(0, rc);
+	ASSERT_NE(0, rc);
 
 	rc = read(self->fd, &data, sizeof(unsigned long));
 	ASSERT_NE(-1, rc);
-- 
2.19.1



