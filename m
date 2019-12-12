Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B0821556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sup/zOKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfLLUSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:18:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfLLUSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:18:53 -0500
Received: from zn.tnic (p200300EC2F0A5A00BC9FD9E905C0F14B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:bc9f:d9e9:5c0:f14b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F4011EC0B73;
        Thu, 12 Dec 2019 21:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576181932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j3ZxA3x8+ibwFStiWaC1SmDTUAr00OrM5QZ5N2qHrvA=;
        b=Sup/zOKpADPlgSXxDPBHXEJr1RcCm9BaBRSp1ftv7pGNFGf0M2I567m1obCtzHLgjbD2Ji
        smlhNATlXrBThOys0TFeDGiyki/wZnDYkld284VBXwky0gBMeImvDHqGbOLJu4w4sTMXvX
        vkcZuBkTXzOa01GdftWZtUwYmMeZdCg=
Date:   Thu, 12 Dec 2019 21:18:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] x86/boot: Wrap up the SRAT traversing code into
 subtable_parse()
Message-ID: <20191212201851.GK4991@zn.tnic>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115144917.28469-2-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:49:14AM -0500, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Wrap up the SRAT traversing code into subtable_parse().

Why?

> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 25019d42ae93..a0f81438a0fd 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -362,6 +362,19 @@ static unsigned long get_acpi_srat_table(void)
>  	return 0;
>  }
>  
> +static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
> +{
> +	struct acpi_srat_mem_affinity *ma;
> +
> +	ma = (struct acpi_srat_mem_affinity *)sub_table;
> +
> +	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> +		immovable_mem[*num].start = ma->base_address;
> +		immovable_mem[*num].size = ma->length;
> +		(*num)++;
> +	}
> +}
> +
>  /**
>   * count_immovable_mem_regions - Parse SRAT and cache the immovable
>   * memory regions into the immovable_mem array.
> @@ -395,14 +408,8 @@ int count_immovable_mem_regions(void)
>  	while (table + sizeof(struct acpi_subtable_header) < table_end) {
>  		sub_table = (struct acpi_subtable_header *)table;
>  		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {

So this is checking for the table type being something but calling a
function which looks generic, at least judging by the name.

And that generic function is a function why exactly? It beats me. And
the input/output argument @num is actually begging for this to *not* be
a function at all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
