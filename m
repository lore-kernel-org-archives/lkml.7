Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF621C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E6A20863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDFrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:47:32 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14355 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725550AbfCDFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:47:31 -0500
X-IronPort-AV: E=Sophos;i="5.58,438,1544457600"; 
   d="scan'208";a="55845591"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Mar 2019 13:47:30 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A3BFA4C5347A;
        Mon,  4 Mar 2019 13:47:14 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 13:47:35 +0800
Date:   Mon, 4 Mar 2019 13:47:20 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>
Subject: Re: [PATCH v2] x86/boot: Fix incorrect ifdeffery scope
Message-ID: <20190304054720.GD28322@localhost.localdomain>
References: <20190304053756.16886-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190304053756.16886-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A3BFA4C5347A.AB2D0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 01:37:56PM +0800, Baoquan He wrote:
>The declarations related to immovable memory handling are put out of
>the BOOT_COMPRESSED_MISC_H #ifdef scope, wrap them inside.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
>v1->v2:
>  Add the lost line which could be made by git.
>
> arch/x86/boot/compressed/misc.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>index fd13655e0f9b..8bbaf362855c 100644
>--- a/arch/x86/boot/compressed/misc.h
>+++ b/arch/x86/boot/compressed/misc.h
>@@ -120,8 +120,6 @@ static inline void console_init(void)
> 
> void set_sev_encryption_mask(void);
> 
>-#endif
>-
> /* acpi.c */
> #ifdef CONFIG_ACPI
> acpi_physical_address get_rsdp_addr(void);
>@@ -135,3 +133,5 @@ int count_immovable_mem_regions(void);
> #else
> static inline int count_immovable_mem_regions(void) { return 0; }
> #endif
>+
>+#endif

If it will look better:

+#endif /* BOOT_COMPRESSED_MISC_H */

I am sorry that I should say that in your V1 version, but I really
forgot it after noticing that PATCH log.

Thanks,
Chao Fan

>-- 
>2.17.2
>
>
>


