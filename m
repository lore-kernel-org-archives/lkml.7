Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D8CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783EE2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfC2Goh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:44:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbfC2Gog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:44:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2T6iBmC3662852
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 23:44:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2T6iADA3662849;
        Thu, 28 Mar 2019 23:44:10 -0700
Date:   Thu, 28 Mar 2019 23:44:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-c2999c281ea2d2ebbdfce96cecc7b52e2ae7c406@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, peterz@infradead.org, pjones@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tiwai@suse.de, tglx@linutronix.de, hpa@zytor.com,
        matt@codeblueprint.co.uk, mingo@kernel.org
Reply-To: mingo@kernel.org, matt@codeblueprint.co.uk, hpa@zytor.com,
          tiwai@suse.de, tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          pjones@redhat.com, ard.biesheuvel@linaro.org
In-Reply-To: <20190328193429.21373-3-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efifb: Omit memory map check on legacy boot
Git-Commit-ID: c2999c281ea2d2ebbdfce96cecc7b52e2ae7c406
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

Commit-ID:  c2999c281ea2d2ebbdfce96cecc7b52e2ae7c406
Gitweb:     https://git.kernel.org/tip/c2999c281ea2d2ebbdfce96cecc7b52e2ae7c406
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 28 Mar 2019 20:34:26 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Mar 2019 07:34:59 +0100

efifb: Omit memory map check on legacy boot

Since the following commit:

  38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")

efifb_probe() checks its memory range via efi_mem_desc_lookup(),
and this leads to a spurious error message:

   EFI_MEMMAP is not enabled

at every boot on KVM.  This is quite annoying since the error message
appears even if you set "quiet" boot option.

Since this happens on legacy boot, which strangely enough exposes
a EFI framebuffer via screen_info, let's double check that we are
doing an EFI boot before attempting to access the EFI memory map.

Reported-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190328193429.21373-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/video/fbdev/efifb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ba906876cc45..9e529cc2b4ff 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -464,7 +464,8 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base = efifb_fix.smem_start;
 	info->apertures->ranges[0].size = size_remap;
 
-	if (!efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
+	if (efi_enabled(EFI_BOOT) &&
+	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
 		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
 		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
 			pr_err("efifb: video memory @ 0x%lx spans multiple EFI memory regions\n",
