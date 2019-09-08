Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F364C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3808021479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="WltSgCMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfIHQKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:10:24 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:43531 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfIHQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:10:23 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 2BFB5213; Sun,  8 Sep 2019 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567959019;
        bh=MO5HlXTxGJraUgrw2HCLRKEZomKPEt298Si8avVe83M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WltSgCMUrh74SD1XIiuOGAJxZAEgVHTxYVAgDgnXshGuvYuwoL6UR9JRVtrlbegpS
         Gz+mdmsZHq/D1qbMqNlXbafeCRd/0UiSKsXdUgkBMSyG6xw0Uo+DYcIDCy6OctkRiF
         SBWCMtOU4mSLyj0N07HqHTZiN5CySovA79YmhS7wBkenNaK+ZWRAbCuAel/lDk9Y6U
         LTXneIL3n19LaslCA/FF8f9XgHmsEQvESuudsBa+c0dVKiizIZs5L1poflM/RlGHf6
         8Czy60XCjvGIehFk/gp0EI7aDSLPofBeyDs7RUeHkRyMG+i+GdpTdOGpeZflyFdN4f
         BsH4v5976shYg==
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2 3/3] staging: exfat: add millisecond support
Date:   Sun,  8 Sep 2019 16:10:15 +0000
Message-Id: <20190908161015.26000-3-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use create_time_ms modify_time_ms fields to store the millisecond
part of the file timestamp with the precision of 10 ms.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 8476eeedba83..e87119fa8c0a 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1139,6 +1139,7 @@ void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			u8 mode)
 {
+	u8 ms = 0;
 	u16 t = 0x00, d = 0x21;
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
@@ -1146,6 +1147,7 @@ void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	case TM_CREATE:
 		t = GET16_A(ep->create_time);
 		d = GET16_A(ep->create_date);
+		ms = ep->create_time_ms * 10;
 		break;
 	case TM_MODIFY:
 		t = GET16_A(ep->modify_time);
@@ -1159,11 +1161,17 @@ void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	tp->day  = (d & 0x001F);
 	tp->mon  = (d >> 5) & 0x000F;
 	tp->year = (d >> 9);
+
+	if (ms >= 1000) {
+		ms -= 1000;
+		tp->sec++;
+	}
 }
 
 void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
+	u8 ms = 0;
 	u16 t = 0x00, d = 0x21;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
@@ -1171,10 +1179,12 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	case TM_CREATE:
 		t = GET16_A(ep->create_time);
 		d = GET16_A(ep->create_date);
+		ms = ep->create_time_ms * 10;
 		break;
 	case TM_MODIFY:
 		t = GET16_A(ep->modify_time);
 		d = GET16_A(ep->modify_date);
+		ms = ep->modify_time_ms * 10;
 		break;
 	case TM_ACCESS:
 		t = GET16_A(ep->access_time);
@@ -1188,21 +1198,33 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	tp->day  = (d & 0x001F);
 	tp->mon  = (d >> 5) & 0x000F;
 	tp->year = (d >> 9);
+
+	if (ms >= 1000) {
+		ms -= 1000;
+		tp->sec++;
+	}
 }
 
 void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			u8 mode)
 {
+	u8 ms;
 	u16 t, d;
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
 	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
 	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
 
+	ms = tp->millisec;
+	if (tp->sec & 1) {
+		ms += 1000;
+	}
+
 	switch (mode) {
 	case TM_CREATE:
 		SET16_A(ep->create_time, t);
 		SET16_A(ep->create_date, d);
+		ep->create_time_ms = ms / 10;
 		break;
 	case TM_MODIFY:
 		SET16_A(ep->modify_time, t);
@@ -1214,20 +1236,28 @@ void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
+	u8 ms;
 	u16 t, d;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
 	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
 
+	ms = tp->millisec;
+	if (tp->sec & 1) {
+		ms += 1000;
+	}
+
 	switch (mode) {
 	case TM_CREATE:
 		SET16_A(ep->create_time, t);
 		SET16_A(ep->create_date, d);
+		ep->create_time_ms = ms / 10;
 		break;
 	case TM_MODIFY:
 		SET16_A(ep->modify_time, t);
 		SET16_A(ep->modify_date, d);
+		ep->modify_time_ms = ms / 10;
 		break;
 	case TM_ACCESS:
 		SET16_A(ep->access_time, t);
-- 
2.20.1

