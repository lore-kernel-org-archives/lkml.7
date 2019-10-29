Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D1F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfJ2OUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:20:01 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36309 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388595AbfJ2OUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:20:01 -0400
Received: from [10.17.212.211] (unknown [195.37.61.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 04F0920225ADB;
        Tue, 29 Oct 2019 15:19:57 +0100 (CET)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] smpboot: reuse timer calibration
Message-ID: <ebb16cf3-128d-2515-a98a-a58db0c1f963@molgen.mpg.de>
Date:   Tue, 29 Oct 2019 15:19:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Date: Wed, 11 Feb 2015 17:28:14 -0600

NO point recalibrating for known-constant tsc ...
saves 200ms+ of boot time.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Arjan, can your Signed-off-by line be added? On what device, did you 
test this?

This upstreams the patch from Clear Linux.

https://github.com/clearlinux-pkgs/linux/blob/master/0108-smpboot-reuse-timer-calibration.patch

  arch/x86/kernel/tsc.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c59454c382fd..42b07ed467d2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1525,6 +1525,9 @@ unsigned long calibrate_delay_is_known(void)
  	if (!constant_tsc || !mask)
  		return 0;

+	if (cpu != 0)
+		return cpu_data(0).loops_per_jiffy;
+
  	sibling = cpumask_any_but(mask, cpu);
  	if (sibling < nr_cpu_ids)
  		return cpu_data(sibling).loops_per_jiffy;
-- 
2.24.0.rc1
