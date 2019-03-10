Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F68C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F45020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEcm4H+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCJS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:58:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40009 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCJS6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:58:37 -0400
Received: by mail-io1-f67.google.com with SMTP id p17so2127174iol.7;
        Sun, 10 Mar 2019 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AKnYvAqiueyTkKUcdTkd4DRK5HdxIHd2jyBD4bgdo24=;
        b=LEcm4H+N5lKvwRTSirKOLAz0B20Ev2XEim3/Zz8A/npstz0aaynTtwhYqEsMzXVPF2
         u0Wd0Av59wTMsOaJx9LLvq6J7NyGgpEwY7vNrws6dNwm/tp8GtsJ1PBxDMs7S8PdRmpd
         k64uvCARYN6yYomorJRuume0v5a2hjcr3SK4CvW7auUnIXnhGDDAHHcDVtQJzQngf7SC
         s5v0EKAXNQfSxOz2G1f76W/5NJxoN25YHbA9z7PzoyvFYikMJvRr57vqyMMeI0BzIvSF
         pTdMd5ZuAP0pn8d1TY9D3Us08vCRYytQQZJI8NnHkhUpXa7jjdWPoQs6zz8FEAg01Dhv
         zRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AKnYvAqiueyTkKUcdTkd4DRK5HdxIHd2jyBD4bgdo24=;
        b=YCk2gF0pQl76UftKB7BwHUj1OpaohcejicMgl3IrwYAuoxorf3Qp2K0fpmQyJW+JpC
         /ArPIFkIt8Mu4zkYeNY4cO1wcnFNuEh9sPLLtzo2ts0blBI9gYvRhd2mzO5V1ApmNofE
         k988pMzSvJQIOEnMP38nEtiUWZwJ1ow9hR6HY1oyaF8auD8TZTWMKHlywt1x1suvgzDR
         KqG5l5zSlVf+UvwPzgFsnFIm9pgvOvNFyzSKI0hgad/yLBHjm3ClwWeHdAXLDuZOujAc
         k8F3kCPr4Dr0VAIB8Mt3S1p8kDyecXL4Tpx8whVkK8eO1wnL6m9VQalJTJND6RdRFv5+
         mTiQ==
X-Gm-Message-State: APjAAAUQEha+lXA5gzE+4EXDdVRnragnhIrWT4XV9TkuhCMSigPNo/+P
        FSJVjp9ab22xycZhUw/ngpk=
X-Google-Smtp-Source: APXvYqy9VrS0bd+iQ9v7QZ4H98ZpTtpJnlQx6I9TmGD6jxLSQ+Fbofc/4zoq4KxCxZfTr4halfn6ag==
X-Received: by 2002:a5e:d819:: with SMTP id l25mr13651049iok.27.1552244316537;
        Sun, 10 Mar 2019 11:58:36 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id y18sm1359270ioa.56.2019.03.10.11.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:58:36 -0700 (PDT)
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
Subject: [PATCH 3/3] iio: adc: xilinx: prevent touching unclocked h/w on remove
Date:   Sun, 10 Mar 2019 14:58:26 -0400
Message-Id: <20190310185826.25916-3-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190310185826.25916-1-TheSven73@gmail.com>
References: <20190310185826.25916-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In remove, the clock is disabled before canceling the
delayed work. This means that the delayed work may be
touching unclocked hardware.

Fix by disabling the clock after the delayed work is
fully canceled. This is consistent with the probe error
path order.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 15e1a103f37d..1ae86e7359f7 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1320,8 +1320,8 @@ static int xadc_remove(struct platform_device *pdev)
 		iio_triggered_buffer_cleanup(indio_dev);
 	}
 	free_irq(xadc->irq, indio_dev);
-	clk_disable_unprepare(xadc->clk);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
+	clk_disable_unprepare(xadc->clk);
 	kfree(xadc->data);
 	kfree(indio_dev->channels);
 
-- 
2.17.1

