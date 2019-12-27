Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB42C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9232620740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="Bf56xgAv";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="EE4Dtcpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfL0RBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:01:16 -0500
Received: from smtp110.ord1d.emailsrvr.com ([184.106.54.110]:50411 "EHLO
        smtp110.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfL0RBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1577466075;
        bh=8ASEO9nb1s4EYQzxV1kAkTa3727cqCnOOe7ocLSymVg=;
        h=From:To:Subject:Date:From;
        b=Bf56xgAvmL+QWeNgo80a0UXrlRzHeyeHDNmXeUc44xtLpAIBESlCTFLgob9yR8x6F
         hvaOP2uYWw8eIz7QozWPrz2WDZdtVlbXmnX/o5tJ/7x7vyuqD7SpsY/CtjN/illg6P
         BPvLtqigFx+uzQtgoKvAmKc7cbQYd6L2FRTq8Qvg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1577466075;
        bh=8ASEO9nb1s4EYQzxV1kAkTa3727cqCnOOe7ocLSymVg=;
        h=From:To:Subject:Date:From;
        b=EE4Dtcpfgy7khxaSo8J06m4OOlR5f7Dfq3OD/ptrNjgndvs687adT/fwEfE1V4lGt
         MWDlBnnclaZUtJIsFkk9wz/Rua3HJyZY4czq3/9iwkOz7djtErb2zE3qGpWcbXLwbQ
         nHUnnfMUE1mzKvWBARAX5pBL3jxIXNiR8MMvy8aE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EB661E0408;
        Fri, 27 Dec 2019 12:01:13 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from konata.homenet (redmecca.plus.com [80.229.15.156])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 27 Dec 2019 12:01:14 -0500
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
        Dmytro Fil <monkdaf@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] staging: comedi: adv_pci1710: fix AI channels 16-31 for PCI-1713
Date:   Fri, 27 Dec 2019 17:00:54 +0000
Message-Id: <20191227170054.32051-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Advantech PCI-1713 has 32 analog input channels, but an incorrect
bit-mask in the definition of the `PCI171X_MUX_CHANH(x)` and
PCI171X_MUX_CHANL(x)` macros is causing channels 16 to 31 to be aliases
of channels 0 to 15.  Change the bit-mask value from 0xf to 0xff to fix
it.  Note that the channel numbers will have been range checked already,
so the bit-mask isn't really needed.

Fixes: 92c65e5553ed ("staging: comedi: adv_pci1710: define the mux control register bits")
Reported-by: Dmytro Fil <monkdaf@gmail.com>
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/adv_pci1710.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/adv_pci1710.c b/drivers/staging/comedi/drivers/adv_pci1710.c
index dbff0f7e7cf5..ddc0dc93d08b 100644
--- a/drivers/staging/comedi/drivers/adv_pci1710.c
+++ b/drivers/staging/comedi/drivers/adv_pci1710.c
@@ -46,8 +46,8 @@
 #define PCI171X_RANGE_UNI	BIT(4)
 #define PCI171X_RANGE_GAIN(x)	(((x) & 0x7) << 0)
 #define PCI171X_MUX_REG		0x04	/* W:   A/D multiplexor control */
-#define PCI171X_MUX_CHANH(x)	(((x) & 0xf) << 8)
-#define PCI171X_MUX_CHANL(x)	(((x) & 0xf) << 0)
+#define PCI171X_MUX_CHANH(x)	(((x) & 0xff) << 8)
+#define PCI171X_MUX_CHANL(x)	(((x) & 0xff) << 0)
 #define PCI171X_MUX_CHAN(x)	(PCI171X_MUX_CHANH(x) | PCI171X_MUX_CHANL(x))
 #define PCI171X_STATUS_REG	0x06	/* R:   status register */
 #define PCI171X_STATUS_IRQ	BIT(11)	/* 1=IRQ occurred */
-- 
2.24.1

