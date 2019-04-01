Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D879C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7EB20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140749;
	bh=zZPhG5F5/OrS61Q+SRZCGay6spaiqmgMoLP8G0Ft98g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIHK8Vz1XRCf3eh04O3pvp3Jqw4DcD4GETEbAzdpIFzjGUWyxB4xiXWg/ZtIk7G/U
	 TeyvIG1mIi3+d1YB0NN+aZwUvOuEBLDsOBeqvnJ4H/5DivT17cA7YDFHo3FB39ZWTx
	 +eepuGO4miyb4E9PSwDOFQ/o/7ouKy6KHlJRoxyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfDAReB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732498AbfDARd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD57720880;
        Mon,  1 Apr 2019 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140036;
        bh=zZPhG5F5/OrS61Q+SRZCGay6spaiqmgMoLP8G0Ft98g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4f1BY0Dy++my/NiaS7RafSYuSCrjoRnd6JaQMgtQFbmM9jzaPLI72fxXCmPoHPpo
         ciTn/Bph9UWdXiuxMQb4VnE+Mkzcou6Za+dpaO+kYpBrD6vsXZteIdvA0JIfWwco/r
         nLE8pJztR1lVu1gyS9RCzpxjYgKb2JfVVW+qaxDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Cox <alan.cox@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Laurent Fert <laurent.fert@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 080/131] stm class: Fix stm device initialization order
Date:   Mon,  1 Apr 2019 19:02:30 +0200
Message-Id: <20190401170058.821301370@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 389b6699a2aa0b457aa69986e9ddf39f3b4030fd ]

Currently, stm_register_device() makes the device visible and then
proceeds to initializing spinlocks and other properties, which leaves
a window when the device can already be opened but is not yet fully
operational.

Fix this by reversing the initialization order.

Reported-by: Alan Cox <alan.cox@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Laurent Fert <laurent.fert@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 0c7f0bae001a..b6cc841de79d 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -664,18 +664,11 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	stm->dev.parent = parent;
 	stm->dev.release = stm_device_release;
 
-	err = kobject_set_name(&stm->dev.kobj, "%s", stm_data->name);
-	if (err)
-		goto err_device;
-
-	err = device_add(&stm->dev);
-	if (err)
-		goto err_device;
-
 	mutex_init(&stm->link_mutex);
 	spin_lock_init(&stm->link_lock);
 	INIT_LIST_HEAD(&stm->link_list);
 
+	/* initialize the object before it is accessible via sysfs */
 	spin_lock_init(&stm->mc_lock);
 	mutex_init(&stm->policy_mutex);
 	stm->sw_nmasters = nmasters;
@@ -683,6 +676,14 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	stm->data = stm_data;
 	stm_data->stm = stm;
 
+	err = kobject_set_name(&stm->dev.kobj, "%s", stm_data->name);
+	if (err)
+		goto err_device;
+
+	err = device_add(&stm->dev);
+	if (err)
+		goto err_device;
+
 	return 0;
 
 err_device:
-- 
2.19.1



