Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B710C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F010421734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624397;
	bh=XOMQrsv1n430giOAfiXaba/kabfX/GmaTkLEaYI6iKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UVGF2/UwLE1LVnEx/8EV8W1IWDyVHgIgUXMvbG04Q80bdMFn7GZfG3cf8+0zHaf9
	 l4EGyIWXKFEFKc8NWf90gm2j9Krg8+zgoKCKHeY0vSdJwnTblZYUMdNWPLc6YOMG3I
	 87jhTShUDAFxr5I4c4M/PPrlc9azhkd811OOK3D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfD3Lj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfD3Ljs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:39:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0940021670;
        Tue, 30 Apr 2019 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624387;
        bh=XOMQrsv1n430giOAfiXaba/kabfX/GmaTkLEaYI6iKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRcep203awC2ZsU/JyZSPcfxQyo6sdV3es7k9jW5rTEazb0X8cSmNi+qwTiVuo1nL
         fJHJ1L5BiLO0KChePk91U1sWDddM6/hplr2koeNHTIi9JbDvGPX+nBnuucodMmMcTD
         B+w64PkeTbBJSfVRuLOfXSIW9a+5hf2dYLs4UJsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        kbuild test robot <lkp@intel.com>,
        Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.9 16/41] drm/vc4: Fix compilation error reported by kbuild test bot
Date:   Tue, 30 Apr 2019 13:38:27 +0200
Message-Id: <20190430113528.917882238@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113524.451237916@linuxfoundation.org>
References: <20190430113524.451237916@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit 462ce5d963f18b71c63f6b7730a35a2ee5273540 upstream.

A pointer to crtc was missing, resulting in the following build error:
drivers/gpu/drm/vc4/vc4_crtc.c:1045:44: sparse: sparse: incorrect type in argument 1 (different base types)
drivers/gpu/drm/vc4/vc4_crtc.c:1045:44: sparse:    expected struct drm_crtc *crtc
drivers/gpu/drm/vc4/vc4_crtc.c:1045:44: sparse:    got struct drm_crtc_state *state
drivers/gpu/drm/vc4/vc4_crtc.c:1045:39: sparse: sparse: not enough arguments for function vc4_crtc_destroy_state

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/2b6ed5e6-81b0-4276-8860-870b54ca3262@linux.intel.com
Fixes: d08106796a78 ("drm/vc4: Fix memory leak during gpu reset.")
Cc: <stable@vger.kernel.org> # v4.6+
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_crtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -846,7 +846,7 @@ static void
 vc4_crtc_reset(struct drm_crtc *crtc)
 {
 	if (crtc->state)
-		vc4_crtc_destroy_state(crtc->state);
+		vc4_crtc_destroy_state(crtc, crtc->state);
 
 	crtc->state = kzalloc(sizeof(struct vc4_crtc_state), GFP_KERNEL);
 	if (crtc->state)


