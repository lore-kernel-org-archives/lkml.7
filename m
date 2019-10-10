Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551C621D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696823;
	bh=vbgDH5249EV0bJnz9nY2ORMiQg8hmDmPY9XI8g4iOL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMHhieiTfZNzYmc3hNFksSVXh3FUicrmeLd+7LzCwNGx2QtT6fsR58W8fYP5jS9S5
	 kZ+V0pQLjSJBjh2CVJzgqdiu2GNslcQQ4shRLg2X86sP/CeoQ9yhGRroOZoZbXRLCM
	 qC393oLzwgTJWFhbL1UKMi/8xxz+/oqEeRQqtXk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfJJIkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbfJJIkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:40:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7610218AC;
        Thu, 10 Oct 2019 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696819;
        bh=vbgDH5249EV0bJnz9nY2ORMiQg8hmDmPY9XI8g4iOL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfmSO5EGTFl+hibl8zY7iz1ji69f3M0XXP51xU83diZB5R8f1VD/i8Q2GEJoH+i7j
         taDaiAy4jF3FxXyH0Yp+4zuXJUpehSg4Tp7ObZQE6PcLstdXvyLjpx1z8zzPl+MNX3
         LiX0CQ1d+1tqwNtuCOdTAsGzvzHFEURPfZcOyHM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexdeucher@gmail.com>,
        Adam Jackson <ajax@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 5.3 063/148] drm/atomic: Reject FLIP_ASYNC unconditionally
Date:   Thu, 10 Oct 2019 10:35:24 +0200
Message-Id: <20191010083615.262955181@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit f2cbda2dba11de868759cae9c0d2bab5b8411406 upstream.

It's never been wired up. Only userspace that tried to use it (and
didn't actually check whether anything works, but hey it builds) is
the -modesetting atomic implementation. And we just shut that up.

If there's anyone else then we need to silently accept this flag no
matter what, and find a new one. Because once a flag is tainted, it's
lost.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Michel Dänzer <michel@daenzer.net>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Adam Jackson <ajax@redhat.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190903190642.32588-2-daniel.vetter@ffwll.ch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic_uapi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1301,8 +1301,7 @@ int drm_mode_atomic_ioctl(struct drm_dev
 	if (arg->reserved)
 		return -EINVAL;
 
-	if ((arg->flags & DRM_MODE_PAGE_FLIP_ASYNC) &&
-			!dev->mode_config.async_page_flip)
+	if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)
 		return -EINVAL;
 
 	/* can't test and expect an event at the same time. */


