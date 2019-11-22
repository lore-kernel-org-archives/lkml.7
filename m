Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263AEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFABB20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421748;
	bh=/NIyCPyZeLdBwZL2f6/XlX7dwDQA8o09yF4PJxAG3WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gl1JzGo5XvMMGp0C2+bj9417S3kFskTitVG/+ZfQxI/cIbFx5Atd9SvRW1AiBVdBS
	 JW9EvLiV1Aa6oMhYGw76cJkLz2wpSaACXhAi7hdPA1ku8KOzijp4D+FCGB7nqAS7Cw
	 A5ZIMRYZT4bOpXreVi+SAMTJRwaXUZU0luQaWSo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfKVKnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfKVKnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:43:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A6D20637;
        Fri, 22 Nov 2019 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419389;
        bh=/NIyCPyZeLdBwZL2f6/XlX7dwDQA8o09yF4PJxAG3WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2pydndonjjVUX4nzh3zAsRHTma9XSxTXgCwCkjkSUas9/q0jj3w0nrwOBMSofU/rM
         pub70Fs5KaZDFOAfQmuZ66hPrTGQNWhHeS5OVSULa0kcN2TVAd8fru2o+3sBm/qjVU
         VhW2Hh3TZ8PIWLrKqwAO4WrQmYyCTSF9trcvupbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 095/222] usb: chipidea: Fix otg event handler
Date:   Fri, 22 Nov 2019 11:27:15 +0100
Message-Id: <20191122100910.315599583@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 59739131e0ca06db7560f9073fff2fb83f6bc2a5 ]

At OTG work running time, it's possible that several events need to be
addressed (e.g. ID and VBUS events). The current implementation handles
only one event at a time which leads to ignoring the other one. Fix it.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/otg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index f36a1ac3bfbdf..b8650210be0f7 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -206,14 +206,17 @@ static void ci_otg_work(struct work_struct *work)
 	}
 
 	pm_runtime_get_sync(ci->dev);
+
 	if (ci->id_event) {
 		ci->id_event = false;
 		ci_handle_id_switch(ci);
-	} else if (ci->b_sess_valid_event) {
+	}
+
+	if (ci->b_sess_valid_event) {
 		ci->b_sess_valid_event = false;
 		ci_handle_vbus_change(ci);
-	} else
-		dev_err(ci->dev, "unexpected event occurs at %s\n", __func__);
+	}
+
 	pm_runtime_put_sync(ci->dev);
 
 	enable_irq(ci->irq);
-- 
2.20.1



