Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CFCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BD62089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcFXtNo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfKDQoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:44:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45923 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:44:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id q13so17896175wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0t94XLffreVVovHGukxf8hICR+94LpUO6Px1WI34vBE=;
        b=AcFXtNo0+1Chg6ruZiD0XY+IdNfhv36E7xA73VrgzEJE997OtyuA97IC5jhjJfsGu3
         47iEsxh/TcwAuANiseYMYuZXuQEi3IRW1BZdRi5WGnuL/Vq/ITSSMYylJ+Fc+Oolnhtm
         5WuHyw73MZEBQL8SVVy0FKkmClvWc1mYZbctnnf63FIpjur3DFSM1wDa/UJTIHOhk1c5
         RA7jw7Nfgou10yM84n0tipylKj8b+i6f91pvE5R8GsCBH31/omO46FqNYhdFYXeHOtwH
         EJSHO58d9thdkRpzbMuei09+dX8AvcIS2cSSWKf0Vn7DbGCik0oCIjhdLODmwDAbozot
         dIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0t94XLffreVVovHGukxf8hICR+94LpUO6Px1WI34vBE=;
        b=cb/XAuad3f0iPO6wXU+0s6MYF08fBNWXn+J/GVqeQoDPUi0LJ1jB7Lz4u+vs3sMF0j
         61FGVhmWxesZv7EB0oKrCAcs+0ee7cBbxre3q7UQHqitBF8CoTFvz0ZtAVLrKvH48pqp
         a/uOytWFlDeAYsfVs/FfGfm0FahKlSBz/g5EmJeHwE6CcJHRA82plkhSVgic5YVWwTe8
         zuISlwsuR1eledULvu5Td2tEPnhb6Qp5zCOQ+VYdXLLf0WkY4Svr9WwxL1skseWKfYQD
         N1zpWzHAwSmsCkdcEZZSJmx/Xa7fH7U7wSQY+IXAIAftgOZvYoOjq0wCZrajM1EyaUXP
         LY0A==
X-Gm-Message-State: APjAAAUGsin0helrulekF1xxXRlKKTvBb1HZBd9Ml9i9qvl7K7NHwalg
        cu//P44nTc9HpjZJfb31zrJBsvRUTfHZ
X-Google-Smtp-Source: APXvYqxBesDB4GQs7XQd7MVcpHiy1j4Bh/l/FwCfRsTaZUuicmiqYqSRJ60kQfR5/nFdXZtemuyxBA==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr25891043wrc.9.1572885851234;
        Mon, 04 Nov 2019 08:44:11 -0800 (PST)
Received: from buntux.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.googlemail.com with ESMTPSA id i3sm17371844wrw.69.2019.11.04.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:44:10 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: rts5208: rewrite macro with GNU extension __auto_type
Date:   Mon,  4 Nov 2019 16:44:00 +0000
Message-Id: <20191104164400.9935-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite macro function with GNU extension __auto_type
to remove issue detected by checkpatch tool.
CHECK: MACRO argument reuse - possible side-effects?

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/rts5208/rtsx_chip.h | 92 +++++++++++++++++------------
 1 file changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
index bac65784d4a1..4b986d5c68da 100644
--- a/drivers/staging/rts5208/rtsx_chip.h
+++ b/drivers/staging/rts5208/rtsx_chip.h
@@ -386,23 +386,31 @@ struct zone_entry {
 
 /* SD card */
 #define CHK_SD(sd_card)			(((sd_card)->sd_type & 0xFF) == TYPE_SD)
-#define CHK_SD_HS(sd_card)		(CHK_SD(sd_card) && \
-					 ((sd_card)->sd_type & SD_HS))
-#define CHK_SD_SDR50(sd_card)		(CHK_SD(sd_card) && \
-					 ((sd_card)->sd_type & SD_SDR50))
-#define CHK_SD_DDR50(sd_card)		(CHK_SD(sd_card) && \
-					 ((sd_card)->sd_type & SD_DDR50))
-#define CHK_SD_SDR104(sd_card)		(CHK_SD(sd_card) && \
-					 ((sd_card)->sd_type & SD_SDR104))
-#define CHK_SD_HCXC(sd_card)		(CHK_SD(sd_card) && \
-					 ((sd_card)->sd_type & SD_HCXC))
-#define CHK_SD_HC(sd_card)		(CHK_SD_HCXC(sd_card) && \
-					 ((sd_card)->capacity <= 0x4000000))
-#define CHK_SD_XC(sd_card)		(CHK_SD_HCXC(sd_card) && \
-					 ((sd_card)->capacity > 0x4000000))
-#define CHK_SD30_SPEED(sd_card)		(CHK_SD_SDR50(sd_card) || \
-					 CHK_SD_DDR50(sd_card) || \
-					 CHK_SD_SDR104(sd_card))
+#define CHK_SD_HS(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
+					 (_sd->sd_type & SD_HS); })
+#define CHK_SD_SDR50(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
+					 (_sd->sd_type & SD_SDR50); })
+#define CHK_SD_DDR50(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
+					 (_sd->sd_type & SD_DDR50); })
+#define CHK_SD_SDR104(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
+					 (_sd->sd_type & SD_SDR104); })
+#define CHK_SD_HCXC(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
+					 (_sd->sd_type & SD_HCXC); })
+#define CHK_SD_HC(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD_HCXC(_sd) && \
+					(_sd->capacity <= 0x4000000); })
+#define CHK_SD_XC(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD_HCXC(_sd) && \
+					 (_sd->capacity > 0x4000000); })
+#define CHK_SD30_SPEED(sd_card)\
+	({__auto_type _sd = sd_card; CHK_SD_SDR50(_sd) || \
+					CHK_SD_DDR50(_sd) || \
+					CHK_SD_SDR104(_sd); })
 
 #define SET_SD(sd_card)			((sd_card)->sd_type = TYPE_SD)
 #define SET_SD_HS(sd_card)		((sd_card)->sd_type |= SD_HS)
