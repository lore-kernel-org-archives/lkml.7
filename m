Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1ADC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AF8206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395245AbfIFRjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:39:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55191 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbfIFRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:39:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6ID7-0005Vl-LM; Fri, 06 Sep 2019 17:39:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: make two arrays static const, makes object smaller
Date:   Fri,  6 Sep 2019 18:39:49 +0100
Message-Id: <20190906173949.21860-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate two arrays on the stack but instead make them
static const. Makes the object code smaller by 49 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  26821	   5616	      0	  32437	   7eb5	rtl8188eu/core/rtw_ieee80211.o

After:
   text	   data	    bss	    dec	    hex	filename
  26612	   5776	      0	  32388	   7e84	rtl8188eu/core/rtw_ieee80211.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 28b3cdd10397..cc1b5438c04c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -59,7 +59,7 @@ static u8 WIFI_OFDMRATES[] = {
 
 int rtw_get_bit_value_from_ieee_value(u8 val)
 {
-	unsigned char dot11_rate_table[] = {
+	static const unsigned char dot11_rate_table[] = {
 		2, 4, 11, 22, 12, 18, 24, 36, 48,
 		72, 96, 108, 0}; /*  last element must be zero!! */
 	int i = 0;
@@ -275,7 +275,7 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
 	uint len;
 	u16 val16;
 	__le16 le_tmp;
-	unsigned char wpa_oui_type[] = {0x00, 0x50, 0xf2, 0x01};
+	static const unsigned char wpa_oui_type[] = {0x00, 0x50, 0xf2, 0x01};
 	u8 *pbuf = pie;
 	int limit_new = limit;
 
-- 
2.20.1

