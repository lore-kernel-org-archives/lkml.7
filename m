Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB717207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDBXHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:07:15 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:35384 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:07:15 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 19:07:06 EDT
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSQGhVnLFldkPBSQHhKth3; Tue, 02 Apr 2019 17:02:29 -0600
X-Authority-Analysis: v=2.3 cv=Ko4zJleN c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8
 a=dE1nd1RK7gJplRNs3mEA:9 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 1A2503010142F7; Tue,  2 Apr 2019 16:02:28 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] memory: brcmstb: dpfe: wait for DCPU to be ready
Date:   Tue,  2 Apr 2019 16:01:00 -0700
Message-Id: <20190402230103.25491-4-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402230103.25491-1-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDMB4UP1Ylg08TW5VgvcgNtKFN1remx5H/3G2T0ggol9J7OQfUNX3GgF2tbDvDJ2BqFCukxZ9mHtx0P2pewDxES31lXfM8Mf/IvRge2TzONrWflszaql
 lWXxxvvwRkPsfaimMtx1kYl8+A1eJrar/bKtHGBXvJT5W6r2jZlufDbGw6+cWt0A+OSeWgd6rw/rnZjOaMz7/dqJwxQEwqGw4HnBzyHrp2wTklUk3z4aAU+6
 4zXN6BS87nYP+hapSkLtqql6oFQe3ipes8HUQPRQ9DvhlYYUTJ4kGmEeca4p4872EaF9dBYZLFFsyNK856bM+g5UkUsNr70LXabRugupLznxA81tulbxf34s
 9V7KrI57ZPheIRaWt8Aa/SlDW9nNsH0xwfgIt6RoPRRuYiqeaLtassUgdnhClEG2F9wRilvRqE2RhAtw4UKT/sVezt2YNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

We wait for the DCPU to be ready before sending a command.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index c67774a4fe8b..f8d05a8266c3 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -304,6 +304,18 @@ static int __send_command(struct private_data *priv, unsigned int cmd,
 
 	mutex_lock(&priv->lock);
 
+	/* Wait for DCPU to become ready */
+	for (i = 0; i < DELAY_LOOP_MAX; i++) {
+		resp = readl_relaxed(regs + REG_TO_HOST_MBOX);
+		if (resp == 0)
+			break;
+		msleep(1);
+	}
+	if (resp != 0) {
+		mutex_unlock(&priv->lock);
+		return -ETIMEDOUT;
+	}
+
 	/* Write command and arguments to message area */
 	for (i = 0; i < MSG_FIELD_MAX; i++)
 		writel_relaxed(msg[i], regs + DCPU_MSG_RAM(i));
-- 
2.17.1

