Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D4920684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5Vh35zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCHJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:53:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36689 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:53:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so13754706pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy96qw906KzwVqq5CS1pkHwqm+ScdE79tDQaBnxqd9k=;
        b=Q5Vh35zyMEg5duJM56TOzPRSRktxy+TEJWCSg66P8bscAIm16R+fSBCvI2NQ3xvop6
         R8oOYP2HXv222mXwSzh1vMurQlGCeq+KF7+zTCq0xSYdtN68wFtJWRFGD8pMLlpEyYfB
         vrhLyltx9pBAooyRB/jAivP/J/eRYr0FTR+BlmGgQUssZc4ilXQiZT8irMhi3UUwTEx8
         EFBANw32TUK/Wm/eSmoRuo8/pQiu4woy5QPewpEXSIkVG/IFSjrxiAsOQmA/00BoEeeJ
         0yhdN4SvyJOwh14di9LG6theNbEMnn28tHea2nR0x86awBNsQQfNhsobPXZAvagxgp81
         9o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy96qw906KzwVqq5CS1pkHwqm+ScdE79tDQaBnxqd9k=;
        b=NQpfDvw8pGHeMvKq1a9raPzfvXkqJlfbO3tLg/Gbq/CS18CDC97ekUnI4VIFTvWP6t
         kxIygCiPihlKr2MeIm6WsmEetMVYzEQ3EZKQ6PatYLGxL68qJTkR5/A66tsKvN3+vXBf
         mGOf+UHNa7zxkJfsAQiBmgovxPcMULmUM/TJGiw8FCHUe/jYHnjMDd/VuODjSbfgjC5l
         8cEKe/iBQkBPfXGGqmN3xu57IjfYONGr9xc1VyfvI0IxsYhuS8IVv6xmfzy8Ue3ANRps
         IdmsRu3tC+BW2TzyivboGSIkN7HhUqzmTh/1STIbEky4dCkHhmUimzfAlqlSmYcqE3rF
         apgQ==
X-Gm-Message-State: APjAAAXBFauS9BKGS0U+Mc2ujuQ07dIQ1GYsNw6j9fz4i7h0Qnk9A8Mt
        8uD4uSanJeLXhbt/UQieYtU9yA==
X-Google-Smtp-Source: APXvYqwimxcAD1KTNVMbzQa8ej6WN+x0Zbp6D/xqQKXfWTFwXYHuMHYvLaaU95iICqwGL7KTMlqSMQ==
X-Received: by 2002:aa7:8c8c:: with SMTP id p12mr18132197pfd.0.1552038799185;
        Fri, 08 Mar 2019 01:53:19 -0800 (PST)
Received: from localhost ([122.171.71.18])
        by smtp.gmail.com with ESMTPSA id m13sm20232219pff.175.2019.03.08.01.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:53:18 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com,
        yuwei3@hisilicon.com, gengyanping@hisilicon.com,
        peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Date:   Fri,  8 Mar 2019 15:23:11 +0530
Message-Id: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_source_remove() is the counterpart of wakeup_source_add() helper
and must undo the initializations done by wakeup_source_add(). Currently
the timer is initialized by wakeup_source_add() but removed from
wakeup_source_drop(), which doesn't look logically correct. Also it
should be okay to call wakeup_source_add() right after calling
wakeup_source_remove(), and in that case we may end up calling
timer_setup() for a potentially scheduled timer which is surely
incorrect.

Move the timer removal part to wakeup_source_remove() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/wakeup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f1fee72ed970..18333962e3da 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -118,7 +118,6 @@ void wakeup_source_drop(struct wakeup_source *ws)
 	if (!ws)
 		return;
 
-	del_timer_sync(&ws->timer);
 	__pm_relax(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_drop);
@@ -205,6 +204,8 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	list_del_rcu(&ws->entry);
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
+
+	del_timer_sync(&ws->timer);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
-- 
2.21.0.rc0.269.g1a574e7a288b

