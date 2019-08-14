Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025F22064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfHNVbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:31:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54181 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfHNVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:31:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so473684wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYZjU1RTDpOkzFDReluCSDSSmZ91Zx0fRKtSGoSAbAQ=;
        b=cHXxVf9wFkApCgc6eo+MXMdcPR4IbRT3UJsd95e/mTBs6CNGuaebDgjYsRrrzGoZb3
         5yNkZQP8UA5o29Kno35ja1G49+zGBc6uUGq+4km6HNivVqwBdtU6UVvvAOldYhJJn/u/
         nKnmzECK5aZsHbMfSn6yPbPNy6UaB86XfIA+i85/rZKZZW0yGmUSAULIfFCzTrVdkunr
         h20Pf2JTEtW/kCjxQcWMl3ROT3cgM+tiv+VX+7yuQI2etfAwvm2F/J+Hi4bs5pRWlB5k
         iwIzkEQpc6jQ3J6kJuIF44K4uINGnLH2cIR3wamLuxZYIwIeLANcSVp37PRLC2XOnJF6
         EC+A==
X-Gm-Message-State: APjAAAWJFghgTAIR3RL+3BLmAusbPdd4pahVCWj9JoabW37Vx4Y2GgKb
        o5ma1BwAM7rkUWnpZWREvANIF8iR9EM=
X-Google-Smtp-Source: APXvYqzNvd+OhowbMV5UPI7p1DFhfCV5EFIScUQVzbZ3KQZm996fQEnm0XDNrUvLBitBCCdEL8ugqA==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr884035wml.169.1565818284752;
        Wed, 14 Aug 2019 14:31:24 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:24 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 2/7] Revert "ACPI / OSI: Add OEM _OSI string to enable NVidia HDMI audio"
Date:   Wed, 14 Aug 2019 23:31:13 +0200
Message-Id: <20190814213118.28473-3-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 887532ca7ca59fcf0547a79211756791128030a3.

We have a better solution for this: b516ea586d717

And same as with the last commit: "NVidia Linux driver" that's Nouveau, any
out of tree driver does _not_ matter. And with Nouveau all of this works even
though it required a proper fix first, but we have that now.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/acpi/osi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 9b20ac4d79a0..56cc95b6b724 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -53,14 +53,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	 * be removed if both new and old graphics cards are supported.
 	 */
 	{"Linux-Dell-Video", true},
-	/*
-	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
-	 * audio device which is turned off for power-saving in Windows OS.
-	 * This power management feature observed on some Lenovo Thinkpad
-	 * systems which will not be able to output audio via HDMI without
-	 * a BIOS workaround.
-	 */
-	{"Linux-Lenovo-NV-HDMI-Audio", true},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-- 
2.21.0

