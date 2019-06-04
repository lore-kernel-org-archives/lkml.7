Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B64C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A387A24F01
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMzknivH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFDEWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:22:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDEWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:22:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so3070860pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgO+w0gDLF/ExNdAxLRh9J+GF5SK4v/4VwjV2iE/MpE=;
        b=HMzknivHZ0ov6XhiCCWRgZzRbXg6Af4MIn5WA9EbXPI+qUeSSGEa9VOpqPNgqaiqGy
         ezA7U+NztWuh8GyqUIajQ/2VaIj4vnOcstQd53gd6QIq6wT0XNqXaYgozMGHT2rsVsEf
         9bw22MNFl2eb1I2IK3efpQiQOLtcpmu3qbyaQd9lbqQyqkSuHBFe8nTDlzrRxN18sXTx
         I94VqWIOS0nzcJpbBOdLKcYeXpbhuQ+0+QC/3mzuCrxhzrGyeVUGIWcJYvmGvS2xlZkk
         XkRaaTlfLwPDmTmagLnHaZ6/wmM8OiKw4dHc6FrzlRgEvqvp4fRMegvVP7YzvGcO3VqN
         3vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgO+w0gDLF/ExNdAxLRh9J+GF5SK4v/4VwjV2iE/MpE=;
        b=fuTo1a5X9TsHbBFw4FrvrDsN1O97LmP89FfMab2hOrEo3gpm3KrSg779qwN2f83HtG
         J+E6+v/ZX8uIBqRi820SKeVOk/BoNDczk37h9lWjxTZrbMmQtN/lfXvfuuTJ67SAS9Lo
         qiCznM85HRQymLF5BGY/Qouh9UlkyRa2tbH4wFkU9qzQ8HHYmQQwk0rg4WynVVTBg3HQ
         VMFkQVHqfvJLpt2ylgmCEkiumPdRnCQPb06wOa1WNYhMhA4ESmwcgExNtoGrSCjBxjrg
         YusDlllWt59XPpE68s+rIXOS/gUMsRZkC5o0GY8D2C+B9fF7/WaprG1rTlmCvYU0nQfi
         JZjw==
X-Gm-Message-State: APjAAAXQbqnywafe1OgrQgje2uGBjnQnm9sxdTJZqGGSHvHbqqIYTX8E
        nv0LqeNWMtP31O+nXr6I3EqY4cyX
X-Google-Smtp-Source: APXvYqxfgbh04zLq8aRzyKTHTkOHPnqdq0Wx22eGbwON2dGEXTNNaslw51ttEKc/sasaQvPb+RX/lA==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr32631911pgd.249.1559622132599;
        Mon, 03 Jun 2019 21:22:12 -0700 (PDT)
Received: from localhost.localdomain ([117.192.17.118])
        by smtp.googlemail.com with ESMTPSA id q3sm14382390pgv.21.2019.06.03.21.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:22:12 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     joe@perches.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com
Subject: [PATCH v3 3/4] staging: rtl8712: removed unused variables from struct _adapter
Date:   Tue,  4 Jun 2019 09:51:35 +0530
Message-Id: <2001636feab6c260aef4349deba7212ab3aee3ef.1559615579.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559615579.git.linux.dkm@gmail.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed following unused variables from struct _adapter

IsrContent, xmitThread, evtThread, recvThread

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 0c722e9c2410..c36a5ef3ee5d 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -148,13 +148,9 @@ struct _adapter {
 	bool	driver_stopped;
 	bool	surprise_removed;
 	bool	suspended;
-	u32	IsrContent;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
-	pid_t evtThread;
-	struct task_struct *xmitThread;
-	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
 	void (*dvobj_deinit)(struct _adapter *adapter);
 	struct net_device *pnetdev;
-- 
2.19.1

