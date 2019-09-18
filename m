Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98482C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94A207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUltYfIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbfIRRT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:19:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38885 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbfIRRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:19:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so418111pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Uy6bHHevUENAulkqSQtPk+BZ1l0ipc3uMDtQFYz2nQ=;
        b=fUltYfIHMIOjnGd1FS6BZiNa/6sr2uKEIzz7Km04e6IE93VkMueUYltt3JEHNNMed1
         GQRuxifsOhM9iy6QFfjHwj5jaUiX3QsJHwCb9hKSyT0mAeqdcDs9/ajmOcMrgjTnntfh
         MuRVkkBgPraBP+jhxCtecPZoou+N86UCV+33hwtlyvZfuoOtA0EbncL9o39XLbqVd6I9
         3Kg49BtFHgGwGEp4UMyN1ypdjImD87vMg/gWcEbN4c7Q86aX4C3vTbB5HbKi9hjaqPtq
         2h1Yj5ChS0HnM9jwMmeHYwddXhW14mb+g0jXmXjUb2lJQQov7Qcyp0X7vLD0dfDJ7xdN
         fnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Uy6bHHevUENAulkqSQtPk+BZ1l0ipc3uMDtQFYz2nQ=;
        b=b7cpB3isz2LtY/ks7HXwygFkmIU+wV5LBifwGyxQuvXtxDjr1uZ7AlPYbXJPec3swi
         8lid+v5kr2XcGdles7u2+dtPIHdCtUD+Vs906E8O34mpI3MZYFmhvHBdPZMT5ZIbfefi
         HiOJkGbdDeLSOBA8BiMCVIO3mJJn2yUfytZoZgjCWlSSg9S+NusSform+MVGeXmB/Cx7
         umQ63VCbXWmvY+SsdovI4/CoRZT5/Qa5QkncJoYAtdXiNWtV8I3L8WYsSv0TySuSm9ws
         ccm2I9ISCml+fx9npZGxbzp9jaevmk1loi7NHACvWgmFmOCYKtwOfzP/FXBjbu6Jj6rL
         Ttjg==
X-Gm-Message-State: APjAAAXhfkFxIY3H10RxwzsousfTHGoRszwzlrM+IhJQ7RpfU7kkzdot
        3qTWRz/M7FwzE9kAFxXnGmeskA==
X-Google-Smtp-Source: APXvYqzUBAdLgS6iTt8bHDfY8QFjRB3LWD0ZA7+0XCI2Z/UvIRKaIlHhFvg+rPfjmsmeW771XqxKXg==
X-Received: by 2002:a62:db84:: with SMTP id f126mr5532642pfg.25.1568827165043;
        Wed, 18 Sep 2019 10:19:25 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4sm2614981pjn.19.2019.09.18.10.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:19:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 4/6] rpmsg: glink: Fix rpmsg_register_device err handling
Date:   Wed, 18 Sep 2019 10:19:14 -0700
Message-Id: <20190918171916.4039-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190918171916.4039-1-bjorn.andersson@linaro.org>
References: <20190918171916.4039-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

The device release function is set before registering with rpmsg. If
rpmsg registration fails, the framework will call device_put(), which
invokes the release function. The channel create logic does not need to
free rpdev if rpmsg_register_device() fails and release is called.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 21fd2ae5f7f1..89e02baea2d0 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1423,15 +1423,13 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 
 		ret = rpmsg_register_device(rpdev);
 		if (ret)
-			goto free_rpdev;
+			goto rcid_remove;
 
 		channel->rpdev = rpdev;
 	}
 
 	return 0;
 
-free_rpdev:
-	kfree(rpdev);
 rcid_remove:
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_remove(&glink->rcids, channel->rcid);
-- 
2.18.0

