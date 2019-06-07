Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DA6C46460
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAE92146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFW5j0r2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFGEqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46722 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFGEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so462945pgr.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86+1jUaVqNTDsIoNrTtwtftI7vuyj9YpQeH9VRCoSLE=;
        b=iFW5j0r2oXeROZ1hCi8tP6YpfgXYKHKwmb6di8l/J35zu9zQoAIJOevqU8aSpUFYvZ
         m11hzfG0lHiFdDjo8dq2E+LdKnhhCWSxm/IAVMPTN5kwP89KuHM6tgAWEVppmCSHVPZk
         jxhDTfyCGQqBtm2nQwPtOHWjTuCYb378wov6Sk//AHtJHsn6Tp7ci4TzZ0RCl0T9qWMb
         KdW66K9MxKNEk9cvv1wURJ/JfrInNJfy4gE3dtsW3l+4HwljMttxC007bXFouQYD8Upu
         SqU5v5QuI1VrLxbBjMTmPYW3w3vBAbHpHEkA+3clvdrVDP4TChXhgxeJBagzmyXaF+4O
         IYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86+1jUaVqNTDsIoNrTtwtftI7vuyj9YpQeH9VRCoSLE=;
        b=j3aBMkBhM57yQsj8xpV3toIJbMT7xEDnMJ6tl/q5suge9KzQUyItV/Jnrt/Y72eqmw
         rjLyoH62QigA65E3Lj23GAjCCP6D3sD8Wg9KgTNY3btGzsv3e4e9MlLQiv3mHDo0YQYs
         98hhRESgI7gp0hmXPCkePyOmTkEKPBi2zETTEa9SgNMVmwz9CnX3AdnjuKNZ59pNaahN
         r9rJ3shzj93jB/WfA7UHNDjgPxvHbAHinfKBNWnPE0rJyMpnzlJDLCQzoxWxONaUUM8r
         3oIqboY32OjT6l9t5Y72qccihY2y9G8FdBSMYobs3owxEnu0HTFKVC8kLLnWAxvvijo0
         GaLA==
X-Gm-Message-State: APjAAAULur5oco3nksSPVCVQizsTFYZYv/9GzfZOqJ+JPzjVTo+DVZEx
        GeNTDAAIkEpq0ra17yj/IxQ=
X-Google-Smtp-Source: APXvYqye+QMLr+CiQqaekDr3vb4uV3hQpJnVs0ll1JLPKRrKlp1+Xi/0K3I+pGiDpxL5i8sX481yVQ==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr3378255pjn.136.1559882790749;
        Thu, 06 Jun 2019 21:46:30 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:30 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
Date:   Thu,  6 Jun 2019 21:45:38 -0700
Message-Id: <20190607044550.13361-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling in tc_link_training() with equivalent call to
tc_poll_timeout() for simplicity. No functional change intended (not
including slightly altered debug output).

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index f463ef6d4271..31f5045e7e42 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
 
 static int tc_wait_link_training(struct tc_data *tc)
 {
-	u32 timeout = 1000;
 	u32 value;
 	int ret;
 
-	do {
-		udelay(1);
-		tc_read(DP0_LTSTAT, &value);
-	} while ((!(value & LT_LOOPDONE)) && (--timeout));
-
-	if (timeout == 0) {
+	ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
+			      LT_LOOPDONE, 1, 1000);
+	if (ret) {
 		dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
-	return (value >> 8) & 0x7;
+	tc_read(DP0_LTSTAT, &value);
 
+	return (value >> 8) & 0x7;
 err:
 	return ret;
 }
-- 
2.21.0

