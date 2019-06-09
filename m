Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F4C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D482212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfHXsdSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfFIMXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:23:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40436 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:23:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so3549920pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=USCUf6xiN3l3FOg/rvPKl6KPsZV1B+M6eFE3+EW1pGM=;
        b=bfHXsdSst457BKXFebYJhT6NoJ96Av22LCDGmLJQdCAovBhK159KtkOG44JVhd5JM4
         9uLR+LHwpqiiL9ojnu5HYFtg6Cw8wwcRVGjlI5xq0SwEKF02U7lUcjCUqW9fDnOTkDpH
         iwbHHNAIgCsyTx0H/sI/1wtok/A5d6mOroTUrq8tXI+GqYigKoiwgLnSguctijTHo3sV
         MUzgD4jZ6kzf34sj0zX3nq3AO795/mtEycAn7iaJdUI0JKMXFjZWphux0rdBwiHzUdS+
         9yzZy+yZlsvS18mqZ4EcLGCpmU74W1pRgqtovQUhfT4ZLgEgcCpcwFd67sxH5y4pkA5Y
         5msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=USCUf6xiN3l3FOg/rvPKl6KPsZV1B+M6eFE3+EW1pGM=;
        b=WuiiDxOrzsqd5xkJEUQZowu/dmQs70nYRB0+LXR4FoOALeGwd5kbfF6pZMRDrItpkD
         K4xUmf0/0zsY5Nwdy2K2uG8TVq4xTBsTU50gckRwRPC4AvK0JRYfHxbj4J4Y5iNl4+dC
         K304iYyCYytnVjRbwDtFLcsrvp1pFrYGv7OwiqMFAumoqvMVO3KI3x9hchyZ1Q6YNUio
         QZpQPWMTDPDD7/r+y528omApIjn5WgSoCF33Jdkm3QdZ/P1X148VZtH/wkp+U4W7+S5E
         fE+FbfvqU+Ahr+cTIP0dSZm3q0g5Y2QgV/jkDU1dnu64JM7gma/QvGH+a0vaQZDQ4UYz
         BtXw==
X-Gm-Message-State: APjAAAXDTJbY2nsFgwG44dIPRWCpP4B84hnmA/lw2izHfKyW+aHntKUQ
        LRyUkZCgYceZtLe2ZidsxVPZxG/l
X-Google-Smtp-Source: APXvYqyeSvvu2vOb+t8zz0Hp3d4U+cXZqJhyNXahx5Azyh62QwvN47KcoopDFdHdAfQDAYJ7ExZMDA==
X-Received: by 2002:a63:d4c:: with SMTP id 12mr11704073pgn.30.1560083025199;
        Sun, 09 Jun 2019 05:23:45 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id v64sm13734618pfv.172.2019.06.09.05.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:23:44 -0700 (PDT)
Date:   Sun, 9 Jun 2019 17:53:39 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: hal: move common code to macro
Message-ID: <20190609122339.GA3120@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In halbtc8723b2ant_TdmaDurationAdjust function,below piece of code is
repeated many times.

halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, val);
pCoexDm->psTdmaDuAdjType = val;

So replace the same with "HAL_BTC8723B2ANT_DMA_DURATION_ADJUST" MACRO.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v2: clean the changelog with proper indent
-----
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 742 ++++++++++--------------
 1 file changed, 291 insertions(+), 451 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index cb62fc0..02da0a8 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -7,6 +7,13 @@
 
 #include "Mp_Precomp.h"
 
+/* defines */
+#define HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(val)			      \
+do {									      \
+	halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, val);           \
+	pCoexDm->psTdmaDuAdjType = val;                                       \
+} while (0)
+
 /*  Global variables, these are static variables */
 static COEX_DM_8723B_2ANT GLCoexDm8723b2Ant;
 static PCOEX_DM_8723B_2ANT pCoexDm = &GLCoexDm8723b2Ant;
