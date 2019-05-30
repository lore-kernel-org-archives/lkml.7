Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ABC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77D625283
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189811;
	bh=iyYhyzwjSKdo9HU+rtPr7PdzkHWb+QaJqJfY4l4hY0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/xen0FIM2nPciCgMLmblYlYw2z/u+aQMYzJBgFhtkG02emiJgj5LzUvwciwUT3aU
	 4S7qiOcJsS6jUPHB4fVd4oAmqQN0OQjnWz2/UsPQQgiUjt3eIMpS0R+TbhnRPeybyC
	 aYhtWJlHvkLJaHGUzgRudnOaaG3vsrRXSP1SF3Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfE3EQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbfE3DPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:45 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D26245A9;
        Thu, 30 May 2019 03:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186144;
        bh=iyYhyzwjSKdo9HU+rtPr7PdzkHWb+QaJqJfY4l4hY0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idqqvIM10UV38A/QK+umYGww+9bPx4Xk99EKs8ScQMye0Txygm/dzyqG96XuuyxSX
         lguFEEWaRDQRuVSEEtBXHLO+BtFFgxqeYFdpLiHeMudb/K1dp85bvVIWAiebJ7Ly0x
         X8ZVVTCODy+vrp0lGJfXkwaFBL0LHW17QIcUqwpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 322/346] regulator: wm831x ldo: Fix notifier mutex lock warning
Date:   Wed, 29 May 2019 20:06:35 -0700
Message-Id: <20190530030557.094413388@linuxfoundation.org>
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

[ Upstream commit 8be64b6d87bd47d81753b60ddafe70102ebfd76b ]

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: d1c6b4fe668b ("regulator: Add WM831x LDO support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/wm831x-ldo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index e4a6f888484ec..fcd038e7cd803 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -51,9 +51,11 @@ static irqreturn_t wm831x_ldo_uv_irq(int irq, void *data)
 {
 	struct wm831x_ldo *ldo = data;
 
+	regulator_lock(ldo->regulator);
 	regulator_notifier_call_chain(ldo->regulator,
 				      REGULATOR_EVENT_UNDER_VOLTAGE,
 				      NULL);
+	regulator_unlock(ldo->regulator);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1



