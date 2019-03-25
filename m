Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C918C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KT8Ax0ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfCYMz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:55:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbfCYMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:55:28 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C6EC1EC02D1;
        Mon, 25 Mar 2019 13:55:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553518526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TfXKG57jE9zlAcUNyv8YxG+cx4r0oKKJxK8A8ypCSMg=;
        b=KT8Ax0ZKayh1VmBcIe1L8qZa09q58c8oi+gB0UOa15i2tQeKaGa8M/vpSxfbPSuRYpgvo2
        KSTFRWgd1JQE2P2CHzsErnvxHSom/BmNnoX1xY9u3RnJThyGQtHU1pn44W8XSaOE0KhbIv
        /+bu7vf6d4A6pzKgsg39HQMeypMU6Sg=
Date:   Mon, 25 Mar 2019 13:55:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Banman <abanman@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: uv: fix missing checks for kcalloc
Message-ID: <20190325125528.GM12016@zn.tnic>
References: <20190324225755.1702-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190324225755.1702-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 05:57:53PM -0500, Kangjie Lu wrote:
> In case kcalloc fails, the patch return an error to avoid
> potential NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  arch/x86/platform/uv/tlb_uv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> index 2c53b0f19329..1ac777f14846 100644
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -2140,7 +2140,13 @@ static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
>  		timeout_us = calculate_destination_timeout();
>  
>  	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
> +	if (!uvhub_descs)
> +		return 1;

Here...

>  	uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
> +	if (!uvhub_mask) {
> +		kfree(uvhub_descs);
> +		return 1;
> +	}

... and here you can simply do

		goto fail;

instead. After having initialized uvhub_descs and uvhub_mask to NULL;

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
