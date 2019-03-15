Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F10CC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD2F2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="BMPpTvxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfCOA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:59:56 -0400
Received: from mail.nic.cz ([217.31.204.67]:46443 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfCOA74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:59:56 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 2FE8460212;
        Fri, 15 Mar 2019 01:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1552611593; bh=XL67WXSvWF7TcYj3JnhjpnYDPLs+2DriTKa4AW6q5vE=;
        h=From:To:Date;
        b=BMPpTvxrmQZjsjvL9fSvc2AwGR0HFSVMaAeC8SN/9baGmm60oNjuVP147Ea9bSaCe
         2DUkcdMOE6lEN43i7bEqDiv1LGVd+U1cTo/t6hlNacbHgt0CJOa7w6UTn+IU3w9t3R
         5nRSWAGvlqwmttUvxiTNrHFPwjUHRA8OTZceN07g=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v3 mailbox+firmware 0/6] Armada 37xx mailbox + Turris Mox secure firmware support
Date:   Fri, 15 Mar 2019 01:59:20 +0100
Message-Id: <20190315005926.5994-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is the third version of my patches to add support for
rWTM mailbox of Marvell A3700 compatible devices, this time also with
turris-mox-rwtm firmware driver.

I would like to ask you guys for reviews, since I didn't get any review
for the first patch (adding mailbox support) yet.

What's new in v3:
 - Three more patches, to add support for communicating with the secure
   firmware on the Turris Mox board. The driver for this firmware needs
   the mailbox driver to be able to communicate with the secure
   processor.

Changes since v2:
 - changed the mailbox driver not to fail when sending a message if the
   firmware reports that secure processor is not ready. The firmware on
   EspressoBin does not indicate that it is ready in the designated
   register, even if it answers to commands. Print only a warning if the
   ready flag is not set in the FIFO_STATUS register.
 - added Rob's Reviewed-by tag for the mailbox dt-binding patch

Marek

Marek Behún (6):
  mailbox: Add support for Armada 37xx rWTM mailbox
  dt-bindings: mailbox: Document armada-3700-rwtm-mailbox binding
  arm64: dts: marvell: armada-37xx: add mailbox node
  firmware: Add Turris Mox rWTM firmware driver
  firmware: turris-mox-rwtm: Add sysfs documentation
  dt-bindings: firmware: Document cznic,turris-mox-rwtm binding

 .../testing/sysfs-firmware-turris-mox-rwtm    |  60 +++
 .../firmware/cznic,turris-mox-rwtm.txt        |  19 +
 .../marvell,armada-3700-rwtm-mailbox.txt      |  16 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   7 +
 drivers/firmware/Kconfig                      |  14 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/turris-mox-rwtm.c            | 508 ++++++++++++++++++
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/armada-37xx-rwtm-mailbox.c    | 225 ++++++++
 include/linux/armada-37xx-rwtm-mailbox.h      |  23 +
 11 files changed, 885 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
 create mode 100644 Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt
 create mode 100644 drivers/firmware/turris-mox-rwtm.c
 create mode 100644 drivers/mailbox/armada-37xx-rwtm-mailbox.c
 create mode 100644 include/linux/armada-37xx-rwtm-mailbox.h

-- 
2.19.2

