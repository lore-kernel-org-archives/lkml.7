Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75516C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4674D21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004447;
	bh=fW9Gz4rN4vuGWaB4xKKJYFcn8j7Hz++IV5tpiplwfIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=We2E+94Mulv/QtClN5fDrgOOtCvaR8pUznL+m1zNFnqcMMGQrAL+Gh4Ez99PkD+Qy
	 vQQnFXY0FFoGe2VENbP0Y3OVu4pHR6NwieQj2lkuz37zOUs5PeAY155YTj0LIraa5x
	 TMXxrwuW/EONjKcZtalYneJQzx9SEaO48OuKsNEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgABWeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbgABWeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:34:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3011E20863;
        Thu,  2 Jan 2020 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004440;
        bh=fW9Gz4rN4vuGWaB4xKKJYFcn8j7Hz++IV5tpiplwfIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNgvP6wwQjaNJ+4hf1vh+qrGgSLn2THms5pT8RDhNrj09GTwvX8m+n0H6anxfHw/7
         7EbajV4egoaFNz2nJd5XSww4ndDt7mrpwdOMkPUNp/F9COb01gQG+f9u0TDTELItjJ
         Gx5666Y+SJ89O1hcctf/0VAyDvJy1eg0StBA4Qt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 152/171] x86/mce: Fix possibly incorrect severity calculation on AMD
Date:   Thu,  2 Jan 2020 23:08:03 +0100
Message-Id: <20200102220607.986637001@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan H. Schönherr <jschoenh@amazon.de>

[ Upstream commit a3a57ddad061acc90bef39635caf2b2330ce8f21 ]

The function mce_severity_amd_smca() requires m->bank to be initialized
for correct operation. Fix the one case, where mce_severity() is called
without doing so.

Fixes: 6bda529ec42e ("x86/mce: Grade uncorrected errors for SMCA-enabled systems")
Fixes: d28af26faa0b ("x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_way_out()")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Link: https://lkml.kernel.org/r/20191210000733.17979-4-jschoenh@amazon.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index d3b2c5b25c9c..07188a012492 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -782,8 +782,8 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 		if (quirk_no_way_out)
 			quirk_no_way_out(i, m, regs);
 
+		m->bank = i;
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			m->bank = i;
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
-- 
2.20.1



