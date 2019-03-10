Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09F9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC5220657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPiHBiOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCJS6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:58:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34380 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:58:35 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so1061987ioh.1;
        Sun, 10 Mar 2019 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yqC4zt3nEa3xfmEsElEgoM7DbcmfILE263nXYl1T67A=;
        b=HPiHBiOxqn5IGYqU7rMfGrZNDUDLK2g5yq67pEwgan135b0L8aTkEwaojqxNdF+OUz
         WvOG+2SdKbklBN9g/5WO+rHtxg7dbb2m+CZyciIWfXokjvpFKuube2AC3bqRyZJRUpoZ
         kXUi+IpHEZhli64iJqVdeH8oCxhyT/IAOb6wO8yfnrbJctkyTQlxAE0Xi2NcVXIe6wdo
         RbM7iqsbLzp5ODWLJVdn2FPkxYmDD4lknJrRj73iORFLbtyHPwQT5l+908SbcM1Uxyun
         jlrAhxVO0eXDvrIc94YiCGI8UAhw/pKvDAqbQb5Hcxy0R/FzB3iCbJ5HAhQ9Vm652EYP
         irHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yqC4zt3nEa3xfmEsElEgoM7DbcmfILE263nXYl1T67A=;
        b=fQ+YvLdtahs9pxlMKKgQ6CsgQNNK81oZFl/Oi/f4joDtGOLkhhmKY7oY2DkydUbbE2
         NxAVZUmPab17RzfMZAuhgeV6xExinT/DqIesAjmewhNCK15KBNtc6clt5sks0C7X4RYj
         P/TRrW18mgNXThMcEyXtPDvEFamXq8k2FQ0a6Md4aYQ2s3CKc3A2MCZ+h9DJVNLhao3T
         jOyUJFYh92VyG1nP2klsqpIIHl/QJb+GtoioGK/gi0umdEMf+EUNZmiYluOfrJXlJwaI
         FkI+fzsPfuZef8XJVTQ3RMSaHTF54IkG7aG0FWl3NmzCTzmw8ZhF4gckQy0yQftE8JnY
         0c5w==
X-Gm-Message-State: APjAAAXD0WUVEIRzJdosdejIObe9/xZgft7BeTGfN+IkXWivkT6GI6fq
        PfeY8lgeGCVWO/8AdJ3zZOQ=
X-Google-Smtp-Source: APXvYqw24O91l34LCLCNpO32ZisLz+346P+TCpOrrUXbLgtobmlaeJQ4n2Pj1hviFvnJvAhox6e5IQ==
X-Received: by 2002:a6b:7847:: with SMTP id h7mr14509934iop.83.1552244314370;
        Sun, 10 Mar 2019 11:58:34 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id y18sm1359270ioa.56.2019.03.10.11.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:58:33 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: xilinx: fix potential use-after-free on remove
Date:   Sun, 10 Mar 2019 14:58:24 -0400
Message-Id: <20190310185826.25916-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cancel_delayed_work() returns, the delayed work may still
be running. This means that the core could potentially free
the private structure (struct xadc) while the delayed work
is still using it. This is a potential use-after-free.

Fix by calling cancel_delayed_work_sync(), which waits for
any residual work to finish before returning.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 3f6be5ac049a..1960694e8007 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1320,7 +1320,7 @@ static int xadc_remove(struct platform_device *pdev)
 	}
 	free_irq(xadc->irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
-	cancel_delayed_work(&xadc->zynq_unmask_work);
+	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
 	kfree(indio_dev->channels);
 
-- 
2.17.1