@@ -1599,63 +1606,43 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 		{
 			if (bScoHid) {
 				if (bTxPause) {
-					if (maxInterval == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 13);
-						pCoexDm->psTdmaDuAdjType = 13;
-					} else if (maxInterval == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-						pCoexDm->psTdmaDuAdjType = 14;
-					} else if (maxInterval == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					}
+					if (maxInterval == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(13);
+					else if (maxInterval == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+					else if (maxInterval == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
 				} else {
-					if (maxInterval == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-						pCoexDm->psTdmaDuAdjType = 9;
-					} else if (maxInterval == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-						pCoexDm->psTdmaDuAdjType = 10;
-					} else if (maxInterval == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					}
+					if (maxInterval == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(9);
+					else if (maxInterval == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+					else if (maxInterval == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
 				}
 			} else {
 				if (bTxPause) {
-					if (maxInterval == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 5);
-						pCoexDm->psTdmaDuAdjType = 5;
-					} else if (maxInterval == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-						pCoexDm->psTdmaDuAdjType = 6;
-					} else if (maxInterval == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					}
+					if (maxInterval == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(5);
+					else if (maxInterval == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+					else if (maxInterval == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
 				} else {
-					if (maxInterval == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 1);
-						pCoexDm->psTdmaDuAdjType = 1;
-					} else if (maxInterval == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-						pCoexDm->psTdmaDuAdjType = 2;
-					} else if (maxInterval == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					}
+					if (maxInterval == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(1);
+					else if (maxInterval == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+					else if (maxInterval == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
 				}
 			}
 		}
@@ -1741,442 +1728,295 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 			if (bTxPause) {
 				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 1\n"));
 
-				if (pCoexDm->curPsTdma == 71) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 5);
-					pCoexDm->psTdmaDuAdjType = 5;
-				} else if (pCoexDm->curPsTdma == 1) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 5);
-					pCoexDm->psTdmaDuAdjType = 5;
-				} else if (pCoexDm->curPsTdma == 2) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-					pCoexDm->psTdmaDuAdjType = 6;
-				} else if (pCoexDm->curPsTdma == 3) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-					pCoexDm->psTdmaDuAdjType = 7;
-				} else if (pCoexDm->curPsTdma == 4) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 8);
-					pCoexDm->psTdmaDuAdjType = 8;
-				}
-
-				if (pCoexDm->curPsTdma == 9) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 13);
-					pCoexDm->psTdmaDuAdjType = 13;
-				} else if (pCoexDm->curPsTdma == 10) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-					pCoexDm->psTdmaDuAdjType = 14;
-				} else if (pCoexDm->curPsTdma == 11) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-					pCoexDm->psTdmaDuAdjType = 15;
-				} else if (pCoexDm->curPsTdma == 12) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 16);
-					pCoexDm->psTdmaDuAdjType = 16;
-				}
+				if (pCoexDm->curPsTdma == 71)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(5);
+				else if (pCoexDm->curPsTdma == 1)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(5);
+				else if (pCoexDm->curPsTdma == 2)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+				else if (pCoexDm->curPsTdma == 3)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+				else if (pCoexDm->curPsTdma == 4)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(8);
+
+				if (pCoexDm->curPsTdma == 9)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(13);
+				else if (pCoexDm->curPsTdma == 10)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+				else if (pCoexDm->curPsTdma == 11)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+				else if (pCoexDm->curPsTdma == 12)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(16);
 
 				if (result == -1) {
-					if (pCoexDm->curPsTdma == 5) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-						pCoexDm->psTdmaDuAdjType = 6;
-					} else if (pCoexDm->curPsTdma == 6) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 7) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 8);
-						pCoexDm->psTdmaDuAdjType = 8;
-					} else if (pCoexDm->curPsTdma == 13) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-						pCoexDm->psTdmaDuAdjType = 14;
-					} else if (pCoexDm->curPsTdma == 14) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 15) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 16);
-						pCoexDm->psTdmaDuAdjType = 16;
-					}
+					if (pCoexDm->curPsTdma == 5)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+					else if (pCoexDm->curPsTdma == 6)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 7)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(8);
+					else if (pCoexDm->curPsTdma == 13)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+					else if (pCoexDm->curPsTdma == 14)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 15)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(16);
 				} else if (result == 1) {
-					if (pCoexDm->curPsTdma == 8) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 7) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-						pCoexDm->psTdmaDuAdjType = 6;
-					} else if (pCoexDm->curPsTdma == 6) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 5);
-						pCoexDm->psTdmaDuAdjType = 5;
-					} else if (pCoexDm->curPsTdma == 16) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 15) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-						pCoexDm->psTdmaDuAdjType = 14;
-					} else if (pCoexDm->curPsTdma == 14) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 13);
-						pCoexDm->psTdmaDuAdjType = 13;
-					}
+					if (pCoexDm->curPsTdma == 8)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 7)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+					else if (pCoexDm->curPsTdma == 6)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(5);
+					else if (pCoexDm->curPsTdma == 16)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 15)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+					else if (pCoexDm->curPsTdma == 14)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(13);
 				}
 			} else {
 				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 0\n"));
-				if (pCoexDm->curPsTdma == 5) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 71);
-					pCoexDm->psTdmaDuAdjType = 71;
-				} else if (pCoexDm->curPsTdma == 6) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-					pCoexDm->psTdmaDuAdjType = 2;
-				} else if (pCoexDm->curPsTdma == 7) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-					pCoexDm->psTdmaDuAdjType = 3;
-				} else if (pCoexDm->curPsTdma == 8) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 4);
-					pCoexDm->psTdmaDuAdjType = 4;
-				}
-
-				if (pCoexDm->curPsTdma == 13) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-					pCoexDm->psTdmaDuAdjType = 9;
-				} else if (pCoexDm->curPsTdma == 14) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-					pCoexDm->psTdmaDuAdjType = 10;
-				} else if (pCoexDm->curPsTdma == 15) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-					pCoexDm->psTdmaDuAdjType = 11;
-				} else if (pCoexDm->curPsTdma == 16) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 12);
-					pCoexDm->psTdmaDuAdjType = 12;
-				}
+				if (pCoexDm->curPsTdma == 5)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(71);
+				else if (pCoexDm->curPsTdma == 6)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+				else if (pCoexDm->curPsTdma == 7)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+				else if (pCoexDm->curPsTdma == 8)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(4);
+
+				if (pCoexDm->curPsTdma == 13)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(9);
+				else if (pCoexDm->curPsTdma == 14)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+				else if (pCoexDm->curPsTdma == 15)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+				else if (pCoexDm->curPsTdma == 16)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(12);
 
 				if (result == -1) {
-					if (pCoexDm->curPsTdma == 71) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 1);
-						pCoexDm->psTdmaDuAdjType = 1;
-					} else if (pCoexDm->curPsTdma == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-						pCoexDm->psTdmaDuAdjType = 2;
-					} else if (pCoexDm->curPsTdma == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 4);
-						pCoexDm->psTdmaDuAdjType = 4;
-					} else if (pCoexDm->curPsTdma == 9) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-						pCoexDm->psTdmaDuAdjType = 10;
-					} else if (pCoexDm->curPsTdma == 10) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 11) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 12);
-						pCoexDm->psTdmaDuAdjType = 12;
-					}
+					if (pCoexDm->curPsTdma == 71)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(1);
+					else if (pCoexDm->curPsTdma == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+					else if (pCoexDm->curPsTdma == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(4);
+					else if (pCoexDm->curPsTdma == 9)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+					else if (pCoexDm->curPsTdma == 10)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 11)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(12);
 				} else if (result == 1) {
-					if (pCoexDm->curPsTdma == 4) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-						pCoexDm->psTdmaDuAdjType = 2;
-					} else if (pCoexDm->curPsTdma == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 1);
-						pCoexDm->psTdmaDuAdjType = 1;
-					} else if (pCoexDm->curPsTdma == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 71);
-						pCoexDm->psTdmaDuAdjType = 71;
-					} else if (pCoexDm->curPsTdma == 12) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 11) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-						pCoexDm->psTdmaDuAdjType = 10;
-					} else if (pCoexDm->curPsTdma == 10) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-						pCoexDm->psTdmaDuAdjType = 9;
-					}
+					if (pCoexDm->curPsTdma == 4)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+					else if (pCoexDm->curPsTdma == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(1);
+					else if (pCoexDm->curPsTdma == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(71);
+					else if (pCoexDm->curPsTdma == 12)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 11)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+					else if (pCoexDm->curPsTdma == 10)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(9);
 				}
 			}
 		} else if (maxInterval == 2) {
 			if (bTxPause) {
 				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 1\n"));
-				if (pCoexDm->curPsTdma == 1) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-					pCoexDm->psTdmaDuAdjType = 6;
-				} else if (pCoexDm->curPsTdma == 2) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-					pCoexDm->psTdmaDuAdjType = 6;
-				} else if (pCoexDm->curPsTdma == 3) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-					pCoexDm->psTdmaDuAdjType = 7;
-				} else if (pCoexDm->curPsTdma == 4) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 8);
-					pCoexDm->psTdmaDuAdjType = 8;
-				}
-
-				if (pCoexDm->curPsTdma == 9) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-					pCoexDm->psTdmaDuAdjType = 14;
-				} else if (pCoexDm->curPsTdma == 10) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-					pCoexDm->psTdmaDuAdjType = 14;
-				} else if (pCoexDm->curPsTdma == 11) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-					pCoexDm->psTdmaDuAdjType = 15;
-				} else if (pCoexDm->curPsTdma == 12) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 16);
-					pCoexDm->psTdmaDuAdjType = 16;
-				}
+				if (pCoexDm->curPsTdma == 1)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+				else if (pCoexDm->curPsTdma == 2)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+				else if (pCoexDm->curPsTdma == 3)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+				else if (pCoexDm->curPsTdma == 4)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(8);
+
+				if (pCoexDm->curPsTdma == 9)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+				else if (pCoexDm->curPsTdma == 10)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+				else if (pCoexDm->curPsTdma == 11)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+				else if (pCoexDm->curPsTdma == 12)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(16);
 
 				if (result == -1) {
-					if (pCoexDm->curPsTdma == 5) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-						pCoexDm->psTdmaDuAdjType = 6;
-					} else if (pCoexDm->curPsTdma == 6) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 7) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 8);
-						pCoexDm->psTdmaDuAdjType = 8;
-					} else if (pCoexDm->curPsTdma == 13) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-						pCoexDm->psTdmaDuAdjType = 14;
-					} else if (pCoexDm->curPsTdma == 14) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 15) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 16);
-						pCoexDm->psTdmaDuAdjType = 16;
-					}
+					if (pCoexDm->curPsTdma == 5)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+					else if (pCoexDm->curPsTdma == 6)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 7)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(8);
+					else if (pCoexDm->curPsTdma == 13)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+					else if (pCoexDm->curPsTdma == 14)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 15)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(16);
 				} else if (result == 1) {
-					if (pCoexDm->curPsTdma == 8) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 7) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-						pCoexDm->psTdmaDuAdjType = 6;
-					} else if (pCoexDm->curPsTdma == 6) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-						pCoexDm->psTdmaDuAdjType = 6;
-					} else if (pCoexDm->curPsTdma == 16) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 15) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-						pCoexDm->psTdmaDuAdjType = 14;
-					} else if (pCoexDm->curPsTdma == 14) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-						pCoexDm->psTdmaDuAdjType = 14;
-					}
+					if (pCoexDm->curPsTdma == 8)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 7)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+					else if (pCoexDm->curPsTdma == 6)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(6);
+					else if (pCoexDm->curPsTdma == 16)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 15)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
+					else if (pCoexDm->curPsTdma == 14)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(14);
 				}
 			} else {
 				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 0\n"));
-				if (pCoexDm->curPsTdma == 5) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-					pCoexDm->psTdmaDuAdjType = 2;
-				} else if (pCoexDm->curPsTdma == 6) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-					pCoexDm->psTdmaDuAdjType = 2;
-				} else if (pCoexDm->curPsTdma == 7) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-					pCoexDm->psTdmaDuAdjType = 3;
-				} else if (pCoexDm->curPsTdma == 8) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 4);
-					pCoexDm->psTdmaDuAdjType = 4;
-				}
-
-				if (pCoexDm->curPsTdma == 13) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-					pCoexDm->psTdmaDuAdjType = 10;
-				} else if (pCoexDm->curPsTdma == 14) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-					pCoexDm->psTdmaDuAdjType = 10;
-				} else if (pCoexDm->curPsTdma == 15) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-					pCoexDm->psTdmaDuAdjType = 11;
-				} else if (pCoexDm->curPsTdma == 16) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 12);
-					pCoexDm->psTdmaDuAdjType = 12;
-				}
+				if (pCoexDm->curPsTdma == 5)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+				else if (pCoexDm->curPsTdma == 6)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+				else if (pCoexDm->curPsTdma == 7)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+				else if (pCoexDm->curPsTdma == 8)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(4);
+
+				if (pCoexDm->curPsTdma == 13)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+				else if (pCoexDm->curPsTdma == 14)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+				else if (pCoexDm->curPsTdma == 15)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+				else if (pCoexDm->curPsTdma == 16)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(12);
 
 				if (result == -1) {
-					if (pCoexDm->curPsTdma == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-						pCoexDm->psTdmaDuAdjType = 2;
-					} else if (pCoexDm->curPsTdma == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 4);
-						pCoexDm->psTdmaDuAdjType = 4;
-					} else if (pCoexDm->curPsTdma == 9) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-						pCoexDm->psTdmaDuAdjType = 10;
-					} else if (pCoexDm->curPsTdma == 10) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 11) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 12);
-						pCoexDm->psTdmaDuAdjType = 12;
-					}
+					if (pCoexDm->curPsTdma == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+					else if (pCoexDm->curPsTdma == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(4);
+					else if (pCoexDm->curPsTdma == 9)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+					else if (pCoexDm->curPsTdma == 10)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 11)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(12);
 				} else if (result == 1) {
-					if (pCoexDm->curPsTdma == 4) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-						pCoexDm->psTdmaDuAdjType = 2;
-					} else if (pCoexDm->curPsTdma == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-						pCoexDm->psTdmaDuAdjType = 2;
-					} else if (pCoexDm->curPsTdma == 12) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 11) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-						pCoexDm->psTdmaDuAdjType = 10;
-					} else if (pCoexDm->curPsTdma == 10) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 10);
-						pCoexDm->psTdmaDuAdjType = 10;
-					}
+					if (pCoexDm->curPsTdma == 4)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+					else if (pCoexDm->curPsTdma == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(2);
+					else if (pCoexDm->curPsTdma == 12)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 11)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
+					else if (pCoexDm->curPsTdma == 10)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(10);
 				}
 			}
 		} else if (maxInterval == 3) {
 			if (bTxPause) {
 				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 1\n"));
-				if (pCoexDm->curPsTdma == 1) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-					pCoexDm->psTdmaDuAdjType = 7;
-				} else if (pCoexDm->curPsTdma == 2) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-					pCoexDm->psTdmaDuAdjType = 7;
-				} else if (pCoexDm->curPsTdma == 3) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-					pCoexDm->psTdmaDuAdjType = 7;
-				} else if (pCoexDm->curPsTdma == 4) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 8);
-					pCoexDm->psTdmaDuAdjType = 8;
-				}
-
-				if (pCoexDm->curPsTdma == 9) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-					pCoexDm->psTdmaDuAdjType = 15;
-				} else if (pCoexDm->curPsTdma == 10) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-					pCoexDm->psTdmaDuAdjType = 15;
-				} else if (pCoexDm->curPsTdma == 11) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-					pCoexDm->psTdmaDuAdjType = 15;
-				} else if (pCoexDm->curPsTdma == 12) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 16);
-					pCoexDm->psTdmaDuAdjType = 16;
-				}
+				if (pCoexDm->curPsTdma == 1)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+				else if (pCoexDm->curPsTdma == 2)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+				else if (pCoexDm->curPsTdma == 3)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+				else if (pCoexDm->curPsTdma == 4)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(8);
+
+				if (pCoexDm->curPsTdma == 9)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+				else if (pCoexDm->curPsTdma == 10)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+				else if (pCoexDm->curPsTdma == 11)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+				else if (pCoexDm->curPsTdma == 12)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(16);
 
 				if (result == -1) {
-					if (pCoexDm->curPsTdma == 5) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 6) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 7) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 8);
-						pCoexDm->psTdmaDuAdjType = 8;
-					} else if (pCoexDm->curPsTdma == 13) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 14) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 15) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 16);
-						pCoexDm->psTdmaDuAdjType = 16;
-					}
+					if (pCoexDm->curPsTdma == 5)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 6)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 7)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(8);
+					else if (pCoexDm->curPsTdma == 13)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 14)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 15)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(16);
 				} else if (result == 1) {
-					if (pCoexDm->curPsTdma == 8) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 7) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 6) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 7);
-						pCoexDm->psTdmaDuAdjType = 7;
-					} else if (pCoexDm->curPsTdma == 16) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 15) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					} else if (pCoexDm->curPsTdma == 14) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 15);
-						pCoexDm->psTdmaDuAdjType = 15;
-					}
+					if (pCoexDm->curPsTdma == 8)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 7)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 6)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(7);
+					else if (pCoexDm->curPsTdma == 16)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 15)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
+					else if (pCoexDm->curPsTdma == 14)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(15);
 				}
 			} else {
 				BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], TxPause = 0\n"));
