Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8CAC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F50D2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfK3Sq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:46:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:38912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfK3Sq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:46:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 475C6ADCF;
        Sat, 30 Nov 2019 18:46:25 +0000 (UTC)
Date:   Sat, 30 Nov 2019 19:46:12 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS urgent for 5.5
Message-ID: <20191130184612.GA17459@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

one urgent fix for the thermal throttling machinery: the recent change
reworking the thermal notifications forgot to mask out read-only and
reserved bits in the thermal status MSRs, leading to exceptions while
writing those MSRs. The fix below takes care of masking out those bits
first.

Please pull,
thanks.

---
The following changes since commit c2da5bdc66a377f0b82ee959f19f5a6774706b83:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-11-26 17:12:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

for you to fetch changes up to 5a43b87b3c62ad149ba6e9d0d3e5c0e5da02a5ca:

  x86/mce/therm_throt: Mask out read-only and reserved MSR bits (2019-11-29 09:17:52 +0100)

----------------------------------------------------------------
Srinivas Pandruvada (1):
      x86/mce/therm_throt: Mask out read-only and reserved MSR bits

 arch/x86/kernel/cpu/mce/therm_throt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index d01e0da0163a..b38010b541d6 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -195,17 +195,24 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_THROT_POLL_INTERVAL	HZ
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
+#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
+#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+
 static void clear_therm_status_log(int level)
 {
 	int msr;
-	u64 msr_val;
+	u64 mask, msr_val;
 
-	if (level == CORE_LEVEL)
-		msr = MSR_IA32_THERM_STATUS;
-	else
-		msr = MSR_IA32_PACKAGE_THERM_STATUS;
+	if (level == CORE_LEVEL) {
+		msr  = MSR_IA32_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_CORE_MASK;
+	} else {
+		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_PKG_MASK;
+	}
 
 	rdmsrl(msr, msr_val);
+	msr_val &= mask;
 	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
 }
 
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
