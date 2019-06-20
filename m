Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFDC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655F72147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L4+UrVzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfFTKAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:00:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFTKAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:00:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5K9xgAF906831
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 02:59:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5K9xgAF906831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024783;
        bh=kFQhygwJI2YkpLXnj1Aw7bCa1lb+mr1aCmZ9wGLIuC8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=L4+UrVzHPj8D3FP8WxA7IC8PSDqrjeDGBq8GATUQHyl2hhNO5j389UYGKq2V0CuVA
         20AjPaOLK/Yk+7wJmO80rwXHVMs8mirbYzt1AnKzJFfnsMHjB221XoelvHj3cdnKrG
         5Cm6eTC220Fz9yA8qDtesZyyhJu0qv7rAeLyI/tjQbJJauuemiIzHLWtwIy7vyWCMi
         hgK0jZVqouQGNaXRZ1gb3oEPSRGPfWMhY6kY77WnYtyK8nUV7SY3k68YNKDrzOz5lL
         bSAcM5jKOZnbIpDgehHgA0ij/rGhW4csJMOH8mjzAdQPOvCb1rid7viraCJpRK1j/s
         4q66rznsNta6Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5K9xfxx906820;
        Thu, 20 Jun 2019 02:59:41 -0700
Date:   Thu, 20 Jun 2019 02:59:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-ae9e13d621d6795ec1ad6bf10bd2549c6c3feca4@git.kernel.org>
Cc:     bp@suse.de, rppt@linux.ibm.com, mingo@kernel.org,
        huang.zijiang@zte.com.cn, n-horiguchi@ah.jp.nec.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com, jgross@suse.com, mhocko@suse.com,
        peterz@infradead.org, joe@perches.com, luto@amacapital.net,
        thomas.lendacky@amd.com, tglx@linutronix.de, lijiang@redhat.com,
        hpa@zytor.com, mingo@redhat.com, akpm@linux-foundation.org
Reply-To: luto@amacapital.net, tglx@linutronix.de, thomas.lendacky@amd.com,
          lijiang@redhat.com, hpa@zytor.com, akpm@linux-foundation.org,
          mingo@redhat.com, bp@suse.de, mingo@kernel.org,
          rppt@linux.ibm.com, huang.zijiang@zte.com.cn, x86@kernel.org,
          n-horiguchi@ah.jp.nec.com, jgross@suse.com,
          m.mizuma@jp.fujitsu.com, linux-kernel@vger.kernel.org,
          joe@perches.com, mhocko@suse.com, peterz@infradead.org
In-Reply-To: <20190423013007.17838-2-lijiang@redhat.com>
References: <20190423013007.17838-2-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/e820, ioport: Add a new I/O resource descriptor
 IORES_DESC_RESERVED
Git-Commit-ID: ae9e13d621d6795ec1ad6bf10bd2549c6c3feca4
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

Commit-ID:  ae9e13d621d6795ec1ad6bf10bd2549c6c3feca4
Gitweb:     https://git.kernel.org/tip/ae9e13d621d6795ec1ad6bf10bd2549c6c3feca4
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Tue, 23 Apr 2019 09:30:05 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 09:54:31 +0200

x86/e820, ioport: Add a new I/O resource descriptor IORES_DESC_RESERVED

When executing the kexec_file_load() syscall, the first kernel needs to
pass the e820 reserved ranges to the second kernel because some devices
(PCI, for example) need them present in the kdump kernel for proper
initialization.

But the kernel can not exactly match the e820 reserved ranges when
walking through the iomem resources using the default IORES_DESC_NONE
descriptor, because there are several types of e820 ranges which are
marked IORES_DESC_NONE, see e820_type_to_iores_desc().

Therefore, add a new I/O resource descriptor called IORES_DESC_RESERVED
to mark exactly those ranges. It will be used to match the reserved
resource ranges when walking through iomem resources.

 [ bp: Massage commit message. ]

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: bhe@redhat.com
Cc: dave.hansen@linux.intel.com
Cc: dyoung@redhat.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Huang Zijiang <huang.zijiang@zte.com.cn>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kexec@lists.infradead.org
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190423013007.17838-2-lijiang@redhat.com
---
 arch/x86/kernel/e820.c | 2 +-
 include/linux/ioport.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 8f32e705a980..e69408bf664b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1063,10 +1063,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
-	case E820_TYPE_RESERVED:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
 	}
 }
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..6ed59de48bd5 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -133,6 +133,7 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
+	IORES_DESC_RESERVED			= 8,
 };
 
 /* helpers to define resources */
