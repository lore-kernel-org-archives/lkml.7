Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF7C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="htsbbGEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDOBrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:47:45 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.251]:43318 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfDOBrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 21:47:45 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id E1C6E98AE
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 20:27:28 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id FqPAhppuz2PzOFqPAhODSW; Sun, 14 Apr 2019 20:27:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nli8XspRAniu+hZMp6iB5II++QseN+g9eYpJ/egI1YI=; b=htsbbGEN8M1y4WkfxhcRtS26n
        7SIG8Y/yr7EJPBo2tatX7ijBZ2s0oPBRPwo2Xj145M0c1og/RyMZ4aGiif0ZKATDA8JSX1Onjm4UI
        opyT4H4akgPqiBcPudphUJmr1pPN8eqXYTZxwI2m9Z3AG5Fqt7wYm4VUaMrrznFffaqCC609bkCPx
        B+hDpqksLPLkl/TKOkAVjyYze4cVkVQK+CjUgBfgxxpAxjQExnAnVTXhQshN3HnFdrH/o4O0BjTdS
        IktnUmZo40VWRVTS86q7r83PmQZt+IgkCE0ZL+kVtOXHEAoRJoqAcofTXu60KZDUANaUuqodwk4hC
        gO/A/cLTw==;
Received: from [191.191.240.251] (port=33232 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hFqP7-000Uj7-Tc; Sun, 14 Apr 2019 22:27:28 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 4/4] power: supply: max17040: Send uevent in SOC changes
Date:   Sun, 14 Apr 2019 22:26:35 -0300
Message-Id: <20190415012635.6369-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190415012635.6369-1-matheus@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.191.240.251
X-Source-L: No
X-Exim-ID: 1hFqP7-000Uj7-Tc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.191.240.251]:33232
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 55
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify core through power_supply_changed() in case of changes in state
of charge. This is useful for user-space to efficiently update current
battery level.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index f036f272d52f..db901ebf495d 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -208,10 +208,17 @@ static void max17040_check_changes(struct i2c_client *client)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	int last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
+	/* store SOC for check change */
+	last_soc = chip->soc;
 	max17040_check_changes(chip->client);
 
+	/* check changes and send uevent */
+	if (last_soc != chip->soc)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
-- 
2.17.0

