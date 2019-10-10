Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97957ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E26206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpVYwvBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbfJJBbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:31:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35609 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJJBbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:31:13 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so10119931iop.2;
        Wed, 09 Oct 2019 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EECY3Fn7ERfSk3kaNkDc4LWe0Wk5Us4HkrIqZXFVQYs=;
        b=BpVYwvBLiXdK9jnurSGzV8/RWT0CoEeQztHt9l/+nWHXkVlZMtnKykxW74MRuVw3Qm
         w0FBKi91ib1bV2MBNW8Ghp3keTncEJbdHL2XHKDYD4rInuLrz8DGLlYMsg6yZdK+D8Im
         ABs2VErgJuArZbu7KqVjGekm/kUn11Lj6S5nzjct+nmHbWf4w2eEm5ZkkH0e2jSIFWKa
         4rdv9s6iqF7TS5Q+v1fxVX5SQ2wxfvlr2NIliNlm8Wt4JLjKOHxCVUKpHHdhBLw100j2
         TaA69t0VZmKgSmIdiUjHQHVGDNadAgpKfTR5qvBLhTAH93Lbfao/71w7BY35Xutfa3ym
         57YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EECY3Fn7ERfSk3kaNkDc4LWe0Wk5Us4HkrIqZXFVQYs=;
        b=lGiVR5Z/a2gRzWJKIA2Lek+iPGOKu8xYjrzRuPIXqQSlrKZeI4e1tATZTJB575xG8E
         oKnYBwbCQhKd7jHxt1BrF0Jd4ciiAtchhMliyXG4mWkz7/JjDJHD/3KRFQiRQK1aloLz
         TX/4zwmpskBuQSoDV5MSKQZxigveL1WJByCsDmKLCKR+LaUubs0DAThzklvvgaUhXuV1
         t9lL5T2frPqgCcDbM+XCUad7tGk4JtIGhjd4piVIbWpRcIla6qsIhCDlGFPXUsJ6jUhp
         zgYCNcSj5dq6Av7uHCSvigKWpqzmYd9spisk/56+HHS2fUeFDVtDYLJaRyPdWavODsPe
         vN3A==
X-Gm-Message-State: APjAAAW8PDZZlOeMXqcgb5y6JsXiAHeee1vxfCGHdjmvJ7YfuygioLkq
        tCaSAuwMxmdUVjVZx5ekCOE=
X-Google-Smtp-Source: APXvYqxEHzLMBGtscrLT6MKlC333wTgfQcvHlzq59OkQTbwmLZj2u36d3Rm/smtUBm5BON7GESKAPQ==
X-Received: by 2002:a02:3081:: with SMTP id q123mr6874353jaq.24.1570671073004;
        Wed, 09 Oct 2019 18:31:13 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id z1sm2300510ioe.8.2019.10.09.18.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 18:31:12 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: bcm2835: Fix memory leak in bcm2835_register_pll
Date:   Wed,  9 Oct 2019 20:30:58 -0500
Message-Id: <20191010013101.5364-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of bcm2835_register_pll(), the allocated memory
for pll should be released if devm_clk_hw_register() fails.

Fixes: b19f009d4510 ("clk: bcm2835: Migrate to clk_hw based registration and OF APIs")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 802e488fd3c3..99549642110a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1320,8 +1320,10 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 	pll->hw.init = &init;
 
 	ret = devm_clk_hw_register(cprman->dev, &pll->hw);
-	if (ret)
+	if (ret) {
+		kfree(pll);
 		return NULL;
+	}
 	return &pll->hw;
 }
 
-- 
2.17.1

