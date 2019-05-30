Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38083C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079FB25CCE
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191792;
	bh=wAoKdH08sGvXUO6NMdS4L0VCg3tFUqAm5C0tAAGgYXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IRZPwEEoQRfzJuhSekcz81wClpVF2FepfgrIZo8BzOs1IdCD9V83X5jSZrG6glMQW
	 rPobKjRpIdfRkS9Yw92HmGVnh+/eFNeSvl94GIknvXoJ2W3DCKnPbraoc49KJE0Dbq
	 nWuUmxf0ouUeRPxH3WcBRbhfPACIzZ9mMC/jXSkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfE3Etu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbfE3DLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:10 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556E3244E6;
        Thu, 30 May 2019 03:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185869;
        bh=wAoKdH08sGvXUO6NMdS4L0VCg3tFUqAm5C0tAAGgYXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMn8CuwzGNI+IFTO3bgEKdi0QIWrcbKakDZsqqb+DEE8sEr8p8U/ufxafO5q6Zu4O
         anThEJtqGr0SyYVSWi7zWZNzEGUgg7znkmvi8J8ciQoGTqkoJXSl+spFU7Ov2SGVNU
         aozIF7HKrL1xogCHdtD4+a/cbrfSjXZmxUxQUzHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 210/405] PM / core: Propagate dev->power.wakeup_path when no callbacks
Date:   Wed, 29 May 2019 20:03:28 -0700
Message-Id: <20190530030551.739793139@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dc351d4c5f4fe4d0f274d6d660227be0c3a03317 ]

The dev->power.direct_complete flag may become set in device_prepare() in
case the device don't have any PM callbacks (dev->power.no_pm_callbacks is
set). This leads to a broken behaviour, when there is child having wakeup
enabled and relies on its parent to be used in the wakeup path.

More precisely, when the direct complete path becomes selected for the
child in __device_suspend(), the propagation of the dev->power.wakeup_path
becomes skipped as well.

Let's address this problem, by checking if the device is a part the wakeup
path or has wakeup enabled, then prevent the direct complete path from
being used.

Reported-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ rjw: Comment cleanup ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f80d298de3fa4..8ad20ed0cb7c3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1747,6 +1747,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	/* Avoid direct_complete to let wakeup_path propagate. */
+	if (device_may_wakeup(dev) || dev->power.wakeup_path)
+		dev->power.direct_complete = false;
+
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
-- 
2.20.1



