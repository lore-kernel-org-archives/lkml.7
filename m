Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E248AC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B780B2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="augbJoLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfFHK5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45007 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfFHK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so1788150pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+foEg/5Kn7Wc3DhqfBX28a12tMvcUqqoAxp0c5JhJxM=;
        b=augbJoLg1soVTWHOaAlQyHTFXTeqcnEZy7ou9u6HMLF0zY6/ei4AKyl42af2jtN/WX
         vJzck9A/LnybA7Ov6fchFlG5K8qefmTsb/+tADy7DHQwoavUM1BGgc1S1qI0NWwGv17L
         O53ly4azLDT7Zssz69HJ8G4a3y9l+F7dR+s8oP0wiVRZAcs5dCvCjHVCaEzsWzKjLre4
         DsXzcaSiUeL4889AFgtpr87PajVKF9bOlUlS0zrxnexqmTmRi/k9Vh9/dCi/nVFBpeuU
         6ke/0H0m9NgkLD6KVGNzROuSiBAg/l1+4b12OUrnTeQaXhXhXk/BznyZa2iSXqnlCmNw
         ZUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+foEg/5Kn7Wc3DhqfBX28a12tMvcUqqoAxp0c5JhJxM=;
        b=lODIahjRYn4WEjxTrYNfRQBeSMqQsZ3P3LxmmTnSNGvNYev3zDQs4xERpG6q/0H5Jd
         8Q/geQ9BphiOIlywSAS+geqEMR8BA6iFDcRoZ0gAxlYBV+MFrFSKCSm2nIfG0PIcs2Q6
         pzUeRXIK3rZQQUGzfQehqW1bE09ZxTnSWUgnEJVUd9T6ty0SYl86t28/yxLXIlZhUsRy
         92fJwsqLZCGT4S++qOQJ22KJHst5OQmEq8FVWD0RbFl57kHU0GVJq9S+2x/hN/xLkXQR
         a0e9D9/oMj0x3rQq3lww8dPeLGzg3XCF5+6R+u4oSErKxYl0vri+CIZ2V0zQZ1WkXFyz
         QzDw==
X-Gm-Message-State: APjAAAUVGoumYK9WjEqWuC8kAK5rIBr4rijLXfWn6iFCzMBZa+gvl+Wp
        8t76JR3/XOXldx6lxYRe/g3UpmwI
X-Google-Smtp-Source: APXvYqzUdym4tz29yE1UgX3MmuIBK+vpu7rFiU5Eisp5PS4nr8P1IB9znQQ+5/lWvreMDC5zralLEQ==
X-Received: by 2002:a17:902:67:: with SMTP id 94mr61541293pla.64.1559991449917;
        Sat, 08 Jun 2019 03:57:29 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:29 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 2/6] staging: rtl8712: Removed redundant code from function oid_rt_pro_write_register_hdl
Date:   Sat,  8 Jun 2019 16:26:57 +0530
Message-Id: <55a2a17ea5f1bc4be7c16e6996ad890aef8f519a.1559990697.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
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

