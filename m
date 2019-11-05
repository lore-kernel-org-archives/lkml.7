Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070CCA9ED4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B96E21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJchIpDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfKECXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:23:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44766 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbfKECXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:23:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so13966885pfn.11;
        Mon, 04 Nov 2019 18:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ixK+g9NmIOquF2TSES+OOVha+NupWLDUPvXjeKzULro=;
        b=KJchIpDzwJIv6cT8V6IGzcPACS4Um2nfF+Do9VNfp0w5HWysfhs9LDRLIi2M1wzzxv
         HZLe5ykkJyKy/c2wsAvqLHkCExm993kWjrPAXc9QjEzxFjZyJ1Bn5rhbdtVc4bfVmzA0
         iCxiB+i4wYZypInvAjRSexnAG8995DpsIdjwAl2IBqdex6vhULdRroEbEy0UQY86oe8G
         xz+GeotU73j8g9ZBfocMPlz1sg/ia7DQeuv2ogBkLXNarxRapu/VZvs+0V1jwowmTUqL
         TfoeBfgp7D3PYZl/8mQ+ctxfBqPXJhmwxCXLc4nsZZO8nJiH07tOPKcAvmkeS6R5snCq
         r/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ixK+g9NmIOquF2TSES+OOVha+NupWLDUPvXjeKzULro=;
        b=Cf34MV9V0D8p6VUdm5vS2A+S7u4C+V9ojU3Mr5z/b3MCGnKxE2AWGhwxLYseikmLLT
         /GrR1ldU1uzxpRY0NLXPC+v4gdTZEO90hjXy0PJ+VKeh0mBfVLUltq9x71Y37Tvub5+6
         lzzaINhaMQotpvFVmClnDY7aEItSP5D/SPF9dXJuxahrrYCjZ/RlOprdGCAjIOIgFA9e
         7hKv4sy63Iiov31TvgDMspXEz1uA7VBKxJDkpgm5UqPVz0UgFrn5NxRdIOpgJnAP/Fex
         FF8U0rx41kLbOEOiDyS7eHaLicaomjGMXi425UZSJe5ztegNetZ53CZIbckKXo3kgFjI
         JxDQ==
X-Gm-Message-State: APjAAAVx/MAi/yTM4l0HAQ73F03yTwFSMRCU1Ly/cIWMv1IoeMay7c3l
        UE2/dk3KPwPmw/5PBxWTCz4=
X-Google-Smtp-Source: APXvYqzcgtqjcEOFQqqgVtpX8bvgmwlz0MGI6YUqBJj1giWzkld7AL/q0jXLgbR3XKpiFTACtfucvQ==
X-Received: by 2002:a62:7c91:: with SMTP id x139mr33389357pfc.119.1572920611096;
        Mon, 04 Nov 2019 18:23:31 -0800 (PST)
Received: from jamal-desktop (97-126-66-56.tukw.qwest.net. [97.126.66.56])
        by smtp.gmail.com with ESMTPSA id v17sm21482274pfc.41.2019.11.04.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:23:30 -0800 (PST)
From:   Jamal Shareef <jamal.k.shareef@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jamal Shareef <jamal.k.shareef@gmail.com>
Subject: [PATCH 3/3] drm/tegra: gr3d: Remove space after parenthesis
Date:   Mon,  4 Nov 2019 18:23:22 -0800
Message-Id: <54df25088b18fb99e44cfa3fb28d65ef8a0d3e40.1572920482.git.jamal.k.shareef@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes spaces after open parenthesis. Issue found by checkpatch.