@@ -420,18 +428,24 @@ struct zone_entry {
 /* MMC card */
 #define CHK_MMC(sd_card)		(((sd_card)->sd_type & 0xFF) == \
 					 TYPE_MMC)
-#define CHK_MMC_26M(sd_card)		(CHK_MMC(sd_card) && \
-					 ((sd_card)->sd_type & MMC_26M))
-#define CHK_MMC_52M(sd_card)		(CHK_MMC(sd_card) && \
-					 ((sd_card)->sd_type & MMC_52M))
-#define CHK_MMC_4BIT(sd_card)		(CHK_MMC(sd_card) && \
-					 ((sd_card)->sd_type & MMC_4BIT))
-#define CHK_MMC_8BIT(sd_card)		(CHK_MMC(sd_card) && \
-					 ((sd_card)->sd_type & MMC_8BIT))
-#define CHK_MMC_SECTOR_MODE(sd_card)	(CHK_MMC(sd_card) && \
-					 ((sd_card)->sd_type & MMC_SECTOR_MODE))
-#define CHK_MMC_DDR52(sd_card)		(CHK_MMC(sd_card) && \
-					 ((sd_card)->sd_type & MMC_DDR52))
+#define CHK_MMC_26M(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
+					 (_sd->sd_type & MMC_26M); })
+#define CHK_MMC_52M(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
+					 (_sd->sd_type & MMC_52M); })
+#define CHK_MMC_4BIT(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
+					 (_sd->sd_type & MMC_4BIT); })
+#define CHK_MMC_8BIT(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
+	 (_sd->sd_type & MMC_8BIT); })
+#define CHK_MMC_SECTOR_MODE(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
+					 (_sd->sd_type & MMC_SECTOR_MODE); })
+#define CHK_MMC_DDR52(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
+					 (_sd->sd_type & MMC_DDR52); })
 
 #define SET_MMC(sd_card)		((sd_card)->sd_type = TYPE_MMC)
 #define SET_MMC_26M(sd_card)		((sd_card)->sd_type |= MMC_26M)
@@ -448,8 +462,9 @@ struct zone_entry {
 #define CLR_MMC_SECTOR_MODE(sd_card)	((sd_card)->sd_type &= ~MMC_SECTOR_MODE)
 #define CLR_MMC_DDR52(sd_card)		((sd_card)->sd_type &= ~MMC_DDR52)
 
-#define CHK_MMC_HS(sd_card)		(CHK_MMC_52M(sd_card) && \
-					 CHK_MMC_26M(sd_card))
+#define CHK_MMC_HS(sd_card)\
+	({__auto_type _sd = sd_card; CHK_MMC_52M(_sd) && \
+					 CHK_MMC_26M(_sd); })
 #define CLR_MMC_HS(sd_card)			\
 do {						\
 	CLR_MMC_DDR52(sd_card);			\
@@ -560,12 +575,15 @@ struct xd_info {
 #define HG8BIT			(MS_HG | MS_8BIT)
 
 #define CHK_MSPRO(ms_card)	(((ms_card)->ms_type & 0xFF) == TYPE_MSPRO)
-#define CHK_HG8BIT(ms_card)	(CHK_MSPRO(ms_card) && \
-				 (((ms_card)->ms_type & HG8BIT) == HG8BIT))
-#define CHK_MSXC(ms_card)	(CHK_MSPRO(ms_card) && \
-				 ((ms_card)->ms_type & MS_XC))
-#define CHK_MSHG(ms_card)	(CHK_MSPRO(ms_card) && \
-				 ((ms_card)->ms_type & MS_HG))
+#define CHK_HG8BIT(ms_card)\
+	({__auto_type _ms = ms_card; CHK_MSPRO(_ms) && \
+		((_ms->ms_type & HG8BIT) == HG8BIT); })
+#define CHK_MSXC(ms_card)\
+	({__auto_type _ms = ms_card; CHK_MSPRO(_ms) && \
+				 ((_ms)->ms_type & MS_XC); })
+#define CHK_MSHG(ms_card)\
+	({__auto_type _ms = ms_card; CHK_MSPRO(_ms) && \
+				 ((_ms)->ms_type & MS_HG); })
 
 #define CHK_MS8BIT(ms_card)	(((ms_card)->ms_type & MS_8BIT))
 #define CHK_MS4BIT(ms_card)	(((ms_card)->ms_type & MS_4BIT))
-- 
2.17.1

