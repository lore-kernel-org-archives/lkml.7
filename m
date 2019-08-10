Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9288C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7702166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsJ2rAXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfHJMxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:53:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34584 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfHJMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:53:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so47459090pfo.1;
        Sat, 10 Aug 2019 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UT83PzxtzNwzEHkb72vvM0RCTWANqqjb6Ts+sJ+oe9E=;
        b=gsJ2rAXMzD6M+OmI/md176/mDTCVYC6cnFn+HOohHLEA5ZxVjBRaLsHhfGvHGCI00B
         HdZ/qw7ugGlrHxXqqkktYXnrlkNrmBqBoAi0Ju+Zf5146HUr6RdAeAd7NM7NNLMaKJxC
         rZom41Z0dTXK/0aZemYIgyqqtsLCIeuEtH4dF4FHaMGODitpeYD0JlrFFJ8MBA+4HIs3
         ge6U71FgUUPPjCtQfTe2Q1+OW0I9NA7Ucqp7+/6R9T0Zwq9MJb5puYnw8NW/Ljot7ZMO
         whxnIz4WCAsZ2ANKyEW726yWzRIwy5wcMfq9zG7dTmQUf5tcd2IbLmsLCL7qOFTIG7E8
         o6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UT83PzxtzNwzEHkb72vvM0RCTWANqqjb6Ts+sJ+oe9E=;
        b=kGk6kQsPvFF+iIdvZ9XAA38qJDdXDUm/FCHo8V0Esz4mnIy+WO4DQCnfkV4/lqiRz0
         bkC13evMcM8w32Zdh/Wp+QUZlkAlREIGoRd7U9YMYbhEjTpdEqThMfeRRNn2zSmAYscN
         tZIdrYIPk8V+ZuLFFi3XKogAJtyoiZzdAXlVLU0WMg2gZFne7zdGwTKMikUoF8Cr+MdF
         QACDZukRIPdsSBH3kAr7sMLRHW3EWGF7AKC9lq4aCgEeDqmZAt2tqtl+pyAWVqKfmtGN
         Xl34cXKLI2DSbvFfu/A2nP0f3BDFDHzqk2zDhFoeTRVPUFpblRDNTzAFnyDSm5cKWRbv
         Rtqg==
X-Gm-Message-State: APjAAAV5Ds0vN2f/4Zxx12w8pyGYD7zmEtWeiV2GFPSqmjy0IpAKjDzl
        oUvtz+n8ImF38A7H+bwGTjRASmgj
X-Google-Smtp-Source: APXvYqynL0ZxSQmLqj2hjlnSjLPApfb7he7X4JKcbgCgHfdr47kCWOiYjhX3GBO3QNbVvbA2ojhOZw==
X-Received: by 2002:a63:194f:: with SMTP id 15mr22393658pgz.382.1565441612290;
        Sat, 10 Aug 2019 05:53:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o3sm19292938pje.1.2019.08.10.05.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 05:53:31 -0700 (PDT)
Date:   Sat, 10 Aug 2019 05:53:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: kernel: hw_breakpoint: Fix missing break in switch
 statement
Message-ID: <20190810125329.GA19990@roeck-us.net>
References: <20190810045944.GA13815@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810045944.GA13815@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:59:44PM -0500, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from
> erroneously falling through to case SH_BREAKPOINT_WRITE.
> 
> Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> If no one cares, I'll apply this to my tree and queue it up for 5.3-rc4.
> 
>  arch/sh/kernel/hw_breakpoint.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
> index 3bd010b4c55f..f10d64311127 100644
> --- a/arch/sh/kernel/hw_breakpoint.c
> +++ b/arch/sh/kernel/hw_breakpoint.c
> @@ -157,6 +157,7 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
>  	switch (sh_type) {
>  	case SH_BREAKPOINT_READ:
>  		*gen_type = HW_BREAKPOINT_R;
> +		break;
>  	case SH_BREAKPOINT_WRITE:
>  		*gen_type = HW_BREAKPOINT_W;
>  		break;
> -- 
> 2.22.0
> 
