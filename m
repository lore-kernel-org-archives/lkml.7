Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D034C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E3520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQADIp2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfGPFDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 01:03:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfGPFDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 01:03:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so2490930pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 22:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XuPh1ec5nyWI9lzxp+dj0MV4o3EuhJcXc845yk8LJjk=;
        b=fQADIp2YgdYHdH1vX7+wb+Xf44XKPz90A4MQaawD9H4et04YyTumC1Vl+ZA5hbQSJz
         GWhkkNiFU5CD4DeVwbcshRHJ35gDgWgT1I13VRIuvRyRmnS31qL+OnyYS/FGN9YNsCro
         vDld9SXrbOgd9AxZaqULs6MMDYonX6w3aD4GsgE7Aw9laYfMCvIoHq/u9uEdghNPiDbS
         hDHY/IVeemd9h3/7ermIDO/1DTGlCIL0PQyWsQd3epqzzK/d7tS0fXdghZcdw6NErEFx
         kyzYlFF7CqBCFfVtwyKzRFdDml26ZhEUDgwGfNgH9cm0VZVb5Yr8p4t4wVezkcIAgzUN
         T3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XuPh1ec5nyWI9lzxp+dj0MV4o3EuhJcXc845yk8LJjk=;
        b=FboKnasoE5M9t47En0elKqlg7lOn2wpl/hgrwX0DCU5Nsv5HZVSxAbmsqHdu7OMKi5
         TlNn+cLaPFBMvzxeekKMtMD1NPUm1Lk4BiORsvGI6cmotTdlx/Eix8A8EqE0eey9Q+2N
         b2YWWU5B6hUwzd3prfWRKq04Cbh8KVH3xOLlJsHu2yu/kus4WjfQYUQ6Ee025W6R7UVw
         gZ86kEXWRyAx0wiBJrleZD9mYtJar7QUFnEMzbh7f3dO9RSXQAe9obYOTckf3YauIryj
         3Gp1R7HJSGzzfNRaFyukxf2w2CtmiqTbrs/cMripAjMCj/B+96i3uTMdfc/wJ+lZb8Xr
         mFtg==
X-Gm-Message-State: APjAAAXTOBNQE+vazx28KmJMBp9KYjJ6bMUER73+27VC7SM4iJLgBmTg
        ZnU99LV/wX7Au5lMA1233tuMJw==
X-Google-Smtp-Source: APXvYqzI8VHfkqwCCD5Y4gUoyXvCjlVeGNhjcHrJUOtCmXjX/eamvM/OJL/hY9jIB0VNLLNw1gSdCQ==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr32606625pjc.23.1563253411592;
        Mon, 15 Jul 2019 22:03:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j20sm18434336pfr.113.2019.07.15.22.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 22:03:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>
Subject: [PATCH] remoteproc: qcom: Move glink_ssr notification after stop
Date:   Mon, 15 Jul 2019 22:03:27 -0700
Message-Id: <20190716050327.8866-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glink_ssr is used to signal a remote processor "A" about the stopping of
another remote processor "B", so that in the event that remote processor
B is ever booted again the fifos of the glink channel between A and B is
in a known state.

But if remote processor A receives this notification before B is
actually stopped the newly reset fifo indices will be interpreted as
there being "data" on the channel and either side of the channel will
enter a fatal error handler.

Move the glink_ssr notification to the "unprepare" state of the
rproc_subdev to avoid this issue.

This has the side effect of us not notifying the dying remote processor
itself about its fate, which has been seen to block in certain resource
constraint scenarios.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 6a448429f223..60650bcc8c67 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -200,7 +200,7 @@ void qcom_unregister_ssr_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
 
-static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
+static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
 
@@ -220,7 +220,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 			 const char *ssr_name)
 {
 	ssr->name = ssr_name;
-	ssr->subdev.stop = ssr_notify_stop;
+	ssr->subdev.unprepare = ssr_notify_unprepare;
 
 	rproc_add_subdev(rproc, &ssr->subdev);
 }
-- 
2.18.0

