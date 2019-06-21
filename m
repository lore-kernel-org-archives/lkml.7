Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69F8C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A72206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LOaqH/Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfFUNjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:39:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42832 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFUNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:39:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so4391991qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W1v9REbUjdM2ZPgzn5WvSncnmCktMY/9EZgX6QI0HOA=;
        b=LOaqH/DlAyTiaVsb+/cJ5fNqCKK9dcYheZzqBkbU8/dJCNcbdbTdvycRRW6WsdWNrq
         s1KlIlJ8pqtzQuZr4K+pscDPf+VAoNvvbLh7zGps691WEcEWVHVgG/y+SfGLilLH8xno
         0bDlX2xF7lyCGAB4ZXKagYnPnFu5m/m8VbNEpdAbBtffvGdOG5+2xjfKlD1S7GX/sCJ8
         Tki+kAZuPALbN16uIeo3/RJOzrwHbwCpqBWSiMTS52KfM4E4JV89wOogvhl4vLh60o2b
         9hG2keijKi4DWyDadCzOTDOZpyKgf7ZyhWBT1TsI17RSZcSyUl57cSd5RfTlT2NIe0b0
         X9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W1v9REbUjdM2ZPgzn5WvSncnmCktMY/9EZgX6QI0HOA=;
        b=mzsgTHfy0CHgBA60XDT+rRxABoZxrW5NYRAHJelWd1JVyNhADXHmfGh1hzw+oesfTt
         qeZ6l+/gz5OUtoqGPOtoaptjd8hqTEmNkaakP343tjcX1zOZ/nrXPdHeH+1Tf8cHOBXH
         zkVoBNOYRCejY7WjTRT7QZjcZs6KMFOiVnNm2NU/0hUr4eleffXD4lBGiuv6Db8iAHNk
         RMteGPJHgUa8uYcxFbacmFSI3vDD3frnpACpeVoz9Lgg6d5l06OFsVhRUHwPqQR6H4hI
         jXLxrFDHqsWG45OntCIGQNpZD3jmxgq2nG/XDOkFdYjMctHv7dxdPVEtaPedechL0FPH
         nwKg==
X-Gm-Message-State: APjAAAVDyIZ7Wg96NTKsDAFv4qXs5hoFfk82W43VDgb6sp3rvNS5+Rqu
        2gTk2WrfJLD4bvum84biCF28hw==
X-Google-Smtp-Source: APXvYqwDjXm2EEI8RDeCs7A5M5DgZpv1lwL8EVk5ylfRpHYYLvhclwPmRsPezAJyTvAyxaG7iZQC7A==
X-Received: by 2002:a37:ef01:: with SMTP id j1mr40587433qkk.163.1561124352349;
        Fri, 21 Jun 2019 06:39:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a6sm1525606qth.76.2019.06.21.06.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 06:39:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heJl1-00005R-4p; Fri, 21 Jun 2019 10:39:11 -0300
Date:   Fri, 21 Jun 2019 10:39:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm: use untagged_addr() for get_user_pages_fast
 addresses
Message-ID: <20190621133911.GL19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:47PM +0200, Christoph Hellwig wrote:
> This will allow sparc64 to override its ADI tags for
> get_user_pages and get_user_pages_fast.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..6bb521db67ec 100644
> +++ b/mm/gup.c
> @@ -2146,7 +2146,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long flags;
>  	int nr = 0;
>  
> -	start &= PAGE_MASK;
> +	start = untagged_addr(start) & PAGE_MASK;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;

Hmm, this function, and the other, goes on to do:

        if (unlikely(!access_ok((void __user *)start, len)))
                return 0;

and I thought that access_ok takes in the tagged pointer?

How about re-order it a bit?

diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e410..f48747ced4723b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2148,11 +2148,12 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	start &= PAGE_MASK;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
-	end = start + len;
-
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return 0;
 
+	start = untagged_ptr(start);
+	end = start + len;
+
 	/*
 	 * Disable interrupts.  We use the nested form as we can already have
 	 * interrupts disabled by get_futex_key.
