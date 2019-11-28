Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26193C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C8B21787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Fs4SgS4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfK1O5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34251 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfK1O5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id m6so21459888ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBhz5rvCw4g2Ox9AwtLP/2ydNw3vwlfo4gXSav3FB44=;
        b=Fs4SgS4/1psPKfkuhI4Ny+x/2oJrTK7HBfKE4/RCaNwwy+uA8dMiNwd3beo5/zLTHw
         62oVxo+n4p+sA9/H9nbzmMU2pfSe0i3IY9PDEKXtA5Y16gW6pwQTd4R0Uiu6nNqFDpUH
         SzXhTou8vQGjVBBwFvDic+ydbfn1zpUpRjhKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBhz5rvCw4g2Ox9AwtLP/2ydNw3vwlfo4gXSav3FB44=;
        b=L1l48ZqkPTy1katdprycsTr9CtZoqYQkcGWRzC+fN0OkTb+llSQJWAGV1X+XdmnGSd
         RC0CxbrzzuK6m7yj538Jj1txA7CFDZwt5gS6CmvBmIxqPhtC9n6q5nCeHRI9vlsu3OpI
         LlfVUs0O+95dFkxZ4DKGtZ4dFAGYzE1+eSgNtFOi+O2RMEBOqilaNuvkqWwkY2UUvPeG
         uGqbBU5OCWvUBNqBOJgWwqOqe5dfSUuxjWiBKUbzKHy3fmH4WLyD1BxRBN/ZUPHemZgQ
         dVc09PihAn6eKgt9viZlNulYPeS1mfMxRduhKdqXGfCudg+WNeGTERUAltL5GWJeesxn
         CunA==
X-Gm-Message-State: APjAAAXLvoaNf+BejIp1Pi18fbY8GpxYmghSRG5wC/eD206Vijc9W35i
        xOutnUkffPC02QkAMfT96+ujDA==
X-Google-Smtp-Source: APXvYqx99pjU5nTC/rq9MmsMvdS7IjR/57AJ+W7tuU3iN95pO3rx6CAJcCzrdDDJbnd7jwEkPdc8CQ==
X-Received: by 2002:a2e:888b:: with SMTP id k11mr10315128lji.87.1574953068992;
        Thu, 28 Nov 2019 06:57:48 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:48 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 33/49] serial: ucc_uart: limit brg-frequency workaround to PPC32
Date:   Thu, 28 Nov 2019 15:55:38 +0100
Message-Id: <20191128145554.1297-34-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Timur Tabi

    This bug in older U-Boots is definitely PowerPC-specific

So before allowing this driver to be built for platforms other than
PPC32, make sure that we don't accept malformed device trees on those
other platforms.

Suggested-by: Timur Tabi <timur@kernel.org>
Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index c055abf4c919..9436b93d5cfa 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1392,6 +1392,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (val)
 		qe_port->port.uartclk = val;
 	else {
+		if (!IS_ENABLED(CONFIG_PPC32)) {
+			dev_err(&ofdev->dev,
+				"invalid brg-frequency in device tree\n");
+			ret = -EINVAL;
+			goto out_np;
+		}
+
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
-- 
2.23.0

