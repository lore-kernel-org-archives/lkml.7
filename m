Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE082C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B172D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCUGiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:38:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11591 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbfCUGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:38:17 -0400
X-IronPort-AV: E=Sophos;i="5.60,251,1549900800"; 
   d="scan'208";a="57284357"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Mar 2019 14:38:15 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1B8904CD5A09;
        Thu, 21 Mar 2019 14:37:45 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 21 Mar 2019 14:38:24 +0800
Date:   Thu, 21 Mar 2019 14:37:40 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel
 reserved region
Message-ID: <20190321063740.GG1590@localhost.localdomain>
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 1B8904CD5A09.AAEE8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:19:31PM +0800, Pingfan Liu wrote:

I tested it in Qemu test with 12G memory, and set crashkernel=6G@6G.
Without this PATCH, it successed to reserve memory just 4 times(total
10 times).
With this PATCH, it successed to reserve memory 15 times(total 15
times).

So I think if you post new version, you can add:

Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>

Thanks,
Chao Fan

>crashkernel=x@y option may fail to reserve the required memory region if
>KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
>skip the required region.
>
>Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Will Deacon <will.deacon@arm.com>
>Cc: Nicolas Pitre <nico@linaro.org>
>Cc: Pingfan Liu <kernelfans@gmail.com>
>Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
>Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: linux-kernel@vger.kernel.org
>---
>v1 -> v2: fix some trival format
>
> arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++++++++++++--
> 1 file changed, 24 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>index 9ed9709..e185318 100644
>--- a/arch/x86/boot/compressed/kaslr.c
>+++ b/arch/x86/boot/compressed/kaslr.c
>@@ -109,6 +109,7 @@ enum mem_avoid_index {
> 	MEM_AVOID_BOOTPARAMS,
> 	MEM_AVOID_MEMMAP_BEGIN,
> 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
>+	MEM_AVOID_CRASHKERNEL,
> 	MEM_AVOID_MAX,
> };
> 
>@@ -240,6 +241,25 @@ static void parse_gb_huge_pages(char *param, char *val)
> 	}
> }
> 
>+/* parse crashkernel=x@y option */
>+static void mem_avoid_crashkernel_simple(char *option)
>+{
>+	unsigned long long crash_size, crash_base;
>+	char *cur = option;
>+
>+	crash_size = memparse(option, &cur);
>+	if (option == cur)
>+		return;
>+
>+	if (*cur == '@') {
>+		option = cur + 1;
>+		crash_base = memparse(option, &cur);
>+		if (option == cur)
>+			return;
>+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
>+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
>+	}
>+}
> 
> static void handle_mem_options(void)
> {
>@@ -250,7 +270,7 @@ static void handle_mem_options(void)
> 	u64 mem_size;
> 
> 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
>-		!strstr(args, "hugepages"))
>+		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> 		return;
> 
> 	tmp_cmdline = malloc(len + 1);
>@@ -286,6 +306,8 @@ static void handle_mem_options(void)
> 				goto out;
> 
> 			mem_limit = mem_size;
>+		} else if (strstr(param, "crashkernel")) {
>+			mem_avoid_crashkernel_simple(val);
> 		}
> 	}
> 
>@@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> 
> 	/* We don't need to set a mapping for setup_data. */
> 
>-	/* Mark the memmap regions we need to avoid */
>+	/* Mark the regions we need to avoid */
> 	handle_mem_options();
> 
> #ifdef CONFIG_X86_VERBOSE_BOOTUP
>-- 
>2.7.4
>
>
>


