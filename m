Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C3D227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782270;
	bh=fHrbUCUbox+/VKqWzedN0KhyVov7PkUo1FGuGQCnq2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAnGghPpRZSWEgJdigY7Ub4Bz5rGzUc6yA34sPWcFSKG+SYtk888eGuUQv/JTRuEB
	 b5KNEYbIRA3CFwGHFtoJL6s8Vy4aRKdhM2wT0T/oQ+8B0ZxtVG/2gDyC/1h3NZznMy
	 yDdc7Hq0DK70QEoN5WqM9gA4cVyGrmZ0EtsaGOMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfLSSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbfLSSrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:47:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3931F24676;
        Thu, 19 Dec 2019 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781223;
        bh=fHrbUCUbox+/VKqWzedN0KhyVov7PkUo1FGuGQCnq2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn07AwvJVQTmGobn5c66dtrDkRqQIwzU0WSkKPauPwfDedc0VWxTdgiMIrvqc7Wgk
         j7yb6Zn0gEAAgpFzxp/3ZOWrtJLcSMm2azvv3sMfQ5I/aaQKnbd7b53TPsGmijCKNj
         naI393M5hWrfiTm+5eXkyBxE4edWJjOuDMYmc/pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.9 134/199] PM / devfreq: Lock devfreq in trans_stat_show
Date:   Thu, 19 Dec 2019 19:33:36 +0100
Message-Id: <20191219183222.501723636@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 2abb0d5268ae7b5ddf82099b1f8d5aa8414637d4 upstream.

There is no locking in this sysfs show function so stats printing can
race with a devfreq_update_status called as part of freq switching or
with initialization.

Also add an assert in devfreq_update_status to make it clear that lock
must be held by caller.

Fixes: 39688ce6facd ("PM / devfreq: account suspend/resume for stats")
Cc: stable@vger.kernel.org
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -135,6 +135,7 @@ int devfreq_update_status(struct devfreq
 	int lev, prev_lev, ret = 0;
 	unsigned long cur_time;
 
+	lockdep_assert_held(&devfreq->lock);
 	cur_time = jiffies;
 
 	/* Immediately exit if previous_freq is not initialized yet. */
@@ -1170,12 +1171,17 @@ static ssize_t trans_stat_show(struct de
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
-	if (!devfreq->stop_polling &&
-			devfreq_update_status(devfreq, devfreq->previous_freq))
-		return 0;
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
 
+	mutex_lock(&devfreq->lock);
+	if (!devfreq->stop_polling &&
+			devfreq_update_status(devfreq, devfreq->previous_freq)) {
+		mutex_unlock(&devfreq->lock);
+		return 0;
+	}
+	mutex_unlock(&devfreq->lock);
+
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)


