Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEEFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D552171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvIhhoax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfDEB5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:57:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41345 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfDEB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:57:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so5679851qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=54yZrRjG9bCP1gV5fr4Ytj4h7K4n9WdItHA3563uuYc=;
        b=QvIhhoax8RG3P01PiGmOrA/Ke404vdQQYwGbhueMjDPD5Muel65vErLK0Q+UDbIt43
         BirCtDUFH1m6FOtzwMmaOB4QQKCdpptfIsvtrdq7+uMwukt+gD9twISaF9OHq0c9axXF
         ofU05QF4gys2EfxO7lL5ZEEL6i3L2y1xxgNRElJSBqPP3HQZmlC7K4+rhmFIzA4O2jrq
         YqX8AsRKH0U8w29WXBMmdZX5MjYka80gA10IEfSThL8HajAospB3uBV1z+ghIgZorrxD
         y6Sn/Dy5cXanAvFFXJpKZNlhXRRW6Eqgjsd9FNSURxq2VqdZ2b6kcdTpcTloy5AXNBYL
         pd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=54yZrRjG9bCP1gV5fr4Ytj4h7K4n9WdItHA3563uuYc=;
        b=QliSvyrB9zW+GYjRrvy9GnLcaFjUNUAqP6S1e5gjmsdi9ZR/BERkY6UqrgUh/kmGCq
         QGIscHCk7HQLWGT1sbPqA9SYAgSroc9Ns7u1QMqSlYSZx2KR1XBk69QfNYN6dekr3kBM
         pvSGnJN3zQMoH+04E/3BGGm6SO4rZ0MX/AgHaRjV5yslUqK++e2krW3yKpkavrEfW3WX
         HxwkDfqC7QeGJfQxi0vkWUEzQXwlDKEcA/bfd1344fFeSlxt4dY9aAaCMEX6A2wfuIem
         zzQ/RD/8Oqw0KiBVVmdBLdcsdW2eCM2Xe4BC3FCWx1tJg7RH4JcdiK5vXremriFwTKS3
         Z/fA==
X-Gm-Message-State: APjAAAU+w8qP8W/61kk4y3PKJXaQ6BwFrIvGjECgjH1K/lGIQGx4/ol2
        l3D84KxXfwhKgEXrds/dJ9w=
X-Google-Smtp-Source: APXvYqxXQ5vDLAgkTu/cNLSzycVx+JvGRBnGAIRGbrUAW6r4ofqWHK96qBsJ/EeBba63HY/mFLABYg==
X-Received: by 2002:a0c:c165:: with SMTP id i34mr8012966qvh.6.1554429438708;
        Thu, 04 Apr 2019 18:57:18 -0700 (PDT)
Received: from localhost.localdomain ([187.104.167.160])
        by smtp.gmail.com with ESMTPSA id 27sm5417831qtp.49.2019.04.04.18.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 18:57:18 -0700 (PDT)
From:   Caio Salvador Rohwedder <caiosalvador96@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: rtl8192u: ieee80211: add space around '==' and before '('
Date:   Thu,  4 Apr 2019 22:56:46 -0300
Message-Id: <20190405015646.20672-1-caiosalvador96@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch coding style errors on rtl819x_TSProc.c
- space required before the open parenthesis '('
- spaces required around that '=='

Signed-off-by: Caio Salvador Rohwedder <caiosalvador96@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index c76715ffa08b..0af1a87a5545 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -373,7 +373,7 @@ bool GetTs(
 			if(!list_empty(pUnusedList)) {
 				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
 				list_del_init(&(*ppTS)->list);
-				if(TxRxSelect==TX_DIR) {
+				if (TxRxSelect == TX_DIR) {
 					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, ts_common_info);
 					ResetTxTsEntry(tmp);
 				} else {
-- 
2.21.0

