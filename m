Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC91C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A23020833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2QYFcaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLBOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:18:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46775 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:18:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id a124so8866620oii.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=O46JpsiVxHvaxS9r0mmnF1X/0tTav9FJHQ6vC2vquJw=;
        b=g2QYFcaKIw/JDRmMvOZflR5+0GUDYg7cmf7W8uyyyHlmAHecHOqGRDXGbXgrevGLVm
         dvZ3OQg3PixAB6iHLoVO/aYmXN4Y3nSx/JgztQdyTWiOZV1sEDrATSUMOHd3LYMU8sJj
         RtvJ8HNPoOBWkiZIdsoPhVneamKnd1Zf2M1pDpXWFr92A+z3qzQbj6F5oX05HVUOzr/l
         JBVRUiUAWjOgvAJLO6Xks3Org+ESsdydQlG/bc0m8/9vAMsI3SPhiOD1NXGGbbjIzRlQ
         gCDE/gotWIkTUw45CCm4scIw/E8b2RTg+LZD9LnJ0i5k+BQjBsFMeVCBWhLevC/DsbY9
         x/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=O46JpsiVxHvaxS9r0mmnF1X/0tTav9FJHQ6vC2vquJw=;
        b=ftjiHOfJpCbrTaqElfp2lWPa7Yz108nx7ZXC0WD/DQiX6xMaBaH92F6jRqblFHzzYF
         VWATjhehZt4Ce6P3wS6yFqiW6iNQxFmtiw1Gt2Vs1N6BfBB1RzjornQmNU7p1rBbAiIm
         /MkagQC3FBClxx2K5WFI1UeVxWP5TaXBQokQ9YcM1m4IQK2niT4qsrCCiqkyG6Y0o+xN
         G4CY4hjvTj4DdZEHwyrROZkR3tt+FOpitiCHa8dE2Bna0K5Hi6yfOUDirkeCSX+Zfk3k
         pjzGIUqrMXETIwnJze7ywG4W/JfcRLugXxpCTwldYa/gsrg52BvoolGtMuL2D6s7Q2i0
         Yj/w==
X-Gm-Message-State: APjAAAX9X3ip0JDIirCCW/PIBox1V9vTRg/Mt2b/H5pm+U7GxsryxreC
        Kalw5bru1q/g819VolqWwMo=
X-Google-Smtp-Source: APXvYqxyrI1tz3YpJ7VUSwiwzYbkct9KmqvLK02ptOCkAvbtQJ0paKYrFJPLjOWCJiPYFEsncZwvEg==
X-Received: by 2002:a05:6808:98d:: with SMTP id a13mr1786184oic.7.1575296320344;
        Mon, 02 Dec 2019 06:18:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y16sm7758914otq.60.2019.12.02.06.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 06:18:39 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Date:   Mon,  2 Dec 2019 06:18:36 -0800
Message-Id: <20191202141836.9363-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code doesn't compile due to incompatible pointer errors such as

drivers/staging/octeon/ethernet-tx.c:649:50: error:
	passing argument 1 of 'cvmx_wqe_get_grp' from incompatible pointer type

This is due to mixing, for example, cvmx_wqe_t with 'struct cvmx_wqe'.

Unfortunately, one can not just revert the primary offending commit, as doing so
results in secondary errors. This is made worse by the fact that the "removed"
typedefs still exist and are used widely outside the staging directory,
making the entire set of "remove typedef" changes pointless and wrong.

Reflect reality and mark the driver as BROKEN.

Fixes: ef1fe6b7369a ("staging: octeon: remove typedef declaration for cvmx_wqe")
Fixes: 73aef0c9d2c6 ("staging: octeon: remove typedef declaration for cvmx_helper_link_info")
Cc: Wambui Karuga <wambui.karugax@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/octeon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon/Kconfig b/drivers/staging/octeon/Kconfig
index 5319909eb2f6..e7f4ddcc1361 100644
--- a/drivers/staging/octeon/Kconfig
+++ b/drivers/staging/octeon/Kconfig
@@ -3,6 +3,7 @@ config OCTEON_ETHERNET
 	tristate "Cavium Networks Octeon Ethernet support"
 	depends on CAVIUM_OCTEON_SOC || COMPILE_TEST
 	depends on NETDEVICES
+	depends on BROKEN
 	select PHYLIB
 	select MDIO_OCTEON
 	help
-- 
2.17.1

