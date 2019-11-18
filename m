Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF0EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AF20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G64zeN1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfKRL0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:26:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKRLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so18953775wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=td9IeMtAnKP3TNZfmfJvazvskLsY9wm2/Illqt7TzBU=;
        b=G64zeN1sRuWJalczBb4PcQsQpdk8AHwaM9zcHSLXuqOvP5z4JH7E9AP76uvffGy3zY
         yjRjr2asra7B1qPqQ/fI0qbAgipxM8OEVMFbLZ0C/GpWiqxCk1f8PPb1AHMEFvY4WNYP
         gENB4iPaF1vsQQWQhDFs6zCOfSvffYUQVX+vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=td9IeMtAnKP3TNZfmfJvazvskLsY9wm2/Illqt7TzBU=;
        b=TSmh9vloaHkRKRVVq8TFvo/vPLqUbdk02lEuOd9UDAhLg3UcvADLeWaHPfoLFUgbQ6
         M6vpbyuHb83ejobwV1uOATvGFo2DXuQIO0C4dcOzwvzCn3dADbvRx3BuxB4jXLDeIaC2
         9LIHmKmtH7lpD18wF44/OGsZU0PVjw0vu0IBTUqx3oJqdtE2YDxP57Mqax3vU+k2ChD8
         V1476i2stz005Njj0WswZVwki23ZzFo8MgQ+CaCn7xogbI5DGrQO86voruq13+sJjRJ4
         VMuGfrRqVZuUfpX1j8tZxtRoa0uq9fJDlcjmgXTvSnbqZxY5fA+lDU9zxycmEdpHk1tv
         Kwqg==
X-Gm-Message-State: APjAAAUQdBotqOE2nCs8FO2xE+H2sGZ00PPH5y2HeVpHsTWpVdh5gweD
        IgToprYouP3uT0RZOp+XRrKu4Q==
X-Google-Smtp-Source: APXvYqzirelmZJRfngi/39rVlWqXESUNTo+aHeVFXR3g/cUeCUfTGitgRt+Ga84uxToqgzwRUh8Unw==
X-Received: by 2002:adf:db4b:: with SMTP id f11mr2022844wrj.239.1574076221874;
        Mon, 18 Nov 2019 03:23:41 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:41 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 09/48] soc: fsl: qe: drop assign-only high_active in qe_ic_init
Date:   Mon, 18 Nov 2019 12:22:45 +0100
Message-Id: <20191118112324.22725-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

high_active is only assigned to but never used. Remove it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 8c874372416b..4b03060d8079 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -320,7 +320,7 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret, high_active = 0;
+	u32 temp = 0, ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -366,10 +366,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		temp |= CICR_GRTB;
 
 	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL) {
+	if (flags & QE_IC_HIGH_SIGNAL)
 		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-		high_active = 1;
-	}
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-- 
2.23.0

