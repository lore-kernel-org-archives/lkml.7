Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBB8215A4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 12:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfTd8sm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgADMXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 07:23:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36443 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgADMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 07:23:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so44798704wru.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwNUSd99uCpcD2i/Zhi09ZcL/ngKkzJPJ00O7NK8uak=;
        b=IfTd8sm1QFVaGBFpKEd2oviq06KevNXtkX8yOkcbAfoA/loOfqRuxsDuAIl+7o48RH
         MSQEDOb1T81BxBwJxy5VfiRMx3OZz7EGSB+++T81oGS2K67N0qr86+S7tNcHwTsyXMh8
         yxZQFVfHiv4Z79srxGd4VVTYYh+SuNKGV7d+yhhEYLou6OmAZk0cNSG11m8vRXHDpR6v
         7DaLWosJ0wFwOh/LQhuxWHn/86XYWgtAJWmeOVic27RwCYORDqmaOK+mk/3nGuKiyvv0
         0U7ZKg1A/dBNlW5n9hlSoXgvJJR7y7E+V6Lrzf1Bh8tHIb0hnrmvpjVmuc+TweyCWkEe
         ravg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwNUSd99uCpcD2i/Zhi09ZcL/ngKkzJPJ00O7NK8uak=;
        b=UmeHIqCfKtkvDik1l1/VIYnQ7PAsh65G9oHMzrzycAOtNcnHzm0COKq9ZdhobE0/fW
         KK53Nxn0zkxBcrt9A4OdGaFekx1pF32I9ZHHM18UPpcnHzgzaZfqe1PkQvUO8ynGKwjc
         BCSRe4dUkHldOyaEJdyFQd//fXT7ORe0jcBLC0T60HDdubJaECxQ7Fkp5e4WA4Lw/ApP
         FJ6jgs+qPkNiiN/PDzWmpju62OamJd69Ls6fsYgbeYhUzfaJQyfl4XH+EOqbiqwHEVX/
         vs6SV82qBrEz73E/GTJUhar/eV6Yu/yEHOzmtXVxfQAlrKToOMWMsF0ZiyAJuo+ldfDj
         oZMw==
X-Gm-Message-State: APjAAAX4Ul3bXNY8eE0tGlaOsw8dMavdgekpkL/dEZP/rj4nFSqcof+4
        qMl5L6/cBZD/K2iaCVqLp10=
X-Google-Smtp-Source: APXvYqwWWPHCXqNuFyKebMBHxIW3UvhYBcQU+Lb0o2+33MGKCCL2vlFiYVBCV4+9nZQtxkNSoTyv6A==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr90778799wru.230.1578140599973;
        Sat, 04 Jan 2020 04:23:19 -0800 (PST)
Received: from localhost.localdomain (bzq-79-176-206-154.red.bezeqint.net. [79.176.206.154])
        by smtp.googlemail.com with ESMTPSA id x1sm63227093wru.50.2020.01.04.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 04:23:19 -0800 (PST)
From:   Dor Askayo <dor.askayo@gmail.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Dor Askayo <dor.askayo@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: do not allocate display_mode_lib unnecessarily
Date:   Sat,  4 Jan 2020 14:22:15 +0200
Message-Id: <20200104122217.148883-1-dor.askayo@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allocation isn't required and can fail when resuming from suspend.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dd4731ab935c..83ebb716166b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2179,12 +2179,7 @@ void dc_set_power_state(
 	enum dc_acpi_cm_power_state power_state)
 {
 	struct kref refcount;
-	struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
-						GFP_KERNEL);
-
-	ASSERT(dml);
-	if (!dml)
-		return;
+	struct display_mode_lib *dml;
 
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
@@ -2206,6 +2201,12 @@ void dc_set_power_state(
 		 * clean state, and dc hw programming optimizations will not
 		 * cause any trouble.
 		 */
+		dml = kzalloc(sizeof(struct display_mode_lib),
+				GFP_KERNEL);
+
+		ASSERT(dml);
+		if (!dml)
+			return;
 
 		/* Preserve refcount */
 		refcount = dc->current_state->refcount;
@@ -2219,10 +2220,10 @@ void dc_set_power_state(
 		dc->current_state->refcount = refcount;
 		dc->current_state->bw_ctx.dml = *dml;
 
+		kfree(dml);
+
 		break;
 	}
-
-	kfree(dml);
 }
 
 void dc_resume(struct dc *dc)
-- 
2.24.1

