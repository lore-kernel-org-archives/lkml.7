Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3160C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B78214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153774;
	bh=l+vwBq8B0iCqSp7zzsk2DETMYixOA5pWhzYBakqzhJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehc82002m5qrr+T515ppzD0TplYAI1Wekn7y4TaJxmbWaTgJ3DGjEbmPAhWmiBGoK
	 5ZohyO+MY0AJhCO0JmiY10eB1/mCSsTphYmzQrKuAzhLsfv+AUNKzQ1AZAtMlsCowG
	 XRuJ2VZ5Eovbback2zkQK20lo/hpeu7uXrMWAv+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfEFOmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbfEFOmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D530C21479;
        Mon,  6 May 2019 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153769;
        bh=l+vwBq8B0iCqSp7zzsk2DETMYixOA5pWhzYBakqzhJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVfwM6nIqARxOGRxYYeqgNPaLVxFaF580F/sJcppxGIDK8itu+ItC1TNjSWd9O1Ze
         GI+F7ZgqG9htDXkqTZWzBo+JuG41Knul/hc8JdLyMJVe7nsryhw3blErGuKRc0GjF+
         7KUgGWCGt/7LwxVYt1fM/esYsZNI7Fv7xmLdd1XA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 88/99] gpio: mxc: add check to return defer probe if clock tree NOT ready
Date:   Mon,  6 May 2019 16:33:01 +0200
Message-Id: <20190506143101.905965388@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

commit a329bbe707cee2cf8c660890ef2ad0d00ec7e8a3 upstream.

On i.MX8MQ platform, clock driver uses platform driver
model and it is probed after GPIO driver, so when GPIO
driver fails to get clock, it should check the error type
to decide whether to return defer probe or just ignore
the clock operation.

Fixes: 2808801aab8a ("gpio: mxc: add clock operation")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-mxc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -438,8 +438,11 @@ static int mxc_gpio_probe(struct platfor
 
 	/* the controller clock is optional */
 	port->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(port->clk))
+	if (IS_ERR(port->clk)) {
+		if (PTR_ERR(port->clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		port->clk = NULL;
+	}
 
 	err = clk_prepare_enable(port->clk);
 	if (err) {


