Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89634C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5689C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbfJONzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:55:23 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48771 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfJONzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:55:22 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKNIC-0003s9-Sv; Tue, 15 Oct 2019 14:55:17 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKNIC-0002ho-Du; Tue, 15 Oct 2019 14:55:16 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/disp/gv100: make gv100_disp_core_mthd_{base,sor} static
Date:   Tue, 15 Oct 2019 14:55:15 +0100
Message-Id: <20191015135515.10357-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gv100_disp_core_mthd_{base,sor} are not used outside
of the file they are defined in, so make them static to
avoid the following sparse warning:

drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c:27:1: warning: symbol 'gv100_disp_core_mthd_base' was not declared. Should it be static?
drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c:43:1: warning: symbol 'gv100_disp_core_mthd_sor' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Bad divisor in main::vcs_assign: 0
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
index 4592d0e69fec..9594ba732113 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
@@ -23,7 +23,7 @@
 
 #include <subdev/timer.h>
 
-const struct nv50_disp_mthd_list
+static const struct nv50_disp_mthd_list
 gv100_disp_core_mthd_base = {
 	.mthd = 0x0000,
 	.addr = 0x000000,
@@ -39,7 +39,7 @@ gv100_disp_core_mthd_base = {
 	}
 };
 
-const struct nv50_disp_mthd_list
+static const struct nv50_disp_mthd_list
 gv100_disp_core_mthd_sor = {
 	.mthd = 0x0020,
 	.addr = 0x000020,
-- 
2.23.0

