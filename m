Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8DC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB321670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VyjcERP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfHXIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 04:53:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44394 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfHXIxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 04:53:41 -0400
Received: from zn.tnic (p200300EC2F1E9400E161D1CD3EE01E5E.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:9400:e161:d1cd:3ee0:1e5e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 750541EC0BFD;
        Sat, 24 Aug 2019 10:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566636820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ax9XVr2446DKYzhDbuEl4JPufvVY1L74U+7t5fsNCv4=;
        b=VyjcERP8D32OT3h5O7R/D74ex8GkZWAnAj89xq2OLQ3qBZvY6XGX7/Z6zpcmI1oYn6BMh8
        Qv6FRGj3V8MuahhRNdSgznS9j37wa8ES+w6hhSDMk4JquQXnxhFYXJlF1zusGvr+Pnngdv
        JTNEU6W4ovwHUvny33mOIq71n9xeR+E=
Date:   Sat, 24 Aug 2019 10:53:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: [PATCH 2/2] x86/microcode/intel: Issue the revision updated message
 only on the BSP
Message-ID: <20190824085341.GC16813@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190824085156.GA16813@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Borislav Petkov <bp@suse.de>
Date: Sat, 24 Aug 2019 10:01:53 +0200

... in order to not pollute dmesg with a line for each updated microcode
engine.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jon Grimm <Jon.Grimm@amd.com>
Cc: kanth.ghatraju@oracle.com
Cc: konrad.wilk@oracle.com
Cc: Mihai Carabas <mihai.carabas@oracle.com>
Cc: patrick.colp@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
---
 arch/x86/kernel/cpu/microcode/intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index ce799cfe9434..6a99535d7f37 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -791,6 +791,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	struct microcode_intel *mc;
 	enum ucode_state ret;
 	static int prev_rev;
@@ -836,7 +837,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 	}
 
-	if (rev != prev_rev) {
+	if (bsp && rev != prev_rev) {
 		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
 			rev,
 			mc->hdr.date & 0xffff,
@@ -852,7 +853,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	c->microcode	 = rev;
 
 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
-	if (c->cpu_index == boot_cpu_data.cpu_index)
+	if (bsp)
 		boot_cpu_data.microcode = rev;
 
 	return ret;
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
