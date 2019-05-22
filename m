Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8ADC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945E6217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgZgRcw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfEVMOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:14:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42728 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:14:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so1958859qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kapFPIcOEF24dNwPZMRD32BN65ja8Nv+o9pXXeC0thg=;
        b=FgZgRcw8izmLbfiybQzq+HK/Z227M9wgN71W5+YqXXRSLLZW1QuQjkOZeFOHczpTU3
         AYShJBMVh8Xv7xs73kM4sk+p/si5sx0cqarf9HJLVsU2wCw2kKYVWjkLkfQORW7iS/k/
         dzU0z7RbG55a+7tPsK7b/qff2INyyxKVgU/cXiGhdYW+f3WdUearhozaLZISnK87bjpO
         XE734IgSA50QBAeHsHxQHnVy6pkmaRMZ9Buqki3AcrPei83lnmGqt8G8/JzfttBK9WmG
         GrIQtmStLUSgVjIMgh3He+sBIhVbxRpkzJ9bCeujlor66gkGthttYxBmAJR3tAJ+VDPH
         tYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kapFPIcOEF24dNwPZMRD32BN65ja8Nv+o9pXXeC0thg=;
        b=QNXbL3fRlhJhxI22D2g8EmVy5AqQtmSS8wtepQeLQjCvyTX46zgrtJoUMVOG2L8lRt
         VnJZGqOyq9W9VuzyHhAO3Q2tQtOmUcHSV8oXDzLaPw3bWd6eqHQgPCOp7ob0f3pAjoFx
         4whtyCFo9V0fK7Je+yj2j+QmtgbLpHPgBygqAcZRQM1buG6cQeG06nXN6V0fSNpwbbuF
         akM2LMONrGVgluapVsKrdvq5jyaGV2Na+n3mCG2tO23egzSGjFDWSTzcKKDNlfEITO7G
         t6sOH69rZqbJVR7WCzze2L3w4+ceWyfYIq02Zwx9bHNit1gTPWI+hQ1qhpbzOnqo4/QG
         M7Gw==
X-Gm-Message-State: APjAAAX2oOZj3PMglcz9CCkya53VPnVJx9wl3szeT5mh0vUfTIFzJja9
        7LPZTpohjJjaoRqcL8W8NCy5hUUkV+Q=
X-Google-Smtp-Source: APXvYqwW3YrS72YzzZpUemYfHXVMnB4yR97jqcGbniBUsRuagkRnkpKhGJGSca3ozzOJrLcrGC/mXw==
X-Received: by 2002:ac8:2da1:: with SMTP id p30mr74524090qta.369.1558527289395;
        Wed, 22 May 2019 05:14:49 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id w2sm8742070qto.19.2019.05.22.05.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:14:48 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 1/6] staging: kpc2000: make kconfig symbol 'KPC2000' select dependencies
Date:   Wed, 22 May 2019 12:13:57 +0000
Message-Id: <932843299b814f3a22dd176771b46be14ceefeea.1558526487.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558526487.git.gneukum1@gmail.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc2000 core makes calls against functions which are conditionally
exported upon the kconfig symbols 'MFD_CORE' and 'UIO' being selected
Therefore, in order to guarantee correct compilation, the 'KPC2000'
kconfig symbol (which brings in that code) must explicitly select its
hard dependencies.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
index fb5922928f47..8992dc67ff37 100644
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
2.21.0

