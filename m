Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83672081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Utp9CJUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEBUq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:46:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34365 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:46:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id w35so1751526edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0rauU0ja3fR+oPmh7A/vlojiO16XNZbGFS9RST2+60=;
        b=Utp9CJUEOxFtr55aE1nrugTYkmR0xU54dXkC5U0oON7vdFRxWfEyIOj9VFCpeFYS5W
         TPxZvq7NqjcuhVbT+S9giMAiCwiHpX11hJlu9muRTwai2Mg897JaDmQ2hdEasPjtICuz
         GEGloN60OTTMoA4FApUKQSfeW6pOtM1aOJo5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0rauU0ja3fR+oPmh7A/vlojiO16XNZbGFS9RST2+60=;
        b=kcB9lyNVHw85TYqcVpRV0TN+sfayW5ZhJB4GrfuLS825DtmCIbDYXtdA+vTRwSQiyO
         OjYJxERYl1txETWiwEoVRVaw64ndcg5Bt+FRQrt83gHq1ZNoSBmcUB51uuGim4fSiO2o
         41PFSRIZzyILa+BgwcrH+ImTb6BKTVAUeWe78SdYxQdiUwq1kyXJLbP3j3tcwJpRTXNL
         N2ngAFJ2MX1fy7N1R2G65MWqJm4pqAOhFxUy8kr8Rvood7Gn+6vWiNnt/qctqO+Bk+JU
         fyUB2JSWuhsIkIJ+D8L3elZtbvVR/pdEQ2i/zHFtpufcoUoYi5T9TrAgHlwFNm0n97h+
         oXJw==
X-Gm-Message-State: APjAAAXNWgcBNG8OwYBAymr/sDbyTXzZ0Cnp3UCPmsEImopPTd/gSeQe
        AGyj2rptLJP1GNYaBXjRxcg2Eg==
X-Google-Smtp-Source: APXvYqz+fy7VdrUIGNccpP20f/DpOEh7Nto0S1P61xfQte4sjgmWCFXmQbZqnzrbJYH+M9hN6ahEig==
X-Received: by 2002:a17:906:c50:: with SMTP id t16mr2927525ejf.296.1556830015518;
        Thu, 02 May 2019 13:46:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x30sm30594edd.74.2019.05.02.13.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:46:54 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: [PATCH] RFC: hung_task: taint kernel
Date:   Thu,  2 May 2019 22:46:48 +0200
Message-Id: <20190502204648.5537-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's the hung_task_panic sysctl, but that's a bit an extreme measure.
As a fallback taint at least the machine.

Our CI uses this to decide when a reboot is necessary, plus to figure
out whether the kernel is still happy.

v2: Works much better when I put the else { add_taint() } at the right
place.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Liu, Chuansheng" <chuansheng.liu@intel.com>
---
 kernel/hung_task.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f108a95882c6..d90d98f53ccb 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -117,6 +117,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		console_verbose();
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
+	} else {
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 	}
 
 	/*
-- 
2.20.1

