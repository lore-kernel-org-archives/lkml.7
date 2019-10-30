Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E432087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfJ3Pm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:42:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfJ3PmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:42:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC85F68D;
        Wed, 30 Oct 2019 08:42:23 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40743F6C4;
        Wed, 30 Oct 2019 08:42:22 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Richard Fontana <rfontana@redhat.com>,
        Armijn Hemel <armijn@tjaldur.nl>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] parisc: Replace cpu_up/down with device_online/offline
Date:   Wed, 30 Oct 2019 15:38:31 +0000
Message-Id: <20191030153837.18107-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030153837.18107-1-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
CC: Helge Deller <deller@gmx.de>
CC: Richard Fontana <rfontana@redhat.com>
CC: Armijn Hemel <armijn@tjaldur.nl>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-parisc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---

Couldn't compile test this one.

I'm not confident that this is a correct patch to be honest. This __init
indicates we're booting the secondary cpus and that might be too early in the
process to use the core API..?


 arch/parisc/kernel/processor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 13f771f74ee3..4dde5fe78f0c 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -212,7 +212,9 @@ static int __init processor_probe(struct parisc_device *dev)
 #ifdef CONFIG_SMP
 	if (cpuid) {
 		set_cpu_present(cpuid, true);
-		cpu_up(cpuid);
+		lock_device_hotplug();
+		device_online(get_cpu_device(cpuid));
+		unlock_device_hotplug();
 	}
 #endif
 
-- 
2.17.1

