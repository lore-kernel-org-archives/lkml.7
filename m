Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F307C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5EF2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egrdri1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfFEO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:28:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45831 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfFEO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:28:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id x7so8763299plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d5BFJo1GaCyqaBLV5Vh0Cy/fBc47Eg0ShxO4nO5M6dM=;
        b=egrdri1FSHktF7zsnB/hbZ/o6P2DAyzWU8XYwT2syRQY37g8yizNtukCbpocjQSCfx
         qmPNfy4tBFaoXlbtXaRNXq/9z1lnm4X7jYlmir7osyv72vE3HWmoQlchWRVjovjZSZrL
         0+ZKci5TlPGtxURSSqsA+urIv1YlIN+SzeIFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5BFJo1GaCyqaBLV5Vh0Cy/fBc47Eg0ShxO4nO5M6dM=;
        b=hR56G4WUMlGcJhTCnu60B1I+GlD79h0JuZ64ljdphbPn+aiqnkdE6Nk3vwqIhPo9J1
         65THlSxZ6tKZ1kq5UnaAGYAWfYhhNuPDR7AEjtwsimMLwZS+XFry8yTOg7SSiGWC2Jqc
         0Ugu+TD2V4glWBRC+3k2bIwOXdFalv8ueMX7XRzuZr33IRHGdNlkwBO5TMy6ZrfH0zE7
         6lAp1j7wghhqGxHkGNzLkBWyjjKHZOqLfFk6r2hrpLb3OESUDZI8tICzuntWF6KQLz6K
         6eU65915kEkYG3Zsp7mWzoMTNFNWAp7WKxo783HilJkpB5zd8bibUojgeuqZgQfYSEa7
         5BSQ==
X-Gm-Message-State: APjAAAUzrUlQ3ALNoSMM0O436XcqzETUIucJTwmtYXTYul3TRtZqZAd8
        YdTXU/iZRnl+zVIB0VxS7n7jIg==
X-Google-Smtp-Source: APXvYqxBqoln1X0OFP0egG53hQMQLYdRXvN5hLZW9ECtmByzrhR3fX3kly0ePMtkA2u5fNLoxl3djA==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr18931439plz.38.1559744934573;
        Wed, 05 Jun 2019 07:28:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j23sm11163753pgb.63.2019.06.05.07.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 07:28:53 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:28:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/asm: Pin sensitive CR4 bits
Message-ID: <201906050728.89B4834@keescook>
References: <20190604234422.29391-1-keescook@chromium.org>
 <20190604234422.29391-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604234422.29391-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:44:21PM -0700, Kees Cook wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2c57fffebf9b..6b210be12734 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -366,6 +366,23 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
>  	cr4_clear_bits(X86_CR4_UMIP);
>  }
>  
> +DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> +unsigned long cr4_pinned_bits __ro_after_init;

I missed EXPORT_SYMBOL()s for these -- I will fix in v3.

-- 
Kees Cook
