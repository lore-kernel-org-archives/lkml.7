Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564992054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cvCQEQvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfCLQsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:48:12 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36938 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCLQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:48:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id BE741B92
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NOnDtEdsRcS0 for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 11:48:10 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 915AA9FD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:48:10 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id a9so2237943iol.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VfSqoJMa7APn7aRjUqyW72PY6UqsoZPTxzhv/akw36U=;
        b=cvCQEQvC6VIFrr6oNUuDwpHbEXjMA0hCd0XOJ194lF886gb9al/8yhE45EVWlGJKWt
         sTeAKhHAU052A6jS+eWADjzoJAIoSW2r+EsUSJXz+82EMi75+HLetCmNJ6GnxGrE6Itx
         t+7MRZmYq/eLb3us9OZGgXVRZNMlzugUHtZO0xZ06vgVFpOHAsCNpMg+dtoxevU0K+IP
         p41BXxRqsitWx5m2pOIaYfvXNGFOh1BPF2kIEG7E/tUkYnTXy7DLhYKTMELmQTxrk42+
         7gtwZHpZr8lhXMseU9xreab8v45VtGRPBSNc2WGT22Sn4ylnv80nNLuQ2hW43KHXJOYY
         FUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VfSqoJMa7APn7aRjUqyW72PY6UqsoZPTxzhv/akw36U=;
        b=B+4Ms8fHG/Qa1WmPNk0lRreOdg1mqwd8ObkADOJ6/x69EmCqLwZNYwDWHMSc0e57Z+
         sVQhr8wiVxdXc/EZbo/4gK5v26dkuWsvUiVjbrgHmcMZFYu4rZQwckpYorAigNcVJces
         HJ16slXusFX6iOoD31Zi/fYT54TrVEF2aKpZA/nQae2CzszHyxlyfPkIEqCptfZKg8bl
         YxR3YnWYwBXrBvYdCUP1C9+TsOUSqEyUicqorI3kBCvqfZ3Lqpx/2ybO18VaWDOnByQO
         eZ8AiqlMqZCsYQPFwV0UrTvPGcmb2r07mK3Zd5m7Zj/AtdVjqN/u7x+B4bWew6CxA798
         E5tQ==
X-Gm-Message-State: APjAAAX1Uh0dEYvVcmiw/+OJldDVvHJSLaT1Fi4Xz/9yBRo8jpgAhXeC
        UJ7Fj7w33LLXnKfUfgfI0C+x25vX/gXY65NR2yhWULUH3KeKgJUUzdoPqPJmqbYQSxAM+kH6L8v
        4LGqxdbzIsWIJKJljZeaZ5YtY5p4I
X-Received: by 2002:a05:660c:a18:: with SMTP id e24mr2545271itk.129.1552409290093;
        Tue, 12 Mar 2019 09:48:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPl1we1TTSL7NXkK43zNWJga9LlegWqIO2jHIvnrJQOGRg39zd8iGW9F0k3kLrVoG8MloiFw==
X-Received: by 2002:a05:660c:a18:: with SMTP id e24mr2545256itk.129.1552409289862;
        Tue, 12 Mar 2019 09:48:09 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 187sm503328itl.27.2019.03.12.09.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:48:09 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Karen Xie <kxie@chelsio.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: cxgb4i: Fix potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 11:47:58 -0500
Message-Id: <20190312164758.4540-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_wr may fail and return NULL. The patch checks for such a
scenario and avoids it.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index d44914e5e415..b4f1e00b9250 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -617,6 +617,8 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
 #endif
 	flowclen16 = tx_flowc_wr_credits(&nparams, &flowclen);
 	skb = alloc_wr(flowclen, 0, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
 	flowc = (struct fw_flowc_wr *)skb->head;
 	flowc->op_to_nparams =
 		htonl(FW_WR_OP_V(FW_FLOWC_WR) | FW_FLOWC_WR_NPARAMS_V(nparams));
-- 
2.17.1

