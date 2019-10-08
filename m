Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE15AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE64320679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1Fxzd/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfJHMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:33:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730317AbfJHMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570538035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vxNxzGS1YL2pIRA3iElWkbMg1T80wDQcjG/i1PxznHk=;
        b=e1Fxzd/Z49/pCF4+A7wVnRB1gkhMs0/zq2K+BCJRGNcLY/g82jQFiPgrP+hY4V+Tc0UA7H
        odvccT5xnz/iztmPTJvoy1Mqbyw3WKS8LEVQbjt7OqYXbUmJ+6pIq0luuc0zesBaFxBnlz
        1iheRgL4u+tor8XIi2oOan7DfTZiQ/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ZZlRT3KIM2KCz7xplebYPA-1; Tue, 08 Oct 2019 08:33:52 -0400
Received: by mail-wm1-f72.google.com with SMTP id f63so919064wma.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4guI5W+JBy2/Wk9QmpICIZphEUf2I9ZwikXlS8M7Tk=;
        b=BAn59oMGISHaz3w0SGCfmUluGbSvFC1W6Jz+FMpuzRnOZGlaf9QTyfRQWgh+z1dcYN
         AeSmVrZnG6wIzhYTfRVQyo27F/hJpK4+t12lvjlQMIu14fLfd5G2/8x1DpzaSbQr3MrJ
         gTkOxhWjipZd5UfxQmViBjFXOOBhj4QvWVBhJ++lE3Njoel8PPxMwM7zrEdoMzM14+SO
         7xckv4IY0lKgDcE74hg0IU3FuuS+HhYbh1167WSvcUmG5kVO5q+rEwaQa3utJMM4/sUE
         IQBkbO1WZWYmP+fXonLQmzExvIqouKqFnM0MOuQYNDf2EB8b2ShlZT5H5RhM/OmdXmmt
         jimw==
X-Gm-Message-State: APjAAAXuZIJ6lSAYgEAhXOPT5ZEBwzFmZnWKRcHZiCPCQK2ISNN78ikC
        5Ijd4zP51MdAU4PPYHcD/25vZOu8Go7lQG1N8TaIi/lY2P6OdqThQ4KkmCBVIFhAMn8W8870yt0
        BRjomH9slTlsZoas6vLSBpW1C
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr3714162wml.149.1570538031448;
        Tue, 08 Oct 2019 05:33:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAKI2iZTVbZl4t588qZfShH353mJjPntH73s4tdZMg33tqt9c0kisZMYYS3sNnU0yf2q5GQA==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr3714148wml.149.1570538031223;
        Tue, 08 Oct 2019 05:33:51 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id u68sm4361842wmu.12.2019.10.08.05.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:33:50 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: vchiq: don't leak kernel address
Date:   Tue,  8 Oct 2019 14:33:46 +0200
Message-Id: <20191008123346.3931-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: ZZlRT3KIM2KCz7xplebYPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
an obfuscated kernel pointer is printed at boot:

    vchiq: vchiq_init_state: slot_zero =3D (____ptrval____)

Remove the the print completely, as it's useless without the address.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c=
 b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 56a23a297fa4..084cd4b0f07c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2132,9 +2132,6 @@ vchiq_init_state(struct vchiq_state *state, struct vc=
hiq_slot_zero *slot_zero)
 =09char threadname[16];
 =09int i;
=20
-=09vchiq_log_warning(vchiq_core_log_level,
-=09=09"%s: slot_zero =3D %pK", __func__, slot_zero);
-
 =09if (vchiq_states[0]) {
 =09=09pr_err("%s: VCHIQ state already initialized\n", __func__);
 =09=09return VCHIQ_ERROR;
--=20
2.21.0

