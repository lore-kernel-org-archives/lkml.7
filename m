Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C5CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E0D20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WR2z2Dg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfEBTmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:42:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44676 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:42:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so3182314edm.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smxA1EiAOM4O+e+0r4yKbO7u3umfCKvxARWKKLxNbAs=;
        b=WR2z2Dg1GwCmYak4J9AuuoWcQuVQmqMjWUu+Q54hC51oh46tx59Mezt76Twu6nyOx7
         2XESGkaJ7es5OvX7Vie/S849j2NCYt1NokepSyOcg3e1lXUiuMsgqeKOwVLhEzPvBCIl
         jQ6RjVRxX2/OkIBALKfGUVaeCukWPniuFYRuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smxA1EiAOM4O+e+0r4yKbO7u3umfCKvxARWKKLxNbAs=;
        b=uhIQjwZj4sZw603UPr84KIFuj7h63rsNTcDSs91NoF2cSCsBcWhzh0dCFGZBo5BzrK
         GkegOeLXZe9NcREaEoUffbXh3nXkWdx4Nv6sbTF5atYQCW3mrpWvem6HMFKmluv1abvN
         fOayga/qatGHl2Mg5V/EJD6sAKrEcvXgPBVVMTWeoAYT7ShbhafRudhFkpu8/kc22iQT
         opkGABQ/YVAK5mt8h9jUGveoZ/b83VndpNARpgT4lfgz8vIV3wyvbs/dhI92OrFMBmoN
         Dz1TPnGOT/KL4+QwMjpFndfrQ1fcDC+Dhu7pIsMaV0pGWtzI8opMBdprUrKTjHTC74hr
         sGNQ==
X-Gm-Message-State: APjAAAWM5+riaUOqEOoBuwWLwy8JTMDooNNKBhOayt5CAaiBczVGZMK2
        +GSEOIIhlDjY1GlrtJK2HshbdnTyYdE=
X-Google-Smtp-Source: APXvYqz01qHcgVvDUN8n2qr8p2sF8W0Dc4T/DUcNDX/kre6/3gWRWF6XI0ffJg/OfJ1Y4qUcg9Ju9Q==
X-Received: by 2002:a50:a3dc:: with SMTP id t28mr3740043edb.256.1556826135961;
        Thu, 02 May 2019 12:42:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l43sm718924eda.70.2019.05.02.12.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:42:14 -0700 (PDT)
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
Subject: [PATCH 1/2] RFC: hung_task: taint kernel
Date:   Thu,  2 May 2019 21:42:07 +0200
Message-Id: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
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
index f108a95882c6..7fae16f1b49c 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -203,6 +203,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (hung_task_call_panic) {
 		trigger_all_cpu_backtrace();
 		panic("hung_task: blocked tasks");
+	} else {
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 	}
 }
 
-- 
2.20.1

