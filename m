Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C621C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D608720673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122747;
	bh=AR8xkLta58mWfwbBEqsTYV291X1xSKFmHu7uqW2tgpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1sRRNhvOQ+qWCu7onpMA2kWKb0msED4BLSuDZwtnuhDMea4lme63XM9xX/balpQW
	 jCjLDQG8MlfJ/K4m4GjOghyGKShKD6kAe2WrkXwI/k7nuSt48fT0RZvZ0hT03QfP4P
	 QWqO7wQgmVEOzDaGey4xgTCYId0IwCpQi8Fz7CEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbfJCQaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391689AbfJCQaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:30:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51822054F;
        Thu,  3 Oct 2019 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120214;
        bh=AR8xkLta58mWfwbBEqsTYV291X1xSKFmHu7uqW2tgpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmEw4kUGE+4oV665ariadkmQ8KjoQnl21LEEactzvjk4+d50cRdcDj9FxLd2FgOmu
         KLTkvnssC1Pmtgsv6KAwpL0N3NEFJVhWrXs+z5zKNdwYbDCEtEtmJDxGk8pmmNWwD9
         rbew6CJzwN5R0BvPZOech/ntuJs+PF4YHqq/Rd/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 139/313] PM / devfreq: passive: Use non-devm notifiers
Date:   Thu,  3 Oct 2019 17:51:57 +0200
Message-Id: <20191003154546.570911185@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 0ef7c7cce43f6ecc2b96d447e69b2900a9655f7c ]

The devfreq passive governor registers and unregisters devfreq
transition notifiers on DEVFREQ_GOV_START/GOV_STOP using devm wrappers.

If devfreq itself is registered with devm then a warning is triggered on
rmmod from devm_devfreq_unregister_notifier. Call stack looks like this:

	devm_devfreq_unregister_notifier+0x30/0x40
	devfreq_passive_event_handler+0x4c/0x88
	devfreq_remove_device.part.8+0x6c/0x9c
	devm_devfreq_dev_release+0x18/0x20
	release_nodes+0x1b0/0x220
	devres_release_all+0x78/0x84
	device_release_driver_internal+0x100/0x1c0
	driver_detach+0x4c/0x90
	bus_remove_driver+0x7c/0xd0
	driver_unregister+0x2c/0x58
	platform_driver_unregister+0x10/0x18
	imx_devfreq_platdrv_exit+0x14/0xd40 [imx_devfreq]

This happens because devres_release_all will first remove all the nodes
into a separate todo list so the nested devres_release from
devm_devfreq_unregister_notifier won't find anything.

Fix the warning by calling the non-devm APIS for frequency notification.
Using devm wrappers is not actually useful for a governor anyway: it
relies on the devfreq core to correctly match the GOV_START/GOV_STOP
notifications.

Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/governor_passive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 58308948b8637..da485477065c5 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -165,12 +165,12 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 			p_data->this = devfreq;
 
 		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devm_devfreq_register_notifier(dev, parent, nb,
+		ret = devfreq_register_notifier(parent, nb,
 					DEVFREQ_TRANSITION_NOTIFIER);
 		break;
 	case DEVFREQ_GOV_STOP:
-		devm_devfreq_unregister_notifier(dev, parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		WARN_ON(devfreq_unregister_notifier(parent, nb,
+					DEVFREQ_TRANSITION_NOTIFIER));
 		break;
 	default:
 		break;
-- 
2.20.1



