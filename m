Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8920828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567670845;
	bh=4LP2F3XGWFD5ORqeVKhmJmgTk7tbsRiH8E5uqqtsu5I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XCvQT+OkHCpXNxKsJyszqUxnRbIJNSIyP9b/5qy8Hgqflghuv1CiGQ5t1r9coBDav
	 yjVW3tJs8d7+RUt43dFTtFUVqR5k8O30a4SWKE6ePCtuuBqiQaXfSR2VIpzy1Ld1mR
	 dgvHb3omPV8NPqaSkzSe1FhcG2z0zVQiRorRwQzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbfIEIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:07:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42863 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfIEIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:07:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id q14so1539127wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TpA22UO2S01IWosberZH55USiMT+Pyytq5Gu1obQWXY=;
        b=k4BLaSOOvhn2hd9ue9YPbY+kGds8sveQJp0lzS3QadW2mWFAYpw4iEoBCRC4tQ2gJx
         KSIT/9HsLvhRgioRosqgOzNCyYTR7RP3Sop76da9WkA0S421GrHoy26r4WWmhCouNqwx
         oG8f9U/ggZYrOzE8LuKQ6XCWT7F66WhSFNeoIco3PhwYH1wBW/aFhBRbrhn+vXd9tUA9
         B4lApOBlsJnGUxtyNOgPmKo0hw3BbShfoJDTmPnHP/vT1l1UD1netoX8KMDA6SAf63HK
         6Uh/Ehd681ZCF6k9yZ82M3ehxMeqBBer8y4iKasU1bRPJ24U72VBh4jllAAGKsh8K3hm
         3Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=TpA22UO2S01IWosberZH55USiMT+Pyytq5Gu1obQWXY=;
        b=NIYSp3k14C30JkAtcvmslMxv4M36eyJrAaTO4utkCbOIL4qxBB+igtRXz/jG3yCRA+
         I/RD0rBMRnEMHWLjCAEDuZqVlubgV3IVp0g5cHRR3hC/VqZV6xNmQXXN4Zjze6Wh2lf6
         I5+zXfgeA3ka9k03iDP1hg7Aa8dM+ahFRTq90dYGiAFNeXshfY0V6PDGFoN3B2Sw7CzD
         v4OF1Wo/2TiiYbW3hYrcomjmoLeC/jT1efwMcwJoftjWlxx2gjTp3vzdj0dNPlTMdAv2
         yx3Aa2C5Ekc+7sYfeHxQM1O6xqjEvQqZjp0S9+5siEAjCUszpSnDL8H1dobrkM37aYls
         F/VQ==
X-Gm-Message-State: APjAAAXHfasetAstgfNqp2LmnLJQL/2B02/mJbBJ26hftwzVnLETn/JB
        P33jmNMCz3TLadizPSmy1hHXMJCd
X-Google-Smtp-Source: APXvYqwRJMRlOH5Mple1Avcc2LC47mouvX6u1SyFLnre7XzCSouDVufSl6zs4e10Z7/HwisNe10+HQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr1456956wru.306.1567670842088;
        Thu, 05 Sep 2019 01:07:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t13sm2693809wra.70.2019.09.05.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:07:21 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:07:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190905080719.GA46542@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 4030b4c585c41eeefec7bd20ce3d0e100a0f2e4d x86/hyper-v: Fix overflow bug in fill_gva_list()

Misc fixes:

 - a signed kernels EFI boot fix,
 - an UBSAN related AC flags fix,
 - and a Hyper-V infinite loop fix.

 Thanks,

	Ingo

------------------>
John S. Gruber (1):
      x86/boot: Preserve boot_params.secure_boot from sanitizing

Peter Zijlstra (1):
      x86/uaccess: Don't leak the AC flags into __get_user() argument evaluation

Tianyu Lan (1):
      x86/hyper-v: Fix overflow bug in fill_gva_list()


 arch/x86/hyperv/mmu.c                  | 8 +++++---
 arch/x86/include/asm/bootparam_utils.h | 1 +
 arch/x86/include/asm/uaccess.h         | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index e65d7fe6489f..5208ba49c89a 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -37,12 +37,14 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 		 * Lower 12 bits encode the number of additional
 		 * pages to flush (in addition to the 'cur' page).
 		 */
-		if (diff >= HV_TLB_FLUSH_UNIT)
+		if (diff >= HV_TLB_FLUSH_UNIT) {
 			gva_list[gva_n] |= ~PAGE_MASK;
-		else if (diff)
+			cur += HV_TLB_FLUSH_UNIT;
+		}  else if (diff) {
 			gva_list[gva_n] |= (diff - 1) >> PAGE_SHIFT;
+			cur = end;
+		}
 
-		cur += HV_TLB_FLUSH_UNIT;
 		gva_n++;
 
 	} while (cur < end);
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 9e5f3c722c33..981fe923a59f 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -70,6 +70,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 			BOOT_PARAM_PRESERVE(eddbuf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(secure_boot),
 			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 9c4435307ff8..35c225ede0e4 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -444,8 +444,10 @@ __pu_label:							\
 ({									\
 	int __gu_err;							\
 	__inttype(*(ptr)) __gu_val;					\
+	__typeof__(ptr) __gu_ptr = (ptr);				\
+	__typeof__(size) __gu_size = (size);				\
 	__uaccess_begin_nospec();					\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
+	__get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err, -EFAULT);	\
 	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__builtin_expect(__gu_err, 0);					\
