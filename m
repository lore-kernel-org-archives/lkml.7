Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD07C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF472067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn0LLbEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfHMDm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 23:42:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfHMDmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:42:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id z14so13290246pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0k9YKjP/cSKJilQHVEEEWvX6n5tlm0qX23zD4SCMvhE=;
        b=Nn0LLbEocWdQsZe0KwASTMeF3yvcOUKdkEWMYH1WHDcbYZWs1/M9S46ADNJLT6ztKg
         ohnPs8aI1SGl2ecJD5x4iWvugHTXqr1TmFHT9cv+2mrcs8/YL8avkYWxe2qtcS225nYV
         P14ZkKXD8rYHbCL1BztGCkUqvwFTpCDtg2APVRC3DfIiLoTr2T0mY9ymE1fahlqjs1tt
         jAqGyWq1s5KnLlyXrLJxyCGWMSHc4nX72i9PyAnH4BPXneTS8wdr1UA9Qv5ybNJHztXl
         ZERPDzUATurdIpD42BJbH+z1ziScK9WqqXl1xpmFhDYq6wbbAGEnOCag2tCMQ1v41Qcb
         7ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0k9YKjP/cSKJilQHVEEEWvX6n5tlm0qX23zD4SCMvhE=;
        b=AgFGjPsNNQtQ8q9H5R1SkdAl8LjNMSGIyJXuDPWzrFLaolUrUo65/ZIu0J46MC/itP
         QBFfJBiaOqDoZ/il4EHpnWfu2E6NHUpApGxmfTxoynmBtQmPYIAvKz41OU7p4isH0nYN
         8ew4yV1SJwEc4YpaQQ/b8jJrqh7+WtAKSxS2OAz/hR122d6jNLnV+1MRDIVaajgcNY0+
         gCj9a9DoDX5JLK792adXpl+WPDn4szBlVJij/4I1YlUWa7+UBYkhyAMVzr3vo0m/C9qY
         MjZwSCGT4o/kVF1QnaJQIuQxEh39xxA9cFJdO0ANUmdV+VJoXfbpP0JfBMwRWSSUbDAP
         nxig==
X-Gm-Message-State: APjAAAUHG1DtDzmsK8x8ts6/HWyQObARmmo5Ujdrk+xLrNWhx8j3Se8v
        HZrv3oCMcb+D9VetGFs+tAg=
X-Google-Smtp-Source: APXvYqzuXbjPwNtkLqe7J3EZLKeX4YYvLOu0YBW46xJSkLaMzHDG9bUK3ND0R2GCFO8QqIz8Vs5+KQ==
X-Received: by 2002:a63:ed55:: with SMTP id m21mr32978136pgk.343.1565667771751;
        Mon, 12 Aug 2019 20:42:51 -0700 (PDT)
Received: from masabert (150-66-86-142m5.mineo.jp. [150.66.86.142])
        by smtp.gmail.com with ESMTPSA id q10sm10076800pfl.8.2019.08.12.20.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 20:42:51 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 7F0F62011CB; Tue, 13 Aug 2019 12:42:37 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com,
        perex@perex.cz, alsa-devel@alsa-project.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ASoC: ti: Fix typos in ti/Kconfig
Date:   Tue, 13 Aug 2019 12:42:35 +0900
Message-Id: <20190813034235.30673-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typo in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 2197f3e1eaed..87a9b9dd4e98 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -12,7 +12,7 @@ config SND_SOC_TI_SDMA_PCM
 
 comment "Texas Instruments DAI support for:"
 config SND_SOC_DAVINCI_ASP
-	tristate "daVinci Audio Serial Port (ASP) or McBSP suport"
+	tristate "daVinci Audio Serial Port (ASP) or McBSP support"
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	select SND_SOC_TI_EDMA_PCM
 	help
@@ -33,7 +33,7 @@ config SND_SOC_DAVINCI_MCASP
 	  - Keystone devices
 
 config SND_SOC_DAVINCI_VCIF
-	tristate "daVinci Voice Interface (VCIF) suport"
+	tristate "daVinci Voice Interface (VCIF) support"
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	select SND_SOC_TI_EDMA_PCM
 	help
-- 
2.23.0.rc2

