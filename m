Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A67C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3D2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="C45T7SLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfDBJG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:06:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDBJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:06:58 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5571A1EC0669;
        Tue,  2 Apr 2019 11:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554196017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YbPunoNThQtG8DbuRb2C7sAqGNV3Jbburn+zBS+foUQ=;
        b=C45T7SLOKAqeIb0bWTxHNbJhUrukMenLFT81UeEXubzZ4m3y6Ix0LSdAHrXv55jZcPPcrm
        6A3pxZPumCqW9DgfR28uUedfNAdC1zbdho5QAAbWT02E7ysww3t4Ewxg/wDASam9jDsp9D
        3ydXSC4jUziHunXwYEAMd4b2jWNO7io=
Date:   Tue, 2 Apr 2019 11:06:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190402090652.GD6826@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190329123914.20939-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:39:13PM +0800, Lianbo Jiang wrote:
> -static int __ioremap_check_desc_other(struct resource *res)
> +/*
> + * Originally, these areas described as IORES_DESC_NONE are not mapped
> + * as encrypted when using ioremap(), for example, E820_TYPE_{RESERVED,
> + * RESERVED_KERN,RAM,UNUSABLE}, etc. It checks for a resource that is
> + * not described as IORES_DESC_NONE, which can make sure the reserved
> + * areas are not mapped as encrypted when using ioremap().
> + *
> + * Now IORES_DESC_RESERVED has been created for the reserved areas so
> + * the check needs to be expanded so that these areas are not mapped
> + * encrypted when using ioremap().
> + */
> +static int __ioremap_check_desc_none_and_reserved(struct resource *res)
>  {
> -	return (res->desc != IORES_DESC_NONE);
> +	return ((res->desc != IORES_DESC_NONE) &&

Why is this still checking IORES_DESC_NONE when the idea is to have this
specific IORES_DESC_RESERVED for all marked as *reserved* regions in
e820 which should not be mapped encrypted?

IOW, which regions are still marked as IORES_DESC_NONE and should not be
mapped encrypted?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
