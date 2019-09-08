Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918E3C49ED5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D82054F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="UrkkEd0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfIHRfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 13:35:53 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:52355 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfIHRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 13:35:52 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 7F20D213; Sun,  8 Sep 2019 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567964146;
        bh=XroL0aeRw1GulK+zsCktbOwBMfaNEGXyCrOVr81n3Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrkkEd0M3eFJNqdMU7revVr1/Nlkteb3l48MdZ/V76mruhDSFwJMivr+rDz9fMGyS
         K7g6KiwjCCazk9UhjEDq2I1gOlCZ9DpyYyWqkXIArQZaNrIa38W990nn9WOsZsNp52
         zEokwHupJwz2NSZeN5TyMwRlcMn5Or1mqCpMKHB1T+RIiTxMWZdOtTKh/Jf8mPE0Yf
         ENnVDwJCANHWVczoCvgxgEmXw93/0mMXuequaMXdMEYcAF5ZhW62mEu0/XaafpZQe1
         6XJ4CMNNizMrOoWaHfMVG7JV7sSWJMAjY9VamjPQ/zY3f+YJF+qjjXiEyXt87Pb94l
         8HCQ9aDNGyB6Q==
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v3 4/4] staging: exfat: add millisecond support
Date:   Sun,  8 Sep 2019 17:35:39 +0000
Message-Id: <20190908173539.26963-4-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
References: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use create_time_ms and modify_time_ms fields to store the millisecond
part of the file timestamp with the precision of 10 ms.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat_core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d21f68d786b8..d6e33a485d5f 100644
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
@@ -1188,21 +1198,32 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
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
+	if (tp->sec & 1)
+		ms += 1000;
+
 	switch (mode) {
 	case TM_CREATE:
 		SET16_A(ep->create_time, t);
 		SET16_A(ep->create_date, d);
+		ep->create_time_ms = ms / 10;
 		break;
 	case TM_MODIFY:
 		SET16_A(ep->modify_time, t);
@@ -1214,20 +1235,27 @@ void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
+	u8 ms;
 	u16 t, d;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
 	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
 
+	ms = tp->millisec;
+	if (tp->sec & 1)
+		ms += 1000;
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

