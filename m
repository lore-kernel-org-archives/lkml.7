Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4BBECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D1420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC62pWf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJJVk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:40:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfJJVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:40:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so9580679wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GVGRarQ+bdKBU0Z2N7AABfx+Km0CibFKi9Lr7Iu2LQ=;
        b=iC62pWf18BZefYC7rZowamPGyqorw0yhW/QM8Ue2NAanuuXQjHA//P2HKmhvv7X9Di
         y2P0/prdc9zX+cgZDYesbheP2d4y5Sn7QOsFm7YFSAEsmOOBraQ8osaojW9rwVoQFB/G
         U0vw8YFTaQsXQiJjNWSA3CRCuB6p7WtjAqbltDEM+pVz1EPbZZA91iQ4RK1F3N9i1Lje
         8QC+x+7Xm7WoeOGl8iLPfchQQ+J5f5f8E10xP0fIvR193ZIn/NokIiwYD9xZta/cQPuA
         0zTuhfjPWNpQxevhIahdJZUK3BUuuTcFDDDlsABMUM2Ou1+BAjrJ/UqzeRiiILoBZCeD
         ldTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GVGRarQ+bdKBU0Z2N7AABfx+Km0CibFKi9Lr7Iu2LQ=;
        b=bKzl/0FwG9j1BqTYVwqpNG88TtvSGsWBXmLhPLpaGpgL66jfNa7SKAMkcn0YRYt1Zr
         3XzTsApYgZcJfVKRARY4ZUdbBMxLUXNW6Cxm+Ff98Hr8qxBlfEj8tVXYVH9yf8WGmG9k
         Fmwn7uY9RfCbBhyb2T/PKN3XkvY+fWGgFaCknPigMQCegAObUXcaiaOifBswlhas+mtR
         1oxrGQ7esTVjE9oT09qVZLwmKtt3NGnZ2NbByd20muIEj45GXlMeMpunvWXGtm/UirHY
         WCFSFE9+41gUQ1t2ojF6o2uJ1lVl7Jn9e0Kke+ss8LiewFxZ27m5KaS7JAxjs6ibWVJx
         Rn4g==
X-Gm-Message-State: APjAAAWbcsTJFvI+FmlQi3bMD5UGaEEvKDZ5pjsej+gSpsGS4T34MmKP
        MOpLUOr3LGQTm6ZhvLhTUw==
X-Google-Smtp-Source: APXvYqxLhYcdl1bEhja2Ce6BMsazdCs5/fc0+wfl0wOJmWaOf4t02EIPTwYVD/RAMmsasBBfDN2/pw==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr134697wrg.147.1570743625253;
        Thu, 10 Oct 2019 14:40:25 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id h63sm11455423wmf.15.2019.10.10.14.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:40:24 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH v1 4/5] staging: qlge: add space to fix check warning
Date:   Thu, 10 Oct 2019 22:40:05 +0100
Message-Id: <20191010214006.23677-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010214006.23677-1-jbi.octave@gmail.com>
References: <20191010214006.23677-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space to fix warning of preferred space near the division operator
 issue detected by checkpatch.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index b8ff9eccc472..eb993207d224 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -72,7 +72,7 @@ static int ql_read_other_func_serdes_reg(struct ql_adapter *qdev, u32 reg,
 		goto exit;
 
 	/* set up for reg read */
-	ql_write_other_func_reg(qdev, XG_SERDES_ADDR/4, reg | PROC_ADDR_R);
+	ql_write_other_func_reg(qdev, XG_SERDES_ADDR / 4, reg | PROC_ADDR_R);
 
 	/* wait for reg to come ready */
 	status = ql_wait_other_func_reg_rdy(qdev, XG_SERDES_ADDR / 4,
-- 
2.21.0

