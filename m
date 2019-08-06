Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A302C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F020C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XTjnnHi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfHFOjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:39:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46472 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbfHFOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:39:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so84690535qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5CPIS4mmyxALTwu292eKFtIXYTqe3SCg3BcaBK423k=;
        b=XTjnnHi8z+SYvy9zIZcrSsQ/4Y2tZDIGwuTiAd3On/3Qyk2jJKpY9TJZwKkhDIEj3+
         MGHtt3rEv401lGpVq5xL0CKheYAiDCONwdtltzljbu1GSNGjaTUSRBGuj6fMXfPd7xx9
         AvWLguAEFAriYfUuE/os0GFuvFNJgqJH9P1XG2mJ+YwX0AZhkzMufVj8RERsoxhYeF6L
         xRIbWAbvwo4On/nNeR5bWsE7X6QGURzO6ky4zV3wi1UlvTjZErwMLSfQ7U9cov+5JWeV
         kG6leE1orrap1pWD6YdXGVpsb3smabaJfOBSV25ApiXrIfZ6NUpp239eLF46tRKUjS0M
         cRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5CPIS4mmyxALTwu292eKFtIXYTqe3SCg3BcaBK423k=;
        b=S8yjDTPkBDLIhI11I8NlaoOwD2E+YXQvhB/QGH69lbYMixIbxCKCLqjtYbZJqGYmOu
         0DzdCoELqJD1MvIYeTOQHxhNR/+4ladRb33sgl0YYWvGuPPmGwoVGf46EdQk5j8ZChtY
         QVP2cnBXPVmhClC/XQphXrp9px8QoeUafgwlYX5bR34ZyeQP4fPanSqFCglO414pNtFQ
         sY2AZ2r3jGy+DbZNld9+XTciwvcK93XrKUGFOw1jEgIQg6dsa+hJkljUVqatztNhLaGR
         oHUzSkqfZIj65k/B3n57KDJH6EtTG5M91gqp9tksWGd3TAJQWojv9ydnDTIP+Rk3Y32n
         g4xQ==
X-Gm-Message-State: APjAAAXPuToyEQUJmqGwt9BoSK2zDPMk/vP7Rn2WuxbiJlmGFLVCna0E
        OLZvb5LgAP8BHj693rfPNRvEMw==
X-Google-Smtp-Source: APXvYqxb9K01d3+TG7ks63JaVg+hAktf2Hz+U/53HsIRu0RYyLZKlOzhu0DzA2UWt4gOEDGxB6xX5A==
X-Received: by 2002:a0c:e001:: with SMTP id j1mr3394954qvk.110.1565102345637;
        Tue, 06 Aug 2019 07:39:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d71sm500507qkg.70.2019.08.06.07.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 07:39:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv0cC-0005jc-Oe; Tue, 06 Aug 2019 11:39:04 -0300
Date:   Tue, 6 Aug 2019 11:39:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix variable 'p4d' set but not used
Message-ID: <20190806143904.GE11627@ziepe.ca>
References: <1564774882-22926-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564774882-22926-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:41:22PM -0400, Qian Cai wrote:
> GCC throws a warning on an arm64 system since the commit 9849a5697d3d
> ("arch, mm: convert all architectures to use 5level-fixup.h"),
> 
> mm/kasan/init.c: In function 'kasan_free_p4d':
> mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
> [-Wunused-but-set-variable]
>   p4d_t *p4d;
>          ^~~
> 
> because p4d_none() in "5level-fixup.h" is compiled away while it is a
> static inline function in "pgtable-nopud.h". However, if converted
> p4d_none() to a static inline there, powerpc would be unhappy as it
> reads those in assembler language in
> "arch/powerpc/include/asm/book3s/64/pgtable.h",
> 
> ./include/asm-generic/5level-fixup.h: Assembler messages:
> ./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
> first unrecognized character is `}'
> ./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
> first unrecognized character is `}'
> ./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
> first unrecognized character is `}'
> make[2]: *** [scripts/Makefile.build:375:
> arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1
> 
> Fix it by reference the variable in the macro instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
>  include/asm-generic/5level-fixup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
> index bb6cb347018c..2c3e14c924b6 100644
> +++ b/include/asm-generic/5level-fixup.h
> @@ -19,7 +19,7 @@
>  
>  #define p4d_alloc(mm, pgd, address)	(pgd)
>  #define p4d_offset(pgd, start)		(pgd)
> -#define p4d_none(p4d)			0
> +#define p4d_none(p4d)			((void)p4d, 0)

Yuk, how about a static inline instead?

Jason
