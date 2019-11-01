Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110BA21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYba00YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKAMRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:17:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbfKAMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:17:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so9149725wmh.5;
        Fri, 01 Nov 2019 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2OEhUt1Q5DjWbRY/ukSA2ISzuN5HR8Asj5+S9oagZM=;
        b=TYba00YOKm1UNoOABodWOurGOD9XySUI/ls9tCevPpKRV7+m/5LdsHgok0jXxvBnMa
         cGvdmuq4fuSQgqkNQlDSxk64J/nYtdYGW3o0F8A/416GZbXYKPq1tsg21tnAhjkyZ3Op
         nfnwUKSYU8jA/cuYZO/c0Z/L8edoNsb9knRgANvsQSDcBrVKbwMyfdIwPFQEj+KLWDh1
         9gLXFUdcWRFZWxCtH9H++l8LfStDKp7amRgqExGCfEBNQhh4L1eYFurjZHtuZKj0wmiF
         mYqMNzVYqsPIbupviWGdk4zvcXq+bZBlFNOSKY5Xz7saMtSQttZ33Z30i+nLnz4i+ePN
         uvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2OEhUt1Q5DjWbRY/ukSA2ISzuN5HR8Asj5+S9oagZM=;
        b=ZmIzkq+fikq7BhPIyWYM7li8duADJ68k6tefCF/PE47G6xXH/arAPeTe7nC1Oha0kG
         jsa2v3TgNcwTs1DwGY7cC8m+BqlnP6c/LrlAyAJEliqpOxMPg8GQsk/gr72BKGwGVJ2+
         Uh4eG2VDWaJmj0+1OqjIlOkYCGeGlHfWpFvJcdVUXPsORhGaQOChAvW06wnvdTLQsMwI
         O6ylP5/5HU1+AwJMBb/UgdXO0J6fDY6hyF0fM8pp1Lnt4bcpyU86U75BrAuFzZqF0lxi
         l90Y3dpuTJ7JyM6SBzjHtstL+BZkaKGnUYrCM28KiieXAgfff03fVfYDR7B9Ey/llc1V
         HnlA==
X-Gm-Message-State: APjAAAUhYaE6FCfdjOOkQYxODPdLTE4YAwZB8yPmgKYjVA9WO43Eb5ab
        9cdxNieFIdOkhyjkUcCIHkE=
X-Google-Smtp-Source: APXvYqxYSyOLx0qkxSJcpJrWWuP4L+Ic7bdIDsG7I7mX0FORQw4tVZXbSlaP34UV0F6JcHml0XOKhg==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr9874673wmh.102.1572610658879;
        Fri, 01 Nov 2019 05:17:38 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u21sm6263928wmj.22.2019.11.01.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:17:38 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] net: ethernet: arc: add the missed clk_disable_unprepare
Date:   Fri,  1 Nov 2019 20:17:25 +0800
Message-Id: <20191101121725.13349-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove misses to disable and unprepare priv->macclk like what is done
when probe fails.
Add the missed call in remove.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 42d2e1b02c44..664d664e0925 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -256,6 +256,9 @@ static int emac_rockchip_remove(struct platform_device *pdev)
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
 
+	if (priv->soc_data->need_div_macclk)
+		clk_disable_unprepare(priv->macclk);
+
 	free_netdev(ndev);
 	return err;
 }
-- 
2.23.0

