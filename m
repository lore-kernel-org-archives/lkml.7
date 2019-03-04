Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C99C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfCDKRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:17:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfCDKRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:17:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E0A7C049E22;
        Mon,  4 Mar 2019 10:17:13 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64A625DD63;
        Mon,  4 Mar 2019 10:17:12 +0000 (UTC)
Date:   Mon, 4 Mar 2019 18:17:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org
Cc:     fanc.fnst@cn.fujitsu.com, bp@alien8.de
Subject: Re: [PATCH v3] x86/boot: Fix incorrect ifdeffery scope
Message-ID: <20190304101709.GZ14858@MiWiFi-R3L-srv>
References: <20190304055546.18566-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304055546.18566-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Mar 2019 10:17:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Thomas and Ingo to CC, and x86 ML.

On 03/04/19 at 01:55pm, Baoquan He wrote:
> The declarations related to immovable memory handling are put out of
> the BOOT_COMPRESSED_MISC_H #ifdef scope, wrap them inside.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
>   Add code comment to clearly note the end of the ifdeffery for better
>   code reading.
> v1->v2:
>   Add the lost line which could be made by git.
>  arch/x86/boot/compressed/misc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index fd13655e0f9b..d2f184165934 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -120,8 +120,6 @@ static inline void console_init(void)
>  
>  void set_sev_encryption_mask(void);
>  
> -#endif
> -
>  /* acpi.c */
>  #ifdef CONFIG_ACPI
>  acpi_physical_address get_rsdp_addr(void);
> @@ -135,3 +133,5 @@ int count_immovable_mem_regions(void);
>  #else
>  static inline int count_immovable_mem_regions(void) { return 0; }
>  #endif
> +
> +#endif /* BOOT_COMPRESSED_MISC_H */
> -- 
> 2.17.2
> 
