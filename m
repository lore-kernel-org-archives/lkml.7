Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51089C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D692075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RyZTbPqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfDPD1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:27:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32854 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDPD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:27:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so9611619pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmlI6g9TYW8s9NJZuspqqo5Sl2BAimkc11hCfEPXgnI=;
        b=RyZTbPqFkczI3MkRFTa6hm6waWq6C5FRhyrM6IR5dzNJxwIhbGXqNBo+s1sayOEwGb
         ijeu6XzT37778x/MK6KW+XxiTiWI2gOqq+hpGWp442Qy8n/Y14wOgpLgBi2Vtt473ciS
         e2UNfhuYJD6nJJylSC1a70+2yYVtDd5u1+17s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmlI6g9TYW8s9NJZuspqqo5Sl2BAimkc11hCfEPXgnI=;
        b=eXcvBzbD8INZOg1E6gtejTqA2BnorrMRCEfLIT/bwiNEdi9dccbzS5/y1SZX3dPWvx
         j/GGgyoWe8EM8rkUJUXP1doNq4bqECqH9lbC8xDZSXGmLxIrKJ40pKb08adx+oxATOmH
         liN6NJZacCSynwLjENXEcz4jo1o5uI8k7P5J5vaoiQXLx4Y6iv7OLZ6wNbAuTnCGwd2H
         sIUDAIlXaSI/4vJ0rleFEpol2nYWB7RtYtSQUyOXVQsndNfUVbcTFR+Nt2YMA/a6UmL+
         06nVKO1dECxsB7Jdu3upfmG388xe8dvg3YZyyIsmjF/nixCNy2xRRIE8xCOuhEEz+LfI
         Ysvw==
X-Gm-Message-State: APjAAAXawONZDKU/8FbYEhpyKE73t9I0tuRMdnuBXFJr2wBpHTnQnyXp
        6tPKT0C0S0SrmjXg5H5C38t50aPQU2CUAg==
X-Google-Smtp-Source: APXvYqwwHSxrRM9RgUsNFZXCwYH3I7R/+zfFIBipzMpv/ilNii36K6iG0vo5m7CFek0hRznMfdgsJw==
X-Received: by 2002:a63:384:: with SMTP id 126mr69200212pgd.341.1555385270489;
        Mon, 15 Apr 2019 20:27:50 -0700 (PDT)
Received: from evgreen-glaptop.corp.google.com ([2401:fa00:41:41:3bee:65a3:bbc3:212f])
        by smtp.gmail.com with ESMTPSA id y12sm119997258pgq.64.2019.04.15.20.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 20:27:49 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake
Date:   Mon, 15 Apr 2019 20:27:43 -0700
Message-Id: <20190416032743.180517-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI IDs for SPI on Comet Lake.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b6ddba833d021..493223e1d032d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1451,6 +1451,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
+	/* CML-LP */
+	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1

