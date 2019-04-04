Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AE1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DBE21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368004;
	bh=9KyJfwxBReI9kvGppxzxbD7dfxmHyjeyC63BNJJpqGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e7SyKw/UA+XUR5iRzUcO5JSMPXb6fj3mQMmweIK80nIkgWE3x15rwpkXw4ErPns/a
	 LBQOe8oTBf5XMDwNrnVGrKispR2ouM64BYO2p0eINnKLTpWa7mzaqKMubrRL7sdoj6
	 RIf+FTusipqEBDWNAxhoyOH8e38A6BeHZC/eI9gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfDDIxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbfDDIxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E8E2171F;
        Thu,  4 Apr 2019 08:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368000;
        bh=9KyJfwxBReI9kvGppxzxbD7dfxmHyjeyC63BNJJpqGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4gSnnynmeyX4fA1vA16TjSseD76eZEY/VmUGjM9OjLqZ1CWRkflXPnRtNaS0UpBF
         iRamwJQBDZVdd98z2GrqYv6i0tBe2I/ZPfZOxjSLlKd1LkyuP8ELazOlSxp+oKG18a
         vATcy73BLtR6RTRC7EgTfeEAzMmupkkShho2FkGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 67/91] efi/memattr: Dont bail on zero VA if it equals the regions PA
Date:   Thu,  4 Apr 2019 10:47:51 +0200
Message-Id: <20190404084539.330838278@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5de0fef0230f3c8d75cff450a71740a7bf2db866 ]

The EFI memory attributes code cross-references the EFI memory map with
the more granular EFI memory attributes table to ensure that they are in
sync before applying the strict permissions to the regions it describes.

Since we always install virtual mappings for the EFI runtime regions to
which these strict permissions apply, we currently perform a sanity check
on the EFI memory descriptor, and ensure that the EFI_MEMORY_RUNTIME bit
is set, and that the virtual address has been assigned.

However, in cases where a runtime region exists at physical address 0x0,
and the virtual mapping equals the physical mapping, e.g., when running
in mixed mode on x86, we encounter a memory descriptor with the runtime
attribute and virtual address 0x0, and incorrectly draw the conclusion
that a runtime region exists for which no virtual mapping was installed,
and give up altogether. The consequence of this is that firmware mappings
retain their read-write-execute permissions, making the system more
vulnerable to attacks.

So let's only bail if the virtual address of 0x0 has been assigned to a
physical region that does not reside at address 0x0.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 10f0d2f577053 ("efi: Implement generic support for the Memory ...")
Link: http://lkml.kernel.org/r/20190202094119.13230-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/memattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 236004b9a50d..9faa09e7c31f 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -93,7 +93,7 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (md->virt_addr == 0) {
+		if (md->virt_addr == 0 && md->phys_addr != 0) {
 			/* no virtual mapping has been installed by the stub */
 			break;
 		}
-- 
2.19.1



