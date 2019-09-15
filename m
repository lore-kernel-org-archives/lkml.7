Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36B0C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74705214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 09:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hapJB8ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfIOJJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 05:09:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44105 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIOJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 05:09:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so5196649wru.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3quvaNUL5po7dhewh2pUgkOagoaEzjF4tpyOxM1okDg=;
        b=hapJB8ow+/cWDLvkriy2Se/Qh+BFbMKIiVZ6EamwbbkAKEZ/NCHGkLRz6Yjekp1D7J
         LqC8SZX5cCsRTAPbDF1XvaLiAc0QH04qWFBw+ZciB8VfTX9JFBR7ZdcoTCkbOlbLARXV
         5rkXASBLsQNuSGqrwlmr9dBJU9wBIV6Xv2DIc1/OUq8XUImuHllPtHdlgQ5AB0SdKvzx
         xIeX3dvGUzPi/0M3Y5lvdesKNJW164kEl3rKDfCzLi3FDITDDz2c5U/TWI7Of6+l1qby
         3M5zqLkRHNEvqJ61i/VBmJyviGEAs3hV/MI7E/8nmNNsqwDgLseFRBp63hp3bG6MMuNy
         I0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3quvaNUL5po7dhewh2pUgkOagoaEzjF4tpyOxM1okDg=;
        b=RA5CheCO2YRLCMbuzVhJNgTOmX5thM08Ba3ow7vuPveNqfua8d4HZr/dEj1+6aizj+
         PxupqmptUd1UjxRExBBlUwTmjkwwn4DurjHHPFXfAgrHODTIShYtYKesIG1TTI3qo4aH
         SWjwfueGGDCyHQ+cmGYE6Ux3o+vma8iCK0cJl6H+1WJZAHnPTwJFEAU8cHhmkXDU84qt
         13dQ1PiHXxGLDHiIuEAK6SilCJqEqc5GzyeCMC9ybq6xsOx0oc5jd1gdIiXUTkp7x5Uk
         BCPZzUvK9Lzc0l4ZYtuWKun2+ocMQ5Muv3gLN4BPlTy6q8oZ0LWW21WULRtzSDlBe7m+
         i+oQ==
X-Gm-Message-State: APjAAAXE5WfWNJGjnj1T+el39YzoV/zrJojYHA8YRIl/Yo9is/xQ+4g+
        euuXcWyPUETZIpKhoZOWEhA=
X-Google-Smtp-Source: APXvYqw3iox93MRVQ3Mh9Ms/Shj0VYeq9VeFJlUyJQImsXAiD2Kc5XjSn9niZo/j8mXPfglg8qYS5A==
X-Received: by 2002:adf:de08:: with SMTP id b8mr4194621wrm.200.1568538573340;
        Sun, 15 Sep 2019 02:09:33 -0700 (PDT)
Received: from lilas (reverse-117.fdn.fr. [80.67.176.117])
        by smtp.gmail.com with ESMTPSA id e20sm70862642wrc.34.2019.09.15.02.09.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 15 Sep 2019 02:09:32 -0700 (PDT)
Date:   Sun, 15 Sep 2019 11:09:25 +0200
From:   Sylvain 'ythier' Hitier <sylvain.hitier@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alex Shi <alex.shi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] x86: intel_tlb_table: small cleanups
Message-ID: <20190915090917.GA5086@lilas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unneeded backslash at EOL: that's not a macro.
And let's please checkpatch by aligning to open parenthesis.

For 0x4f descriptor, remove " */" from the info field.
For 0xc2 descriptor, sync the beginning of info to match the tlb_type.

(The value of info fields could be made more regular, but it's unused by
the code and will be read only by developers, so don't bother.)

Signed-off-by: Sylvain 'ythier' Hitier <sylvain.hitier@gmail.com>
---
 arch/x86/kernel/cpu/intel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8d6d92e..24e619d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -813,7 +813,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	{ 0x04, TLB_DATA_4M,		8,	" TLB_DATA 4 MByte pages, 4-way set associative" },
 	{ 0x05, TLB_DATA_4M,		32,	" TLB_DATA 4 MByte pages, 4-way set associative" },
 	{ 0x0b, TLB_INST_4M,		4,	" TLB_INST 4 MByte pages, 4-way set associative" },
-	{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages */" },
+	{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages" },
 	{ 0x50, TLB_INST_ALL,		64,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
 	{ 0x51, TLB_INST_ALL,		128,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
 	{ 0x52, TLB_INST_ALL,		256,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
@@ -841,7 +841,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	{ 0xba, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way associative" },
 	{ 0xc0, TLB_DATA_4K_4M,		8,	" TLB_DATA 4 KByte and 4 MByte pages, 4-way associative" },
 	{ 0xc1, STLB_4K_2M,		1024,	" STLB 4 KByte and 2 MByte pages, 8-way associative" },
-	{ 0xc2, TLB_DATA_2M_4M,		16,	" DTLB 2 MByte/4MByte pages, 4-way associative" },
+	{ 0xc2, TLB_DATA_2M_4M,		16,	" TLB_DATA 2 MByte/4MByte pages, 4-way associative" },
 	{ 0xca, STLB_4K,		512,	" STLB 4 KByte pages, 4-way associative" },
 	{ 0x00, 0, 0 }
 };
@@ -853,8 +853,8 @@ static void intel_tlb_lookup(const unsigned char desc)
 		return;
 
 	/* look up this descriptor in the table */
-	for (k = 0; intel_tlb_table[k].descriptor != desc && \
-			intel_tlb_table[k].descriptor != 0; k++)
+	for (k = 0; intel_tlb_table[k].descriptor != desc &&
+	     intel_tlb_table[k].descriptor != 0; k++)
 		;
 
 	if (intel_tlb_table[k].tlb_type == 0)
-- 
1.7.10.4

Regards,
Sylvain "ythier" HITIER

-- 
Business is about being busy, not being rich...
Lived 777 days in a Debian package => http://en.wikipedia.org/wiki/Apt,_Vaucluse
There's THE room for ideals in this mechanical place!
