Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BDFC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BE2217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o0PT76bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfDRDDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:03:14 -0400
Received: from m50-132.163.com ([123.125.50.132]:32831 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbfDRDDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Cw1Kp4F8rudsIsH9nr
        z8PZXrCFnjTmyP6A82n35dok0=; b=o0PT76bd1p1tJzGfQILHvbV9ZGToYSjjbj
        3x30oZgksw7iShvxiXQK9J1h1OK+6JX08peE/W/LstFGtEyR7SGaynlv/vLLexAW
        ifAFa1duxrIoQOOa2QqpaA15RprbrPfEudCgnOlpRQ8uK+165rDPNcbjkG1TRlZn
        wPfUSD/iA=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp2 (Coremail) with SMTP id DNGowAD3SY7h6Ldc4YNNAA--.119S3;
        Thu, 18 Apr 2019 11:02:59 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: iio: dummy_evgen: fix possible memleak in evgen init
Date:   Thu, 18 Apr 2019 11:02:56 +0800
Message-Id: <1555556576-6927-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowAD3SY7h6Ldc4YNNAA--.119S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy7ZFyxAr1kJFWDCrWrGrg_yoWfCFX_WF
        1FvF97XF1fGa1UKr45AF43ZrWFkayjvFs3JF17tF1fGF9YqFn7ZFWDXrZ8tr4DWw4Ygryv
        gr4Utrn2ya1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjtfH5UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQOaclaD2Iam6gAAs9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory allocated in the function iio_dummy_evgen_create is not
released if it fails to add the evgen device to device hierarchy. This
may result in a memory leak bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iio/dummy/iio_dummy_evgen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index efd0005..f96c0a3 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -196,7 +196,10 @@ static __init int iio_dummy_evgen_init(void)
 		return ret;
 	device_initialize(&iio_evgen_dev);
 	dev_set_name(&iio_evgen_dev, "iio_evgen");
-	return device_add(&iio_evgen_dev);
+	ret = device_add(&iio_evgen_dev);
+	if (ret)
+		put_device(&iio_evgen_dev);
+	return ret;
 }
 module_init(iio_dummy_evgen_init);
 
-- 
2.7.4


