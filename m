Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6DEC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C8E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N7gavrhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfEWCvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:51:33 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:42580 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfEWCvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:32 -0400
Received: by mail-pg1-f175.google.com with SMTP id e17so2156794pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fg/iHmx0B1Mv4Llb80mXau43v90pWA5HUyUPc2gShgg=;
        b=N7gavrhWEUw0x/OIpr76d/A/QEMOAExQ8CGX8SNEHzd2JYpT3BBsEN530r3g2yElpk
         wugcmhEbfKVTlhkWKEjCBVr3lU+rUfVMzJZSFvlX2W+k+T70pFHPUHfiK9lhtq5qYdh6
         SvnzqrkmEVoHcpfXIlsCgqzZds2/iFokvqmN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fg/iHmx0B1Mv4Llb80mXau43v90pWA5HUyUPc2gShgg=;
        b=SwZJpGv0YJeY4bQMJwXvwTwudyna/q0Mw+0eO5yXoSPci3bEzx0uxpoBW+fhE6+rVG
         SjQGIN4NeyFc2VrIghVxXIXkfZC4Zwns55g8xvjKfKTAFT8xe+jij9ZUXLwwzufrgX9L
         yIrGBAEDlfaCHBOz3MDFXGZTHNTy0x7v60lzo7DT77EWaL2BtpWdZYEzesNAMgsZqsHa
         V3TpBBbzdWFyrCe+oae5YxK6TZPuKQ+Cyhe8TI4Wuzl0vzLSYYfWFBBCI7aeUJV4ZS1C
         bhUCD4039OrhqydBeIdNyF3bYfg8TjgdeIl2mqhOPfGxnHvT0/LhzBKiE1WbUskcYHL0
         SvIg==
X-Gm-Message-State: APjAAAXKtpK7MdQ3O9xI9ky/iwuXGdOop2ZFiMkh6mFpcRZ4Q37scYrG
        GxwI9V3qlEmrnNZrwvwNc5CITQ==
X-Google-Smtp-Source: APXvYqyXG074m3md96HTSMqZH6wIifHHqDJmGnwXeGgSJ4ZhoMxIhAnPrKUyQBs+M9DIGdtK5+64qQ==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr100298494pfu.4.1558579891739;
        Wed, 22 May 2019 19:51:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q19sm42812174pff.96.2019.05.22.19.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:31 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 3/3] soc: qcom: mdt_loader: add offset to request_firmware_into_buf
Date:   Wed, 22 May 2019 19:51:13 -0700
Message-Id: <20190523025113.4605-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523025113.4605-1-scott.branden@broadcom.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust request_firmware_into_buf API to allow for portions
of firmware file to be read into a buffer.  mdt_loader still
retricts request fo whole file read into buffer.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/soc/qcom/mdt_loader.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 1c488024c698..ad20d159699c 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -172,8 +172,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		if (phdr->p_filesz) {
 			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
-			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
-							ptr, phdr->p_filesz);
+			ret = request_firmware_into_buf
+						(&seg_fw, fw_name, dev,
+						 ptr, phdr->p_filesz,
+						 0,
+						 KERNEL_PREAD_FLAG_WHOLE);
 			if (ret) {
 				dev_err(dev, "failed to load %s\n", fw_name);
 				break;
-- 
2.17.1

