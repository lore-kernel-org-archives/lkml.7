Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C71C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B15F2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413337;
	bh=0i8+MroQvcCp4W7iTdzxkMdymi9RZSRFAFVF573fmOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2e8oiH0m6KlHBdzVjqvRl2lO5jALgj5iytdPRZG7Fb89kLTIfq8AYQeeuqpF/u7L
	 /iG8pFi2ElUra/tH8cbbLmj+s6E2bse+K5C61TIckV9iTEimjXirlpmVG0sK4U4Pab
	 aVDvNjQasnym9tvzlx13noYgW8Era7kWBuKX1E3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfLCWsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfLCWst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:48:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9D820684;
        Tue,  3 Dec 2019 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413328;
        bh=0i8+MroQvcCp4W7iTdzxkMdymi9RZSRFAFVF573fmOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZApyfCgGjDt20MZ30IZnGMia7n251hhxMt7TibG+W0Vmm91NAPZllX9YqRSRYNSj
         jKtY4yVOmFr+M9p2w8d1QaJW/UhKLX+nTNjEWCEhwO/2PNHpLB2iM2i5tXSdJOhSvQ
         Z6ptTifYDTLZLw+JYJr/uM7iWO+2/p/6IjDWsWo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/321] pwm: bcm-iproc: Prevent unloading the driver module while in use
Date:   Tue,  3 Dec 2019 23:31:52 +0100
Message-Id: <20191203223429.504337448@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 24906a41eecb73d51974ade0847c21e429beec60 ]

The owner member of struct pwm_ops must be set to THIS_MODULE to
increase the reference count of the module such that the module cannot
be removed while its code is in use.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-bcm-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index d961a8207b1cb..31b01035d0ab3 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -187,6 +187,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops iproc_pwm_ops = {
 	.apply = iproc_pwmc_apply,
 	.get_state = iproc_pwmc_get_state,
+	.owner = THIS_MODULE,
 };
 
 static int iproc_pwmc_probe(struct platform_device *pdev)
-- 
2.20.1



