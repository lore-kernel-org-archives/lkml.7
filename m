Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85967C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FA2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DAfDeiI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfLQTom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:44:42 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48434 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfLQTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:44:41 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47cpWF1NmTz9vklN
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WjxUqYrm_4yz for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 13:44:41 -0600 (CST)
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com [209.85.161.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47cpWF08FHz9vklB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:44:41 -0600 (CST)
Received: by mail-yw1-f71.google.com with SMTP id q187so8934344ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1nYMTu3Wf2YneM8vgiZKJG+c743nMdOxOT93hCjzzs=;
        b=DAfDeiI9HtOxukTLIYKgQmkpkKUv7J7YaGh692J9VOk0jzsLoQqUlE5fAUcdFsMR4Y
         Xns2iJygS4mABqaeC/J+xVsaEyeDGyiK1fRpm4SFCGS16TXbnPr0qiQNpL/hiANdaXDI
         A9zrev0buQQs2T0isEDR4B0nbdPu4jRQ3K4U5FQJS5bSOCl3gt3ek8HXY1LNc3TTNzIZ
         cV2Iye4xX9pW6Xa/c4yxQopgjl2nvYQa7xvJEVqD1BF416uU0jgisubF0awK9vpGd2jK
         9y4lzRZnLQ/DLt1VN/6oMlmVMQpMXlES1Ca4gXM2E98tcJSCqmu27SRw6PyoZfwDKVAb
         7ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1nYMTu3Wf2YneM8vgiZKJG+c743nMdOxOT93hCjzzs=;
        b=kRscFFFm53Vnkcko31lJBwcWdxJsqqdCRwxdCeQzDxoHCNcsmMPEe+c7vNKkldieHp
         oFd9dVL+NDScvgqQWsv+il8721cdCGLSlB5Be5RGTimiRzflPhvEvfGT7mSpD8iut0qh
         I63TqS+Ty9tPgBJ4OUkr5eqXbtKtyhWSDpr97QPluBzhEOoKchv1YLbdkVDJApBndmD4
         xOjaZlb8V5sGxBsnkLjqvMnlaCdkvMziz0kOEnBQqOiwoXYdeFCpD+WICti0Yy8phfbt
         T2Yk1F9K70p4Dp8VvtEbT4HdCmXXkl64BSe6Q0Y18PVF/cL9uO5kJrV5Rc3h++6m4+pe
         tskw==
X-Gm-Message-State: APjAAAW+7mMoCU54e5MICi0xBrrAWsbSO9cjyPy6IFSyZY7R1DLJNio7
        P2+7cDfsr/4VTdn1kdowt3re4ZQl/BnxRBAsiA/kZi90vYD7MRSaXo6VTsvEUxXgwoQZ3p6Bdq8
        Yg6vHcwulbCQl5tCm45X4MPSpgTqu
X-Received: by 2002:a81:4685:: with SMTP id t127mr261857ywa.280.1576611880205;
        Tue, 17 Dec 2019 11:44:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwG27ef4T4PwFlqhO7GpbzcsqqrakfJavePAIbgiH1x+hqfmQDxFACpa97lZJlVnTx0c9xA7Q==
X-Received: by 2002:a81:4685:: with SMTP id t127mr261838ywa.280.1576611879986;
        Tue, 17 Dec 2019 11:44:39 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i72sm10195197ywg.49.2019.12.17.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:44:39 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: RDMA/srpt: remove unnecessary assertion in srpt_queue_response
Date:   Tue, 17 Dec 2019 13:44:37 -0600
Message-Id: <20191217194437.25568-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, BUG_ON in srpt_queue_response, is used as an assertion for
empty rdma channel. However, if the channel is NULL, the call trace
on console is sufficient for diagnosis.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Avoid potential NULL pointer derefernce of ch. Current fix
suggested by Bart Van Assche
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 23c782e3d49a..98552749d71c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2810,8 +2810,6 @@ static void srpt_queue_response(struct se_cmd *cmd)
 	int resp_len, ret, i;
 	u8 srp_tm_status;
 
-	BUG_ON(!ch);
-
 	state = ioctx->state;
 	switch (state) {
 	case SRPT_STATE_NEW:
-- 
2.20.1

