Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB4CA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F5220882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRNOreMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbfJVCl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:41:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387541AbfJVCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wf3I4OIkp0qm6tO7brfVABcNpcqMbdi2p8pnXmDdjTc=;
        b=DRNOreMxGrscVzzPj2fzM+VvJ/nUAcIqoSTrgbMBnpW9V3D2ArnO9L2DYvJppbsX61ZWsL
        1Zv7K+5n1fjql7wfDi8qSmwzgAnLHlkX7opVBRRu9ipCq50j4+05OugeOov6hnEQ01unsc
        0vE7CZ1HuTi/3kSbrz1c0j56/TB9TKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-QjKFinjDMgW6eY09foP7QA-1; Mon, 21 Oct 2019 22:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23FCA8017D9;
        Tue, 22 Oct 2019 02:41:22 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCA9060126;
        Tue, 22 Oct 2019 02:41:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/14] drm/amdgpu/dm: Resume short HPD IRQs before resuming MST topology
Date:   Mon, 21 Oct 2019 22:36:07 -0400
Message-Id: <20191022023641.8026-13-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QjKFinjDMgW6eY09foP7QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to be reprobing the entire topology state on resume
now using sideband transactions, we need to ensure that we actually have
short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
So, do that.

Changes since v3:
* Fix typo in comments

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 887bc1d5d9e2..8f67d301ad81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1186,15 +1186,15 @@ static int dm_resume(void *handle)
 =09/* program HPD filter */
 =09dc_resume(dm->dc);
=20
-=09/* On resume we need to  rewrite the MSTM control bits to enamble MST*/
-=09s3_handle_mst(ddev, false);
-
 =09/*
 =09 * early enable HPD Rx IRQ, should be done before set mode as short
 =09 * pulse interrupts are used for MST
 =09 */
 =09amdgpu_dm_irq_resume_early(adev);
=20
+=09/* On resume we need to rewrite the MSTM control bits to enable MST*/
+=09s3_handle_mst(ddev, false);
+
 =09/* Do detection*/
 =09drm_connector_list_iter_begin(ddev, &iter);
 =09drm_for_each_connector_iter(connector, &iter) {
--=20
2.21.0

