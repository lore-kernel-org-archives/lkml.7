Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8338CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5124720882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=laposte.net header.i=@laposte.net header.b="HQqAVYnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfCaSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:54:42 -0400
Received: from smtpoutz24.laposte.net ([194.117.213.99]:37910 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731241AbfCaSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:54:42 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 801671637FD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 20:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1554058478; bh=3ObRabcrAxzcPUSt8FNEMa78if3MPuasUhfnOdvrkKk=;
        h=From:To:Cc:Subject:Date;
        b=HQqAVYnN4OGn65Fb/O3lcEWhOddr5jmrv2Wssyemngzg/1JXft2xHu5F9LeufVmxV
         tb2miBdDfxwJ/EO1zAsQm6/gnKW6cbGCKaFkA5Vy+M4tU9N6NRMnwRlojiNMbNj7K5
         j5en0rv97ypZiF2wqdeFsseNRAA+HgsMCd7wsAyByz55ILHlanF/fb+vgOgD2owIsl
         rRIOubTT0r5jgAb/+FJSdQb1p/YOLDI48Eu1AgVFg9f8DmTYcD7grzHRgB3ej7hV43
         j3o9SslyuGdFRv/+hyeuNcFbdiks06foIsdr4m1wslpZVDeTJjQLQ4kUZxKuana5g0
         Jm12aEuc5L8uA==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 706F1163841
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 20:54:38 +0200 (CEST)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.prosodie [10.128.63.5])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 6B5BD1637FD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 20:54:38 +0200 (CEST)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
        by lpn-prd-vrin004 (Postfix) with ESMTP id 5A2CE728EE9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 20:54:38 +0200 (CEST)
Received: from romuald.bergerie (rqp06-1-88-178-86-202.fbx.proxad.net [88.178.86.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by lpn-prd-vrin004 (Postfix) with ESMTPSA id F3084728EEC;
        Sun, 31 Mar 2019 20:54:37 +0200 (CEST)
Received: from radicelle.bergerie (radicelle.bergerie [192.168.124.12])
        by romuald.bergerie (Postfix) with ESMTPS id 2035D2E25AFB;
        Sun, 31 Mar 2019 20:54:37 +0200 (CEST)
Received: from vincent by radicelle.bergerie with local (Exim 4.92)
        (envelope-from <vincent@radicelle.bergerie>)
        id 1hAfbI-0005i8-VN; Sun, 31 Mar 2019 20:54:36 +0200
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Dan Murphy <dmurphy@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: ads124: avoid buffer overflow
Date:   Sun, 31 Mar 2019 20:54:23 +0200
Message-Id: <20190331185423.11749-1-vincent.stehle@laposte.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedutddrledvgddufeduucetufdoteggodetrfdotffvucfrrhho
X-VR-Cause-2: fhhilhgvmecunfetrffquffvgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhht
X-VR-Cause-3: shculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepgghi
X-VR-Cause-4: nhgtvghnthcuufhtvghhlhoruceovhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvght
X-VR-Cause-5: qeenucfkphepkeekrddujeekrdekiedrvddtvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdp
X-VR-Cause-6: ihhnvghtpeekkedrudejkedrkeeirddvtddvpdhhvghloheprhhomhhurghlugdrsggvrhhgvghrihgv
X-VR-Cause-7: pdhmrghilhhfrhhomhepvhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtpdhrtghp
X-VR-Cause-8: thhtoheplfhonhgrthhhrghnrdevrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehv
X-VR-Cause-9: ihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopegumhhurhhphhih
X-VR-Cause-10: sehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VR-Cause-11: pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehl
X-VR-Cause-12: uhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing the priv->data array starting from index 1, there is one
less element to consider than when initializing the full array.

Fixes: e717f8c6dfec8f76 ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads124s08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 53f17e4f2f230..552c2be8d87ad 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -202,7 +202,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
 	};
 
 	priv->data[0] = ADS124S08_CMD_RDATA;
-	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
+	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data) - 1);
 
 	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
 	if (ret < 0)
-- 
2.20.1

