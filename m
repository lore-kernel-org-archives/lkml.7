Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852EC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEC220C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bCbkjSfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfELSsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:48:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40654 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELSsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:48:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so5275106plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+tmCd02fCJiDUSiTQt8UkGfYRxlwTjJZiePzrILeZA=;
        b=bCbkjSfUL2gmcqSGvbPBb18gk9fHdbxrFoqityYU7SzakDp/If7y+tOR4CZzvjIWDs
         Njc7zBNZHf+z8/w6ZzH+nFE8RIHoj2ZXgL3eB8dXGJftZ9nQ3pRuG9sUgqQOB4Ju6WTs
         IGoDFDxJIS2FQxc8SlsUoESDbIDZL+54R/s9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+tmCd02fCJiDUSiTQt8UkGfYRxlwTjJZiePzrILeZA=;
        b=S2tU3H9PnovaHu/un5FSDuS8qRMfuQjzs5zkucCGK+avNI94/GTtpv4kssMf9zPXWP
         dPZmRPQEZ5mSJKpdsfW8RoItrCJqlS6wtFkGIme5Acmsux+kzNvXaLgHpj7dwILyAGtO
         I3WZ6E48I0cUYIQ+2zNCdZrvUmMe+qMMBzfxhg825Oh3IRogWzVZZsPse3mm7VFVSO7J
         3gskp+0FCko+qGdPOmTtOikEZ7aQ3FC1CUm1EeXRwky11jR2yKMT9jtzCtitgbeameUL
         4gMZmue9bRbxD1QkMFauvpRnqVAhvPK+/FKoaTQ6aeesnQDT2gpKEtrzKpUXTtGhRgw4
         l5KQ==
X-Gm-Message-State: APjAAAWQmFJEpkRCmLBtLevxj2NtN7Jvq4Cl7i96Va/PRQOPxSLAEe52
        ikg5asguM1qM+ZpkFjBUF9UWrg==
X-Google-Smtp-Source: APXvYqxAqVOknDpYxgct8nDYNHZfPNhxQmUq8NyMFF+aGH7SDmm/VOXXqCbFjxQPR4tIHMOF2/a6TA==
X-Received: by 2002:a17:902:8f84:: with SMTP id z4mr25127180plo.124.1557686921322;
        Sun, 12 May 2019 11:48:41 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id t26sm15216683pgk.62.2019.05.12.11.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 11:48:40 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] drm/panel: st7701: Swap vertical front and back porch timings
Date:   Mon, 13 May 2019 00:18:27 +0530
Message-Id: <20190512184827.13905-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vertical front and back porch values on existing driver are swapped.
The existing timings are still working as expected, but to make sure 
it can compatible with techstar ts8550b bsp timings this patch swap
the same values.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 63f9a1c7fb1b..09c5d9a6f9fa 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -305,9 +305,9 @@ static const struct drm_display_mode ts8550b_mode = {
 	.htotal		= 480 + 38 + 12 + 12,
 
 	.vdisplay	= 854,
-	.vsync_start	= 854 + 4,
-	.vsync_end	= 854 + 4 + 8,
-	.vtotal		= 854 + 4 + 8 + 18,
+	.vsync_start	= 854 + 18,
+	.vsync_end	= 854 + 18 + 8,
+	.vtotal		= 854 + 18 + 8 + 4,
 
 	.width_mm	= 69,
 	.height_mm	= 139,
-- 
2.18.0.321.gffc6fa0e3

