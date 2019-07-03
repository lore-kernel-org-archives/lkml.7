Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B11C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8CD218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr0lsFRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGCNNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:13:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46884 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:13:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so1219609pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/SnzKzwbJwdsQHXwXFz/daj/8JZPIhirrV+rjMpDDQs=;
        b=dr0lsFRiXjQ5piksHRyi/X873mKA7ZcleDGYjHaXJ5f6LYS/VE0e/SYvGVFJWfoKkj
         0cIiNUXi+RTrlmuHHb0sHzMy7BgSWHdi7jb4wBHHl8UZ1HqJK/ft+gWm2y3SQNXfk+XU
         QbUh0VxZr8zCCGesslE6GDDmJaE54z/Phatgo8UNnCbnhSTSgINB4WBtiG4VNVbws4wp
         9efLTJd/Fg82mtSy6ys1sDKZ3wzwr9O7A9JUj+nYaABvtOXSQpRzlMxlNwi3iaaP7qbG
         xgLdBcsi5QTE4TgK7Ikoudh1E04otuVlSb2U/SgRB07q5j6vqwTgTMLD5BvhHZQWDB3R
         W7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/SnzKzwbJwdsQHXwXFz/daj/8JZPIhirrV+rjMpDDQs=;
        b=NlT+F2F09aTO+uiw0+Y3cXnelGImVFLsE+kn0ASdILcGTi2CgvpN0VBemnZiEukVhz
         gP0OptAJqaN1Kk5TQJhve/Yau7FaMWrF4sag8T0J5SwY3mACtquksTE6R+Im/iHC2fjx
         Qv2NtPgDZaQzDtJ2919uVwollQXPHBarunsAA9XiY36b9icb/HhN19zAYN/HpCNj4lh6
         aBXcttDNulxMQ02MIffWI3h9CTiUcu1ZwX+KAxnmbnq9/efn0SeJT77sQoWQdsL/UXDK
         L3/QxrkKV0cy/tSYVitRsrFg1kYOkkINqoxYmIg03BhSWrSC4yW8hhIjG0cOXHep1J76
         GP5Q==
X-Gm-Message-State: APjAAAWfmgDeXBqQI6BSKhadqKm/Fx6dX2oyc/Skhd8alJyDjgIXj3dk
        I3M1nA6HCOtuIQO88+Zfxj0=
X-Google-Smtp-Source: APXvYqzOfbchVfF3/6U0IzeocYcLu5dgpAA7P9Hm0M9qWQAd0ah06QF4dndiPFX5GsPWDHOl3mweYg==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr12775207pjq.64.1562159615496;
        Wed, 03 Jul 2019 06:13:35 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n89sm10811597pjc.0.2019.07.03.06.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:13:35 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 02/30] powerpc: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:13:27 +0800
Message-Id: <20190703131327.24762-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Add an allocation failure check.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 437a74173db2..20fe7b79e09e 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -383,9 +383,10 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog)
 	struct pseries_hp_work *work;
 	struct pseries_hp_errorlog *hp_errlog_copy;
 
-	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
+	hp_errlog_copy = kmemdup(hp_errlog, sizeof(struct pseries_hp_errorlog),
 				 GFP_KERNEL);
-	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
+	if (!hp_errlog_copy)
+		return;
 
 	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
 	if (work) {
-- 
2.11.0

