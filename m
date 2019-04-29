Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321032075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niwBPwvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfD2HhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:37:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42375 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2HhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:37:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so4664731pln.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JVE5mmezCRxz6WW+z9H8b28By3jF0TFZuCkFOKjspBU=;
        b=niwBPwvEkClbDRK9YJuSfR/YAnw/h5dMpYBXnWsjBRo9UdkYLnka/aYR5Q7xahnsIb
         as+f30ARN/KtCMGevNIB0IFhdEVlRioN0ls7/DgVufSsEhcD3pPvCOkX+kR7wurJgDQ0
         AfpgLTNON+AQhxtN2jqk62c+TBCuNXyFrjduyVWOcpFE9NWYjqpJ0QLhiOGOFgry51RF
         xKXS/VhlJkxeMb+81VBqOogBaQZjisJZMKVJ2CTFOY464h+3H9sNR06XsK3URQxdDtgB
         CzRm8dgt5mRLInnpfk2i29EgagbmkXCDUfrlSQFnhEhyouzfrwunzNGSvkchDUFV406W
         kdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JVE5mmezCRxz6WW+z9H8b28By3jF0TFZuCkFOKjspBU=;
        b=VXKqiavqtnb/YCuFNs2pXlwKksT4JGBeRWMWGKh7a0t9AIa/uGwS1BwGO+S29kxT5a
         GyYMu4d8Lp8mTHY6WZdth9eaAJ9JgypQQ2fBnPal0ALvHI5j5tlQnM88Qc9wnb/SsNPx
         i2f30crvceYXQyR/D7nxTOd9f153McvcXzRh6YuV09hlStfOk3+UXBZmMvXsT3LaczS7
         OqwgSZ0DnzwwXWpa8LQMb6ao+Hs/P7CRXx9Pf+V9tBOo3g3G69uSxYckSwavHvdO9763
         UJpUsgIRd7WveHOgiW5UuIT+vqeDejcFYrtkqLnRDrf02u8xV0gxvt6EFCAg5ewkWw7j
         wRMQ==
X-Gm-Message-State: APjAAAWcZHwkYzBKu3AKDqPykQHBYZfFtftuUeZ3jQjCVR/DU2bRG4xe
        +YmE9dAySYI0ZqPpgEXzJtwk66bjqtE=
X-Google-Smtp-Source: APXvYqwZzhRLIoaP5LpqWQUbjpD0Ir8YyzDeEPPahuxhn3iNg6BmuHDKJjh9YnJwHCLE1BExK5KxAg==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr24800187plo.198.1556523444886;
        Mon, 29 Apr 2019 00:37:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:12a5:ab58:559f:ec82:1c85:ce7])
        by smtp.gmail.com with ESMTPSA id t24sm43485198pfe.110.2019.04.29.00.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 00:37:24 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: vc04_services: bcm2835-camera: Modify return statement.
Date:   Mon, 29 Apr 2019 13:06:58 +0530
Message-Id: <20190429073658.32009-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify return statement and remove the respective assignment.

Issue found by coccinelle.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index c9b6346111a5..cef6d5b758e8 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1507,10 +1507,9 @@ static int set_camera_parameters(struct vchiq_mmal_instance *instance,
 		.use_stc_timestamp = MMAL_PARAM_TIMESTAMP_MODE_RAW_STC
 	};
 
-	ret = vchiq_mmal_port_parameter_set(instance, &camera->control,
+	return vchiq_mmal_port_parameter_set(instance, &camera->control,
 					    MMAL_PARAMETER_CAMERA_CONFIG,
 					    &cam_config, sizeof(cam_config));
-	return ret;
 }
 
 #define MAX_SUPPORTED_ENCODINGS 20
-- 
2.17.1

