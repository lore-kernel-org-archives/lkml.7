Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88989C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBC424673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PURWzZkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfLFSqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:42 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34930 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLFSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:39 -0500
Received: by mail-pj1-f65.google.com with SMTP id w23so3109713pjd.2;
        Fri, 06 Dec 2019 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCA0Lh1oqn+r4US697iCgjw5AryMojMo8zFhnnjBzkc=;
        b=PURWzZkG47zpj1FwjLfYXS1dTfzPkRvyXRkoXHy4WMu08UWL41Qb9xxBGlC5gQAgXv
         P4D4vkNfq1Yq1ruXHckUDoDSRI5/ZnKMOjxZ4nwt9RUZKytsSz/WFBvhaQsR3ybQ5aj8
         FDPhhTp2l3WuF+HYjLruP66uaikTQCBZ1C6k03mKOEnfVcHuDxAZe9Y/dix6qv1OW94Y
         uzJxt0s46pAsM8/IeDxfD0W9AAfyqUg1zB/Z1xBn9b/O/Q/IYiKQaB0nAtSoAOsyfGpx
         Wx/9zrU5m17uqSzWJlCAlkK+0FEcwt9m8fjkcb9YwJMQVMW8iIBaK5GTar3AIhd7XmRX
         eZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCA0Lh1oqn+r4US697iCgjw5AryMojMo8zFhnnjBzkc=;
        b=BUvONb9of3PGCE4jg7LYnLLbz0yafAltNihHbyHLi6ACyUzAJY/EVu1YyyZ+pNzzM1
         EgPGRLgonv3DdIHA8eJZmjxEvaPj35omB1G00PXA94VU45PTTYMxtV4hQMWO770rOrAt
         Re8ScGYwHxFFotgUSEtX2sgKGjsgyZwRULpCbmqZO5fsaar/WmvgM2e+DG8O3bEsSLsl
         IWCPtQa+FveB2BOjZerF0Kujm52ffBOqIxCVaVPkGsUvkVN/w+66Fel0vKzXhqFwyoSO
         xcdvKRMa5edEd0/cugPQUt4HxewBzog/nxE4N3cNcOQX8ktGvOlZZ5uRnhYpeNfVgidQ
         xKyQ==
X-Gm-Message-State: APjAAAWQNwmY52h0IjTHUGKuS0l359A++nraDbF3RXw3UT0ir2j4FWA9
        92MK9/6L6xjHs6b4tpJdpzA=
X-Google-Smtp-Source: APXvYqwYjvDq6y29Blyu2XOdGiJ7Yu2PVUwlKv8vwV3l85aFyC7d4APbzS9Q+6LsrmLl4BEfRIqYQw==
X-Received: by 2002:a17:90a:e98d:: with SMTP id v13mr17397080pjy.107.1575657998981;
        Fri, 06 Dec 2019 10:46:38 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:38 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 6/8] mfd: rk808: use common syscore for all PMCI for clean shutdown
Date:   Fri,  6 Dec 2019 18:45:34 +0000
Message-Id: <20191206184536.2507-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the register_syscore_ops to common location for all PMIC.
Add missing unregister_syscore_ops in rk808_remove function.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mfd/rk808.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 9a7be379946a..54f3999e4948 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -590,7 +590,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
 		cells = rk817s;
 		nr_cells = ARRAY_SIZE(rk817s);
-		register_syscore_ops(&rk808_syscore_ops);
 		break;
 	default:
 		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
@@ -644,6 +643,8 @@ static int rk808_probe(struct i2c_client *client,
 	if (!rk808_i2c_client)
 		rk808_i2c_client = client;
 
+	register_syscore_ops(&rk808_syscore_ops);
+
 	return 0;
 
 err_irq:
@@ -657,6 +658,8 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 
+	unregister_syscore_ops(&rk808_syscore_ops);
+
 	return 0;
 }
 
-- 
2.24.0

