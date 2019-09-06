Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BEFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F7520640
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395289AbfIFRuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:50:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55647 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfIFRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:50:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6INJ-0006Sb-Qj; Fri, 06 Sep 2019 17:50:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: make array op_class static const, makes object smaller
Date:   Fri,  6 Sep 2019 18:50:21 +0100
Message-Id: <20190906175021.25103-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array op_class on the stack but instead make it
static const. Makes the object code smaller by 64 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  93553	   7944	   5056	 106553	  1a039	rtl8723bs/core/rtw_mlme_ext.o

After:
   text	   data	    bss	    dec	    hex	filename
  93425	   8008	   5056	 106489	  19ff9	rtl8723bs/core/rtw_mlme_ext.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 2128886c9924..814b7a6bf4ea 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -344,7 +344,7 @@ static void init_channel_list(struct adapter *padapter, RT_CHANNEL_INFO *channel
 							  struct p2p_channels *channel_list)
 {
 
-	struct p2p_oper_class_map op_class[] = {
+	static const struct p2p_oper_class_map op_class[] = {
 		{ IEEE80211G,  81,   1,  13,  1, BW20 },
 		{ IEEE80211G,  82,  14,  14,  1, BW20 },
 		{ IEEE80211A, 115,  36,  48,  4, BW20 },
@@ -363,7 +363,7 @@ static void init_channel_list(struct adapter *padapter, RT_CHANNEL_INFO *channel
 
 	for (op = 0; op_class[op].op_class; op++) {
 		u8 ch;
-		struct p2p_oper_class_map *o = &op_class[op];
+		const struct p2p_oper_class_map *o = &op_class[op];
 		struct p2p_reg_class *reg = NULL;
 
 		for (ch = o->min_chan; ch <= o->max_chan; ch += o->inc) {
-- 
2.20.1

