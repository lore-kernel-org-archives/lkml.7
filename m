Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCBEC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CD9208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuSnj//f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfEENWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:22:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37665 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEENWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:22:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so5297227pfi.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TdBBbUZ0RxPdEUkWNKneikj6T2F+pAawD9gH2hw+dsY=;
        b=FuSnj//f/UTrafYQ3ex+zWM9aPxdrU3RgOaAtbF1TaXWKUnHy+4Kx/8pVAPs3/pDao
         2OAKtKa2Uze4wAJpHKqgGy0l0o7EULWM32NuCN9B2RQ+ZZpdbu58Yb8ZRJ+HV6Grm1uj
         uZ28vvmQDhV42QBbLW27Eevi3Rbg+inztCZHPX3QdtqE+fMJYqLAh8QNzO26/rNGgcNa
         2p11Gjb0q1xL0NDg+zIjYHU6GMFQDTgXctGr5QCYc6S9A4AI/855Tf8kiaK4kGVBI+xZ
         UgLW3LqlCoogn6TZH5gXm7PKO1ZLd/ANs5t5Nxie0LLQ2gwyIPZS1gFeoBLL9fmDMQmn
         2cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TdBBbUZ0RxPdEUkWNKneikj6T2F+pAawD9gH2hw+dsY=;
        b=Ezl3uRtH8EvVStxjtu2kNn01wiHqitRGGPk5/dAC/LSxdk8uWq1YhkXjCvX3pbyO9n
         AikVd1ISHlip/zGtzZ99KtnaD+29qKkk5M2BWj4WwNhyHyZiMFQvSKSwoEAyf4CiOEpU
         ZTJwCXSnsGx0Wfqfk1NrmIQ8noDAGCOv7HIbKbDAv2SGSZHAiI3nr6axyNnwN3U70yFm
         n4oQmhWY0fWsA0oFC3DsvtJAPgYyZUEh2yozCwm0dIDsteciu8bx1JFhSDv4mS6oKnF7
         aw3dS8DESs8GWFEDT0EyJX+I6BS+HP98GgTUKeoTcEgBRu3rfFQrillI4avR8l076tk8
         lY4A==
X-Gm-Message-State: APjAAAUR0/QFORJhb3ZtH5j2wgdITUjHAEpQANsbHdf7tu/80OO8GnBI
        zgRXOu31bTJ28L+Bnitm9wU=
X-Google-Smtp-Source: APXvYqyiHDaKTbuRvF2+8D6TYGwy7w+BRqstD1lqEVH3ao6IO8qV8Avl+NZ0nUC14CrQ2z9STXjZzA==
X-Received: by 2002:a63:da14:: with SMTP id c20mr9828991pgh.191.1557062551816;
        Sun, 05 May 2019 06:22:31 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id z7sm9206851pgh.81.2019.05.05.06.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:22:31 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 5/6] staging: rtl8723bs: core: Fix variable constant comparisons.
Date:   Sun,  5 May 2019 18:52:12 +0530
Message-Id: <20190505132212.4458-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap the terms of comparisons whenever the constant comes first to get
rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a8ceaa9f8718..0b5bd047a552 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1276,7 +1276,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 			status = _STATS_FAILURE_;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	/*  check if the supported rate is ok */
@@ -1372,7 +1372,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		wpa_ie_len = 0;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
-- 
2.17.1

