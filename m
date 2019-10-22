Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B612166E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlkmkkMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfJVCkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:40:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387462AbfJVCkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZdUhVKkftltagMebxpbhd4zgoUdMWHISXefOvdS+cU=;
        b=RlkmkkMmWbD7GK2eo/hNKfAAvZsGTRq5UHas1P5lpxob2gR06+wIHfsqH5B9Lyv9aeDYrw
        RgNp79U1NXKR8sIUl+LPYEMHETWCcUqA/7kZ1dm9ga0zkxFZAypEF96PgGDc0pJpIpVHn5
        OpHp/P4ZJKfOxpvelIEPmG3GncBz4mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-tzxQeZjGNL6Y49eMud6FTw-1; Mon, 21 Oct 2019 22:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A46021005500;
        Tue, 22 Oct 2019 02:40:29 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91C0760126;
        Tue, 22 Oct 2019 02:40:26 +0000 (UTC)
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
Subject: [PATCH v5 10/14] drm/nouveau: Resume hotplug interrupts earlier
Date:   Mon, 21 Oct 2019 22:36:05 -0400
Message-Id: <20191022023641.8026-11-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tzxQeZjGNL6Y49eMud6FTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we enable hotplug detection only after we re-enable the
display. However, this is too late if we're planning on sending sideband
messages during the resume process - which we'll need to do in order to
reprobe the topology on resume.

So, enable hotplug events before reinitializing the display.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/no=
uveau/nouveau_display.c
index 6f038511a03a..53f9bceaf17a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -407,6 +407,17 @@ nouveau_display_init(struct drm_device *dev, bool resu=
me, bool runtime)
 =09struct drm_connector_list_iter conn_iter;
 =09int ret;
=20
+=09/*
+=09 * Enable hotplug interrupts (done as early as possible, since we need
+=09 * them for MST)
+=09 */
+=09drm_connector_list_iter_begin(dev, &conn_iter);
+=09nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
+=09=09struct nouveau_connector *conn =3D nouveau_connector(connector);
+=09=09nvif_notify_get(&conn->hpd);
+=09}
+=09drm_connector_list_iter_end(&conn_iter);
+
 =09ret =3D disp->init(dev, resume, runtime);
 =09if (ret)
 =09=09return ret;
@@ -416,14 +427,6 @@ nouveau_display_init(struct drm_device *dev, bool resu=
me, bool runtime)
 =09 */
 =09drm_kms_helper_poll_enable(dev);
=20
-=09/* enable hotplug interrupts */
-=09drm_connector_list_iter_begin(dev, &conn_iter);
-=09nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
-=09=09struct nouveau_connector *conn =3D nouveau_connector(connector);
-=09=09nvif_notify_get(&conn->hpd);
-=09}
-=09drm_connector_list_iter_end(&conn_iter);
-
 =09return ret;
 }
=20
--=20
2.21.0

