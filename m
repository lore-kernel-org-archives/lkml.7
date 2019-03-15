Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EFC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C14421873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="eTuzDzp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfCOA77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:59:59 -0400
Received: from mail.nic.cz ([217.31.204.67]:46481 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfCOA75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:59:57 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id C0EDB6349F;
        Fri, 15 Mar 2019 01:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1552611593; bh=7nwYubPVyHO1QTa8B2zena5P4Yk2SHX083yXXVFMOBY=;
        h=From:To:Date;
        b=eTuzDzp8Jqbii54Ck8napAC8vcMpYr88EqYxwewibFZiv2ZtzRN84jcOj7d4fYZM4
         +dDNwqQK7YWXSNYvLZImkp9o3k5fJvTtR2cUUzycG5mOpRqSONVzdYzMfIbiDB/jkw
         t4G3J47O15OTVaY35JSfNL2pw2qdCLaI8WCMuCno=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 mailbox+firmware 6/6] dt-bindings: firmware: Document cznic,turris-mox-rwtm binding
Date:   Fri, 15 Mar 2019 01:59:26 +0100
Message-Id: <20190315005926.5994-7-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190315005926.5994-1-marek.behun@nic.cz>
References: <20190315005926.5994-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree binding documentation for the driver communicating
with the rWTM firmware on Turris Mox.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../firmware/cznic,turris-mox-rwtm.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt

diff --git a/Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt b/Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt
new file mode 100644
index 000000000000..338169dea7bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt
@@ -0,0 +1,19 @@
+Turris Mox rWTM firmware driver
+
+Required properties:
+ - compatible		: Should be "cznic,turris-mox-rwtm"
+ - mboxes		: Must contain a reference to associated mailbox
+
+This device tree node should be used on Turris Mox, or potentially another A3700
+compatible device running the Mox's rWTM firmware in the secure processor (for
+example it is possible to flash this firmware into EspressoBin).
+
+Example:
+
+	firmware {
+		turris-mox-rwtm {
+			compatible = "cznic,turris-mox-rwtm";
+			mboxes = <&rwtm 0>;
+			status = "okay";
+		};
+	};
-- 
2.19.2

