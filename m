Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53772ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FF20640
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:42:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53648 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:42:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iHV8x-0000bB-Pu; Mon, 07 Oct 2019 15:41:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: make array hw_engine_mask static, makes object smaller
Date:   Mon,  7 Oct 2019 16:41:51 +0100
Message-Id: <20191007154151.23245-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array hw_engine_mask on the stack but instead make it
static. Makes the object code smaller by 316 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  34004	   4388	    320	  38712	   9738	gpu/drm/i915/gt/intel_reset.o

After:
   text	   data	    bss	    dec	    hex	filename
  33528	   4548	    320	  38396	   95fc	gpu/drm/i915/gt/intel_reset.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/gt/intel_reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index eeb3bd0c4d69..db58ca9bee3a 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -285,7 +285,7 @@ static int gen6_reset_engines(struct intel_gt *gt,
 			      unsigned int retry)
 {
 	struct intel_engine_cs *engine;
-	const u32 hw_engine_mask[] = {
+	static const u32 hw_engine_mask[] = {
 		[RCS0]  = GEN6_GRDOM_RENDER,
 		[BCS0]  = GEN6_GRDOM_BLT,
 		[VCS0]  = GEN6_GRDOM_MEDIA,
@@ -408,7 +408,7 @@ static int gen11_reset_engines(struct intel_gt *gt,
 			       intel_engine_mask_t engine_mask,
 			       unsigned int retry)
 {
-	const u32 hw_engine_mask[] = {
+	static const u32 hw_engine_mask[] = {
 		[RCS0]  = GEN11_GRDOM_RENDER,
 		[BCS0]  = GEN11_GRDOM_BLT,
 		[VCS0]  = GEN11_GRDOM_MEDIA,
-- 
2.20.1

