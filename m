Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898992082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfC2GpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:45:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbfC2GpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:45:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2T6iuK93662911
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 23:44:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2T6it7J3662908;
        Thu, 28 Mar 2019 23:44:55 -0700
Date:   Thu, 28 Mar 2019 23:44:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marcin Benka <tipbot@zytor.com>
Message-ID: <tip-5e83cfe947444c7f201f8c39ce0189922ec9f578@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mbenka@marvell.com,
        ard.biesheuvel@linaro.org, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, rrichter@marvell.com, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mbenka@marvell.com, torvalds@linux-foundation.org,
          ard.biesheuvel@linaro.org, hpa@zytor.com, peterz@infradead.org,
          mingo@kernel.org, rrichter@marvell.com, matt@codeblueprint.co.uk,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190328193429.21373-4-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-4-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/arm: Show SMBIOS bank/device location in CPER
 and GHES error logs
Git-Commit-ID: 5e83cfe947444c7f201f8c39ce0189922ec9f578
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5e83cfe947444c7f201f8c39ce0189922ec9f578
Gitweb:     https://git.kernel.org/tip/5e83cfe947444c7f201f8c39ce0189922ec9f578
Author:     Marcin Benka <mbenka@marvell.com>
AuthorDate: Thu, 28 Mar 2019 20:34:27 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Mar 2019 07:35:00 +0100

efi/arm: Show SMBIOS bank/device location in CPER and GHES error logs

Run dmi_memdev_walk() for arch arm* as other architectures do.
This improves error logging as the memory device handle is
translated now to the DIMM entry's name provided by the DMI handle.

Before:

 {1}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0038

After:

 {1}[Hardware Error]:   DIMM location: N0 DIMM_A0

Signed-off-by: Marcin Benka <mbenka@marvell.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190328193429.21373-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/arm-runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 0c1af675c338..4a0dfe4ab829 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
 	 * itself, depends on dmi_scan_machine() having been called already.
 	 */
 	dmi_scan_machine();
+	dmi_memdev_walk();
 	if (dmi_available)
 		dmi_set_dump_stack_arch_desc();
 	return 0;
