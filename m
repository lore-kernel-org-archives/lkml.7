Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BB1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3E020818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919217;
	bh=Iw1X6AK5j5XgsceJxtGzhsLo/Icfgvf1doooyJUqZt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1PiUABT5WTQ6vmFfyU3wsAwxW4rofbKcXQUT9psl0HbJ9Z+SfAQd/ag+SsbfeSsq
	 rUn9n6IE5ElaziZGQBJwaBTlBeBOoslUN39zRBoiYPIxSIHcNmv83xXFtkDnXXE44U
	 o4tv9qi+sC0O14FTiQWozXsSU6ITkcxAZ1Fppo6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfEOLUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731046AbfEOLT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:19:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5BB20862;
        Wed, 15 May 2019 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919198;
        bh=Iw1X6AK5j5XgsceJxtGzhsLo/Icfgvf1doooyJUqZt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIlzsBufaH3uTKgozk1BbEdWeWuA3OLKBa+txg2KaeUABPEokgCNd3NwL8UFOBkZi
         2m2H2Pjy2/Z0vqb9to64SD3UWDrcP1mLck1Ff48X9nplUWTVRLoxHeYqOasxoYxwVu
         srrz1WGYY3cos6NWE2EMEf6t5JvyrJUZQCldFMNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 059/115] drm/i915: Downgrade Gen9 Plane WM latency error
Date:   Wed, 15 May 2019 12:55:39 +0200
Message-Id: <20190515090703.846879299@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 86c1c87d0e6241cbe35bd52badfc84b154e1b959 ]

According to intel_read_wm_latency() it is perfectly legal for one WM
and all subsequent levels to be 0 (and the deeper powersaving states
disabled), so don't shout *ERROR*, over and over again.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180726161527.10516-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/i915/intel_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 96a5237741e0c..cb377b003321a 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -2934,8 +2934,8 @@ static void intel_print_wm_latency(struct drm_i915_private *dev_priv,
 		unsigned int latency = wm[level];
 
 		if (latency == 0) {
-			DRM_ERROR("%s WM%d latency not provided\n",
-				  name, level);
+			DRM_DEBUG_KMS("%s WM%d latency not provided\n",
+				      name, level);
 			continue;
 		}
 
-- 
2.20.1



