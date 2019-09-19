Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A36218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHzxOc1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfISAJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:09:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40056 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfISAJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:09:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so1033616pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jFcf9iaa7Tt4QrvMrWEeq0CzGPxx9DksNwganDUQw0=;
        b=AHzxOc1w8Ea6pHo+1TvR/i0feaAwaavrGAD9fcT7m8YnFkOJx3p43rpMLW2m/wHb0C
         c/cxBpUKn5fQNkhvjHMXRO+SDzjOurEm+Ge47N94fybQ6OHOH7/eDiQcIB3Fjmb/FIrY
         d0jlclUlTAsDoP/XloLOW3tg2nHBY8nSbSrmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jFcf9iaa7Tt4QrvMrWEeq0CzGPxx9DksNwganDUQw0=;
        b=deNQk27T/360Wye7RciLAnoC2W79dbrrGk/NcfnFycIvvuuF1RxRCb2P1qnfPQT/w8
         O64MsXnhg0MsHHIlNilhiG4ujRFHPrq5zj63P/EEfSIOQ3KhI6RJs/cY+BtoUMiyx3Xf
         JBDOgq3JkOBwSeKqygCIYfgWprtDl0jmJ9D/izMUvVmfn/rmu0UvFpm67foxFI9YPGVu
         crRZJp8qJmT3SHYqotfGMAnUNf3j6TNm9G9n0cVP1LeJ4/Nult16TbOIco/hSe9ViTpr
         2/w0UhDJIV6wNkFIoKVR+3mhTBCOcjGi/XCnK4ZjHxC1BO6oK+woLRZ2LZ1nnsISGBZD
         Zn1g==
X-Gm-Message-State: APjAAAXcfImBGHY54MCuoybzDZf5uk/7uG0ADjSBpOD4PTn90uaAezT/
        rNhDvpYV+xsBpCa03tWnT2eyUmb5w8o=
X-Google-Smtp-Source: APXvYqyGzlz4fGaEnyzkA0gV1KKoYGKOWF3MNf0NuTCha9rCY0aacX7jNyH0uw9hH/t+v16yZw7TZQ==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr603695pju.41.1568851792121;
        Wed, 18 Sep 2019 17:09:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k31sm3890132pjb.14.2019.09.18.17.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:09:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] devfreq: Make log message more explicit when devfreq device already exists
Date:   Wed, 18 Sep 2019 17:09:46 -0700
Message-Id: <20190919000946.158454-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before creating a new devfreq device devfreq_add_device() checks
if there is already a devfreq dev associated with the requesting
device (parent). If that's the case the function rejects to create
another devfreq dev for that parent and logs an error. The error
message is very unspecific, make it a bit more explicit.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..0e2dd734ab58 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -625,7 +625,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq = find_device_devfreq(dev);
 	mutex_unlock(&devfreq_list_lock);
 	if (!IS_ERR(devfreq)) {
-		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
+		dev_err(dev, "%s: devfreq device already exists!\n",
 			__func__);
 		err = -EINVAL;
 		goto err_out;
-- 
2.23.0.237.gc6a4ce50a0-goog

