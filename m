Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D973C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952120835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjKGwJnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCCUYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:24:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44752 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCCUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:24:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so3287685wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v6FzZwUqk5EgW7A8NmcEo+WrIt7b3xUuIJmHfUMcNIw=;
        b=ZjKGwJnU3YD9eRDVTORKz7nhAoBZT8xMbhLqzztnkYfYcIGHW005SnimOlJvUfjLGj
         pLcs8nsGh9LKdx4YemGITYQTVQqfFEOqCpEIqXA1CWwSxC1Kb+FSNIv6pN6SwX4DzWXI
         uTQ8pCtXPUfWaJXqGYdU2MIyaQk+JeBE2IqPhu55QS61XNiWV1aipijtHgfHGwzbeid/
         wdqS0Ad7/w+/iGCiCsE/2zsSFFyJchwIfN4DvIOWfiEceHNGZbyb2ZWpWsXc3Cw4rciY
         ZVmW6kBfh79fZOXK9eNYlbBplcnZgvEE5S9+xZF05S9yAceCOj2jpdG6lC8ZYxlRGg/h
         XvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v6FzZwUqk5EgW7A8NmcEo+WrIt7b3xUuIJmHfUMcNIw=;
        b=IjOt1H/hyPMCCUUxQzYaete0lv1abDJLWsxsBNt4njHgRFJuT3MSnlZqteJp14ud/+
         RWDem9/arfoOrrlc0jlOl1wXXDKyaWUiicXL9kiwGjxkqjk6voF0v7QnKg3ZEDWCzXF4
         2Nxwm6jpujIg4zMRMCHLlcToNZlXHW4EKKVbB0BMHLiUBl1hNTJXaz9mdEPrilB1+aId
         KbZ1aoP+ZY5ow8FbHofNtcDihdfysypoImjjcJK57Of2JODcqOtN9XymACdDxTTkfLXI
         kX1XxLafcsEws+UPoTl6r+ifEt+3qOo4zWVU7PxGcsfNlZ7JywyFVVYNBsMGgMgNaIT1
         5EbQ==
X-Gm-Message-State: APjAAAXUzKZpNtWDnHGPEGoo+A/V0KbVEZY8AC2pkzfgmC4VJM12NM+i
        PIyJwQrgPF/I7YZG2lBkkec=
X-Google-Smtp-Source: APXvYqxegLEL9aWo3RkaRyAzJ840LKSuJTZDyQr45RwJ18/eyvGD2uKBtLQzawhN9DuB+r8DZ6hMlg==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr10946274wrx.203.1551644682607;
        Sun, 03 Mar 2019 12:24:42 -0800 (PST)
Received: from debian.lan (host-92-20-66-190.as13285.net. [92.20.66.190])
        by smtp.gmail.com with ESMTPSA id i13sm6986116wrm.86.2019.03.03.12.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:24:42 -0800 (PST)
From:   Hugo Lange <hugolange7000@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.ousul.org, linux-kernel@vger.kernel.org,
        Hugo Lange <hugolange7000@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary braces from if/else
Date:   Sun,  3 Mar 2019 20:24:39 +0000
Message-Id: <20190303202439.15357-1-hugolange7000@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary braces for single blocks.

Signed-off-by: Hugo Lange <hugolange7000@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 7ae476ffcd8c..149b0009ad66 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -394,11 +394,11 @@ static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
 {
 	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
 					 pPktinfo);
-	if (dm_odm->RSSI_test) {
+	if (dm_odm->RSSI_test)
 		;/*  Select the packets to do RSSI checking for antenna switching. */
-	} else {
+	else
 		odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
-	}
+
 }
 
 void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
-- 
2.11.0

