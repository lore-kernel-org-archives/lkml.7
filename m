Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8601AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDC32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sCQjknSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfCYOSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39410 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbfCYOSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so10362793wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZHAlhhZl4+Tb6D04VMXd4+6C74wYfqvuN1/1tdvht8=;
        b=sCQjknSnFZ5hPsApj04J60Lj9X6JNqXn2GB6s4LtNWPUTnQyyoV9CxqVkQrajMUBaU
         6k7IvHzFmSgtI9MCV37Fyv9bADnfinMB1CMfgck2q4IKK/gn830683MZJTJKrQCcVOD5
         oG2igSmdLWiLU7whmPnnprpWxW8jOGJiC0zEB84s1w0Lnnh+7ZNOadXsxtHAJ6A4Fze4
         5pCkMwdM4l5StXCPTQcxQhk07RsuMxCE7tWZ/bqX0PYujjg7LFImvHDkVx39+Jo8+Lnz
         r2bE/edSVj8tB67aQf2WYLvb8FrnlyTqo3sJwsOnbDogFiz1H/hhrGEayrO3XFRGI2AP
         nT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZHAlhhZl4+Tb6D04VMXd4+6C74wYfqvuN1/1tdvht8=;
        b=gvVW8GrLKcueawHBP+mnQe/Mm8yGxWynbxgYbRaqMHzXg74o0yN6SYBHyfFOf+1fd9
         G8f7vhtKf3lRq214RS7zzCJ8vsa3IdAVWhKOi5ddnzOKsojg+g9DjaIiJPAayfAF7cir
         fVeYXUlOJ7cXYNfBpIIiSBqFCIDAYFKDlcp7OhoTBfCKtiKIlisotaAk66ImRERUiM6D
         kWOyBkiGUDT7Y1S14VVsdnSEcx5NnANmS2eAeLK13clXMsb7cnfZZNnoOXtNO4rMMuff
         00iBjGayUwdEMzcKNSfZQjVMfDFWFRTekhccBKbUURnvVOSMMrYJZPTReGiW+LEoFcMQ
         lTlQ==
X-Gm-Message-State: APjAAAXVnsN80e0iKc1gauYiIOsiv2hyscz6mAOnZ1XSe2eA6VzwyzFV
        tPiJRRNb83vggQdaMSThzjxEQg==
X-Google-Smtp-Source: APXvYqz7TZe+GfPDXgH4vnTFw9UMh3w7TlDUMzE6Dfqc8AZpcbL95itv4iTLnlORU77tW9jxuk0yHA==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr16685292wre.10.1553523519418;
        Mon, 25 Mar 2019 07:18:39 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] drm/meson: Add G12A compatible
Date:   Mon, 25 Mar 2019 15:18:23 +0100
Message-Id: <20190325141824.21259-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally add the Amlogic G12A SoC compatible for the VPU driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 079d22299d78..faf1b1b0357c 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -447,6 +447,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-vpu" },
 	{ .compatible = "amlogic,meson-gxl-vpu" },
 	{ .compatible = "amlogic,meson-gxm-vpu" },
+	{ .compatible = "amlogic,meson-g12a-vpu" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.21.0

