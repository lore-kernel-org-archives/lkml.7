Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE2C0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1121744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyffoxom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392160AbfFKSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:55:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37590 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfFKSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:55:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id 20so7474027pgr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dbiCszwzEy2LyynB/BzUukSSBRX6PSMXl/5QcFgmSC4=;
        b=Oyffoxom8I92kRwOF0WNENgPvTdr3GRmujPu+NvBny9AIZ+PXYdK/XDAkyA5cj0Wm1
         P3iFY05jCwvbjvsN2SNkQUIndwqYr/zVxmH/VBkKs5LGsQUv+xjT/+HDt1Qi8WDGY2jd
         cKryvoW/E5lzx29YZCYNfrIagRjmrhmsEnNxi6wq1C4wXeYCbgUUUGDOTQPiM+Tb3O27
         3kcxtZevl5HrLcstlYQ1PldAWH1LdtJru41QiDB1zvKGo6841B0ntLcgN/rCBxB7DDne
         Sx9+X1vcUV23yuIWzxiqhKB//hHhX7QlF9FNkmUFeEw0VUpLutDT8xYNrsrt8fE5huSU
         HBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dbiCszwzEy2LyynB/BzUukSSBRX6PSMXl/5QcFgmSC4=;
        b=NG7Hb0XDODxY1nQIrvMzhyXgTFp/0vRtv6OmiLNG2X05q3/ktHOqpsCdWCzc9/VQRC
         8MPgQ9ntezzt1PnjLnGHzOuZILRxrBJ3yDieLJc5KdEzjo2f+9Pb1PCEiabXBLF/Mar7
         IlDtNVezze+apjaQPhDPdOUNE8Hy4ZHOHsxX+14GIp6YTzqOzYRuRRKyQ+7+SsB2rvu8
         5mupuXpiYku4QdqsXWwB0qvvhm0qgXoJWCZppFGxDFh7sm0jNsxtDgyiLI1eCwNqdrOL
         SQp1ZYpS2Extr4vo/Blbh5q9w+f08OC+Zuj/9vdy14LJbpUxZB05OyMv5a3H5tm9Npkr
         QUmg==
X-Gm-Message-State: APjAAAW87kleeh00RBhwowRuBO9BYYBf/loagwIP94tUNPt28C+bd19r
        QjasgZqpBwwvI+s6zibHJVU=
X-Google-Smtp-Source: APXvYqx84s0caginVRm/JwqplMJsBTlFQtWDKinEOBfe8H2ZkqFDTRESf77XdFCV7uL6ipvkBL91ng==
X-Received: by 2002:a63:224a:: with SMTP id t10mr12610806pgm.289.1560279310016;
        Tue, 11 Jun 2019 11:55:10 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id a18sm3119388pjq.0.2019.06.11.11.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 11:55:08 -0700 (PDT)
Date:   Wed, 12 Jun 2019 00:25:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Change return type to void from u8
Message-ID: <20190611185503.GA9606@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function HalQueryTxOQTBufferStatus8723BSdio always returns true and
caller functions are not bother about return status.

Change return type to void.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c     | 3 +--
 drivers/staging/rtl8723bs/include/sdio_ops.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index ac79de8..feb95ed 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -1194,12 +1194,11 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *adapter)
 /* 	Description: */
 /* 		Query SDIO Local register to get the current number of TX OQT Free Space. */
 /*  */
-u8 HalQueryTxOQTBufferStatus8723BSdio(struct adapter *adapter)
+void HalQueryTxOQTBufferStatus8723BSdio(struct adapter *adapter)
 {
 	struct hal_com_data *haldata = GET_HAL_DATA(adapter);
 
 	haldata->SdioTxOQTFreeSpace = SdioLocalCmd52Read1Byte(adapter, SDIO_REG_OQT_FREE_PG);
-	return true;
 }
 
 #if defined(CONFIG_WOWLAN) || defined(CONFIG_AP_WOWLAN)
diff --git a/drivers/staging/rtl8723bs/include/sdio_ops.h b/drivers/staging/rtl8723bs/include/sdio_ops.h
index 0f117ff..6b0446b 100644
--- a/drivers/staging/rtl8723bs/include/sdio_ops.h
+++ b/drivers/staging/rtl8723bs/include/sdio_ops.h
@@ -33,7 +33,7 @@ extern void InitSysInterrupt8723BSdio(struct adapter *padapter);
 extern void EnableInterrupt8723BSdio(struct adapter *padapter);
 extern void DisableInterrupt8723BSdio(struct adapter *padapter);
 extern u8 HalQueryTxBufferStatus8723BSdio(struct adapter *padapter);
-extern u8 HalQueryTxOQTBufferStatus8723BSdio(struct adapter *padapter);
+extern void HalQueryTxOQTBufferStatus8723BSdio(struct adapter *padapter);
 #if defined(CONFIG_WOWLAN) || defined(CONFIG_AP_WOWLAN)
 extern void ClearInterrupt8723BSdio(struct adapter *padapter);
 #endif /* CONFIG_WOWLAN */
-- 
2.7.4

