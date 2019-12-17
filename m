Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C31C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DD52082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CE+hrIYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfLQTGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:06:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726731AbfLQTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576609573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b0zxRRtx431jc/y/uldsiCxJPFBL7PynAZnho2SH+cY=;
        b=CE+hrIYol8R+OYGv/be3oeOCE25DhjbEdbhAIqVNRQJfLuQripdra+wECRK42cZFB5SMRs
        s2eUHpKAVYfIihGhjxAl+pB6lP1LiOFXQz7e440MlaV+7I33DVLCEG6IkM47RbTC6LIcZ7
        T1J/AlOaHCMXXrswiFkMealoX5274qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-_Bi380WDNKqpTK94Ahy16A-1; Tue, 17 Dec 2019 14:06:08 -0500
X-MC-Unique: _Bi380WDNKqpTK94Ahy16A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25F910866FE;
        Tue, 17 Dec 2019 19:06:07 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 623C319C58;
        Tue, 17 Dec 2019 19:06:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Make buffer for HPWMI_FEATURE2_QUERY 128 bytes
Date:   Tue, 17 Dec 2019 20:06:04 +0100
Message-Id: <20191217190604.638467-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least on the HP Envy x360 15-cp0xxx model the WMI interface
for HPWMI_FEATURE2_QUERY requires an outsize of at least 128 bytes,
otherwise it fails with an error code 5 (HPWMI_RET_INVALID_PARAMETERS):

Dec 06 00:59:38 kernel: hp_wmi: query 0xd returned error 0x5

We do not care about the contents of the buffer, we just want to know
if the HPWMI_FEATURE2_QUERY command is supported.

This commits bumps the buffer size, fixing the error.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1520703
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/hp-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.=
c
index 9579a706fc08..a881b709af25 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -300,7 +300,7 @@ static int __init hp_wmi_bios_2008_later(void)
=20
 static int __init hp_wmi_bios_2009_later(void)
 {
-	int state =3D 0;
+	u8 state[128];
 	int ret =3D hp_wmi_perform_query(HPWMI_FEATURE2_QUERY, HPWMI_READ, &sta=
te,
 				       sizeof(state), sizeof(state));
 	if (!ret)
--=20
2.23.0

