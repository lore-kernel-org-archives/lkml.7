Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C6C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8F727AFB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUxJ14Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFCDB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 23:01:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45473 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCDB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:01:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so9695011pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 20:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FVbLKJ7aHdVl9olP6rdiDo2FyvciQZ6SOLC15bFopUs=;
        b=JUxJ14EuMKRdzXXJnHjWCIA4R7kBcEmsSkQGdZH3lE4jYv715BnrdakjQqAJCSDOxf
         r2GEm4mvgKjfY57U2QZpUW3K/12ItP9/9YQb2NmTUd6SaiQmwpvgXJJynTZ/B6ZGCJSi
         pBwpTZ3DcSpHVkZZZfV/+bETZne+g8EmRI1F8oxbo9d4i93hzY7O0EeKoPgeAYzHCouH
         fCE321KyIc9QtGVLY1THGxJvgwkcQhbMWZVV3MncuHzMKU3G5KHF+mQx76SfczhJZFQd
         DQci1EcpJdg4D5/pTZADlFJs+s08N5QqrsrqDevtITPm83s2Beye6kyFOl0ttPo3r52j
         d4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FVbLKJ7aHdVl9olP6rdiDo2FyvciQZ6SOLC15bFopUs=;
        b=HfDnVdHjAAKPOxd/+QNUB/4W7SC6gC/hljPbJXmLvaG7M8oK5q+rH0zMgaTDimK/Rv
         4WFVhAsK6yi9rzIJtxMkPBqWLsU7zFdZ5sTgtCZ1E+PBrJmS65ewSueNQ7pvfGtUzumF
         hxkMlEADfCq0pXDoMJB+dlbe2jVJ7B9H4y85zTCvkyFkDaL4MTCKwQjWLtEufdS5vzsd
         +sjD0Fiba37e13bb7OWOr74QcS68Jgqf8/6TvEDglBGFO481pTM16dlOWahVtmDv5nHV
         q+sL9csR4Kz1piDQpgnMuddUzgbGsshj6ydinY8PLFFdiSBW1fgAfVCo7GxTiVVY72IJ
         ciAw==
X-Gm-Message-State: APjAAAXjrvDcZxzlh7WHaKb5oD96mk5LkldiqRFYuxObdkM9kXoIHgIy
        ux7IBVtbTDHGsWy7Bo77ccQ=
X-Google-Smtp-Source: APXvYqxUNmDjQvpsM4PrbSHqDfF6Oikg3UOWVN0H3OuTPiIN+Wg0Uy4PR0jcHezKI0HJgfNmeklV8Q==
X-Received: by 2002:a62:ee04:: with SMTP id e4mr27285689pfi.232.1559530888348;
        Sun, 02 Jun 2019 20:01:28 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id c16sm2244467pfc.69.2019.06.02.20.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Jun 2019 20:01:27 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/radeon: avoid a possible arrary overflow
Date:   Mon,  3 Jun 2019 11:02:37 +0800
Message-Id: <1559530957-11103-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking up the connector type make sure the index
is valid.  Avoids a later crash if we read past the end
of the array.

This bug is similar to the issue which was fixed in
commit e1718d97aa88 ("drm/amdgpu: avoid a possible
array overflow").

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index f422a8d..971c541 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -632,6 +632,10 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 					connector_object_id = con_obj_id;
 				}
 			} else {
+				if (con_obj_id >= ARRAY_SIZE(object_connector_convert)) {
+					DRM_ERROR("invalid con_obj_id %d\n", con_obj_id);
+					continue;
+				}
 				igp_lane_info = 0;
 				connector_type =
 				    object_connector_convert[con_obj_id];
-- 
2.7.4