Signed-off-by: Jamal Shareef <jamal.k.shareef@gmail.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 120 +++++++++++++++++------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 8b9a35b1cbb3..35d1dff067b7 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -176,16 +176,16 @@ static const struct of_device_id tegra_gr3d_match[] = {
 MODULE_DEVICE_TABLE(of, tegra_gr3d_match);
 
 static const u32 gr3d_addr_regs[] = {
-	GR3D_IDX_ATTRIBUTE( 0),
-	GR3D_IDX_ATTRIBUTE( 1),
-	GR3D_IDX_ATTRIBUTE( 2),
-	GR3D_IDX_ATTRIBUTE( 3),
-	GR3D_IDX_ATTRIBUTE( 4),
-	GR3D_IDX_ATTRIBUTE( 5),
-	GR3D_IDX_ATTRIBUTE( 6),
-	GR3D_IDX_ATTRIBUTE( 7),
-	GR3D_IDX_ATTRIBUTE( 8),
-	GR3D_IDX_ATTRIBUTE( 9),
+	GR3D_IDX_ATTRIBUTE(0),
+	GR3D_IDX_ATTRIBUTE(1),
+	GR3D_IDX_ATTRIBUTE(2),
+	GR3D_IDX_ATTRIBUTE(3),
+	GR3D_IDX_ATTRIBUTE(4),
+	GR3D_IDX_ATTRIBUTE(5),
+	GR3D_IDX_ATTRIBUTE(6),
+	GR3D_IDX_ATTRIBUTE(7),
+	GR3D_IDX_ATTRIBUTE(8),
+	GR3D_IDX_ATTRIBUTE(9),
 	GR3D_IDX_ATTRIBUTE(10),
 	GR3D_IDX_ATTRIBUTE(11),
 	GR3D_IDX_ATTRIBUTE(12),
@@ -196,16 +196,16 @@ static const u32 gr3d_addr_regs[] = {
 	GR3D_QR_ZTAG_ADDR,
 	GR3D_QR_CTAG_ADDR,
 	GR3D_QR_CZ_ADDR,
-	GR3D_TEX_TEX_ADDR( 0),
-	GR3D_TEX_TEX_ADDR( 1),
-	GR3D_TEX_TEX_ADDR( 2),
-	GR3D_TEX_TEX_ADDR( 3),
-	GR3D_TEX_TEX_ADDR( 4),
-	GR3D_TEX_TEX_ADDR( 5),
-	GR3D_TEX_TEX_ADDR( 6),
-	GR3D_TEX_TEX_ADDR( 7),
-	GR3D_TEX_TEX_ADDR( 8),
-	GR3D_TEX_TEX_ADDR( 9),
+	GR3D_TEX_TEX_ADDR(0),
+	GR3D_TEX_TEX_ADDR(1),
+	GR3D_TEX_TEX_ADDR(2),
+	GR3D_TEX_TEX_ADDR(3),
+	GR3D_TEX_TEX_ADDR(4),
+	GR3D_TEX_TEX_ADDR(5),
+	GR3D_TEX_TEX_ADDR(6),
+	GR3D_TEX_TEX_ADDR(7),
+	GR3D_TEX_TEX_ADDR(8),
+	GR3D_TEX_TEX_ADDR(9),
 	GR3D_TEX_TEX_ADDR(10),
 	GR3D_TEX_TEX_ADDR(11),
 	GR3D_TEX_TEX_ADDR(12),
@@ -213,16 +213,16 @@ static const u32 gr3d_addr_regs[] = {
 	GR3D_TEX_TEX_ADDR(14),
 	GR3D_TEX_TEX_ADDR(15),
 	GR3D_DW_MEMORY_OUTPUT_ADDRESS,
-	GR3D_GLOBAL_SURFADDR( 0),
-	GR3D_GLOBAL_SURFADDR( 1),
-	GR3D_GLOBAL_SURFADDR( 2),
-	GR3D_GLOBAL_SURFADDR( 3),
-	GR3D_GLOBAL_SURFADDR( 4),
-	GR3D_GLOBAL_SURFADDR( 5),
-	GR3D_GLOBAL_SURFADDR( 6),
-	GR3D_GLOBAL_SURFADDR( 7),
-	GR3D_GLOBAL_SURFADDR( 8),
-	GR3D_GLOBAL_SURFADDR( 9),
+	GR3D_GLOBAL_SURFADDR(0),
+	GR3D_GLOBAL_SURFADDR(1),
+	GR3D_GLOBAL_SURFADDR(2),
+	GR3D_GLOBAL_SURFADDR(3),
+	GR3D_GLOBAL_SURFADDR(4),
+	GR3D_GLOBAL_SURFADDR(5),
+	GR3D_GLOBAL_SURFADDR(6),
+	GR3D_GLOBAL_SURFADDR(7),
+	GR3D_GLOBAL_SURFADDR(8),
+	GR3D_GLOBAL_SURFADDR(9),
 	GR3D_GLOBAL_SURFADDR(10),
 	GR3D_GLOBAL_SURFADDR(11),
 	GR3D_GLOBAL_SURFADDR(12),
@@ -230,48 +230,48 @@ static const u32 gr3d_addr_regs[] = {
 	GR3D_GLOBAL_SURFADDR(14),
 	GR3D_GLOBAL_SURFADDR(15),
 	GR3D_GLOBAL_SPILLSURFADDR,
-	GR3D_GLOBAL_SURFOVERADDR( 0),
-	GR3D_GLOBAL_SURFOVERADDR( 1),
-	GR3D_GLOBAL_SURFOVERADDR( 2),
-	GR3D_GLOBAL_SURFOVERADDR( 3),
-	GR3D_GLOBAL_SURFOVERADDR( 4),
-	GR3D_GLOBAL_SURFOVERADDR( 5),
-	GR3D_GLOBAL_SURFOVERADDR( 6),
-	GR3D_GLOBAL_SURFOVERADDR( 7),
-	GR3D_GLOBAL_SURFOVERADDR( 8),
-	GR3D_GLOBAL_SURFOVERADDR( 9),
+	GR3D_GLOBAL_SURFOVERADDR(0),
+	GR3D_GLOBAL_SURFOVERADDR(1),
+	GR3D_GLOBAL_SURFOVERADDR(2),
+	GR3D_GLOBAL_SURFOVERADDR(3),
+	GR3D_GLOBAL_SURFOVERADDR(4),
+	GR3D_GLOBAL_SURFOVERADDR(5),
+	GR3D_GLOBAL_SURFOVERADDR(6),
+	GR3D_GLOBAL_SURFOVERADDR(7),
+	GR3D_GLOBAL_SURFOVERADDR(8),
+	GR3D_GLOBAL_SURFOVERADDR(9),
 	GR3D_GLOBAL_SURFOVERADDR(10),
 	GR3D_GLOBAL_SURFOVERADDR(11),
 	GR3D_GLOBAL_SURFOVERADDR(12),
 	GR3D_GLOBAL_SURFOVERADDR(13),
 	GR3D_GLOBAL_SURFOVERADDR(14),
 	GR3D_GLOBAL_SURFOVERADDR(15),
-	GR3D_GLOBAL_SAMP01SURFADDR( 0),
-	GR3D_GLOBAL_SAMP01SURFADDR( 1),
-	GR3D_GLOBAL_SAMP01SURFADDR( 2),
-	GR3D_GLOBAL_SAMP01SURFADDR( 3),
-	GR3D_GLOBAL_SAMP01SURFADDR( 4),
-	GR3D_GLOBAL_SAMP01SURFADDR( 5),
-	GR3D_GLOBAL_SAMP01SURFADDR( 6),
-	GR3D_GLOBAL_SAMP01SURFADDR( 7),
-	GR3D_GLOBAL_SAMP01SURFADDR( 8),
-	GR3D_GLOBAL_SAMP01SURFADDR( 9),
+	GR3D_GLOBAL_SAMP01SURFADDR(0),
+	GR3D_GLOBAL_SAMP01SURFADDR(1),
+	GR3D_GLOBAL_SAMP01SURFADDR(2),
+	GR3D_GLOBAL_SAMP01SURFADDR(3),
+	GR3D_GLOBAL_SAMP01SURFADDR(4),
+	GR3D_GLOBAL_SAMP01SURFADDR(5),
+	GR3D_GLOBAL_SAMP01SURFADDR(6),
+	GR3D_GLOBAL_SAMP01SURFADDR(7),
+	GR3D_GLOBAL_SAMP01SURFADDR(8),
+	GR3D_GLOBAL_SAMP01SURFADDR(9),
 	GR3D_GLOBAL_SAMP01SURFADDR(10),
 	GR3D_GLOBAL_SAMP01SURFADDR(11),
 	GR3D_GLOBAL_SAMP01SURFADDR(12),
 	GR3D_GLOBAL_SAMP01SURFADDR(13),
 	GR3D_GLOBAL_SAMP01SURFADDR(14),
 	GR3D_GLOBAL_SAMP01SURFADDR(15),
-	GR3D_GLOBAL_SAMP23SURFADDR( 0),
-	GR3D_GLOBAL_SAMP23SURFADDR( 1),
-	GR3D_GLOBAL_SAMP23SURFADDR( 2),
-	GR3D_GLOBAL_SAMP23SURFADDR( 3),
-	GR3D_GLOBAL_SAMP23SURFADDR( 4),
-	GR3D_GLOBAL_SAMP23SURFADDR( 5),
-	GR3D_GLOBAL_SAMP23SURFADDR( 6),
-	GR3D_GLOBAL_SAMP23SURFADDR( 7),
-	GR3D_GLOBAL_SAMP23SURFADDR( 8),
-	GR3D_GLOBAL_SAMP23SURFADDR( 9),
+	GR3D_GLOBAL_SAMP23SURFADDR(0),
+	GR3D_GLOBAL_SAMP23SURFADDR(1),
+	GR3D_GLOBAL_SAMP23SURFADDR(2),
+	GR3D_GLOBAL_SAMP23SURFADDR(3),
+	GR3D_GLOBAL_SAMP23SURFADDR(4),
+	GR3D_GLOBAL_SAMP23SURFADDR(5),
+	GR3D_GLOBAL_SAMP23SURFADDR(6),
+	GR3D_GLOBAL_SAMP23SURFADDR(7),
+	GR3D_GLOBAL_SAMP23SURFADDR(8),
+	GR3D_GLOBAL_SAMP23SURFADDR(9),
 	GR3D_GLOBAL_SAMP23SURFADDR(10),
 	GR3D_GLOBAL_SAMP23SURFADDR(11),
 	GR3D_GLOBAL_SAMP23SURFADDR(12),
-- 
2.17.1

