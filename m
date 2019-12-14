Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C593C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB9224125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjJhF1CA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLNSLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:11:38 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33089 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfLNSLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:11:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so1148914pjb.0;
        Sat, 14 Dec 2019 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SvTdvPiQ4xS/R0i2wr0OUTzm/R634IQg+liWq51l5qI=;
        b=GjJhF1CAXzdxoO+FucPX1sTsI0/8x0LFMpCRzTIKTB81SGg0MRkFv1GuE/kKOUL7UM
         6xh1yviwLoQNhqQclDhr0qbETgbrQEG3Ud5h6lssD5CihvWHgbVvX6aL1znY47R16vE/
         ni44huX7x6QKD+AxFPeFCEPoWTnbtgzVWNKv8UqHGkmTqwiSPs5E+KsZp2EXozsYAOhX
         3hYprEBKDcQcZKcQD4ARCH0TFznsrlG/fZGamrUOwgWtiiVSUq8eqaX6lUkslUZDWMwO
         X6+igpp4YIpotZWdWePFhV80TtqzIO+7MiGcJ+TpQj+fIBok9XfGdQvGdXu+alQtEHut
         4SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvTdvPiQ4xS/R0i2wr0OUTzm/R634IQg+liWq51l5qI=;
        b=SAi0fXmjUwWcM0gyarAOTC1jqa2bw9J1mgvb+ldBRF9ZoAIpoPTKdXj02oeOjj6cVk
         BtX+hGVh/PhDaxZK88X/m+bij/kvvDFU2qObVbbnGNqLkuBIJMliPwCw9dJtRM7BTA1U
         CYLfJNUgy9b8R0Kr9bQIpvyeMM4TicTz0lpsHz8I4wyNPMHwZL9wR00HIzyX3S77hlsX
         Ya72WhXbJcxdpwu9QfLwvteMZDRh8GPwckwgtk3ErAuhVHJdZelpk937/pBpyfmBXzhL
         3K2tKhnONUbbGtla0Nl46tyFsQRZ/KPUC0xLGKZAFnWRMd3QAjgp/2V+LgNzrY8q/Qvq
         S80g==
X-Gm-Message-State: APjAAAWSzFomgwIym5wkBevIMvbnkDh94B1O0UhB6vi5E2FnCIb8zY6I
        rMKqDyLmMpAQ0qTRbMMy0BQ=
X-Google-Smtp-Source: APXvYqwO9rgNZe3r1YYJXfOMjUaz6xLzQB0K3HMgzzIWBQTtDHfKH5LltW8bhA04msSercIVr4AEHw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr6447836plo.57.1576347096300;
        Sat, 14 Dec 2019 10:11:36 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id f8sm13276261pfn.2.2019.12.14.10.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Dec 2019 10:11:35 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] PM / devfreq: rk3399_dmc: add missing of_node_put()
Date:   Sat, 14 Dec 2019 18:11:30 +0000
Message-Id: <20191214181130.25808-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214181130.25808-1-tiny.windzz@gmail.com>
References: <20191214181130.25808-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put() needs to be called when the device node which is got
from of_parse_phandle has finished using.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/rk3399_dmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2e65d7279d79..2f1027c5b647 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -372,6 +372,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (node) {
 		data->regmap_pmu = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(data->regmap_pmu))
 			return PTR_ERR(data->regmap_pmu);
 	}
-- 
2.17.1

