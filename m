Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF36BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFD621907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KccycJwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbfISBid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:38:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfISBid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:38:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so876576pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 18:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsN9pxLcPJ1qeXa5m6pMME74hufrhsEiWRUwQfSsmVQ=;
        b=KccycJwxERGqBJbUtMI8N2EkDjSdmHH9ab7eqE1HNL3NoDfTzOVfq3ZhlKD/UYZ0Lt
         MwIYJxhPhCtaQ4RwdIxeDZoA038ETi2g/8XOb3xespSfS+oVG6lWlEf1fAZWBm6cMPyL
         JTZ/8x4CXa7KTZCVjCxISSTAqMFMTqYddxGInc3ipb3nKDud/VPSc+UIGgG49PTj3SDM
         qf2WazvIZ2pelPxrSqRIsTJ+aC+7qiWbXwI09PgLvS740/TksEDvcXGMXU686ebCglyZ
         lYja/gN2AoWjVVq9Ydls08x+vhN59tS197PQZnhamD9fnAYxrOzZsXgRdcDymP2ude64
         Cwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsN9pxLcPJ1qeXa5m6pMME74hufrhsEiWRUwQfSsmVQ=;
        b=e/SW7pRxnddlV9TDn2tsbaqAcv+jQSTbnLxVdxy16xo86I03DuKMoweXicBU0NEqvd
         lLumNOw2kq/jQbzB24JRF52Yp6F+655n7p6Mtudyl3QwXlcRbWjrNcLFCqE1ZGvG+l4z
         NfmZOZxniUeyn4NK2T7zePEQSIA6rbYPRiBpDUwtuT77jMAiaAn6H9fq1GT1hdZ/Kh0O
         cD8aFhYE02EWnKTxToIOT+e3rxL2LdfMxs8uPU8rfsL9vYdWC4ZTBonh5EldBnWTO+E+
         N3pslzGlloRH2obHX6+XDoWeyVXlUZ8OLI0dopjI5eH9F43NMNmjTEtKfdadWA/l98F4
         qd+Q==
X-Gm-Message-State: APjAAAX8TrF7Hx3vmgux+CFTt9wKQsoffaL8P/RbvfaEPmjjyYqL22ad
        3bbD1Vt9onSltU/CxOBDZdAWJae7mms=
X-Google-Smtp-Source: APXvYqwrTSgOClI+KXimx0HPoDZ975i7weQtaKEnR0RIeq9IyHlZF9TGjXxv+m7kfwPlWcKf44JaRw==
X-Received: by 2002:a17:90a:c68a:: with SMTP id n10mr935649pjt.31.1568857112797;
        Wed, 18 Sep 2019 18:38:32 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.68])
        by smtp.gmail.com with ESMTPSA id 193sm9508608pfc.59.2019.09.18.18.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 18:38:32 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     dedekind1@gmail.com
Cc:     richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] UBI: fix warning static is not at beginning of declaration
Date:   Thu, 19 Sep 2019 07:08:18 +0530
Message-Id: <1568857098-3863-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler generates following warning when kernel is built with W=1:

drivers/mtd/ubi/ubi.h:971:1: warning: ‘static’ is not at beginning
of declaration [-Wold-style-declaration]

This commit fixes this by correctly ordering keywords.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/mtd/ubi/ubi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 721b6aa..75e818ca 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -968,7 +968,7 @@ int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
 void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
 #else
 static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
-int static inline ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
+static inline int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
 static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
 #endif
 
-- 
2.7.4

