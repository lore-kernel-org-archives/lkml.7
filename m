Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA9C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B9A25C3B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191676;
	bh=LTGs/ZQ0ZWor2mCV+mT5jRrLzyYC3NSzLDS7oOfHpEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjI3lJFGD9yzGO+EOV4drGG4t8/BdwOHKiW76UCXTVBVUR31PwHKh88+aEO54q9mI
	 Yzw5emOncsdpeAqPVgkIXJlwumJFyCI/em4aoaV5hKJUHMO8ZiM/p69hun+qQJDs2V
	 mCIWXbtCkp+rhGdMVfmzHYYWEU/V6dk+/ZWRmFdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbfE3Erz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfE3DL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E42F24482;
        Thu, 30 May 2019 03:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185885;
        bh=LTGs/ZQ0ZWor2mCV+mT5jRrLzyYC3NSzLDS7oOfHpEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGMtPZX9LdSvmOoUoXgKD7gSYpotlYmB9xDaepx22Ifg16Dl6IP0OCCghSEBzU0GS
         WczEfK3dPg7oe/pkeqtGySN2mKrlOpWmB35rGnZdhon+8sLyuDlN1kflMTAfRk2WWq
         ztbEmBKQothkTcHFrJ+7ffiQST530gdjEv+PvXSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 196/405] PM / devfreq: Fix static checker warning in try_then_request_governor
Date:   Wed, 29 May 2019 20:03:14 -0700
Message-Id: <20190530030550.927772449@linuxfoundation.org>
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

[ Upstream commit b53b0128052ffd687797d5f4deeb76327e7b5711 ]

The patch 23c7b54ca1cd: "PM / devfreq: Fix devfreq_add_device() when
drivers are built as modules." leads to the following static checker
warning:

    drivers/devfreq/devfreq.c:1043 governor_store()
    warn: 'governor' can also be NULL

The reason is that the try_then_request_governor() function returns both
error pointers and NULL. It should just return error pointers, so fix
this by returning a ERR_PTR to the error intead of returning NULL.

Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b7..839621b044f49 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -228,7 +228,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  * if is not found. This can happen when both drivers (the governor driver
  * and the driver that call devfreq_add_device) are built as modules.
  * devfreq_list_lock should be held by the caller. Returns the matched
- * governor's pointer.
+ * governor's pointer or an error pointer.
  */
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
@@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return NULL;
+			return ERR_PTR(err);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1



