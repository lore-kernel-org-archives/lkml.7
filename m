Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6804F2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714355;
	bh=KIaSZbyVU7oeCQc+8FkgNKioQ7h8nz580PI1iesjiK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwHEyeDtcboXmmQjgxsu3Iyi0rqpkaIdiRdoC2MpKwKoPzG0+GVtCNyhborIcapJk
	 libFP0xT3o3iiYF3D9u1mUkMGUptQHCHqiQ2CzlfU3jZ/8XKT3+rZ0+QH/VJBCPzRG
	 Vurn4p+9c8FQfLJvnt8SirdftAWEGUFsp9FYtLCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfC0TTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbfC0SH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B0E217D9;
        Wed, 27 Mar 2019 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710075;
        bh=KIaSZbyVU7oeCQc+8FkgNKioQ7h8nz580PI1iesjiK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qM2DKh30iWRyNUD3B/5NmKmQPZQDS547n+4iJGzSsCyDfyxlulKwGrRhc9NCq/3Qu
         qn8L/Dn45LPS6fP5fqzZwyuto79jL8EOuL8T5rnjb48ywSGWUF0CIMfwqIR+gMNF6D
         LpK9PnDRozBDrBURVYRl6p/rjdWW7SHgUpxx+ywg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH AUTOSEL 5.0 186/262] efi/memattr: Don't bail on zero VA if it equals the region's PA
Date:   Wed, 27 Mar 2019 14:00:41 -0400
Message-Id: <20190327180158.10245-186-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

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
index 8986757eafaf..aac972b056d9 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -94,7 +94,7 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (md->virt_addr == 0) {
+		if (md->virt_addr == 0 && md->phys_addr != 0) {
 			/* no virtual mapping has been installed by the stub */
 			break;
 		}
-- 
2.19.1

