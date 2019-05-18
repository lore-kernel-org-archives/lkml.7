Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF019C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5AA20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558171052;
	bh=IlJp5YWs0ddocyfiiFNvvgvI0GtecDFbZBcvkD1dQxM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ke8IKtDzZ1znn42BMYiPRqcHC0LEVlqBXnvDI7xxGMN87htsvb3aSRuZnBsSkzngt
	 hdLa+9o4C6uT9TUFdWSlL5Jz5UfAfCvm9li5bv3v+BtCJfUBnqMpG//7wowcJqrNJK
	 rtanS4sFYuJDRnk5gPoDyZA+Lkrr71U+X2CHxntc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfERJRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:17:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39811 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:17:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so9443817wrl.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VXjGbB8IK4t+6naxMPHljUGMibb1mHdTkM1gGyq/XwE=;
        b=K1I+hEYtnrOtnl3ZUfK890+wqma0VqQjNPO2HLnL7NuhjRP+nT2QC4QJHeCDVLoPmc
         8oTnBX7Ex4+oxyVAFtj8r/fwTkUsfyV82osklMPHhipwFzhhUIzurBGs2BqF6p3+6lCl
         KRx/30ws0VMxvWOeN5rVV+VJ8zJhXtOAZzDcDJMAjouGeRM42Ld9NQYWEl3mkBeMLPXp
         WDGEsVSrLMI7fuM7KzOfdkpIScp/CjhZn4x7h+leRcShHJwuXKIuvTAShxCIttxP53Fx
         cMuJX+5HkJRC+rpUVUlCseVCK0aDmDsqMV+FI16a+RbIdLfge94MrYW2rGRiGrtd5Bxr
         Tt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=VXjGbB8IK4t+6naxMPHljUGMibb1mHdTkM1gGyq/XwE=;
        b=Psn3pi9hgWCab4IN0Zmyqn4DaipTXld03T8wenrcoaDQhSmZSWVlbQSjO4TSmkpdBH
         zvVuRWy+gwsrtB+uqv8QN6Qcr1EeIzSn5ZF+PXRGRf7x5AaqYNqhMcNK2fEtuQyPjvP7
         ELXPp4uOt8D9GXYGNO/7qJxjeZD0IrQ4S6pfO/S5lI8+wno5moiHVQSv6WZfhcJ5jiN5
         etoh6Un7n/IkBTTXAs70Ffz+AhJr3BSNxdfyhk1OhMQUzv7sdntSTPTnE8fGgi+9dGyq
         G/z16Y/kIw4dgT2LCavvOlRcOOEmwuvdBOWkCvnVkBHHfgeYi4YJS+guSAuwECFvyn8C
         GseA==
X-Gm-Message-State: APjAAAURegGpt6jSuXm61DJ7M8dby+cYumew34TqjxN6FHvyj3tFbH1i
        P7TK5j70a54ZPQ5xwm8+tFE=
X-Google-Smtp-Source: APXvYqzvRg2OpgDX9V48aEgbCGhwCxN3tRVu2LxZzGDzmzoYjUl1Fbt/w4ixzvKag0b8+Vj/JbVM0g==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr13843344wrt.217.1558171049279;
        Sat, 18 May 2019 02:17:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u2sm19551251wra.82.2019.05.18.02.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 02:17:28 -0700 (PDT)
Date:   Sat, 18 May 2019 11:17:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [GIT PULL] EFI fix
Message-ID: <20190518091726.GA47721@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: f8585539df0a1527c78b5d760665c89fe1c105a9 fbdev/efifb: Ignore framebuffer memmap entries that lack any memory types

Fix an EFI-fb regression that affects certain x86 systems.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      fbdev/efifb: Ignore framebuffer memmap entries that lack any memory types


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
