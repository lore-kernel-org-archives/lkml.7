Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D061CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5022080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMivkkZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfJaXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:03:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36318 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaXDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:03:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id y10so3975616qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1lv6i5WMZhr+LJHUYk12uXR0Zf+Nge4dShOz7QCLY4=;
        b=gMivkkZ54O49XnNT6ktSMTgKwQeUd9Pjiy2DBrSJ9BCNsak1LylpmxHg8bqyZaBJBq
         fAXl5C+HkhUS9PBr7QFiApn1HVtf1UKky3vnp1q/FfTM6nsfDLa57Ugzkt+KRmjk7BI2
         eljn/NRnMtydKl2yk9BHWAOpVNodeDERcwWv6I5obW2farhTreah+/1gC4iAVuYa6Vuk
         FkPNhjXYAwTUtNdwyQNUA4TDPBtJCBFTj3zJtxq9YCbBfb9+q0X1I926tSdPwuVqoYa2
         An8hZjAhbIiIleUo/lC2P3NLHqdtKszSqc9rg82KLDoGoLgVY4ytoGx3h9dF5nSRmPcj
         EsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1lv6i5WMZhr+LJHUYk12uXR0Zf+Nge4dShOz7QCLY4=;
        b=ja5Wf+15GajG6ek1fk0pO2V6Mtr27tpl8QTgcZCJJDRrP5wjmJKtTTEfdutZcDXNFx
         h8/SexzRESgAWb85u/+4qHY0sczBERpbVyUFE2Rrd/EvGc7+rLUViTxEFOJz0C+lQbHe
         nxdt7l8hCMZ63116UeRXPVoaFzl3LzJO/ro/D9TX1K60igFqyNgAwUby0kceceDeoeJn
         xsYIX9eKM1IrWHlEYdIKDA6JNDQZ4Z6P/WtQ1lX+tb11prX/TfaHdDKQE+89vLE5vpKs
         eGh96NCSfxk+hn7ocNmONaMYOrOzdnusMPgerVV++F/8DJTGah0fMfEOhqsKJ4/pI4xJ
         ag3g==
X-Gm-Message-State: APjAAAWdUwRSkcY49YtFDQ+05O+mxWVUcipSRb0FKY0MX4XT9mnIdkNM
        7d4D0OgDAYaVtDrx1WnDs1Q=
X-Google-Smtp-Source: APXvYqxnW2g3AzvIUkcvZbFqLXCygMYsIlDZ1TD8IYQ0y48FZF5RQ8h5I08Rno3FcRXBeNUBY7KUVg==
X-Received: by 2002:a0c:936e:: with SMTP id e43mr7260553qve.73.1572563011216;
        Thu, 31 Oct 2019 16:03:31 -0700 (PDT)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id s67sm2633875qkh.70.2019.10.31.16.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:03:30 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v4 3/3] staging: rts5208: Eliminate the use of Camel Case in file sd.h
Date:   Thu, 31 Oct 2019 20:02:43 -0300
Message-Id: <20191031230243.3462-4-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031230243.3462-1-gabrielabittencourt00@gmail.com>
References: <20191031230243.3462-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file sd.h
Even though the constant "DCM_LOW_FREQUENCY_MODE_SET" is defined and never used,
it's useful to keep it because it documents the device.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---
Changes in v4:
- Explain the reason of keeping a constant that is defined and not used
---
 drivers/staging/rts5208/sd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.h b/drivers/staging/rts5208/sd.h
index dc9e8cad7a74..f4ff62653b56 100644
--- a/drivers/staging/rts5208/sd.h
+++ b/drivers/staging/rts5208/sd.h
@@ -232,7 +232,7 @@
 #define DCM_LOW_FREQUENCY_MODE   0x01
 
 #define DCM_HIGH_FREQUENCY_MODE_SET  0x0C
-#define DCM_Low_FREQUENCY_MODE_SET   0x00
+#define DCM_LOW_FREQUENCY_MODE_SET   0x00
 
 #define MULTIPLY_BY_1    0x00
 #define MULTIPLY_BY_2    0x01
-- 
2.20.1

