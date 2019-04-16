Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE37020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/ujkBlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfDPI4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:56:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39964 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:56:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so24361073wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=X/fS4B4TQYLCt/1NT/s+qwpNcuJkf+cjzjwlLPIrmXk=;
        b=r/ujkBlRMalnyNsSMrJkbDzZmSBJYtfYmn+wrTwKsrNw4+UOgJgYNo72ff6me+emOf
         /hQWXyXr6NuhGgzFUr6sZf/WwQ2DJIesjZZJfkxChHCxFr06nU9F9ssdZJBpBYxXcwN3
         PrsuipRwWACBX2DmyRmj/hOlZLR9tfoDdAXwm0wmGSB61icv7AOkU3NkTp4/+fYn+ORX
         g4qRRZEEGUaQSQ2ecH/PgwNWD5saE06cInQV2r2DLTrUs1RHA3z0YPRPG34ln4sSoqCm
         Y25lHfrnv2qumHG4VYFlcFVPcGGdDtVmZVtCm4+wK76HDAUrCM29We6tiyMes2VfhClu
         0EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=X/fS4B4TQYLCt/1NT/s+qwpNcuJkf+cjzjwlLPIrmXk=;
        b=qLYkM/rBdNdwqO93rV+uhrVefCUnXJeJLIj7biQss7rffp1QNYY2lD0L2QlJ9OFJZM
         1s+FV1yeSggwWBxBx1GG+SWuj4vKDydbmvRGVtKG5Jngj7CIrqQ/gymgBg4wae2jn7Is
         rq9rWwY90k3nYcwks1MagpAY6G0HjGU+DisCVTqehD23E3b2FBqjr4I/6p89SJLzIpnR
         3OeeKDC4nKj0kEBH/xP4kTamYhA/NUXTPuLnOhkmjopYA7v57h/wXm+HVYg+ELRRB3Of
         AXkh/Ex4YQbV5M0X7M2B08s4FfDXBYgL/gLhXKLKxuZocOtCs5Jgo25TrScTDvYUyBHk
         JaVQ==
X-Gm-Message-State: APjAAAW/oyPwVP1lA0KrgzIaGsflWWVHCNf59YlYKm2eo2fpRyRTmH7w
        mwrUY61z7j20kaEKYO4bT+4DGdJ5
X-Google-Smtp-Source: APXvYqwIdb675g+5InaMGc4AgnwvxPshGNlOuuKsIDCo0bpe+7bB9FlmWugCKrLF+0MgqMJzthqNPg==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr1086053wme.49.1555404970420;
        Tue, 16 Apr 2019 01:56:10 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id e1sm86288374wrw.66.2019.04.16.01.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:56:09 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vhost-scsi: remove incorrect memory barrier
Date:   Tue, 16 Apr 2019 10:56:08 +0200
Message-Id: <1555404968-39927-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, vs_tpg is not public at all; tv_tpg_vhost_count
is accessed under tpg->tv_tpg_mutex; tpg->vhost_scsi is
accessed under vhost_scsi_mutex.  Therefor there are no atomic
operations involved at all here, just remove the barrier.

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/vhost/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 618fb6461017..c090d177bd75 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1443,7 +1443,6 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 			tpg->tv_tpg_vhost_count++;
 			tpg->vhost_scsi = vs;
 			vs_tpg[tpg->tport_tpgt] = tpg;
-			smp_mb__after_atomic();
 			match = true;
 		}
 		mutex_unlock(&tpg->tv_tpg_mutex);
-- 
1.8.3.1

