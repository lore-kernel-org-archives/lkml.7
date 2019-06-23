Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5881C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E56820679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFWN2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33514 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfFWN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X6-0001lJ-Cq; Sun, 23 Jun 2019 15:27:48 +0200
Message-Id: <20190623132435.911652981@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 20/29] x86/hpet: Add mode information to struct hpet_channel
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of the individual HPET channels is not tracked in a central
place. The information is scattered in different data structures. Also the
HPET reservation in the HPET character device is split out into several
places which makes the code hard to follow.

Assigning a mode to the channel allows to consolidate the reservation code
and paves the way for further simplifications.

As a first step set the mode of the legacy channels when the HPET is in
legacy mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -22,9 +22,17 @@ struct hpet_dev {
 	char				name[10];
 };
 
+enum hpet_mode {
+	HPET_MODE_UNUSED,
+	HPET_MODE_LEGACY,
+	HPET_MODE_CLOCKEVT,
+	HPET_MODE_DEVICE,
+};
+
 struct hpet_channel {
 	unsigned int			num;
 	unsigned int			irq;
+	enum hpet_mode			mode;
 	unsigned int			boot_cfg;
 };
 
@@ -947,6 +955,9 @@ int __init hpet_enable(void)
 
 	if (id & HPET_ID_LEGSUP) {
 		hpet_legacy_clockevent_register();
+		hpet_base.channels[0].mode = HPET_MODE_LEGACY;
+		if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC))
+			hpet_base.channels[1].mode = HPET_MODE_LEGACY;
 		return 1;
 	}
 	return 0;


