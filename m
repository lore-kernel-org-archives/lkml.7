Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5531C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5742075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfDPLR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:17:29 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:33291 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbfDPLRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:17:24 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x3GAkZ0C014004;
        Tue, 16 Apr 2019 13:46:35 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 74C5262FFF; Tue, 16 Apr 2019 14:16:32 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     gregkh@linuxfoundation.org, arnd@arnd.de, robh+dt@kernel.org,
        mark.rutland@arm.com, yuenn@google.com, venture@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] misc: Add NPCM LPC BPC driver support 
Date:   Tue, 16 Apr 2019 14:16:29 +0300
Message-Id: <20190416111631.356803-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds BIOS Post code (BPC) support for the
Nuvoton NPCM Baseboard Management Controller (BMC).

Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two
configurable I/O addresses written by the host on the
Low Pin Count (LPC) bus, the capture data stored in 128-word FIFO.

NPCM BPC can support capture double words.

I have created common lpc-snoop documentation for both 
Nuvoton and Aspeed drivers as Andrew suggested.
Andrew Jeffery: https://patchwork.kernel.org/patch/10506269/ 

I prefer to add the lpc-dnoop documentation to misc folder instead 
of creating new /devicetree/binding folder that named BMC
as been done in the last lpc-snoop patchset because I am not sure
is something that should be done for only 
one module for now. 
https://patchwork.kernel.org/patch/10506269/

The NPCM7xx BPC driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Guenter Roeck: https://lkml.org/lkml/2019/4/15/450
 - Andrew Jeffery: https://lkml.org/lkml/2019/4/15/1385
				  
Changes since version 1:
 - Using devm_platform_ioremap_resource function.
 - Add new line at the end of dt-binding documentation.

Tomer Maimon (2):
  dt-binding: misc: Add common LPC snoop documentation
  misc: npcm: add NPCM LPC BPC driver

 .../devicetree/bindings/misc/lpc-snoop.txt         |  27 ++
 drivers/misc/Kconfig                               |   8 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/npcm-lpc-bpc-snoop.c                  | 385 +++++++++++++++++++++
 4 files changed, 421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/lpc-snoop.txt
 create mode 100644 drivers/misc/npcm-lpc-bpc-snoop.c

-- 
2.14.1

