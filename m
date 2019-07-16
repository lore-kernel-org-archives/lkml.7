Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B43C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66922145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="a2lu/HLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfGPVWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:22:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfGPVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:22:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLM5NR1230100
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:22:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLM5NR1230100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563312125;
        bh=FkTg5NkZ7+UyBNo1lwbD1FJFi/V4LU7OKvYpJ8Xzp9w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=a2lu/HLVSsUR3vJNcnjWiKpv1XI5W/Gsvb5z/IwNEOLt/Gg+E2fDllhHCdhQZbC25
         amdVDmYkExi6FRbdVEL39z3uyhclLnl+v0lQJNeKWIC/ysooQMNGhRbLFis8t50QJY
         vsbmr0mqqCPY1b6uLbtPAYNLeGM3UbCtYjsJkZOIEW/ZkRqElj/87Omd4UfBgAyC0j
         ni+DejIE4HTwV29wtLxw792qcjWHywUjTpI9RSDpLBEIfDDHZyQTkep3MGgKKsSX4g
         TAJOmoqI0/V6WgzGsXtKGcucU51U3IwyHLPiL1ji+41lvmYPR2WQc1j/N214bOjDPg
         bITr7qiq075Rw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLM5Rk1230097;
        Tue, 16 Jul 2019 14:22:05 -0700
Date:   Tue, 16 Jul 2019 14:22:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michel Thierry <tipbot@zytor.com>
Message-ID: <tip-080ac61bad4a3307880bb982cec48b225912b362@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, rodrigo.vivi@intel.com, michel.thierry@intel.com,
        lucas.demarchi@intel.com
Reply-To: rodrigo.vivi@intel.com, michel.thierry@intel.com,
          lucas.demarchi@intel.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190712210238.5622-1-lucas.demarchi@intel.com>
References: <20190712210238.5622-1-lucas.demarchi@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/gpu: Add TGL stolen memory support
Git-Commit-ID: 080ac61bad4a3307880bb982cec48b225912b362
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

Commit-ID:  080ac61bad4a3307880bb982cec48b225912b362
Gitweb:     https://git.kernel.org/tip/080ac61bad4a3307880bb982cec48b225912b362
Author:     Michel Thierry <michel.thierry@intel.com>
AuthorDate: Fri, 12 Jul 2019 14:02:39 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:49 +0200

x86/gpu: Add TGL stolen memory support

Reuse Gen11 stolen memory functionality since Tiger Lake uses the same BSM
register (and format).

Signed-off-by: Michel Thierry <michel.thierry@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://lkml.kernel.org/r/20190712210238.5622-1-lucas.demarchi@intel.com

---
 arch/x86/kernel/early-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 6c4f01540833..6f6b1d04dadf 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_CNL_IDS(&gen9_early_ops),
 	INTEL_ICL_11_IDS(&gen11_early_ops),
 	INTEL_EHL_IDS(&gen11_early_ops),
+	INTEL_TGL_12_IDS(&gen11_early_ops),
 };
 
 struct resource intel_graphics_stolen_res __ro_after_init = DEFINE_RES_MEM(0, 0);
