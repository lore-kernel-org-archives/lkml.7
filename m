Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A733F21852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B60aJnWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfKSLBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:01:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47043 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727761AbfKSLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574161299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TpsTNb8F4YRI6TLaH+wSJs+oDBX86nBQbo9F03+T2Q=;
        b=B60aJnWB4DF9UKnj3kHoYtAVUTXnpgl4b2QG7LI5aTbDt7FXto/DYADwTPdtM98e9RcHl0
        5JKz8BXkHAY5yrTT/D572HOSVr4fy3Va6197rIp/Zlh64FbXFqMKfA+9R4dkemkjbXgoPv
        WkurPFWahX0PtSMk4IE01n+pemvCuvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-uuIYqfakNAqOeRLo6xzJIw-1; Tue, 19 Nov 2019 06:01:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DD90801FD2;
        Tue, 19 Nov 2019 11:01:34 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-41.ams2.redhat.com [10.36.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75E4760BE0;
        Tue, 19 Nov 2019 11:01:32 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH net-next 3/6] vsock: add local transport support in the vsock core
Date:   Tue, 19 Nov 2019 12:01:18 +0100
Message-Id: <20191119110121.14480-4-sgarzare@redhat.com>
In-Reply-To: <20191119110121.14480-1-sgarzare@redhat.com>
References: <20191119110121.14480-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uuIYqfakNAqOeRLo6xzJIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to register a transport able to handle
local communication (loopback).

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h   |  2 ++
 net/vmw_vsock/af_vsock.c | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 4206dc6d813f..b1c717286993 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -98,6 +98,8 @@ struct vsock_transport_send_notify_data {
 #define VSOCK_TRANSPORT_F_G2H=09=090x00000002
 /* Transport provides DGRAM communication */
 #define VSOCK_TRANSPORT_F_DGRAM=09=090x00000004
+/* Transport provides local (loopback) communication */
+#define VSOCK_TRANSPORT_F_LOCAL=09=090x00000008
=20
 struct vsock_transport {
 =09struct module *module;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index cc8659838bf2..c9e5bad59dc1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -136,6 +136,8 @@ static const struct vsock_transport *transport_h2g;
 static const struct vsock_transport *transport_g2h;
 /* Transport used for DGRAM communication */
 static const struct vsock_transport *transport_dgram;
+/* Transport used for local communication */
+static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
=20
 /**** UTILS ****/
@@ -2130,7 +2132,7 @@ EXPORT_SYMBOL_GPL(vsock_core_get_transport);
=20
 int vsock_core_register(const struct vsock_transport *t, int features)
 {
-=09const struct vsock_transport *t_h2g, *t_g2h, *t_dgram;
+=09const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
 =09int err =3D mutex_lock_interruptible(&vsock_register_mutex);
=20
 =09if (err)
@@ -2139,6 +2141,7 @@ int vsock_core_register(const struct vsock_transport =
*t, int features)
 =09t_h2g =3D transport_h2g;
 =09t_g2h =3D transport_g2h;
 =09t_dgram =3D transport_dgram;
+=09t_local =3D transport_local;
=20
 =09if (features & VSOCK_TRANSPORT_F_H2G) {
 =09=09if (t_h2g) {
@@ -2164,9 +2167,18 @@ int vsock_core_register(const struct vsock_transport=
 *t, int features)
 =09=09t_dgram =3D t;
 =09}
=20
+=09if (features & VSOCK_TRANSPORT_F_LOCAL) {
+=09=09if (t_local) {
+=09=09=09err =3D -EBUSY;
+=09=09=09goto err_busy;
+=09=09}
+=09=09t_local =3D t;
+=09}
+
 =09transport_h2g =3D t_h2g;
 =09transport_g2h =3D t_g2h;
 =09transport_dgram =3D t_dgram;
+=09transport_local =3D t_local;
=20
 err_busy:
 =09mutex_unlock(&vsock_register_mutex);
@@ -2187,6 +2199,9 @@ void vsock_core_unregister(const struct vsock_transpo=
rt *t)
 =09if (transport_dgram =3D=3D t)
 =09=09transport_dgram =3D NULL;
=20
+=09if (transport_local =3D=3D t)
+=09=09transport_local =3D NULL;
+
 =09mutex_unlock(&vsock_register_mutex);
 }
 EXPORT_SYMBOL_GPL(vsock_core_unregister);
--=20
2.21.0

