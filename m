Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF3C247C2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186311;
	bh=J1/zFimrRNrrH5QrRbJW90QONc3c99bq6Evf4sxsOX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BDzUz6TlqytdaJDi4Tx7ZjOpaKWT18XojxbHh39TrE3yKio1ZxR5lXD6RJwIlEfeN
	 YcGRROqjxCanMClgawirDAivsTFu4W8spJyqRDBDX0RpuK6+bYmi1DGWNp1tSw8FyK
	 oBLG/JfvNBV3rf7Uc7vSKRU1BW/EjRK3Fw6ATM6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfE3DSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfE3DOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:37 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C3B24555;
        Thu, 30 May 2019 03:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186076;
        bh=J1/zFimrRNrrH5QrRbJW90QONc3c99bq6Evf4sxsOX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teV+2PtSjyF5tRf8J4StKgpcA2qG80JdFF1ivZG1FUeBzvf0cTcqCzMxBU6qlMRHw
         0630WevlojHZlqzVmO1IxZpThdF03Q4mZeNvUcfmqvH4dkxmtBS75CeYm0fmg8WqVq
         3xnyXkRT3zSoY3/qRx3EuDKib4UgjFJzD5bLY7ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 193/346] PM / core: Propagate dev->power.wakeup_path when no callbacks
Date:   Wed, 29 May 2019 20:04:26 -0700
Message-Id: <20190530030550.847848011@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
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
index 0992e67e862b7..7900debc5ce44 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1738,6 +1738,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
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



