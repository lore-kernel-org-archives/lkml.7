Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DC4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE234217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFwAhhKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCNGhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:37:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46938 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCNGhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:37:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so3287963pgg.13;
        Wed, 13 Mar 2019 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wiZf8o1LOWzsK2CTaAA4NlFLKe6EFJl2TYB6454+c0=;
        b=TFwAhhKY1w3kvZVt+puF3uVLEZs3JbZeyZM909leQijL9U1KwQAeT3pvzjbUG54kZa
         xnDrgRW3pgx+WpzxwOQONQWIKbtcBCxq/Ka8sJS1uW0Z1el4cNoLdht99L9le7Ry5VgM
         s23aaUJD6diJVW6CbKa0BwGi4C6BHAIPAlc7gjk+WvzRauADbNnRRq5SoAag2CjWACpP
         bvly7vjfztfTWi4bHZtBd2jNlMusBXVPXiP4gvQMZ7g3VKlIgOA7Z7m19DrKlSwx/CQV
         DrxunoZBYkjjfESMtULFFiloIy4QJw7DWE7tZqcTAb+iHsA3NvH1He9DNx9o+g5LiFm8
         uufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wiZf8o1LOWzsK2CTaAA4NlFLKe6EFJl2TYB6454+c0=;
        b=i/wXsEnr00PU9CBTNxmwu2iogSbMcC2Y6fKjDf9G2BNzEAc446v4nhSzZouhmAaJzn
         V2BJK73J79Ivurv69FWG4qWwMu8bi1wEd/wg7+VkUm/VOybgLDepkrE1W5mqslFzGYBe
         9We/F8pByPbA2pm1ZYAz/cCYLOgKu04g2zFkDpNsx96Y/x3YctpAHgJpeQzx0nxFanKK
         W3DIN4TJI8zuqXSfp3LXxF1zieW9Q2mFvRou8ZNBwGrtLsG29DKxyI8k1cJ5rth1cO2S
         tMwwx6dgptVejpRNUlHwRoMeGXH8L3HbReKNGQtQmGwPqRdliOInHhh/S990jZV2Y4ro
         f47g==
X-Gm-Message-State: APjAAAXqJSmxD1cKT1dn08yJ8VOT1/StpSL3PeNSXq0CU2Cb39Csfy6P
        IVWSvE74CXnyOda5Bm+NgYw=
X-Google-Smtp-Source: APXvYqzIv+HQ+ykIbuPHFJLuZyi/4qvp15e3afMHRwC5Re74xGE5Ubkp01Eef90GrheJ5FecANZHjw==
X-Received: by 2002:aa7:8b0c:: with SMTP id f12mr13797415pfd.154.1552545431600;
        Wed, 13 Mar 2019 23:37:11 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id f125sm25509011pfc.91.2019.03.13.23.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:37:10 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        QLogic-Storage-Upstream@qlogic.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 2/2] scsi: qla2xxx: do not use __constant_cpu_to_leXX
Date:   Thu, 14 Mar 2019 15:36:56 +0900
Message-Id: <20190314063656.25561-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314063656.25561-1-sergey.senozhatsky@gmail.com>
References: <20190314063656.25561-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch.

cpu_to_le32() and cpu_to_le16() are capable enough to detect
__builtin_constant_p() and to use an appropriate compile time
___constant_swahbXX() functions.

So we can use cpu_to_leXX() instead of __constant_cpu_to_leXX().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 582d1663f971..e839c80fb9a9 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3623,12 +3623,12 @@ static int __qlt_send_term_imm_notif(struct scsi_qla_host *vha,
 	nack->u.isp24.nport_handle = ntfy->u.isp24.nport_handle;
 	if (le16_to_cpu(ntfy->u.isp24.status) == IMM_NTFY_ELS) {
 		nack->u.isp24.flags = ntfy->u.isp24.flags &
-			__constant_cpu_to_le32(NOTIFY24XX_FLAGS_PUREX_IOCB);
+			cpu_to_le32(NOTIFY24XX_FLAGS_PUREX_IOCB);
 	}
 
 	/* terminate */
 	nack->u.isp24.flags |=
-		__constant_cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);
+		cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);
 
 	nack->u.isp24.srr_rx_id = ntfy->u.isp24.srr_rx_id;
 	nack->u.isp24.status = ntfy->u.isp24.status;
-- 
2.21.0

