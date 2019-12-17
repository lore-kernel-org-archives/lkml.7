Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E226FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FC521582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CTtWiJ7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfLQUnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:43:07 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33474 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLQUnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:43:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47cqpd3Tbmz9vYVL
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ggquj8QYgGIm for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 14:43:05 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47cqpd1ZMzz9vYVC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:43:05 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id 7so10276336ybc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHRpA8yRAnpMeohn/UFdPWTBWzHvpiDJXOI1dqhcReE=;
        b=CTtWiJ7ZynxyBiVgl7haMTiSAZMraAf25CTEbBmXZbWSCpGPk9w4OP1unNmqZPcLu7
         T1rvwMQoHik5BXZOa6QZ0yKouot0SnzJaqzc0VcAjeywu13qAUPUE13DQOfaiF+WSUc+
         3kKYtLMazrzTRA8evIeSWobfHCmwnmjQ/fvbSahMt+s/2Y0GaiijGYD8+WQWzTAU7AOh
         f8yGtNCKjHZcG4e8ldpSrAT6+yXUe5kPJh+nLdlqAI7blqf+YTJL0OQQTpd61jv2Y7Ej
         jXmhGBiCVILebE2E5pu267FKYXC5TSJ1o84GNr5zwjSu2+V+SZXIU4oNHDJ3pC30+woi
         9Sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHRpA8yRAnpMeohn/UFdPWTBWzHvpiDJXOI1dqhcReE=;
        b=dg+teeg86uLM2+2GdmpqlbGXVliuXTfhLNaix5cmWW6rQZ8g9PT7IkkB5RyWy+qfGt
         ER4xr73fXSVwJIXkEwGZubfC+1Ymv6Hp/1ho2o6xPOOmXaQ1QzkcP42+hEm2pk7Tj0Fk
         1nQQ/YKjjB6dO4JjP93GX5LegAaTP0hmxXmgFp0XwMEERGpXTfgCCA3g2vN+o0F+jVYf
         pNTbEuO4rpJFhzHKO5v/4087BVZ5N8l9W4XxEew31fTip332nb+GPvJr092KvrlqiBPE
         mzQqg7TpseyVrgxo3MllmsEyC7vebUAjksA38FdZmxm2kCH+M42vz7rhdhkAZkcR6ejT
         6n7Q==
X-Gm-Message-State: APjAAAUBGEQBXK2HjEajAYKm7BJ/hF8JvXbzobEg6nPyvfpDfxsF63x0
        pjxZySCe7hoH/JI+Y0G+Do2mkzDd4Fk2x6dvmxTa6VXSKWC4B5Mkwa28Q+XupkhKV1wbEg9KAqg
        my/vhbrAf7JT9ZE4QJ/0alyLGUfuD
X-Received: by 2002:a81:a8c1:: with SMTP id f184mr500679ywh.29.1576615384708;
        Tue, 17 Dec 2019 12:43:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXIOXh9OMCS6/U1az+abjHX1IWifPSH0LicBhZb60OQ7I/lxSkDp2DHmDJ21iYOY8fXBSOkQ==
X-Received: by 2002:a81:a8c1:: with SMTP id f184mr500638ywh.29.1576615384392;
        Tue, 17 Dec 2019 12:43:04 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id p62sm10125054ywc.44.2019.12.17.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:43:04 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Robert Baldyga <r.baldyga@samsung.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nfc: s3fwrn5: replace the assertion with a WARN_ON
Date:   Tue, 17 Dec 2019 14:43:00 -0600
Message-Id: <20191217204300.28616-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In s3fwrn5_fw_recv_frame, if fw_info->rsp is not empty, the
current code causes a crash via BUG_ON. However, s3fwrn5_fw_send_msg
does not crash in such a scenario. The patch replaces the BUG_ON
by returning the error to the callers and frees up skb.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Failed to free memory of skb, identified by David Miller
---
 drivers/nfc/s3fwrn5/firmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index be110d9cef02..de613c623a2c 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -507,7 +507,10 @@ int s3fwrn5_fw_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
 	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
 	struct s3fwrn5_fw_info *fw_info = &info->fw_info;
 
-	BUG_ON(fw_info->rsp);
+	if (WARN_ON(fw_info->rsp)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	fw_info->rsp = skb;
 
-- 
2.20.1

