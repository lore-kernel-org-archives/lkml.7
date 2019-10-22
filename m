Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7029CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9CA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSSCHIDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfJVCkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:40:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39305 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387462AbfJVCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5jcZwjlYxKIN+ZIuBL1G9ofGIMh7sLLjPY6LJCqd3Y=;
        b=FSSCHIDONGz/B73qnUas3fXtCoOZGIT1pxIuS211EZKg7PWlaSpinKiCjNVm3h6qkE29/q
        FoKqM0JBO6yW3f9261SwhTTihS0VDqb22vFzc5PEZu41n2r+QvtRsj/2a1ZmB3kafLQUID
        n79jNajx2ei05qZazQoJ/qQgM2Zmv84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-HUmMC_PYMZ27M5xQzaJrQA-1; Mon, 21 Oct 2019 22:40:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04AC1107AD31;
        Tue, 22 Oct 2019 02:40:26 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D54FD60126;
        Tue, 22 Oct 2019 02:40:22 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/14] drm/nouveau: Don't grab runtime PM refs for HPD IRQs
Date:   Mon, 21 Oct 2019 22:36:04 -0400
Message-Id: <20191022023641.8026-10-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HUmMC_PYMZ27M5xQzaJrQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for suspend/resume reprobing to work, we need to be able to
perform sideband communications during suspend/resume, along with
runtime PM suspend/resume. In order to do so, we also need to make sure
that nouveau doesn't bother grabbing a runtime PM reference to do so,
since otherwise we'll start deadlocking runtime PM again.

Note that we weren't able to do this before, because of the DP MST
helpers processing UP requests from topologies in the same context as
drm_dp_mst_hpd_irq() which would have caused us to open ourselves up to
receiving hotplug events and deadlocking with runtime suspend/resume.
Now that those requests are handled asynchronously, this change should
be completely safe.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 33 +++++++++++----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/=
nouveau/nouveau_connector.c
index 3a5db17bc5c7..5b413588b823 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1130,6 +1130,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify=
)
 =09const char *name =3D connector->name;
 =09struct nouveau_encoder *nv_encoder;
 =09int ret;
+=09bool plugged =3D (rep->mask !=3D NVIF_NOTIFY_CONN_V0_UNPLUG);
+
+=09if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
+=09=09NV_DEBUG(drm, "service %s\n", name);
+=09=09drm_dp_cec_irq(&nv_connector->aux);
+=09=09if ((nv_encoder =3D find_encoder(connector, DCB_OUTPUT_DP)))
+=09=09=09nv50_mstm_service(nv_encoder->dp.mstm);
+
+=09=09return NVIF_NOTIFY_KEEP;
+=09}
=20
 =09ret =3D pm_runtime_get(drm->dev->dev);
 =09if (ret =3D=3D 0) {
@@ -1150,25 +1160,16 @@ nouveau_connector_hotplug(struct nvif_notify *notif=
y)
 =09=09return NVIF_NOTIFY_DROP;
 =09}
=20
-=09if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
-=09=09NV_DEBUG(drm, "service %s\n", name);
-=09=09drm_dp_cec_irq(&nv_connector->aux);
-=09=09if ((nv_encoder =3D find_encoder(connector, DCB_OUTPUT_DP)))
-=09=09=09nv50_mstm_service(nv_encoder->dp.mstm);
-=09} else {
-=09=09bool plugged =3D (rep->mask !=3D NVIF_NOTIFY_CONN_V0_UNPLUG);
-
+=09if (!plugged)
+=09=09drm_dp_cec_unset_edid(&nv_connector->aux);
+=09NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
+=09if ((nv_encoder =3D find_encoder(connector, DCB_OUTPUT_DP))) {
 =09=09if (!plugged)
-=09=09=09drm_dp_cec_unset_edid(&nv_connector->aux);
-=09=09NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
-=09=09if ((nv_encoder =3D find_encoder(connector, DCB_OUTPUT_DP))) {
-=09=09=09if (!plugged)
-=09=09=09=09nv50_mstm_remove(nv_encoder->dp.mstm);
-=09=09}
-
-=09=09drm_helper_hpd_irq_event(connector->dev);
+=09=09=09nv50_mstm_remove(nv_encoder->dp.mstm);
 =09}
=20
+=09drm_helper_hpd_irq_event(connector->dev);
+
 =09pm_runtime_mark_last_busy(drm->dev->dev);
 =09pm_runtime_put_autosuspend(drm->dev->dev);
 =09return NVIF_NOTIFY_KEEP;
--=20
2.21.0

