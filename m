Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC4320896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAr7JEe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfCQUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55986 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfCQT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so10968736wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bhfHovqbZFLg6HGYSBa8f6f1JC1yLKKfhNBBAo8hWfI=;
        b=aAr7JEe9gTB2IGQGhNLyew7tWUoEEqkOhaa6fTsagje/93iAWt4jSPrgkfWY9728tN
         0UBrFkroRyc88ZXFIDgYuPR26yiZNr8OOtGWGqua2yTRkbucM1nz6DV6w8zosWQklPnV
         5A+T5Th8lQB39EPW7dwBOUa7ANPjdwHe9+7KEHzQTXKOCgZfYldnDK+U4HYZX+DT13F8
         BpKzagb+7lCQ9/djBbfbFno9CFWTx0OeT1yvyxqv/SeBIrx/E2ChannT6eSqKcJi0azU
         iq/wEQsoY2tdZKZtmalX2bA1WZ4R6O0DHi3+ctg3aTfC2Pq+Cv+UJkqA1wC+JTnYWaTd
         SVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bhfHovqbZFLg6HGYSBa8f6f1JC1yLKKfhNBBAo8hWfI=;
        b=Hu8o5vEJinyFJLQDgxmG5jOasJIGCKpBke4dnJINz0fNYnP9YGGKoLSm2KyTbqC+oR
         cqKHRb7Aw1l5eyI4wj+b7ie5+ojw6TuBMBn0DjsuaKbFoJW3dm48fCOkYoVM+uEKnQrn
         +bX/HV/iPFfv547SmgUUtqPrwqswZ734fgj9i8fusCDmJO9ydWcLsYA2nVIjhGhjE8ki
         JLB972STkgPsEnIpFLRPHJdIiRUN5V1YwUEZZPvJGqYaljDvE5kKMUBRc/YMChSNUvrp
         7I0jZ3gJIo3HBsOlso/FI0aKZgrWZkH3PlvdhHVPqDFcWESyymypyZh6JWQmuCnzQXMH
         zJcQ==
X-Gm-Message-State: APjAAAXLqByJj2nn3nQtfnULtvR/ff8De4p3+vubwpBKSYmr1VLaeCle
        LXpoVq4HcG1adk+W3Qoh04gJ2glT
X-Google-Smtp-Source: APXvYqxYyXqJohpcreb/r7ItQBuNLjGNiMA78LFr3LdxAj7K45ieMXy/burQ3yLwBi7EbkexqEIHnA==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12mr8748083wmc.38.1552852792956;
        Sun, 17 Mar 2019 12:59:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 10/15] uapi/habanalabs: add some comments in habanalabs.h
Date:   Sun, 17 Mar 2019 21:59:22 +0200
Message-Id: <20190317195927.26238-11-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two comments in uapi/habanalabs.h:
- From which queue id the internal queues begin
- Invalid values that can be returned in the seq field from the CS IOCTL

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 7fd6f633534c..ab1957e31077 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -33,7 +33,7 @@ enum goya_queue_id {
 	GOYA_QUEUE_ID_DMA_3,
 	GOYA_QUEUE_ID_DMA_4,
 	GOYA_QUEUE_ID_CPU_PQ,
-	GOYA_QUEUE_ID_MME,
+	GOYA_QUEUE_ID_MME,	/* Internal queues start here */
 	GOYA_QUEUE_ID_TPC0,
 	GOYA_QUEUE_ID_TPC1,
 	GOYA_QUEUE_ID_TPC2,
@@ -181,7 +181,10 @@ struct hl_cs_in {
 };
 
 struct hl_cs_out {
-	/* this holds the sequence number of the CS to pass to wait ioctl */
+	/*
+	 * seq holds the sequence number of the CS to pass to wait ioctl. All
+	 * values are valid except for 0 and ULLONG_MAX
+	 */
 	__u64 seq;
 	/* HL_CS_STATUS_* */
 	__u32 status;
-- 
2.17.1

