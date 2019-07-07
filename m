Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E11C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7663D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 14:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJGOHMK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGGOlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 10:41:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34829 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGGOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 10:41:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so6358350pgl.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hg+2F4CQEXTPGuzXZHgWpeWud+WKMzNK6Pc5pT307kM=;
        b=JJGOHMK2ecBPtywHW+pwEEByqzswqKCHObyjZWXEVxFiTcAEhRTBI1Aaso+HqQNaYf
         w77emYzzGqa8xlvmUTTPz2E/T5pNla2Q9nZVIY2keM65vyK7548yvj4UhvRui34hsNof
         uaUFHKvBdztXLVaQc9cc3BwuhFxbTwmu+1EL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hg+2F4CQEXTPGuzXZHgWpeWud+WKMzNK6Pc5pT307kM=;
        b=LkDriMzPVKxN+A4ETXYx9LO85tzpctGKhbIA9JYKspAFWIJA4HpmS7l7WZ1GRuKwx6
         uzRpG8b4GJWe2lzJss/NuWuF3VJwlc1foSwGLPjlnxAtBgcIZMxGuhZ7HIz7nFabOZ/B
         StjAg6bhjKtB0MUdX3uW24kZNUknEPoTtsJ0kGmErtTAtrItaAr77QMvlCynsZKF+lsx
         bR3zQrpOP1LtWoR61AfQ7SDtGbVOUEsXiMrMoa4tLUS8c23jt1CqxdbbrKRfMDIMc0Qg
         5T50AHCwQsu2poGNDoZAlavvNtgXtf2E2aDuzpqniFx+ReQTy+8/pSrDPZVoLP5sbBlM
         B6JQ==
X-Gm-Message-State: APjAAAXk/y4CNwF1vnakPc3suhqqkvgk4Kl+gu/V+yd2KR5U1LRqYC+1
        JyzWAPPjgn8PoC0eWIl439KRNA==
X-Google-Smtp-Source: APXvYqwoFkA7zB3NISebB7rck4JJBsMvhQVhl6urEfNNYp+x5Eh1QSRUAOBb52JpqyJmGjIupV0V4g==
X-Received: by 2002:a17:90a:f98a:: with SMTP id cq10mr18462409pjb.43.1562510471215;
        Sun, 07 Jul 2019 07:41:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i74sm16400681pje.16.2019.07.07.07.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2019 07:41:10 -0700 (PDT)
Date:   Sun, 7 Jul 2019 07:41:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH pstore fix v1] pstore: fix use after free
Message-ID: <201907070734.86DE450@keescook>
References: <1562331960-26198-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562331960-26198-1-git-send-email-nmanthey@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 03:06:00PM +0200, Norbert Manthey wrote:
> The pstore_mkfile() function is passed a pointer to a struct
> pstore_record. On success it consumes this 'record' pointer and
> references it from the created inode.
> 
> On failure, however, it may or may not free the record. There are even
> two different code paths which return -ENOMEM -- one of which does and
> the other doesn't free the record.
> 
> Make the behaviour deterministic by never consuming and freeing the
> record when returning failure, allowing the caller to do the cleanup
> consistently.

Yup, good catch. Looks like a double-free in the one failure case.

> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>

Fixes: 83f70f0769ddd ("pstore: Do not duplicate record metadata")
Fixes: 1dfff7dd67d1a ("pstore: Pass record contents instead of copying")
Cc: stable@vger.kernel.org

Applied to my pstore tree. :)

-Kees

> ---
>  fs/pstore/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -333,7 +333,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  	private = kzalloc(sizeof(*private), GFP_KERNEL);
>  	if (!private)
>  		goto fail_alloc;
> -	private->record = record;
>  
>  	switch (record->type) {
>  	case PSTORE_TYPE_DMESG:
> @@ -387,6 +386,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  	if (!dentry)
>  		goto fail_private;
>  
> +	private->record = record;
> +
>  	inode->i_size = private->total_size = size;
>  
>  	inode->i_private = private;
> -- 
> 2.7.4
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 

-- 
Kees Cook
