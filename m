Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC09C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730E92196E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfJHLHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:07:46 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51059 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:07:45 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iHnLC-0006Y7-IO; Tue, 08 Oct 2019 12:07:42 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iHnLB-0003aj-Qh; Tue, 08 Oct 2019 12:07:41 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/3] drm/nouveau/kms/nv50-: make unexported items static
Date:   Tue,  8 Oct 2019 12:07:38 +0100
Message-Id: <20191008110739.13757-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008110739.13757-1-ben.dooks@codethink.co.uk>
References: <20191008110739.13757-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make functions that are not used directly outside the file
they are in static to avoid the following warnings:

drivers/gpu/drm/nouveau/dispnv50/headc57d.c:73:1: warning: symbol 'headc57d_olut_clr' was not declared. Should it be static?
drivers/gpu/drm/nouveau/dispnv50/headc57d.c:85:1: warning: symbol 'headc57d_olut_set' was not declared. Should it be static?
drivers/gpu/drm/nouveau/dispnv50/headc57d.c:155:1: warning: symbol 'headc57d_olut' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index 32a7f9e85fb0..f3d46276a7c4 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -69,7 +69,7 @@ headc57d_procamp(struct nv50_head *head, struct nv50_head_atom *asyh)
 	}
 }
 
-void
+static void
 headc57d_olut_clr(struct nv50_head *head)
 {
 	struct nv50_dmac *core = &nv50_disp(head->base.base.dev)->core->chan;
@@ -81,7 +81,7 @@ headc57d_olut_clr(struct nv50_head *head)
 	}
 }
 
-void
+static void
 headc57d_olut_set(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	struct nv50_dmac *core = &nv50_disp(head->base.base.dev)->core->chan;
@@ -151,7 +151,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size, void __iomem *mem)
 	writew(readw(mem - 4), mem + 4);
 }
 
-void
+static void
 headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	asyh->olut.mode = 2; /* DIRECT10 */
-- 
2.23.0

