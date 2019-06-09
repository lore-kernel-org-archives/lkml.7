Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A150C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8F3208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udpu/tNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfFIMcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:32:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36978 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:32:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so2873520pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+foEg/5Kn7Wc3DhqfBX28a12tMvcUqqoAxp0c5JhJxM=;
        b=Udpu/tNPNMdecn9q29vZ6ywBMQjIbIWWVHCkIWZEt0z44aCB28BLrMMUKD3pML8k6Q
         OA5C3T2m00hnPejb0G8z+6h3VAn3ZRj6SLt7ZIZzwocJ9SEBm0hvPvmnrz4L+V+S7ZlJ
         OMIsouNp2VartTnVOPKQ4fAyvcogaNSmF7AzkSo1GuH4lY959mWcyRX7t3ZkExhPu7P+
         PqmnGc2nkAugo12/ff39ytbmgwDR8H/u2j5VBqE4dSX8l3DPNMdNVeQSA1Aclw0O0clH
         a85PEzBsptMWj8lihbrKBYLdXZulDhLIa1HDjmeL4ymI8jJU5g4/zZhmXdQkoMelCMAK
         tJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+foEg/5Kn7Wc3DhqfBX28a12tMvcUqqoAxp0c5JhJxM=;
        b=eFxz+04nVPm2NP19VvPGzYK8NIL2kT8q2dYFzvMNrK0LqvWKRf9IB0EHAShaeyiizS
         ED42OgSeVf83aFIoOmBNyv+esenysufnf78vwHoUMdVAxywhNp9I67Whqw9KHTjuLjnc
         JlABK9p3bpfKzesSI8HTS8pmuJxvt039wgG3Voe+V4lhbSI8zytYrBxiwYLWUAZ3JD2n
         4hwzGfKnmh5h9GcbTkveI/zeEYUzwzWleV1QYAsfsql3fQps3kmGTYTFObXzMR2Qg6UF
         GFCDwS50UOBTIaXAlwFiiXojKlvxykq25o8rzV/VdaKigaZpLXJ0LKtEKiLKAmw1mKRM
         XxOQ==
X-Gm-Message-State: APjAAAWlnsL0DNGLBNUgOeOLBT72/RfD8bRKXMMFO1RgG8NWw+554ExU
        05aCzhxrQSzVp3CZj2MHX1754s/L
X-Google-Smtp-Source: APXvYqw4qKAX/d/zI48eo3yHUFr3bqRWFXtXIZa9N/ZXmBQfuktRcvKXzBCt5gPmsjRSHxdYVfRceA==
X-Received: by 2002:aa7:90d3:: with SMTP id k19mr67193376pfk.1.1560083525202;
        Sun, 09 Jun 2019 05:32:05 -0700 (PDT)
Received: from localhost.localdomain ([117.192.26.87])
        by smtp.googlemail.com with ESMTPSA id c142sm10209982pfb.171.2019.06.09.05.32.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 05:32:04 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v5 2/6] staging: rtl8712: Removed redundant code from function oid_rt_pro_write_register_hdl
Date:   Sun,  9 Jun 2019 18:01:41 +0530
Message-Id: <55a2a17ea5f1bc4be7c16e6996ad890aef8f519a.1560081971.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560081971.git.linux.dkm@gmail.com>
References: <cover.1560081971.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function oid_rt_pro_write_register_hdl, Adapter->ImrContent is
assigned with RegRWStruct->value but Adapter->ImrContent is never used
anywhere else. So those lines has no impact and are removed removed.

As that was the only place where ImrContent was used, so the member
variable is removed from the structure _adapter

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h        | 1 -
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index d4262a68dd4d..9fbd19f03ca9 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -149,7 +149,6 @@ struct _adapter {
 	bool	surprise_removed;
 	bool	suspended;
 	u32	IsrContent;
-	u32	ImrContent;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmdThread;
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 588346da1412..add6c18195d6 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -661,11 +661,6 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 			status = RNDIS_STATUS_NOT_ACCEPTED;
 			break;
 		}
-
-		if ((status == RNDIS_STATUS_SUCCESS) &&
-		    (RegRWStruct->offset == HIMR) &&
-		    (RegRWStruct->width == 4))
-			Adapter->ImrContent = RegRWStruct->value;
 	}
 	return status;
 }
-- 
2.19.1

