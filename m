Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC25C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98DB27280
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395151;
	bh=xgM/0zR1Re+p+SRvP4V+6y1AYNCntVtbaaDoL2WYHZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RoZRnC0mpo3t4O6MZKhPliBPul31AvqePmPV4LeBpsyIb0uDcYExvNvVZlS7r/2J9
	 cOLm50VPF+CbwvmjuifmKXQ+t/eS0R2BoiF/DE6uZC84wFnFWqCsadYyMIsjHzIJmI
	 t7u7XQDavniEbrKbRAQsBcU6/WGQK4dLVG0dyMk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfFANTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfFANTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:19:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D359E272BE;
        Sat,  1 Jun 2019 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395148;
        bh=xgM/0zR1Re+p+SRvP4V+6y1AYNCntVtbaaDoL2WYHZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzQz/d6JZ0fGaGgiXttBtPEp1PWguJ5M/RBlqAXN8rKfgU+5YlESuECYRM1p3xHfE
         g6AdKjp9OngYiOM1MxLxlAYj0Z6wcHZMDoBBB2aUYwLo60NaQm/H2+z7rufOvUcp2t
         lV8yrKRwjkOaMs422mfvugl+KGUKOUPi9inqOi4E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marko Myllynen <myllynen@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 065/186] fbcon: Don't reset logo_shown when logo is currently shown
Date:   Sat,  1 Jun 2019 09:14:41 -0400
Message-Id: <20190601131653.24205-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Schwab <schwab@linux-m68k.org>

[ Upstream commit 3c5a1b111373e669c8220803464c3a508a87e254 ]

When the logo is currently drawn on a virtual console, and the console
loglevel is reduced to quiet, logo_shown must be left alone, so that it
the scrolling region on that virtual console is properly reset.

Fixes: 10993504d647 ("fbcon: Silence fbcon logo on 'quiet' boots")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Marko Myllynen <myllynen@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cd059a801662e..786f9aab55df6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1069,7 +1069,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	cap = info->flags;
 
-	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
+	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
 		logo_shown = FBCON_LOGO_DONTSHOW;
 
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
-- 
2.20.1

