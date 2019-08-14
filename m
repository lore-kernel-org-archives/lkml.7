Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB8BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D4B205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfHNVbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:31:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42459 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfHNVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:31:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so435950wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhvDIcAWfosZBJhY+0+tJdL27Lzyx+m3Z571YGmGrMU=;
        b=Jicse2YWLnqV3SEOtl50/yKepFCQWzCZmD9DcoO4jncH93TC8Rm8QwSeuFGqKXP5zu
         qykg23toimjL1zfL0En84jHpAGcls0nDLuUXZkdrEJE1WHzHh+KOpPegwev6xnc3cjwo
         XxxFC9CRc0KSJMEEiF6Wvw5PRUfKdyt8Fb0VG/HmSoScv5lHaHI8BVHoQMzv3Hb0Svws
         HhZ8TzLFaglC8TQOCYRWSRqSQwzQ1k8FEX6hipbjhtfTbUrrU5PKZNZ6lY4HSXehM67B
         6lswDj0mllrLxHUNt/4MQy57+RsdFFCtL7d453DJ91ETq4wpZYU8SHjQt8pM69Na6lGv
         5lNQ==
X-Gm-Message-State: APjAAAXeDAhh+LsBNZiMii3QiJnLlsvgcGHYXZe0bz6ObCg0sBvLisd/
        BuTA3ccDc0BpRZPnPid3PlNX6aE5fIg=
X-Google-Smtp-Source: APXvYqzpILgvWyO/axbBU+RuIXy2MhZX3baBIQN5meB2TU+nSw73f26dSGUM9WN8J6xOSH+pbpo82A==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr1601044wrs.200.1565818285969;
        Wed, 14 Aug 2019 14:31:25 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:25 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 3/7] Revert "ACPI / OSI: Add OEM _OSI strings to disable NVidia RTD3"
Date:   Wed, 14 Aug 2019 23:31:14 +0200
Message-Id: <20190814213118.28473-4-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9251a71db62ca9cc7e7cf364218610b0f018c291.

This was never discussed with anybody Nouveau related and we would have NACKed
this change immediately.

We have a better workaround, which makes it actually work with Nouveau. No idea
why the comment mentions the Nvidia driver and assumes it gives any weight to
the reasoning.... we don't care about out of tree drivers.

Nouveau does support RTD3, but we had some issues with that. And we even have
a better fix for this issue. Also, can we _please_ do it in a way worthy of an
upstream community the next time?

If some distribution feels like they have to please companies not wanting to
be part of the linux community, please do so downstream and don't try to push
something like this upstream.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/acpi/osi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 56cc95b6b724..f5d559a2ff14 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
-	/*
-	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
-	 * cards as RTD3 is not supported by drivers now.  Systems with NVidia
-	 * cards will hang without RTD3 disabled.
-	 *
-	 * Once NVidia drivers officially support RTD3, this _OSI strings can
-	 * be removed if both new and old graphics cards are supported.
-	 */
-	{"Linux-Dell-Video", true},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-- 
2.21.0

