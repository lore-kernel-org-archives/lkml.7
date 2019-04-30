Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F145C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044582075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625535;
	bh=S0SOl4WlJ3Nkb7wjdnQgB3nyI8KIwfRHP3+uxXnFOrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jq0Ic7HJrtZyEr5X54kF3ajoL4UpfHkuy95rQj1TQ8qLJ5OLwy6pDerV/N9MejfPd
	 La6zm2DkTZyyHcDaO87RgRr0MpcIdbu6mPVx6ytOBAmadmoTaB6SbOQJsAgJt9oVHG
	 EsjFRxImT+zTX/0fIBJ1uWWEwy9/JySTI0xlY3wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfD3L6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbfD3LrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:47:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D3020449;
        Tue, 30 Apr 2019 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624823;
        bh=S0SOl4WlJ3Nkb7wjdnQgB3nyI8KIwfRHP3+uxXnFOrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgNr8khph1GC1A27p5IcN1FVLN/KtHU6Uj5ELSrTpbtKbrQioDx0uAbuaLyaBwXYD
         sZFCVpIgQuGKndKgoyGjDjKvlrQydLLoftz4Iht5NsrHGznAQGH4V031fhc6qMzhwJ
         Irz27+adxX3Yn4Xjy5MUKfMRc0eh8fTEnePwEYas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        kbuild test robot <lkp@intel.com>,
        Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 049/100] drm/vc4: Fix compilation error reported by kbuild test bot
Date:   Tue, 30 Apr 2019 13:38:18 +0200
Message-Id: <20190430113611.343971382@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
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
@@ -998,7 +998,7 @@ static void
 vc4_crtc_reset(struct drm_crtc *crtc)
 {
 	if (crtc->state)
-		vc4_crtc_destroy_state(crtc->state);
+		vc4_crtc_destroy_state(crtc, crtc->state);
 
 	crtc->state = kzalloc(sizeof(struct vc4_crtc_state), GFP_KERNEL);
 	if (crtc->state)


