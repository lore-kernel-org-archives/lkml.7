Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F2C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41459208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404064AbfIMW1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404021AbfIMW1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:27:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA57D3082E57;
        Fri, 13 Sep 2019 22:27:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2025060BF1;
        Fri, 13 Sep 2019 22:27:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/encoder: Fix possible_clones documentation
Date:   Fri, 13 Sep 2019 18:27:01 -0400
Message-Id: <20190913222704.8241-2-lyude@redhat.com>
In-Reply-To: <20190913222704.8241-1-lyude@redhat.com>
References: <20190913222704.8241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 13 Sep 2019 22:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We say that all of the bits in possible_clones must be set before
calling drm_encoder_init(). This isn't true though, since:

* The driver may not even have all of the encoder objects that could be
  used as clones initialized at that point
* possible_crtcs isn't used at all outside of userspace, so it's not
  actually needed to initialize it until drm_dev_register()

So, fix it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_encoder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 70cfca03d812..81273b50b3f6 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -154,7 +154,7 @@ struct drm_encoder {
 	 * using drm_encoder_index() as the index into the bitfield. The driver
 	 * must set the bits for all &drm_encoder objects which can clone a
 	 * &drm_crtc together with this encoder before calling
-	 * drm_encoder_init(). Drivers should set the bit representing the
+	 * drm_dev_register(). Drivers should set the bit representing the
 	 * encoder itself, too. Cloning bits should be set such that when two
 	 * encoders can be used in a cloned configuration, they both should have
 	 * each another bits set.
-- 
2.21.0

