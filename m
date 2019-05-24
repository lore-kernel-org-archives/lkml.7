Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF674C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8615D217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="uUXtgo59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbfEXUbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:31:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41291 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403760AbfEXUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:31:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so8041853lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dK/1JvLa+KFDpT0Stv3jbktB6OWMlgN+u1uYZ1mqVrw=;
        b=uUXtgo59sEbRPtpAbCcNKGAiQ5WgsLW4Tnive+7Sz+9dIMiIgBORk7hOpR7tx2kLGn
         9WnepcCO8NbakfhHZjWZA5NGl24wOl7ItjZcEUsnPdElGstKbf1pLnuiBLRsXaU88AqN
         nbSR/dX7GwAUesktXwEaL2BKh+flMmmxjzL0eNI7QYMO8EiFLN1fBeFLgrYmJ5gmqkou
         PWYYaFMJChpwPLyPqIhNPshLK2r6H+XfzlygXOxKNibUe/InHCuM0oGCH/jmM2pWjeBX
         3nGn2mEa9KDBVuAa7jMFE+6hqB/3+3db7pkmrHx7w7w7ZQrHlm2IyPrJHpVvRBabfBJR
         vmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dK/1JvLa+KFDpT0Stv3jbktB6OWMlgN+u1uYZ1mqVrw=;
        b=BLizQibwT3dlKSvT67/aCnM1CozoQ5qAYPcROTuq7d2Os6TeCVN8qtz0Urr4rgnlrz
         6tI80xxTmN+1g4zct/tiudp8BYufwaHjH1osFCcgsDJZ4CHVvSWYfQhMDSK+Lxm+clJ7
         KUQOu3GGs96zhk2Ptge8se8VaIkVhHRE6RE0XHg6+IrXTOa+yZGsRz6t6qpF47UZWBSy
         dH+75ViCTW91/YqCJhRYvrvfSTy4bylJdAmr0LxFjOGiCmQ1+d6HUp8h2oFIP7WV04hU
         vnln2uVpu2zSV27kNEAEGn2/jkE+tDHOTFh5oylHRa2qQUVLCIFg6tT6i8HRPlbfYDVJ
         mGWA==
X-Gm-Message-State: APjAAAW2ZED4tcI4kbeDL1x6rZSuVuaDCmCSIR0NWZdAKyz6ChOkS/RG
        ZXBFSsXi/ot8UDxUTMTt08CL0Q==
X-Google-Smtp-Source: APXvYqwl4t9wip3XKZDNShHedMCImAGjA97ArvuSj2apoobaboElKm+PY52jNWpvczBPyxlYjPxw+g==
X-Received: by 2002:a19:9f09:: with SMTP id i9mr17398813lfe.71.1558729865812;
        Fri, 24 May 2019 13:31:05 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id j69sm921036ljb.72.2019.05.24.13.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 13:31:05 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, Matt.Sickler@daktronics.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: kpc2000: add missing dependencies for kpc2000
Date:   Fri, 24 May 2019 22:30:58 +0200
Message-Id: <20190524203058.30022-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524203058.30022-1-simon@nikanor.nu>
References: <20190524203058.30022-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes build errors:

ERROR: "mfd_remove_devices" [kpc2000.ko] undefined!
ERROR: "uio_unregister_device" [kpc2000.ko] undefined!
ERROR: "mfd_add_devices" [kpc2000.ko] undefined!
ERROR: "__uio_register_device" [kpc2000.ko] undefined!

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
index c463d232f2b4..5188b56123ab 100644
--- a/drivers/staging/kpc2000/Kconfig
+++ b/drivers/staging/kpc2000/Kconfig
@@ -3,6 +3,8 @@
 config KPC2000
 	bool "Daktronics KPC Device support"
 	depends on PCI
+	select MFD_CORE
+	select UIO
 	help
 	  Select this if you wish to use the Daktronics KPC PCI devices
 
-- 
2.20.1

