Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9222054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+12pmEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfHTPeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:34:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:34:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 129so3601975pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPHNmTe4Qd6sGNb6G6+TQiW7l0R1WKyJpGI4kCBBgLU=;
        b=R+12pmEPP36+qTGpBxTfi+7XXsKJd23bmEEKqznjUXPyVRhGmSQ3tO15ETAl5a65xs
         udovK9MUPsc/LeqJJ3OtO/8UmZIc7utKbKpH3VxsHwTWuTn4P/aEQFJzpR9yuzQ0yjx6
         ktPV8+ySpuJt4r4KVubB3s0Kttb8/J5lb/ktY6gk92aWvnHCw0J3FTBZiflkUL9zs/T6
         FU2KWd/sb424pco+quhOXUsVJxTFH8VKvD7QFyyTQQL8n7yKqXb56Djp5AfSt1TOH050
         RqfzXmM4BvnABddyQb/cUwLf/IgeKoQlOjfFTxG4xPd5icurBVOQgS9RdJWKhi2iJUUn
         1EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPHNmTe4Qd6sGNb6G6+TQiW7l0R1WKyJpGI4kCBBgLU=;
        b=ncZVYc2q0EBC2C9Nb5z6DXsIwG3FsbWAXxGm7j/WmUaOORaqI2wpMIn57ZMXCYXx9T
         qFZobMxrsYXyUV6SunqHoON8epGIg9uHe87f6puvjY7AhGsI6KFjJcVp6MIC9XJcSSIf
         MKgfjLZjOlO8Z9CIjUZAw3YKAez7DFQquHJ0lP+LTCl8aJ8s5NXKDEuAHQIjhUd4RhcF
         L6s7g8W1FHiwWg0maJXSJM+Qv3aJrsUtQjuOTQTY54oncoK/TgLQjTdeBKWP9Ezzdugz
         suJQhjyihI9E9Nhqr6im3RbSYKYEdeO38yRwpmBbnzqmEkuTEMBiAnI76YntdFRvo/pO
         LBEg==
X-Gm-Message-State: APjAAAVn3cNEwgp6dOQVHU3RWBlb7I+QtbTNfjyNIIrhJTSfeuvUGkQ4
        k5xzZ9xWWMBsj56S8Q1Xxh0=
X-Google-Smtp-Source: APXvYqzHRKRyg7+7CoVECVrHvDxtLshKsTIe4TgL6o5OZVN72oUf3TOpd2aOox7UbbYlhK/bpuuiHg==
X-Received: by 2002:a17:90a:c086:: with SMTP id o6mr668903pjs.2.1566315251498;
        Tue, 20 Aug 2019 08:34:11 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id bt18sm276897pjb.1.2019.08.20.08.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:34:10 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 43C312011CC; Wed, 21 Aug 2019 00:33:58 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] staging: comedi: ni_mio_common: Fix a typo in ni_mio_common.c
Date:   Wed, 21 Aug 2019 00:33:56 +0900
Message-Id: <20190820153356.25189-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in ni_mio_common.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/staging/comedi/drivers/ni_mio_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
index c175227009f1..f98e3ae27bff 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -596,7 +596,7 @@ static int ni_request_ao_mite_channel(struct comedi_device *dev)
 	if (!mite_chan) {
 		spin_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
 		dev_err(dev->class_dev,
-			"failed to reserve mite dma channel for analog outut\n");
+			"failed to reserve mite dma channel for analog output\n");
 		return -EBUSY;
 	}
 	mite_chan->dir = COMEDI_OUTPUT;
-- 
2.23.0

