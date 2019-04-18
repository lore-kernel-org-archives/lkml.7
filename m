Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149FDC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CFE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BTif/b8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfDRB7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:59:35 -0400
Received: from m50-134.163.com ([123.125.50.134]:42983 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbfDRB7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=tH6E7FoBnszZj55i5i
        9lHvJ8Y0KxCuAXuPMwnApoTE0=; b=BTif/b8wk1XVp4we6YgGyE/HTPjVOoH3IT
        BXyKZI4htL4DNVCBnwJ9hKrisLo2/ylW0sEsVdNT4+UhHgIHe/gAQsIy+j1BdctI
        1HiDVZ9E0BuwZcSL71+M6NyFTsw1xJJcv7JVxXZCrYPPfKYZ9IuohSKKPo80aVws
        H1lMezBZE=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp4 (Coremail) with SMTP id DtGowABXsVLM2bdca969AA--.0S3;
        Thu, 18 Apr 2019 09:59:20 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Nick Dyer <nick@shmanahar.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: Input: synaptics-rmi4: fix possible double free
Date:   Thu, 18 Apr 2019 09:58:35 +0800
Message-Id: <1555552715-34820-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DtGowABXsVLM2bdca969AA--.0S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw47Ar45CrW7ZF4DXF1xGrg_yoWkGFXE9r
        WfJ3s7Xw4jkry8Wry7A39xZry0k3s0qFWfCr1Fq3s5Kr17Z3ykuwnrAr4qyr1DWw17A3Z0
        9Fy5Wr1kAw47WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjlfO3UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQB+aclSIaGwqEQAAsU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RMI4 function structure has been released in rmi_register_function
if error occurs. However, it will be released again in the function
rmi_create_function, which may result in a double-free bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/input/rmi4/rmi_driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index fc3ab93..7fb358f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -860,7 +860,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 
 	error = rmi_register_function(fn);
 	if (error)
-		goto err_put_fn;
+		return error;
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
@@ -870,10 +870,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	list_add_tail(&fn->node, &data->function_list);
 
 	return RMI_SCAN_CONTINUE;
-
-err_put_fn:
-	put_device(&fn->dev);
-	return error;
 }
 
 void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
-- 
2.7.4


