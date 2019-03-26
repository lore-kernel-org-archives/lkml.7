Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB768C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D3220823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfCZCVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:21:03 -0400
Received: from www.osadl.org ([62.245.132.105]:46944 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbfCZCVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:21:03 -0400
X-Greylist: delayed 1229 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 22:21:01 EDT
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x2Q20GmX005010;
        Tue, 26 Mar 2019 03:00:16 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [RFC PATCH] drm/nouveau/fb/ram/gk104: move assignment out of condition
Date:   Tue, 26 Mar 2019 02:55:18 +0100
Message-Id: <1553565318-15108-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"hiding" unconditional assignments in the if() parentesis makes for
hard to read code and has no advantage over placing these assignments
in proper formated lines before the if() statement. Simply move those
lines out.

Before sending out roughly 20 patches to fix the roughly 50 cases - all
in the nouveau driver. I would like to know if this will be accepted at
all. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by and experiemental coccinelle script.

Note that the last hunk retained the if (i == 0) rather than switching
to a more consistent if (!i) - but then again the code is not really
consistent on that - so not sure if that should be done or not.

Cocciscript to generate the appropriate patches - note though that it
will *not* remove excess parentesis where these are present in the
current code:
<snip>
/// Check for unconditional code "hiding" in an if condition
/// effectively that code is unconditionally executed before
/// reaching the actual branch statement - which just makes it
/// hard to read and thus is always wrong.
/// Some of the cases found also look buggy
/// In other cases some excess () are left in place in the
/// generated patches - so some postprocessing may be needed.
///
/// As of 5.0-rc8 all 50 cases look like they are found and fixed
/// correctly - correctly only in the sense that the patched
/// code is equivalent to the original code. but as this is in
/// the nouveau driver only it might well be that this only
/// fits that specific pattern and others might have wilder ways
/// to achieve the same level of confusing code- so confidence
/// Low for now (though the the nouveau cases all are patched
/// correctly)
///
// Copyright: (C) 2019 Nicholas Mc Guire. GPL-V2.
// Confidence: Low
// Comments:
// Options: --no-includes --include-headers

virtual patch
virtual report

@badif@
position p;
statement S;
expression E1,E2;
@@

  if@p (E1,E2) S

@script:python depends on report@
p << badif.p;
@@

msg = "unconditional code hiding in if condition"
coccilib.report.print_report(p[0],msg)

@fixbadif depends on badif && patch@
position p=badif.p;
statement S;
expression E1=badif.E1,E2=badif.E2;
@@

+ E1;
  if@p (
- E1,
  E2)
  S

@script:python depends on patch@
p << fixbadif.p;
@@
<snip>

 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c | 42 +++++++++++++++--------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
index 8bcb7e7..885c24d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
@@ -1168,7 +1168,8 @@ gk104_ram_prog_0(struct gk104_ram *ram, u32 freq)
 	if (&cfg->head == &ram->cfg)
 		return;
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0a_03fe) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0a_03fe) {
 		data |= cfg->bios.rammap_11_0a_03fe << 12;
 		mask |= 0x001ff000;
 	}
@@ -1178,31 +1179,36 @@ gk104_ram_prog_0(struct gk104_ram *ram, u32 freq)
 	}
 	nvkm_mask(device, 0x10f468, mask, data);
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0a_0400) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0a_0400) {
 		data |= cfg->bios.rammap_11_0a_0400;
 		mask |= 0x00000001;
 	}
 	nvkm_mask(device, 0x10f420, mask, data);
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0a_0800) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0a_0800) {
 		data |= cfg->bios.rammap_11_0a_0800;
 		mask |= 0x00000001;
 	}
 	nvkm_mask(device, 0x10f430, mask, data);
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0b_01f0) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0b_01f0) {
 		data |= cfg->bios.rammap_11_0b_01f0;
 		mask |= 0x0000001f;
 	}
 	nvkm_mask(device, 0x10f400, mask, data);
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0b_0200) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0b_0200) {
 		data |= cfg->bios.rammap_11_0b_0200 << 9;
 		mask |= 0x00000200;
 	}
 	nvkm_mask(device, 0x10f410, mask, data);
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0d) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0d) {
 		data |= cfg->bios.rammap_11_0d << 16;
 		mask |= 0x00ff0000;
 	}
@@ -1212,7 +1218,8 @@ gk104_ram_prog_0(struct gk104_ram *ram, u32 freq)
 	}
 	nvkm_mask(device, 0x10f440, mask, data);
 
-	if (mask = 0, data = 0, ram->diff.rammap_11_0e) {
+	mask = 0, data = 0;
+	if (ram->diff.rammap_11_0e) {
 		data |= cfg->bios.rammap_11_0e << 8;
 		mask |= 0x0000ff00;
 	}
@@ -1453,17 +1460,21 @@ gk104_ram_ctor_data(struct gk104_ram *ram, u8 ramcfg, int i)
 
 	/* memory config data for a range of target frequencies */
 	data = nvbios_rammapEp(bios, i, &ver, &hdr, &cnt, &len, &cfg->bios);
-	if (ret = -ENOENT, !data)
+	ret = -ENOENT;
+	if (!data)
 		goto done;
-	if (ret = -ENOSYS, ver != 0x11 || hdr < 0x12)
+	ret = -ENOSYS;
+	if (ver != 0x11 || hdr < 0x12)
 		goto done;
 
 	/* ... and a portion specific to the attached memory */
 	data = nvbios_rammapSp(bios, data, ver, hdr, cnt, len, ramcfg,
 			       &ver, &hdr, &cfg->bios);
-	if (ret = -EINVAL, !data)
+	ret = -EINVAL;
+	if (!data)
 		goto done;
-	if (ret = -ENOSYS, ver != 0x11 || hdr < 0x0a)
+	ret = -ENOSYS;
+	if (ver != 0x11 || hdr < 0x0a)
 		goto done;
 
 	/* lookup memory timings, if bios says they're present */
@@ -1471,14 +1482,17 @@ gk104_ram_ctor_data(struct gk104_ram *ram, u8 ramcfg, int i)
 		data = nvbios_timingEp(bios, cfg->bios.ramcfg_timing,
 				       &ver, &hdr, &cnt, &len,
 				       &cfg->bios);
-		if (ret = -EINVAL, !data)
+		ret = -EINVAL;
+		if (!data)
 			goto done;
-		if (ret = -ENOSYS, ver != 0x20 || hdr < 0x33)
+		ret = -ENOSYS;
+		if (ver != 0x20 || hdr < 0x33)
 			goto done;
 	}
 
 	list_add_tail(&cfg->head, &ram->cfg);
-	if (ret = 0, i == 0)
+	ret = 0;
+	if (i == 0)
 		goto done;
 
 	d->rammap_11_0a_03fe |= p->rammap_11_0a_03fe != n->rammap_11_0a_03fe;
-- 
2.1.4

