Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58511C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241762166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGZVrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:47:06 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:41062 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfGZVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 3556D19315;
        Fri, 26 Jul 2019 23:47:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HgFx9HJp6DC3; Fri, 26 Jul 2019 23:47:03 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 861ED19312;
        Fri, 26 Jul 2019 23:47:03 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1hr83K-00012p-Gb; Fri, 26 Jul 2019 23:47:02 +0200
Date:   Fri, 26 Jul 2019 23:47:02 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        931507@bugs.debian.org
Subject: [PATCHv2] hda: Fix 1-minute detection delay when i915 module is not
 available
Message-ID: <20190726214702.kxi2gavlieiwyf7q@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        931507@bugs.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distribution installation images such as Debian include different sets
of modules which can be downloaded dynamically.  Such images may notably
include the hda sound modules but not the i915 DRM module, even if the
latter was enabled at build time, as reported on
https://bugs.debian.org/931507

In such a case hdac_i915 would be linked in and try to load the i915
module, fail since it is not there, but still wait for a whole minute
before giving up binding with it.

This fixes such as case by only waiting for the binding if the module
was properly loaded (or module support is disabled, in which case i915
is already compiled-in anyway).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 sound/hda/hdac_i915.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -136,10 +136,13 @@ int snd_hdac_i915_init(struct hdac_bus *
 	if (!acomp)
 		return -ENODEV;
 	if (!acomp->ops) {
-		request_module("i915");
-		/* 60s timeout */
-		wait_for_completion_timeout(&bind_complete,
-					    msecs_to_jiffies(60 * 1000));
+		if (!IS_ENABLED(CONFIG_MODULES) ||
+		    !request_module("i915"))
+		{
+			/* 60s timeout */
+			wait_for_completion_timeout(&bind_complete,
+						   msecs_to_jiffies(60 * 1000));
+		}
 	}
 	if (!acomp->ops) {
 		dev_info(bus->dev, "couldn't bind with audio component\n");
