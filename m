Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86312FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0DB2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240454;
	bh=Sab2lu3lsOYA2LODitlLuvKjU5crS02ruw/fNrVJLaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nIbUWgexxjWCmYJZTISC0DreJ909+GIhdwgBfE3j80UQQjFksxuU9d4DkQMl26UBw
	 BBOnLv03ErnJBQPysmwaUotE+2Lhdx0wM+LZOlO9v9tedwqnM70FtAElHYJDqVisUh
	 l60QYJ9j8FwwJtHPJ+0hdOA9gnI5YTSrcjhQcrEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391319AbfKHTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391309AbfKHTGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:06:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5D1222C5;
        Fri,  8 Nov 2019 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240000;
        bh=Sab2lu3lsOYA2LODitlLuvKjU5crS02ruw/fNrVJLaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urb0OyU36KJohjcuB7WVLwH+ojEmRePzbkQQbGqwxTkLS4MPFrHncY9eItCh6Cb/3
         eGliWx71Kgv0PzRWwlRMM7ErYz0Ehhb+AWFqMQ8mRW6dWnyy5hfxS0OV5dOI3CR50d
         z9FsaGeuFfZ93/Hawc5SgDud57SW+7j+2ewGmo8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 027/140] pinctrl: ns2: Fix off by one bugs in ns2_pinmux_enable()
Date:   Fri,  8 Nov 2019 19:49:15 +0100
Message-Id: <20191108174905.121225494@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
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
index 2bf6af7df7d94..9fabc451550ea 100644
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



