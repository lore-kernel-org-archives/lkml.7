Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE16C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBC12183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfDXS4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:56:24 -0400
Received: from anholt.net ([50.246.234.109]:40302 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbfDXS4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:56:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9736910A3399;
        Wed, 24 Apr 2019 11:56:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QLcSsQefhvOA; Wed, 24 Apr 2019 11:56:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EA1BF10A33B6;
        Wed, 24 Apr 2019 11:56:17 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3C77A2FE3AA9; Wed, 24 Apr 2019 11:56:17 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/2] drm/doc: Allow new UAPI to be used once it's in the driver's -next.
Date:   Wed, 24 Apr 2019 11:56:16 -0700
Message-Id: <20190424185617.16865-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to figure out if it was permissible to merge the Mesa
side of V3D's CSD support yet while it's in drm-misc-next but not
drm-next, and developers on #dri-devel IRC had differing opinions of
what the requirement was.  Propose a clarification here to see if Dave
Airlie agrees.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

Personally, I thought the rule was "has to be in drm-next", but
assuming our review processes aren't totally broken, this should be
enough.

 Documentation/gpu/drm-uapi.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index c9fd23efd957..8e5545dfbf82 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -92,8 +92,9 @@ leads to a few additional requirements:
   requirements by doing a quick fork.
 
 - The kernel patch can only be merged after all the above requirements are met,
-  but it **must** be merged **before** the userspace patches land. uAPI always flows
-  from the kernel, doing things the other way round risks divergence of the uAPI
+  but it **must** be merged to the driver's -next tree (as documented in
+  MAINTAINERS) **before** the userspace patches land. uAPI always flows from
+  the kernel, doing things the other way round risks divergence of the uAPI
   definitions and header files.
 
 These are fairly steep requirements, but have grown out from years of shared
-- 
2.20.1

