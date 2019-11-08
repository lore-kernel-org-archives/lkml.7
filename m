Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF78C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A2E2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239653;
	bh=MEbPA6Qcubxag4Ew2M//KXeX4cegr3py9JHVD7ZNsRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N0N7V3H8nT2A7p0wH4wtOZLKfUNWkWDYzWeYJAZ9xvnbGgIja7Ggi6ZunveIdz4qG
	 vUqTMd05ombSA+PlJBKmhYB5y8caI0G2kUO6tElycKnx5VgYIXx0/AFbEsg8qDbMAu
	 7xvRFDgmFRz6wQU9TuWeeCX+d7PVfxbHTZejwDLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfKHTAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389908AbfKHTAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CC82067B;
        Fri,  8 Nov 2019 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239644;
        bh=MEbPA6Qcubxag4Ew2M//KXeX4cegr3py9JHVD7ZNsRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHJ1b2s1dxtdVw2gGlbuX0E8FSkGWoG4W++NUujTKI7jbHCU0gbhDz8QJRJ4Ak6Mp
         BskEOulPGAV1B+nJzlSzUvKipcf+5OqgGJK+HStgEoqsIkUAo2vTsqsSuyDscg+x9d
         rj8iiqBoMXYTD6XzppwSlbss1YM2ejdN5/hfyn0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/79] pinctrl: ns2: Fix off by one bugs in ns2_pinmux_enable()
Date:   Fri,  8 Nov 2019 19:49:53 +0100
Message-Id: <20191108174752.160133693@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
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
index 4b5cf0e0f16e2..951090faa6a91 100644
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



