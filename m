Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF078C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052520818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfCDBVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:21:12 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40100 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbfCDBVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:21:11 -0500
X-IronPort-AV: E=Sophos;i="5.58,438,1544457600"; 
   d="scan'208";a="55826740"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Mar 2019 09:21:09 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E54AC4C5347A;
        Mon,  4 Mar 2019 09:20:53 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 09:21:14 +0800
Date:   Mon, 4 Mar 2019 09:20:58 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Louis Taylor <louis@kragniz.eu>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <bhe@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>, <ndesaulniers@google.com>,
        <jflat@chromium.org>
Subject: Re: [PATCH] x86/KASLR: always return a value from process_mem_region
Message-ID: <20190304012058.GA28322@localhost.localdomain>
References: <20190302184929.28971-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190302184929.28971-1-louis@kragniz.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: E54AC4C5347A.AB7B5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 06:49:29PM +0000, Louis Taylor wrote:
>When compiling with -Wreturn-type, clang warns:
>
>arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
>      non-void function [-Wreturn-type]
>
>This function's return statement should probably have been placed
>outside the #endif, so move it there
>
>Link: https://github.com/ClangBuiltLinux/linux/issues/360
>Signed-off-by: Louis Taylor <louis@kragniz.eu>
>---
> arch/x86/boot/compressed/kaslr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>index fa0332dda9f2..2e53c056ba20 100644
>--- a/arch/x86/boot/compressed/kaslr.c
>+++ b/arch/x86/boot/compressed/kaslr.c
>@@ -697,8 +697,8 @@ static bool process_mem_region(struct mem_vector *region,
> 			return 1;
> 		}
> 	}
>-	return 0;
> #endif
>+	return 0;

Make sense, thanks for your PATCH.

Thanks,
Chao Fan

> }
> 
> #ifdef CONFIG_EFI
>-- 
>2.20.1
>
>
>


