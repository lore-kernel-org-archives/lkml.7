Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECDEC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C2E21926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSyicQVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGXNSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:18:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43149 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGXNSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:18:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so20955205pfg.10;
        Wed, 24 Jul 2019 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQG2eHs7d/jEQNZdhaaQxZqRLlvGRTN9PHj+B+aWods=;
        b=mSyicQVhuxp5RfTuWIlsi3I2S7iMekb4AMI28k+2m/G7MrUeYHu2V67tpE3drpIuQA
         hhRDQ3mr7oHwEPhkPpy1r+GCKpDHm4x/XiKu9pFssgoi/MZ47unyvL5KAZysXsG6Wveo
         cdm6A5suSH7efFMEd9ZimNUdGBr9hr0PQgjXwMqz3q11524QXS5ugOuCn3gO8l6gKBfY
         Rj+cOR2oJfZZoyPTYEEXRRY+w5dV5rMP0krQXAatRetQVx/04r4Usm3DK6ImYhpFYwn2
         c1WJxbKY8RKs0CUNe0ceZPpdBjQQGFhN5KDXblJwugkUAek1vBg7julg3a7Uxg9vPTKW
         TuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQG2eHs7d/jEQNZdhaaQxZqRLlvGRTN9PHj+B+aWods=;
        b=nfsra4OtXclJNOHEIVI+t4dSsjeJfK9ACBXhrNvybjTWZsNhwrVO2TMYKIiWnDrjBs
         j8egN4hDDX0xLhC9YP2lmB6174l+AP0QwLOVNJhJRYC+M2Qk3P9lRvMqb3m9lpAxdBSu
         2hu4NnAOVVIKoWKK6RFi4W4Wuqceu5pb/ARlUeUtWhFURIpHRFp/GNyvFs9Hn472EsgG
         q2VC5Qcl0BHkz/SgvNs1IgTA5XM5gRgGLfySNG/OuVPilREj2oNorRggZo2iiHX8AmH9
         s3k32eMMQfaPw1zl/BPKLhP8rE2M1SIu7UUSt8l/OzEUZqCq8DHOEwoWtQqrVke9fJyL
         YTfw==
X-Gm-Message-State: APjAAAUrnOp9oHRUm3ZlUe03VUCXR3dV46F040bNUI6wkJB2Ia3WMMPZ
        Zwby4Dff7DKMfLbZurexwqO3tsZXWQw=
X-Google-Smtp-Source: APXvYqyc3HgDcn5q+48BQzPuIRU9pWJKo7NoNkXpidsgmu4rmMuhz1xWVUPWqzXtfkFFjtyFJrp6cg==
X-Received: by 2002:a65:5043:: with SMTP id k3mr23620512pgo.406.1563974322551;
        Wed, 24 Jul 2019 06:18:42 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id p20sm72562330pgj.47.2019.07.24.06.18.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:18:41 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] USB: core: hcd-pci: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 21:18:38 +0800
Message-Id: <20190724131838.1931-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/usb/core/hcd-pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 03432467b05f..03bee698d7eb 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -407,8 +407,7 @@ static inline void powermac_set_asic(struct pci_dev *pci_dev, int enable)
 
 static int check_root_hub_suspended(struct device *dev)
 {
-	struct pci_dev		*pci_dev = to_pci_dev(dev);
-	struct usb_hcd		*hcd = pci_get_drvdata(pci_dev);
+	struct usb_hcd		*hcd = dev_get_drvdata(dev);
 
 	if (HCD_RH_RUNNING(hcd)) {
 		dev_warn(dev, "Root hub is not suspended\n");
-- 
2.20.1

