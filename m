Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D3DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF95321874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Evlsr1hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbfHWShq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:37:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39856 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390289AbfHWShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:37:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id 125so9016375qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K6bpuQL+cink1ifj2JHG6nbNFjIxQlV3Y84jEqbo5vk=;
        b=Evlsr1hDPf8Jv3i32l+rkNwnF8sbK1RXp7eJDrXIB0v22CQWyR4hjiujIN8EScs0XK
         aOue7YpJS7cr+GnCDLT3WQGWlbXO6bJ47iubX42e6CtXu1L+bFEpGmWzS7TGPbTokak+
         s1xqseqdQLw4Fx2v3FMdv45K65jzf3QcPwysGBxhN3kOy5HUnoDMI9590lgDx/oVfKN7
         et0xqEGrg9eNJMUVmP43aIgoISsB2vBPvdIZfVo83x+KGS1NqY5l6hboYmDDBKCgVskr
         sahbHb87yBHuDno0v/v/5E0vpqojYcgyYYCk25qJV85iB2tqSfV0urJIZaGsjDpcU7hT
         LcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K6bpuQL+cink1ifj2JHG6nbNFjIxQlV3Y84jEqbo5vk=;
        b=QIL0mSxCSQxNBmHqP4zm35tNJ76jojRTnYAzDBWhXzfCKq2Yk1Pm1prdSNdGgmgKEu
         HigyC7t1hK9VnLCiYfxDPYwO0n1qxnPvP9mK7ADM1xPqjTuP9fbXtFFL4WY3PQD5iYPd
         Y4CwQnp3dXD/dxYuvYt70NuUxpMqQJDFWRsR5XJ7CZg8KrfP+NmAtgy5DzC2pcjT0vC0
         ugfeavSrEJLTpRyY2TWaDyiRAacXGPJHRD0UleEpejkA1t5rYqELrHrxqqvIGWhNsc+t
         9NKBDtwGjs/BqpbWbygvbp6ikO2SWUlyPq4Hm/bupMOi7LDESj+NWo8/nWUid+2gH+07
         P6EQ==
X-Gm-Message-State: APjAAAVKdYMOPWIrT87951drI6iyBklor5BKgiv704tcK/4qEtGvKtNA
        NJoH/Jpe68UqhGqGws6YNnF+wQ==
X-Google-Smtp-Source: APXvYqz1XZyujdK0IAvMbZFvo+vEeUsWSNzj0vDry/nXK/m98CjK2Dr8Rm6LZJn4cNZVgaeOnHT1qQ==
X-Received: by 2002:a37:6146:: with SMTP id v67mr5406438qkb.493.1566585464569;
        Fri, 23 Aug 2019 11:37:44 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x69sm1834380qkb.4.2019.08.23.11.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 11:37:43 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] gpu/drm: fix a -Wstringop-truncation warning
Date:   Fri, 23 Aug 2019 14:37:06 -0400
Message-Id: <1566585426-2952-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/uaccess.h:5,
                 from drivers/gpu/drm/drm_property.c:24:
In function 'strncpy',
    inlined from 'drm_property_create' at
drivers/gpu/drm/drm_property.c:130:2:
./include/linux/string.h:305:9: warning: '__builtin_strncpy' specified
bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by using strscpy() which will always return a valid string, and
doesn't unnecessarily force the tail of the destination buffer to be
zeroed.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/drm_property.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 892ce636ef72..66ec2cc7a559 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -127,8 +127,7 @@ struct drm_property *drm_property_create(struct drm_device *dev,
 	property->num_values = num_values;
 	INIT_LIST_HEAD(&property->enum_list);
 
-	strncpy(property->name, name, DRM_PROP_NAME_LEN);
-	property->name[DRM_PROP_NAME_LEN-1] = '\0';
+	strscpy(property->name, name, DRM_PROP_NAME_LEN);
 
 	list_add_tail(&property->head, &dev->mode_config.property_list);
 
-- 
1.8.3.1

