Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404AC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A82125721
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190841;
	bh=aFulq45jcbmOE+rmTiPFUcS+ut7sv6MMNvhjK8ujpNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q7JYb4IRWFXb24/F4pf0nzX+qievDX+VYTF7m4lPmzSG3nHk7GjtvMs9eArtDGCnJ
	 rojptuFmNWbyVeTekLCCA7LW0eHEe9joDV8an+fCSFoSqK4MNsDqARK0UVF8VQI4+w
	 /s2KrpXKDZ5fFgfoRt61/n/bgIrfDvEqV4DI06Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfE3EeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfE3DN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:27 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D32A2449A;
        Thu, 30 May 2019 03:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186006;
        bh=aFulq45jcbmOE+rmTiPFUcS+ut7sv6MMNvhjK8ujpNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtbDNkmAQCrugU/l6NLmCTXa1j5t7XV8zfwq3byiHkJUGtx+4VKJVgKGWO3I/1Vy3
         +NCSudbGRMjyLWF7pu9c0UmxLZ+n4c2jWWO7N1cqmukS1zvXvjOXHXceZr9p4e45Fg
         rjs6v/EgQtdtTOtbNxgDVPc8dBLrFeepzrnSW0Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, linux-gpio@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 061/346] pinctrl: zte: fix leaked of_node references
Date:   Wed, 29 May 2019 20:02:14 -0700
Message-Id: <20190530030544.157167473@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 02d15f0d80720545f1f4922a1550ea4aaad4e152 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/zte/pinctrl-zx.c:415:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:422:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:436:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:444:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:448:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/zte/pinctrl-zx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/zte/pinctrl-zx.c b/drivers/pinctrl/zte/pinctrl-zx.c
index caa44dd2880a8..3cb69309912ba 100644
--- a/drivers/pinctrl/zte/pinctrl-zx.c
+++ b/drivers/pinctrl/zte/pinctrl-zx.c
@@ -411,6 +411,7 @@ int zx_pinctrl_init(struct platform_device *pdev,
 	}
 
 	zpctl->aux_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!zpctl->aux_base)
 		return -ENOMEM;
 
-- 
2.20.1



