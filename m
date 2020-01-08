Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337DCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043E12067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C63i9qbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgAHQfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:35:41 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41088 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgAHQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:35:40 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so3854793ioo.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stmoRBUwIDDNfn0qe+9AbU6IJN9NJVkp8GrenHVAux8=;
        b=C63i9qbAd/9chrpdbayX3EdsPRbIYNp5Mji8wwH7OL/Em9vl7dV0fT+IpLko6zEH4t
         XVLRzg+F8X9gJxT1EZCB/tMf0lS4dfgZQu6kwaAbYwe3MxoeG4bpf+ice1D6N7nW8tAd
         PvQcVjLjp1hA4fw3kNzcX+xjRKg/iC15vUEBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stmoRBUwIDDNfn0qe+9AbU6IJN9NJVkp8GrenHVAux8=;
        b=W+7RxITIXBjQ1n02JyTkYqcFFvZziKkNRF8QZFuy9MLs0Vahc8fSbR0LrdwdA8FebD
         i9fe6VO1xP9Ogv+WETSo1qPIDBOYJSPy8Urqh9Z1BCyL4gALChukAYLF9ATcG1cC/c8j
         Q2+FEwVnif3n5jhhshExMFd78Np2Ja//94AekVWAneHra0tACK2QXh7h27ktAi9q2TYa
         UC2MkmyRpy1SgXT1d6oA/3wI4LbP7IuaZWiN7lnMEOHCVrl7uYub/i6GVsjZtA5rqnxD
         KjLlY+YO4DLYHm2kmmLROJ9s1GgdcXCRYOcIyH4x0QL/DLuDrf3OSx2zj1MWnacCDKRH
         +bbQ==
X-Gm-Message-State: APjAAAX6ndT/+eNEXiKUaEOnnvMwIyFBfQZY+6WXdmnngSwHWWQ+4YOn
        rqPIrTbtAKIsVINsM/oI3bOz7O3lTsQ=
X-Google-Smtp-Source: APXvYqzQVN1caSHKImdi3Rs4dPoIbc51pMQ8Au5my3Zg8bHYvTgB9zGTCR3M0CSOIWxI5xlwUHheNg==
X-Received: by 2002:a02:a694:: with SMTP id j20mr4960877jam.69.1578501339930;
        Wed, 08 Jan 2020 08:35:39 -0800 (PST)
Received: from localhost ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id z17sm742533ior.22.2020.01.08.08.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:35:39 -0800 (PST)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Fix unregistration order
Date:   Wed,  8 Jan 2020 09:35:20 -0700
Message-Id: <20200108093459.2.Ia8f971d42dcf892541a806b906414ddfbe4fea36@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the unregistration order on the Wilco EC core driver to follow the
christmas tree pattern.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/platform/chrome/wilco_ec/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 5210c357feefd4..2d5f027d8770f8 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -137,9 +137,9 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);

+	platform_device_unregister(ec->telem_pdev);
 	platform_device_unregister(ec->charger_pdev);
 	wilco_ec_remove_sysfs(ec);
-	platform_device_unregister(ec->telem_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
--
2.24.1.735.g03f4e72817-goog

