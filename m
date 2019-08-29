Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01488C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE89B233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfH2QvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:51:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54898 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2QvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:51:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id k2so3018176wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWO650+kQjgd0freSzG4GVYInuwUakQ2FRAAY/0z/rI=;
        b=pFfR6QaFX/f5q+PRifIkEFLx76QPxvpS/Z0z/GSPLwy9vWF6qL0hqJvJHnBEbs6qiV
         m1V7nm7/bt2zoShZgPjtFkblDCAs0VncBGRNNuSHxlp4e7akEUd4FDNbR1ASoQ+vuMkM
         L7oaa/XtglHdkwWLWBftCFkzFIBFDxZgIx1kTcWa/+z1jfXYwlkBI+283iivfFCCazoN
         O3HY8nfakmUh1IXzuMOzUOsPzKMqmUryqwm4XR9+HM+/4YRNZWA2K8uZq0JGyo/RKqFg
         LdEg9waAxjD5FZAmasYMe7nxEoCpZWq7svt/yp1cF7A+Pa6Wgf1zWxivJ3Dm4ET/F1fl
         UulA==
X-Gm-Message-State: APjAAAW7iU9voUVyoj6BHD6Q98vVSdWyWvpkUGwUfGUXfg/24W5PJjtn
        Dis1cqHULyF7Xli5p35plRvrX1s+B88=
X-Google-Smtp-Source: APXvYqzoDiooG1fxgtlB90KCm2/ikDEZkuoKce/dvTUg9dkOr5UrMz18qNY8RMFolm7jcxa9qIDUiQ==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr12562563wmi.16.1567097481381;
        Thu, 29 Aug 2019 09:51:21 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id o14sm8340770wrg.64.2019.08.29.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:51:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v3 04/11] xen/events: Remove unlikely() from WARN() condition
Date:   Thu, 29 Aug 2019 19:50:18 +0300
Message-Id: <20190829165025.15750-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829165025.15750-1-efremov@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"unlikely(WARN(x))" is excessive. WARN() already uses unlikely()
internally.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 2e8570c09789..6c8843968a52 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -247,7 +247,7 @@ static void xen_irq_info_cleanup(struct irq_info *info)
  */
 unsigned int evtchn_from_irq(unsigned irq)
 {
-	if (unlikely(WARN(irq >= nr_irqs, "Invalid irq %d!\n", irq)))
+	if (WARN(irq >= nr_irqs, "Invalid irq %d!\n", irq))
 		return 0;
 
 	return info_for_irq(irq)->evtchn;
-- 
2.21.0

