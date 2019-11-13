Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD43C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DC32084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611449;
	bh=b1zZCWHgviqi7cGaVJbe44nWhVRzGNjrthtf+9iCCxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9em5IuOA1QoCurOk51P+U+bkpi73GfvaExY9SN1oWh1DONeNT0A4wJ4a1zCgMK17
	 TV1kBDqAM6X8JK9Hxo513p50J8OzZQo+cHGwVAj3ZSH7uWc693rGcsTu8g9Q9Qoc5D
	 2JmGC3EmUiSGjapDJIR84dkrb2UphYc7LabcRijI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfKMCR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfKMB4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3613022499;
        Wed, 13 Nov 2019 01:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610163;
        bh=b1zZCWHgviqi7cGaVJbe44nWhVRzGNjrthtf+9iCCxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqvmzKa+BzlTc83bUQQWK34qBzGg5KyIUIo7Esq5/G6e7DjDNqeX9Dm++UNIoxPOI
         Nn2glwcJyMaFK66TvR3myQjJ7jycLcKJX6VXaReAJvgM8GyeF5n1A7gpZ3U1KY4QI1
         u6jRnn50OlIudVVCWPlNXYuhK+CvSzKGTG/vxxfA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 205/209] PM / devfreq: Fix static checker warning in try_then_request_governor
Date:   Tue, 12 Nov 2019 20:50:21 -0500
Message-Id: <20191113015025.9685-205-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

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
index bcd2279106760..e2ab46bfa666e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -231,7 +231,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  * if is not found. This can happen when both drivers (the governor driver
  * and the driver that call devfreq_add_device) are built as modules.
  * devfreq_list_lock should be held by the caller. Returns the matched
- * governor's pointer.
+ * governor's pointer or an error pointer.
  */
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
@@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return NULL;
+			return ERR_PTR(err);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1

