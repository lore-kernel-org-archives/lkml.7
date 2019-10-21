Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC11CCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8351F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPg/RYjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfJUK6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJUK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so2160828wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJ3e2otpMWVdhjzztz3QDOTYAmPJU5Qr6nYPafBRUGw=;
        b=uPg/RYjg86DcbqDDwpLKJLDizvEJdEwdu7r8c2St5KAPIaUBtJ2NW+5df+E/vgXtRN
         5KCsxEpSpB+ox0II7sWLU3yx5zbb3bufQ9EdHuMQsm9cxEgwwa95Xn//m2vJuZg1aSk9
         DkAsQh224TNp+EtORwR5LqBWH6mauTV2SPhSUPH0izHHkNJMgCZD9j+g92xNaSILVH+L
         dWEP0ZxA4RqmAgcPuMTW71oZN0nM2oFbvTD0Txz+qhIi7ft29z9G8DkYPqbjA/HDsHeg
         hkHAUiGTBRPTl4v9JqDXpcwLen9YMKYs8bWi1bhKchCeIVDVmZgUmQ8L0Prx/dEq9IXG
         oK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJ3e2otpMWVdhjzztz3QDOTYAmPJU5Qr6nYPafBRUGw=;
        b=DtOrN1LmB6ud5KhAH0zgnJQLoZFvPgt0HRoQyqilKIiH2PBc5VSl219+vw8X3JrQRj
         OKzodgz2o14vwYPy/hgHqQHpEZIea3JvXbANOYqDW/zoUQuoNgkGv4kPGONyx3/ZWxc3
         U3HWh9mzi9aBm1ocx/t0IqO5F2OcJhU6rEN+TBmORzNkrwLIgKShvEQlNtf2085HgBn9
         3G3hXf+OdFEWg1B6SsAm/xqIupLrNA13G2PODXXfMtntr3Cc2a9LJQE6wY2Ft0yAFzDT
         5M6oWTnn3RfDkCOKpGgnIKF0D+6fvYgDU6syD8GEVNU7NKlUnuKVRU6/a8hlW8LDAJ98
         QzXA==
X-Gm-Message-State: APjAAAXyjq+lVNLQiBoHMPNeNuMUZ9hpLuSSQgfbujwLLxXCqTtkwaOt
        UE2IsC8y/XURJHBehfZ5licxxA==
X-Google-Smtp-Source: APXvYqwyiJ4CShgCva1aHDb9OaW+SaBP+3Mjz6V/AfG/14A+ll0S9UPgGeR8jG6GaIzIwyi/fU8qqw==
X-Received: by 2002:a5d:4047:: with SMTP id w7mr19242902wrp.270.1571655506394;
        Mon, 21 Oct 2019 03:58:26 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/9] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
Date:   Mon, 21 Oct 2019 11:58:14 +0100
Message-Id: <20191021105822.20271-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most contexts '-1' doesn't really mean much to the casual observer.
In almost all cases, it's better to use a human readable define.  In
this case PLATFORM_DEVID_* defines have already been provided for this
purpose.

While we're here, let's be specific about the 'MFD devices' which
failed.  It will help when trying to distinguish which of the 2 sets
of sub-devices we actually failed to register.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index f1825c0ccbd0..2c47afc22d24 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		cs5535_mfd_cells[i].id = 0;
 	}
 
-	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
 			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
 	if (err) {
-		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
+		dev_err(&pdev->dev,
+			"Failed to add CS5532 sub-devices: %d\n", err);
 		goto err_disable;
 	}
 
-- 
2.17.1

