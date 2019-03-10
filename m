Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56762C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23009206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 19:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CefmRJ5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfCJTdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 15:33:00 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36745 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfCJTdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 15:33:00 -0400
Received: by mail-it1-f195.google.com with SMTP id v83so4034880itf.1;
        Sun, 10 Mar 2019 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u+DoI4sI+hMVW166TNGuic0psX3hAbOUaR7E0HZK7I0=;
        b=CefmRJ5jnqnTC6+suGK+V3lL5Fdyf3x20xpF2m1h0Yp/4na6BEJsEVwe0c+ReE88TJ
         ePoMYjY0fpr/4IePni2vJFisQPxx5t+FiHG9S2yJXODhIDY5nr17Qiln+EY1pYKUhOws
         wWe/+PCSXV1O8DnAK9P/+HC2LussSXnDVGFVwkWUtKP9zmWkBca1WKHKSxIpLI4DvMsT
         fN+o0mF48unpUnzO0qWh7TUA5C7hr48KoaDkOTr6z99mCV3/1BBNjSTEaO53ZU5VHXQi
         rotkgR4rjtPtlW+nobzBHp+/oe3cc7Q1+2fKoVjqv0xAlQEKuTfIYDpAQJqB85UtX4rW
         vXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u+DoI4sI+hMVW166TNGuic0psX3hAbOUaR7E0HZK7I0=;
        b=nrTMph6DntEqGyMenog4KKrehjpvJCxnmgn6OcWjIJfAvCiEtENn1F1OahLCB0G5hb
         guBJi4mLtQCgCtY9Dj+26KHdUXpm28aTMYpyGyphBubr1JhszsPaxZ7mH9uz+Kxi+rJ/
         bdF5GF6K1INpt1Li3t7QataEDe9WEtnfrfmpwsu5fyTnxXgp2bc1FTmHHE8b8iD/idGD
         eMmtFwzQq41P9OZWwYn4vjZKKtlJ27lOkz7O2kjp+mRE6UGztVc/nTRr9KcXJBjdCBxg
         DraYbN/dY5QCDbs1vA2sJa/wDgnY4anfJVx2ckiU0c9jWEz8yvGO+v8j21AHaK55GI9K
         UDtA==
X-Gm-Message-State: APjAAAXqmTpvHdm/eI2BvNmhdUi7592sPpm8ny8RWfLnI/bNedLugd+h
        vpySIi4JDpKpZZ4WgPeWpVs=
X-Google-Smtp-Source: APXvYqydBApxDLyKgcWQWctp+hyrCtPmRfUuwKSXCeeunLwJja/XvGr7WBg2/bGL8Tgy8rh0AwRn2w==
X-Received: by 2002:a24:21d5:: with SMTP id e204mr14309614ita.56.1552246379241;
        Sun, 10 Mar 2019 12:32:59 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id w74sm7160856itb.44.2019.03.10.12.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 12:32:58 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: envelope-detector: fix use-after-free on device remove
Date:   Sun, 10 Mar 2019 15:32:46 -0400
Message-Id: <20190310193246.31761-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver's remove path never explicitly cancels the
delayed work. So it is possible for the delayed work to
run after the core has freed the private structure
(struct envelope). This is a potential use-after-free.

Fix by adding a devm_add_action callback to the remove
path, called right after iio_device_unregister(), which
explicitly cancels the delayed work.

This issue was detected with the help of Coccinelle.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/iio/adc/envelope-detector.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 2f2b563c1162..2f1c78b3ff44 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -321,6 +321,14 @@ static const struct iio_info envelope_detector_info = {
 	.read_raw = &envelope_detector_read_raw,
 };
 
+static void envelope_detector_stop_work(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct envelope *env = iio_priv(indio_dev);
+
+	cancel_delayed_work_sync(&env->comp_timeout);
+}
+
 static int envelope_detector_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -395,6 +403,10 @@ static int envelope_detector_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action(dev, envelope_detector_stop_work, indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.17.1

