Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2C206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dspERCVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCDRHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:07:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33113 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:07:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so6391186wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+sJerntu2Nxylwhrv9DwfDgV8w8VUJJnjLWGL6MfhE=;
        b=dspERCVoDGRENGiepNc8DjsNHD1hb3Bcl2nVqKZBi9rIoF9254hiREzV638fmi91vQ
         hD3pNN118iuC7Xs/m1aHrd1H6+qDAuEjEBKrhMFuUIrLBl8KbFwTnZ5h4OYmopd82Lzw
         TNao7ER3uakqEBqAe7o6F3mJiFfTnV0TDat+wVPkd3GiER0dTZ1z2YJuvM8SH5yykxje
         +M7nZOooffwuPXwXT7DWICo/wwGLOv/LwJEpi1OtPp34R9hSvGY34ts5L2D04xeUnike
         THJWZ1E8uIqqQVo5sMohjryi1wrrRRWEO3t1P4Hwr4EHFH0CuqKvV6FYtFfE5FR1k15Q
         vzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+sJerntu2Nxylwhrv9DwfDgV8w8VUJJnjLWGL6MfhE=;
        b=jvWrQllOtdULYJ3oawioMm08m0nfzsAuWMzfgxm3Tkt1CX7dXgj78j/qn1epIugtXx
         6/PpIW6X5GWxEM/r8QVM7yjbnGaK5HPkDuSLRxtBbpVP70Xz1raVfKMgE/qUDYJvpiWf
         Ol6IMLEM8y9/zSn2WY/0OAeFVpJRzpwPmdR8rQB1Oq8ezC0tC32Q3ouPhwhZNjtzQiy1
         cB5SkYX5nZrH+2zCgvaMKXBFHENoqgpKaPLu0W6jW6lXREtXPFXhaK7DAsxX+z1oq7Qn
         VM+JZlDzpZ2jq5S+OsULCMzYg+QP+iFJzycDYq2CbO3KuHoDzmh1VfSB3HMSCrgMPmqR
         wg8Q==
X-Gm-Message-State: APjAAAVIKsl1JotM8fXwuPcSBqR8KMf0ZLDnXl5zfFtJlY9vGNu/cYmI
        lTjD3p0e6+4PYqJIgwmmi4A=
X-Google-Smtp-Source: APXvYqwyjVqKmprzrqXxH5vfxo8nNMt614zN1luluNIokiCERCDnDdhjL3JDBz7JU9mKeB+YTUnEgA==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr13709466wrq.273.1551719265050;
        Mon, 04 Mar 2019 09:07:45 -0800 (PST)
Received: from localhost.localdomain ([5.146.133.129])
        by smtp.googlemail.com with ESMTPSA id f7sm5450043wru.3.2019.03.04.09.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 09:07:44 -0800 (PST)
From:   Dominik Adamski <adamski.dominik@gmail.com>
Cc:     adamski.dominik@gmail.com, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: bundle.c fix comparison to NULL
Date:   Mon,  4 Mar 2019 18:06:36 +0100
Message-Id: <20190304170636.4340-1-adamski.dominik@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issue:
Comparison to NULL could be written "!bundle->state"

Signed-off-by: Dominik Adamski <adamski.dominik@gmail.com>
---
 drivers/staging/greybus/bundle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/bundle.c b/drivers/staging/greybus/bundle.c
index e97b2b87ba47..3f702db9e098 100644
--- a/drivers/staging/greybus/bundle.c
+++ b/drivers/staging/greybus/bundle.c
@@ -32,7 +32,7 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 {
 	struct gb_bundle *bundle = to_gb_bundle(dev);
 
-	if (bundle->state == NULL)
+	if (!bundle->state)
 		return sprintf(buf, "\n");
 
 	return sprintf(buf, "%s\n", bundle->state);
-- 
2.19.1

