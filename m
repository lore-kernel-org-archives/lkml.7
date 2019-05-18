Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF424C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39DC20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipnrZSoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfERGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:34:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37469 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:34:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id n27so1714962pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wc5ne2C0qlrJ59+3B2aOlKeT4GO/cZZs3Ekwp68VN98=;
        b=ipnrZSoo0H+Z2+SnBu85rH1f6qyomy6PObAPvmmSEHQDsSayThOZWxg/Ds+MguyT4n
         2mLSA/cAPSYkrhL6BP5IECMuiS01QZTK+f6pNstsr1tLkPqc/nZXaKQTTq0BZk6qNbpu
         lDwvgECaj0P0BXOE5PV8B7s2vuBevXa06H+2/H+GSdQ21X9euS/h96Z3jQwBdLv8gauA
         loTGGi1BRilpjTtHEZArUjKakW8StZ0LPxLobYIGa8q93qOIRlBtRzJYepSPI6w88ylR
         GL8NXru68D39VDU4RsLwTTT6jGEicgeGt8EvMF6vbU2ZWWF87DuQRWSJhNDahPCd+IQB
         dYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wc5ne2C0qlrJ59+3B2aOlKeT4GO/cZZs3Ekwp68VN98=;
        b=uWtMaLR9MfVdhUQ2sIoRcp24wEpj5MLhqMHT4imLsw3nvKZTOuHOmw2fKFM7ZiyskJ
         ARoVCoZLN4H4z/j1kzngs04Z3kohNzSeqyr2lGRgLBVPhUXVJJVBRECJXF9v3CQG8Jyr
         U9pgO+r73r37/nOdi2vrlqUTcL72r6HzEro6Y8AGK0MSFqs2zf4/5gONATIGT4z0FjYd
         Z0v8aKtO9daarnOiATrjVbOIeuRj6ParKrd/kOQqL52JQSAXjyTydui4c4HELb/6LZJV
         9/0TCuLx5IVFKuHBvDRblBCOkcuUHidGHh4njjhJ6bvoPBvbNXCRdN8bvPWduygvs8JE
         zSjA==
X-Gm-Message-State: APjAAAUZGzG0gQnpZpSHoCoKAeu4B4z9Vvyb8zFiU+vTOeIl3JLU2WZ8
        AErav261WgUojjCYYhnjhMA=
X-Google-Smtp-Source: APXvYqw5bqfqOoPCJHuwau2XqUoILQqXQK3PrEqTkaTBMFQMfx3iPTdCzhOVf3nQF1UEp3xBFaqV0g==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr8199475pgp.72.1558161289605;
        Fri, 17 May 2019 23:34:49 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:34:49 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 3/6] staging: unisys: use help instead of ---help--- in Kconfig
Date:   Sat, 18 May 2019 12:03:38 +0530
Message-Id: <20190518063341.11178-4-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518063341.11178-1-moseschristopherb@gmail.com>
References: <20190518063341.11178-1-moseschristopherb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/unisys/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/unisys/Kconfig b/drivers/staging/unisys/Kconfig
index dc5e1bddc085..43fe1ce538e1 100644
--- a/drivers/staging/unisys/Kconfig
+++ b/drivers/staging/unisys/Kconfig
@@ -4,8 +4,8 @@
 #
 menuconfig UNISYSSPAR
 	bool "Unisys SPAR driver support"
-	---help---
-	Support for the Unisys SPAR drivers
+	help
+	  Support for the Unisys SPAR drivers
 
 if UNISYSSPAR
 
-- 
2.17.1

