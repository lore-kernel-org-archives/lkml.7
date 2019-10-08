Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62126ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F7B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="My8MUZ5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJHO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:29:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfJHO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:29:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so19715717wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=O2DKR9eVO5OT6dZUmMuRNe3VzeLrEJcFDO2ZD+CSBCY=;
        b=My8MUZ5BeTlbJ4CYKc+YscCMzGsj99j9TCvOMv+gpxNHWLucCPr3Z7HdsknPFFYfGM
         d0jbIVYN3mrf2AW75uCOahJri4qJ/gr+6N/Nw2fquJqBbXugNxRBK+GpDO74dF26u/WW
         AcnxtmyJReYEbXo+TvK7Fbl5J3YE5pG+WqFDx/RF4Ay+GwuEHDWs8UMOB5Y4D3XHnMvK
         mKdn3H5JGGklX98DZHKbLnKJyl1ZKyvKdG5tJYxGNPdiCXhL3Y4nmx8hDEeuGgNc/omB
         jf5PRirw8tnOSf8485yjv2YPNnVr/9+AGQ6+zd3D1Q0p9SEj8CUUmHueRjasBU4PBBei
         DWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=O2DKR9eVO5OT6dZUmMuRNe3VzeLrEJcFDO2ZD+CSBCY=;
        b=oj8PHhlJJLz+5JrfuRwsuhqBhaIOixQDexdXNjRL81dtj3IGtv/0XusRal0tcUg3Xz
         IK/SRUeVaFG0UdWJB8aUff9uWCQhkJ8E1vtIZZ5MQOGKw+cbBp67utytKpWfjSQ4rmYK
         vmt7BXf8NfkKQlecsR6vKqugRFFNvd4oNUpCe+2Q/u7IOhb7RgyUY/jEiv9rwwLZtctf
         A2g9M52PMLAMVn90e9F/qLtqJpuK1wamjaF3+mfzx7CADfi8lJZwhSrTjhKwlnPIORXi
         H9R60d0yGddYoUSdeiKcuD1O0nfM/eF7e8I6ECdgMImtHwog+HKpJNBoovefIhd2TN62
         czkQ==
X-Gm-Message-State: APjAAAVYvZ/ET12BRUgND83GzJ79WLw7xHjzUwsre633xWh83+rdCtVh
        RDiv9T7IUD6FMbaN7zpavDA2P/5kGB3Y5aKJ
X-Google-Smtp-Source: APXvYqzIOQi91UO0cOPTnKrWsL9UFz2PFIb85TvBoICGl8cGkXjDiCeyM9zGLzXDfEQm7OIMutwrmw==
X-Received: by 2002:a5d:4fc7:: with SMTP id h7mr24378359wrw.158.1570544951950;
        Tue, 08 Oct 2019 07:29:11 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a13sm48136827wrf.73.2019.10.08.07.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 07:29:11 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: cadence: Do not show error in case of deferred probe
Date:   Tue,  8 Oct 2019 16:29:10 +0200
Message-Id: <d3e295d5ba79f453b4aa4128c4fa63fbd6c16920.1570544944.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to show error message if clocks are not ready yet.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/watchdog/cadence_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 76d855ce25f3..672b184da875 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -335,8 +335,10 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 
 	wdt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-		dev_err(dev, "input clock not found\n");
-		return PTR_ERR(wdt->clk);
+		ret = PTR_ERR(wdt->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "input clock not found\n");
+		return ret;
 	}
 
 	ret = clk_prepare_enable(wdt->clk);
-- 
2.17.1

