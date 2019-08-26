Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073E52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tw1HgwV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfHZUpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33192 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbfHZUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so837499wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pfgll+eOW/8GRcD+GQOG9wsokOGoEsAY+zrwwcHk0F8=;
        b=tw1HgwV+d1ZLCN/W6jJUD6Gh5yZk3O2sSimFrMoNkvGT9EIzDYAJHZtayb0QXaZQID
         sYZu5wITzd9MsJamY4tu9/XBZWGSLBjZUdoIGExzeowfcg0fL3Im+8wu6kl2Z3PDU48N
         iZQopI5eiHQNT6Qn0FVQDQzx/fi7gBjm7k82utxYzHlp7PDsvfGiPtAaImoVQLYrHX4n
         5BiZ8k5vC85RH0gsqu6DXVaLAGd7WhRHiqvF4GVnMkVIjCJWikzlVj3jY0dS8j5GEo2W
         9/Aq424qST1A14EWnRaP+y4eOErz1EKhAEe6o+x0nB8jAyI+GaYiPtCvb3z+nqDIjN/1
         08rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pfgll+eOW/8GRcD+GQOG9wsokOGoEsAY+zrwwcHk0F8=;
        b=aFgXbACIgwvXKQ3Rcb6MztGB49NRXywR8xFYdW0lfo0oPb9BK2qR1J/W00ttPc+Clc
         GZUW9/IW0fo2ydsLrJSOK7KpQO97d4MtBCths6bFRT57f0mjEK0TCZgoK5pQS8BQw1EC
         RQnO6LU85g3Ej0LFzf+gyJKcw0+4igbvaM4nnU+nAfwwMQG0qizZAiy9poiepCWrKDah
         /t9r47JwIqWv7PFI7fjvc1SfrBlAuehzgBUZH2LrL68TwVDi5h6sGZnM65Ui9APb3Wq+
         +BpQYkibj6w8g5IkZz8bC4YkaS6Irf+HrEe0eMvuMWLrbK8QqZdhhDPOTmcZZk7X/+H5
         KxtQ==
X-Gm-Message-State: APjAAAWNvkb5KXmE4Cs2oKdxVMGVv7U6iRPQJsSHtY/rgXg5A/eCd+Aq
        GYaLvTBE29TK8g9Jn+d1u+dPwQ==
X-Google-Smtp-Source: APXvYqxurtHL9SW7y95CUMKMTuHP20EbwCPjnNUCGz9on/FUvEfhI/EIc3Z0xsgFr6zrGa8ZTps4Dg==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr5700230wma.16.1566852323451;
        Mon, 26 Aug 2019 13:45:23 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH 19/20] clocksource/drivers/sh_cmt: r8a7740 and sh73a0 SoC-specific match
Date:   Mon, 26 Aug 2019 22:44:06 +0200
Message-Id: <20190826204407.17759-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add SoC-specific matching for CMT1 on r8a7740 and sh73a0.

This allows us to move away from the old DT bindings such as
 - "renesas,cmt-48-sh73a0"
 - "renesas,cmt-48-r8a7740"
 - "renesas,cmt-48"
in favour for the now commonly used format "renesas,<soc>-<device>"

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index f6424b61e212..abf5e7873a18 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -924,6 +924,14 @@ static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
 		.compatible = "renesas,cmt-48-gen2",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
 	},
+	{
+		.compatible = "renesas,r8a7740-cmt1",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
+	{
+		.compatible = "renesas,sh73a0-cmt1",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
 	{
 		.compatible = "renesas,rcar-gen2-cmt0",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
-- 
2.17.1

