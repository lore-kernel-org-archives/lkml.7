Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA27CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6FD2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450975;
	bh=MEbPA6Qcubxag4Ew2M//KXeX4cegr3py9JHVD7ZNsRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggO72RfCHPLPEabhzu8M5itZIyeZ+73GM+qT4c2bWq30Dg58O6Tm9Nz+GsWoJUkMY
	 OLW7aPHtokwxvgaXOerqoaBgcOHLw/4uqZPvLCVsL0bbJ7GN1BEusoQLAI6w2cqBS8
	 dZ7trpM0mNR0vhz+ypfiKrKk0b00mVHu3sset9Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfJ3P4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbfJ3P4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:56:12 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B152B2087E;
        Wed, 30 Oct 2019 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450972;
        bh=MEbPA6Qcubxag4Ew2M//KXeX4cegr3py9JHVD7ZNsRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cw8iT3MFZsFlyChNbk++ArpujRm2/98Xky3yXhJOYYnOkfvwF4gh/9PnZVLMJvjtH
         FDSG7s+DNm4o7QFsxDBBlTqkvShjiM0ReKNHjhvD66QQ0aNvtkH4LErGLzS/WJWnaH
         ITARGQgtwUnWNj873MYGfaS2BQE2H2P8vfrA/0xI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/24] pinctrl: ns2: Fix off by one bugs in ns2_pinmux_enable()
Date:   Wed, 30 Oct 2019 11:55:38 -0400
Message-Id: <20191030155555.10494-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155555.10494-1-sashal@kernel.org>
References: <20191030155555.10494-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

