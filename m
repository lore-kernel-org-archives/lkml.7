Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3502AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027BC20674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240750;
	bh=sIPwQ4u7Z3vSg97f/aUb5xfgPihDNGLx3nfdTiQaRpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snolMu0ztQVGT4mClkv68tUPxKsYeuPTYsA68OZSe4wfOY/kJ9ZTIrYK9NUgvnnFp
	 YGIhW3cLjNLdSTRt4RdD4yQeYdms/+KpkuZMGd+T52ZYxBCTBCRevgOfcxrO/H9L4l
	 GnK3PbUz900ILAS7wcq4fQ7Oa989dsgnDoVy4s7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbfKHTTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389514AbfKHTAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EACC222C4;
        Fri,  8 Nov 2019 18:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239447;
        bh=sIPwQ4u7Z3vSg97f/aUb5xfgPihDNGLx3nfdTiQaRpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlKirObhWTKSfweURuNveFDvq+1z+cP4Wykzq45pxQmcAtV+8khjiC3PXrdJE6Pup
         0BaRDL9OTkUcMPxwkqLG++GmgO9JZUDyXsXZm1u8+xj+TQYNE87CZGLK7XjTlP//OY
         BMzKgzlJQzsDhSYMZyMHLzXvLijL29RSa+NBSenM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/34] pinctrl: ns2: Fix off by one bugs in ns2_pinmux_enable()
Date:   Fri,  8 Nov 2019 19:50:13 +0100
Message-Id: <20191108174627.598993760@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 39b65fbb813089e366b376bd8acc300b6fd646dc ]

The pinctrl->functions[] array has pinctrl->num_functions elements and
the pinctrl->groups[] array is the same way.  These are set in
ns2_pinmux_probe().  So the > comparisons should be >= so that we don't
read one element beyond the end of the array.

Fixes: b5aa1006e4a9 ("pinctrl: ns2: add pinmux driver support for Broadcom NS2 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20190926081426.GB2332@mwanda
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
index 13a4c27741572..6adfb379ac7e6 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
@@ -640,8 +640,8 @@ static int ns2_pinmux_enable(struct pinctrl_dev *pctrl_dev,
 	const struct ns2_pin_function *func;
 	const struct ns2_pin_group *grp;
 
-	if (grp_select > pinctrl->num_groups ||
-		func_select > pinctrl->num_functions)
+	if (grp_select >= pinctrl->num_groups ||
+		func_select >= pinctrl->num_functions)
 		return -EINVAL;
 
 	func = &pinctrl->functions[func_select];
-- 
2.20.1



