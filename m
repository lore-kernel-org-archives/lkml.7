Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DC7C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B3216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+zQEQRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfHUQdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:33:25 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40224 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfHUQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:33:24 -0400
Received: by mail-yw1-f68.google.com with SMTP id z64so1167449ywe.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsJUOJvTHv8JutMy3HEjd0J3qoBEPeD8iaS9gmpHh8E=;
        b=m+zQEQRmVGvX8h+izIycQAmQBGBY9l0IC+f9qwlQtrS5bbYvuVubCqwMeQjat7BYmh
         wi+VowbnjZaKjM6RCy55hyKV9Uv3F8vxK8yTvdpM+jgiMdhsc6G8aC2IWdXMMn/6FoJN
         mD9ZTYAx4rQ+yo117fJEz+j9B1Had63A10TSu6V7LeVlS8xIuN8Bez8T6EvN6PZGJZGh
         FTTDJX3syqVDEedkq6AfkbvIILsHhaC7Xa3u1x9gPaA5ePOpVcBgs2Wb2wW7BdtNRnIq
         1TQVDowBh+5qF1eyOjdAvOIzuhCXtihQ4G5/GIHRYQySw9+iPs2tnlyMoOdl9SgfF2bV
         Qfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsJUOJvTHv8JutMy3HEjd0J3qoBEPeD8iaS9gmpHh8E=;
        b=IAju/mQ4UmRw5B2tl8VCPfQPjpbjDqsYxEp9bLA+SAY1zMvcbquOyN2Rq8EkHn15wa
         h83Bl0ZTyx0LjKnbHrGZ4Q82uLwp/5/wQozBfZ/xTRhRGMnIoTf/sR71eBqcW5X26Ft+
         bBCwk/Jqce64hxpISO/h8+yJT9e7DDaaaKqN6DGzSxNpOfoTEpuk7oDvXvAteXoICEyv
         Z2DWlNXqIm/rbpXV6IRnrpxJGyZKbi8ppNcSCdYdLws9dxX1KzehodbISdimNrm7r1r9
         bmyoaairABF9hDlQiV5Or7N400e589zQgtBo/UsgEBAtXKLFwH/VoTEqFCYAuY5C37Nw
         cmZw==
X-Gm-Message-State: APjAAAVdnRMAhAIoXjuyl6/gToOe31ZwJIr1TsJQaIn7lSW4Zd34On1B
        qrG2Ce1FiqwOsa6BNouN0VgRXnix
X-Google-Smtp-Source: APXvYqzNfSCYeklIRCT9iq31zZTZJ2GAjqbnwHemyCqKek07QxjXpSq8AYUeCVMkHK1bfFRKURLYRw==
X-Received: by 2002:a81:4c55:: with SMTP id z82mr25212205ywa.439.1566405203551;
        Wed, 21 Aug 2019 09:33:23 -0700 (PDT)
Received: from theseus.lan ([2604:2d80:b386:1f00::780])
        by smtp.gmail.com with ESMTPSA id l71sm2794323ywl.39.2019.08.21.09.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 09:33:23 -0700 (PDT)
From:   Clark Williams <clark.williams@gmail.com>
To:     bigeasy@linutronix.org
Cc:     tglx@linutronix.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vgr.kernel.org
Subject: [PATCH] i915: reduce scope of irq disable when signaling breadcrumbs
Date:   Wed, 21 Aug 2019 11:33:14 -0500
Message-Id: <20190821163314.9830-1-clark.williams@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Williams <williams@redhat.com>

Rather than disable irqs around the call to intel_engine_breadcrumbs_irq()
use raw_spin_lock_irq() around the signalers loop inside
intel_engine_breadcrumbs_irq().

It's entirely possible that we only need local_irq_{disable, enable} around
the call to __intel_breadcrumbs_disarm_irq() but for now just use the
raw_spin_lock_irq() call to disable irqs (and preemption).

This prevents a debug splat on PREEMPT_RT where the request lock is taken
in atomic context.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/intel_breadcrumbs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
index 32ebbe887e61..b393421ddf06 100644
--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -119,7 +119,7 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 	struct list_head *pos, *next;
 	LIST_HEAD(signal);
 
-	raw_spin_lock(&b->irq_lock);
+	raw_spin_lock_irq(&b->irq_lock);
 
 	if (b->irq_armed && list_empty(&b->signalers))
 		__intel_breadcrumbs_disarm_irq(b);
@@ -163,7 +163,7 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 		}
 	}
 
-	raw_spin_unlock(&b->irq_lock);
+	raw_spin_unlock_irq(&b->irq_lock);
 
 	list_for_each_safe(pos, next, &signal) {
 		struct i915_request *rq =
@@ -181,9 +181,7 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 
 void intel_engine_signal_breadcrumbs(struct intel_engine_cs *engine)
 {
-	local_irq_disable();
 	intel_engine_breadcrumbs_irq(engine);
-	local_irq_enable();
 }
 
 static void signal_irq_work(struct irq_work *work)
-- 
2.21.0

