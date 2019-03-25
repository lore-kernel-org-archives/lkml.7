Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE6420883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eDufYQDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfCYDIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:08:50 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50504 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfCYDIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:08:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 07527A2B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1lvpOo0p0_6o for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 22:08:47 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id CF58087A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:08:47 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id l140so161221ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 20:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Utn6p4nXLnOYm10umWeaqQUkhCCUuB5hzL6kg2hYEmM=;
        b=eDufYQDoYJPyELpBqbKdy6X1BZycmmqecSbFmIHGOwWPz5PXBZrFWrVGa1mmWUKpXA
         RL+ZY//z37BwoJlMF5crVLAjECjlTXOn7A+5MiNPdfdcC+rRBUZBlH5CFcBriv5N4GL9
         orzVii7I4jr/Pv7gYacfNcNihtl/VBH/wRh3ySdaQwvg6UxyHVkprJ2VtPF3rrRM+UnQ
         6WgbFpYvtzeSMdK8s1yvYnm7CGSKpH3mkoXv+lkNQ77qz+ktPk4go9Kaa6jcpu7IMz8U
         1kss7fVrjS1xD+Xxa3mx2bThRgITyQSYWcLLLOvb5J70Hgzkx7Pv8dliZ+WJLPxFOhhd
         TAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Utn6p4nXLnOYm10umWeaqQUkhCCUuB5hzL6kg2hYEmM=;
        b=WfQk5I2W9eKB6eXEHtxYxQv+Yw4odVAWu1NRDIJUQME7MNojl4FYLqNKLQgEkZOQ/A
         dxzfVDY80Wuznkw/KqVChEIRqlTr0SYnIpOFDqqTWSaL68uLrymJ+wOcTO6l4yxgjdIL
         8S6DGaHZk21JLFQxBoX+bghng49l4L7+zYASlSfgcIW6h6Rhqs3ObsGCF8R8lYUahMrn
         LwPKTrxdggW94jd5hxgfb7JpPEG0gve917/kWnb/PpGvqmXVcdX3AibDJ1v5rx1jp6SY
         th5T8h0FOC2+zesBUDYxFeiZGPmgnNFjmoQ+lJundJCmrClfVelN4jzrZ6yulntsmvWN
         f9eg==
X-Gm-Message-State: APjAAAXd+FP0hHfmSBtAl//OMfSOSVvV0Zhk8fKzve8Ln7FPgSKjmz/a
        /ixXFeS1V4J48xniLTmyEKyWGnw1Ry/hvJ4rWkNNt+rbwBhUdYIxTvEjyOn6W9AoyJjlj3HCicB
        rAh81zPEJ42W5Wb8f4Hkim/2IMd2B
X-Received: by 2002:a24:e184:: with SMTP id n126mr2277455ith.155.1553483327462;
        Sun, 24 Mar 2019 20:08:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw63D7THsrLkUYpPUONKKVreVq+l5pvnayYwoz3KyVVpCEC1v89KLzn80VcJBgBknZQLyCLUw==
X-Received: by 2002:a24:e184:: with SMTP id n126mr2277442ith.155.1553483327182;
        Sun, 24 Mar 2019 20:08:47 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id m137sm4316394itb.27.2019.03.24.20.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 20:08:46 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: sierra: fix a missing check of device_create_file
Date:   Sun, 24 Mar 2019 22:08:28 -0500
Message-Id: <20190325030828.14068-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190324223920.961-1-kjlu@umn.edu>
References: <20190324223920.961-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_create_file() could fail and return an error code. The fix
captures the error and returns the error code upstream in case it
indeed failed.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/usb/storage/sierra_ms.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index 6ac60abd2e15..e605cbc3d8bf 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -194,8 +194,6 @@ int sierra_ms_init(struct us_data *us)
 		kfree(swocInfo);
 	}
 complete:
-	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
-
-	return 0;
+	return device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
 }
 
-- 
2.17.1