-				if (pCoexDm->curPsTdma == 5) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-					pCoexDm->psTdmaDuAdjType = 3;
-				} else if (pCoexDm->curPsTdma == 6) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-					pCoexDm->psTdmaDuAdjType = 3;
-				} else if (pCoexDm->curPsTdma == 7) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-					pCoexDm->psTdmaDuAdjType = 3;
-				} else if (pCoexDm->curPsTdma == 8) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 4);
-					pCoexDm->psTdmaDuAdjType = 4;
-				}
-
-				if (pCoexDm->curPsTdma == 13) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-					pCoexDm->psTdmaDuAdjType = 11;
-				} else if (pCoexDm->curPsTdma == 14) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-					pCoexDm->psTdmaDuAdjType = 11;
-				} else if (pCoexDm->curPsTdma == 15) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-					pCoexDm->psTdmaDuAdjType = 11;
-				} else if (pCoexDm->curPsTdma == 16) {
-					halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 12);
-					pCoexDm->psTdmaDuAdjType = 12;
-				}
+				if (pCoexDm->curPsTdma == 5)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+				else if (pCoexDm->curPsTdma == 6)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+				else if (pCoexDm->curPsTdma == 7)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+				else if (pCoexDm->curPsTdma == 8)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(4);
+
+				if (pCoexDm->curPsTdma == 13)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+				else if (pCoexDm->curPsTdma == 14)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+				else if (pCoexDm->curPsTdma == 15)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+				else if (pCoexDm->curPsTdma == 16)
+					HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(12);
 
 				if (result == -1) {
-					if (pCoexDm->curPsTdma == 1) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 4);
-						pCoexDm->psTdmaDuAdjType = 4;
-					} else if (pCoexDm->curPsTdma == 9) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 10) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 11) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 12);
-						pCoexDm->psTdmaDuAdjType = 12;
-					}
+					if (pCoexDm->curPsTdma == 1)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(4);
+					else if (pCoexDm->curPsTdma == 9)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 10)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 11)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(12);
 				} else if (result == 1) {
-					if (pCoexDm->curPsTdma == 4) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 3) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 2) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-						pCoexDm->psTdmaDuAdjType = 3;
-					} else if (pCoexDm->curPsTdma == 12) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 11) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					} else if (pCoexDm->curPsTdma == 10) {
-						halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-						pCoexDm->psTdmaDuAdjType = 11;
-					}
+					if (pCoexDm->curPsTdma == 4)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 3)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 2)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(3);
+					else if (pCoexDm->curPsTdma == 12)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 11)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
+					else if (pCoexDm->curPsTdma == 10)
+						HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(11);
 				}
 			}
 		}
-- 
2.7.4

