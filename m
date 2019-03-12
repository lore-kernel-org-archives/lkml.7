Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EFA2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJwZSjGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCLA36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:29:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42077 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfCLA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:29:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id i5so911447oto.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+mo31ZZMZQSbg3yE64y/aYDwVlJjvQHm07sPQNpiJA=;
        b=uJwZSjGhXilrwCQOBYEssTvWDItsBpX2o3Nao1W/jnd4W6p3q5Q03mdCV3IjKxZ3k2
         a7R0Dq4FbWSpQgfqbwl07gNcAvgSHgnqMbhssEVyGobHIdy5vHVpSIznkRssNNCwR35y
         pKlG9r1lSOMV8doq8mLVf8IXOHbDUP4CTVwobFw71lseVTvqPImraFyGvx5cC6axL0w6
         kd/RcQqLWv6n5WEX+OvF1He6f5m4ac5xjVT7BVAT6DFUN4nhz9I7jAdTqlnwHjfAMR/M
         MZy1hMuS0yir261YNbl5bMuxONzSqzCcHE7YJLF8fM9k/sp4f2gQm5O7je7SO0Gs9joN
         lYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+mo31ZZMZQSbg3yE64y/aYDwVlJjvQHm07sPQNpiJA=;
        b=e4vbmm4bO8fcUvfVBy7tAXsDDCgPiM9OLbOCu8REOO/o66yrHAiENj0KuwqvCdS8vS
         Mk5H6UYfLoQo3UxDpW8z1uPcP8hlyLqWy1Zzq1HVyXfOqXaABfaFVMozmuOUJzsVUpvg
         TuZf95QCAGLGTNDKk6LKaUCekAjfLBJJd7jThFWOnTucsqfEMeVALEvcGyNENLqPqjwj
         JwFmY4hsXFPl3AkLIdZt7Vru8cTIUFsOQdZlG4p8iCFBxxFiEQzR5GfSNx86myQGRXxQ
         4G/Llg+kGMoTeyP1u1tspLRCJJnYZAwg0YLvFNBpWJvmtM4iVY72jwe8CjK/78KqMrVG
         qafQ==
X-Gm-Message-State: APjAAAWHvM2V+lPAWWCLA67aBqkAjaB4kDgl5yVhRNfTM6crzYyrO6Np
        NuWIvRl7XVfQeT5ZfHePfB0=
X-Google-Smtp-Source: APXvYqyWmat0gfD0iXqyEsBDaybl8+qwqlHLzmJHGNSgdafWzFasRtXHtRqVarzZqvcM85p9eAn78A==
X-Received: by 2002:a9d:7f98:: with SMTP id t24mr23715474otp.132.1552350597315;
        Mon, 11 Mar 2019 17:29:57 -0700 (PDT)
Received: from griffin.server111.com ([177.234.13.170])
        by smtp.gmail.com with ESMTPSA id g1sm2921829otl.78.2019.03.11.17.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 17:29:56 -0700 (PDT)
From:   =?UTF-8?q?Jes=C3=BAs=20Castro?= <x51v4n@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     miguel.bernal@zapopan.tecmm.edu.mx, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, joe@perches.org,
        =?UTF-8?q?Jes=C3=BAs=20Castro?= <x51v4n@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] hv: utils: enhance code for human read
Date:   Mon, 11 Mar 2019 18:29:49 -0600
Message-Id: <20190312002949.4937-1-x51v4n@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190305234542.5243-1-x51v4n@gmail.com>
References: <20190305234542.5243-1-x51v4n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if/else block from hvt_op_open function can be written
as a switch/case block,  and the bool issue_reset variable
is avoided.

No functional change made.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Jesús Castro <x51v4n@gmail.com>
---

v2: Refactoring hvt_op_open function with a switch/case block.
    Change subject from: fix coding style


 drivers/hv/hv_utils_transport.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index 832777527936..6b27dd7be9bb 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -125,35 +125,35 @@ static int hvt_op_open(struct inode *inode, struct file *file)
 {
 	struct hvutil_transport *hvt;
 	int ret = 0;
-	bool issue_reset = false;
 
 	hvt = container_of(file->f_op, struct hvutil_transport, fops);
 
 	mutex_lock(&hvt->lock);
 
-	if (hvt->mode == HVUTIL_TRANSPORT_DESTROY) {
-		ret = -EBADF;
-	} else if (hvt->mode == HVUTIL_TRANSPORT_INIT) {
+	switch (hvt->mode) {
+	case HVUTIL_TRANSPORT_INIT:
 		/*
 		 * Switching to CHARDEV mode. We switch bach to INIT when
 		 * device gets released.
 		 */
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	}
-	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
+		break;
+	case HVUTIL_TRANSPORT_NETLINK:
 		/*
 		 * We're switching from netlink communication to using char
 		 * device. Issue the reset first.
 		 */
-		issue_reset = true;
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	} else {
+		hvt_reset(hvt);
+		break;
+	case HVUTIL_TRANSPORT_DESTROY:
+		ret = -EBADF;
+		break;
+	default:
 		ret = -EBUSY;
+		break;
 	}
 
-	if (issue_reset)
-		hvt_reset(hvt);
-
 	mutex_unlock(&hvt->lock);
 
 	return ret;
-- 
2.21.0

