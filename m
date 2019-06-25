Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDEFC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB12085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VSaRR2XF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfFYHbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:31:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfFYHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:31:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7V4LS3509722
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:31:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7V4LS3509722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561447864;
        bh=qsRzFhXGzqGyiZcGkpMIJ06dTufLonxZWOOU0344IVE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VSaRR2XFcCAowqHupC583ICXjmmSO6B6imnyFnFWIUxjwLeNSz9Ct3//v9LaT5CWg
         UaMjiL56S+OLpZwx0gCTmA2wK+VHOdnKDWAwEdrV82tiH22nyHcr12mteAkP007TiS
         1z5dOQbeNb21182nOjHUAZ1tuLBywYj3K0GWINguRFkOfvESYysEI5k/S6bX3fwTzm
         cKVyr1sX0ds55cADl/Ipy/946w1Lh5L2b9nV6PqBBfXEtl0/nOTCxprq9opVATWfRY
         BFxmZAQu9oP5CZYp+cocsownVbq4+qg6bczNXgmlaa2XTbWrDA8nganFqSirsjExGN
         LAJjjWtkxj47w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7V3mf3509719;
        Tue, 25 Jun 2019 00:31:03 -0700
Date:   Tue, 25 Jun 2019 00:31:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-2ef085bd110c5723ca08a522608ac3468dc304bd@git.kernel.org>
Cc:     hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        reinette.chatre@intel.com
Reply-To: reinette.chatre@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <15ba03856f1d944468ee6f44e3fd7aa548293ede.1561408280.git.reinette.chatre@intel.com>
References: <15ba03856f1d944468ee6f44e3fd7aa548293ede.1561408280.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Cleanup cbm_ensure_valid()
Git-Commit-ID: 2ef085bd110c5723ca08a522608ac3468dc304bd
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

Commit-ID:  2ef085bd110c5723ca08a522608ac3468dc304bd
Gitweb:     https://git.kernel.org/tip/2ef085bd110c5723ca08a522608ac3468dc304bd
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Mon, 24 Jun 2019 13:34:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:26:11 +0200

x86/resctrl: Cleanup cbm_ensure_valid()

A recent fix to the cbm_ensure_valid() function left some coding style
issues that are now addressed:

- Return a value instead of using a function parameter as input and
  output
- Use if (!val) instead of if (val == 0)
- Follow reverse fir tree ordering of variable declarations

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/15ba03856f1d944468ee6f44e3fd7aa548293ede.1561408280.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2f4824793798..bf3034994754 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2488,21 +2488,21 @@ out_destroy:
  * modification to the CBM if the default does not satisfy the
  * requirements.
  */
-static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
+static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 {
-	unsigned long val = *_val;
 	unsigned int cbm_len = r->cache.cbm_len;
 	unsigned long first_bit, zero_bit;
+	unsigned long val = _val;
 
-	if (val == 0)
-		return;
+	if (!val)
+		return 0;
 
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
 	/* Clear any remaining bits to ensure contiguous region */
 	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
-	*_val = (u32)val;
+	return (u32)val;
 }
 
 /*
@@ -2560,7 +2560,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	 * Force the initial CBM to be valid, user can
 	 * modify the CBM based on system availability.
 	 */
-	cbm_ensure_valid(&d->new_ctrl, r);
+	d->new_ctrl = cbm_ensure_valid(d->new_ctrl, r);
 	/*
 	 * Assign the u32 CBM to an unsigned long to ensure that
 	 * bitmap_weight() does not access out-of-bound memory.
