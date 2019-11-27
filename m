Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495392158C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886958;
	bh=krZDS5Xres+b4gBKMkpeIRgF9Ij2mTybHD+luW0D7ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfLSNN6rYIWWmhzRbdqMNKObLqhQIZ2Go3/mX64YL+FInO8VaNwDtO4tO8i2snvUV
	 B5vLV/KS9e8mm7vSAcWxM/uxC9yp4Dvy+IOWfuZAKnWmEyu9k+sRsX7MK1XU9e6S+m
	 Wdbk73BKm0J59jgmL4vYwD/xY7BOveiKSrQ5PfYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfK0Uf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfK0Ufv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:35:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F77A21569;
        Wed, 27 Nov 2019 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886950;
        bh=krZDS5Xres+b4gBKMkpeIRgF9Ij2mTybHD+luW0D7ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfxcNo3Eff2Je8DO/Tuj5rT0ZLPLLua9TwEj09mnYApa7VqxdyQ4dkRtZ36GKGRU+
         N7p+5+a3g8uXnYP+KmGyea9MwS6T6IyM2kF/+XypgDDQxjB4Ln/XSQS92CussYnvRS
         RxxqpC3i9QZ/kJt3NFcX+q3wcHGifmelYgWQn08Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 054/132] mISDN: Fix type of switch control variable in ctrl_teimanager
Date:   Wed, 27 Nov 2019 21:30:45 +0100
Message-Id: <20191127202953.567388511@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit aeb5e02aca91522733eb1db595ac607d30c87767 ]

Clang warns (trimmed for brevity):

drivers/isdn/mISDN/tei.c:1193:7: warning: overflow converting case value
to switch condition type (2147764552 to 18446744071562348872) [-Wswitch]
        case IMHOLD_L1:
             ^
drivers/isdn/mISDN/tei.c:1187:7: warning: overflow converting case value
to switch condition type (2147764550 to 18446744071562348870) [-Wswitch]
        case IMCLEAR_L2:
             ^
2 warnings generated.

The root cause is that the _IOC macro can generate really large numbers,
which don't find into type int. My research into how GCC and Clang are
handling this at a low level didn't prove fruitful and surveying the
kernel tree shows that aside from here and a few places in the scsi
subsystem, everything that uses _IOC is at least of type 'unsigned int'.
Make that change here because as nothing in this function cares about
the signedness of the variable and it removes ambiguity, which is never
good when dealing with compilers.

While we're here, remove the unnecessary local variable ret (just return
-EINVAL and 0 directly).

Link: https://github.com/ClangBuiltLinux/linux/issues/67
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/mISDN/tei.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/mISDN/tei.c b/drivers/isdn/mISDN/tei.c
index 592f597d89518..8261afbbafb05 100644
--- a/drivers/isdn/mISDN/tei.c
+++ b/drivers/isdn/mISDN/tei.c
@@ -1180,8 +1180,7 @@ static int
 ctrl_teimanager(struct manager *mgr, void *arg)
 {
 	/* currently we only have one option */
-	int	*val = (int *)arg;
-	int	ret = 0;
+	unsigned int *val = (unsigned int *)arg;
 
 	switch (val[0]) {
 	case IMCLEAR_L2:
@@ -1197,9 +1196,9 @@ ctrl_teimanager(struct manager *mgr, void *arg)
 			test_and_clear_bit(OPTION_L1_HOLD, &mgr->options);
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-	return ret;
+	return 0;
 }
 
 /* This function does create a L2 for fixed TEI in NT Mode */
-- 
2.20.1



