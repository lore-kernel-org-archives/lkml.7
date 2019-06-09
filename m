Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3034C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793E8206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099059;
	bh=Kyw+DKCc0PB3LdzCySl7UpeaARmShREkB7OnDvbwj0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVkYsEPPBOj9793kH5BHfN1aMJN6Q0JIBDrImVJ1XY1ftM2lvr0tBCUgQOowL3P7m
	 uz7Ggk8A4ec3K5lqojGfi+2VBE7z4Evs08Y28WXoJiVA7tPU3z6uUNWjnsJng6XYGa
	 MPGojttg4/pi7TUB8KwHTa3FPXDfwwZ4LJcmFM5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfFIQu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbfFIQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:50:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCE520843;
        Sun,  9 Jun 2019 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099054;
        bh=Kyw+DKCc0PB3LdzCySl7UpeaARmShREkB7OnDvbwj0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jgx4n08eO9IXYh7o/j8gKa+CGuxucj7J42qGMNPhmIcUnZMkiLyCHjEWnXVsV7GnJ
         9ofv0DyYypm19RnZlD3sgu7y1Y/if7R6W5LIlWbuU2YW/hRifyHbyMlLuZiSeT24Yx
         z3kR8JMO4nyWj3wP04TRyQpmOyzw9lUylk93H0pU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 31/35] drm/i915/fbc: disable framebuffer compression on GeminiLake
Date:   Sun,  9 Jun 2019 18:42:37 +0200
Message-Id: <20190609164127.307742746@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

commit 396dd8143bdd94bd1c358a228a631c8c895a1126 upstream.

On many (all?) the Gemini Lake systems we work with, there is frequent
momentary graphical corruption at the top of the screen, and it seems
that disabling framebuffer compression can avoid this.

The ticket was reported 6 months ago and has already affected a
multitude of users, without any real progress being made. So, lets
disable framebuffer compression on GeminiLake until a solution is found.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108085
Fixes: fd7d6c5c8f3e ("drm/i915: enable FBC on gen9+ too")
Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.11+
Reviewed-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190423092810.28359-1-jian-hong@endlessm.com
(cherry picked from commit 1d25724b41fad7eeb2c3058a5c8190d6ece73e08)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_fbc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/i915/intel_fbc.c
+++ b/drivers/gpu/drm/i915/intel_fbc.c
@@ -1299,6 +1299,10 @@ static int intel_sanitize_fbc_option(str
 	if (!HAS_FBC(dev_priv))
 		return 0;
 
+	/* https://bugs.freedesktop.org/show_bug.cgi?id=108085 */
+	if (IS_GEMINILAKE(dev_priv))
+		return 0;
+
 	if (IS_BROADWELL(dev_priv) || INTEL_GEN(dev_priv) >= 9)
 		return 1;
 


