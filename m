Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF8C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668C220818
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xoZ8BzIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfEQJNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:13:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfEQJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:13:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4H9D6R41276894
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 17 May 2019 02:13:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4H9D6R41276894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558084386;
        bh=xfh6alafibosZoel6b6WXS/RG/MjrXQFctY9qB0J/0I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xoZ8BzImn0nZWxpSAe/hZ9ZtCjD7AleN6oFVVV0+T9myc9gFxor9CK9KSRxF/fuZx
         +IlvXogikYOQ0exwABDckcy+zneoU2iICJ2P22rA4jCG0n8z6h+UM4ZnTB3sT3z6GA
         b4zl55qyASr+dEyElKyvB0aGVFdaUK4jXeyfLN3YQxuG7gAsOLuODqAfxqqEWDNFZI
         5VVCD5SHs41gBJmvHx+iqCsgNhGS8qECQQAt2Ne+mkvdpAVdmNOm1iVTBf1EfyaLm5
         njYnkZEm+/41IaaqiIln/8951yA5JADZZD8nwl5nH4ZQCUZgWPHXfU6lKKRmAq4mNG
         5EVAr976s/nYA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4H9D5pm1276891;
        Fri, 17 May 2019 02:13:05 -0700
Date:   Fri, 17 May 2019 02:13:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-f8585539df0a1527c78b5d760665c89fe1c105a9@git.kernel.org>
Cc:     pjones@redhat.com, bp@alien8.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        james.hilliard1@gmail.com, peterz@infradead.org,
        matt@codeblueprint.co.uk, ard.biesheuvel@linaro.org,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, bp@alien8.de, pjones@redhat.com, mingo@kernel.org,
          james.morse@arm.com, linux-kernel@vger.kernel.org,
          james.hilliard1@gmail.com, peterz@infradead.org,
          matt@codeblueprint.co.uk, tglx@linutronix.de,
          torvalds@linux-foundation.org, ard.biesheuvel@linaro.org
In-Reply-To: <20190516213159.3530-2-ard.biesheuvel@linaro.org>
References: <20190516213159.3530-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] fbdev/efifb: Ignore framebuffer memmap entries
 that lack any memory types
Git-Commit-ID: f8585539df0a1527c78b5d760665c89fe1c105a9
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

Commit-ID:  f8585539df0a1527c78b5d760665c89fe1c105a9
Gitweb:     https://git.kernel.org/tip/f8585539df0a1527c78b5d760665c89fe1c105a9
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 16 May 2019 23:31:59 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 17 May 2019 11:07:42 +0200

fbdev/efifb: Ignore framebuffer memmap entries that lack any memory types

The following commit:

  38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")

updated the EFI framebuffer code to use memory mappings for the linear
framebuffer that are permitted by the memory attributes described by the
EFI memory map for the particular region, if the framebuffer happens to
be covered by the EFI memory map (which is typically only the case for
framebuffers in shared memory). This is required since non-x86 systems
may require cacheable attributes for memory mappings that are shared
with other masters (such as GPUs), and this information cannot be
described by the Graphics Output Protocol (GOP) EFI protocol itself,
and so we rely on the EFI memory map for this.

As reported by James, this breaks some x86 systems:

  [ 1.173368] efifb: probing for efifb
  [ 1.173386] efifb: abort, cannot remap video memory 0x1d5000 @ 0xcf800000
  [ 1.173395] Trying to free nonexistent resource <00000000cf800000-00000000cf9d4bff>
  [ 1.173413] efi-framebuffer: probe of efi-framebuffer.0 failed with error -5

The problem turns out to be that the memory map entry that describes the
framebuffer has no memory attributes listed at all, and so we end up with
a mem_flags value of 0x0.

So work around this by ensuring that the memory map entry's attribute field
has a sane value before using it to mask the set of usable attributes.

Reported-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # v4.19+
Cc: Borislav Petkov <bp@alien8.de>
Cc: James Morse <james.morse@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when ...")
Link: http://lkml.kernel.org/r/20190516213159.3530-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/video/fbdev/efifb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 9e529cc2b4ff..9f39f0c360e0 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -477,8 +477,12 @@ static int efifb_probe(struct platform_device *dev)
 		 * If the UEFI memory map covers the efifb region, we may only
 		 * remap it using the attributes the memory map prescribes.
 		 */
-		mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
-		mem_flags &= md.attribute;
+		md.attribute &= EFI_MEMORY_UC | EFI_MEMORY_WC |
+				EFI_MEMORY_WT | EFI_MEMORY_WB;
+		if (md.attribute) {
+			mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
+			mem_flags &= md.attribute;
+		}
 	}
 	if (mem_flags & EFI_MEMORY_WC)
 		info->screen_base = ioremap_wc(efifb_fix.smem_start,
