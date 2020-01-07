Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C8C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401EE2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdRb1vPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgAGSFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:05:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50371 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgAGSFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:05:14 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so124644pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjlkWiKh+g3cKf2mHxhVG1Q3e4MbsjG1T7AKRjtPSkI=;
        b=hdRb1vPOgy96J5vwannmHaIeo+MQjIA7+ETDXumsG26Ddm7emM3k1YbhBfN61WrDIt
         BxGjzW/2jKd352E4uJBsznTy21FffH4Ppg1+Do/EQQXKjx6vtroq2SEMpHVwp+PlOHFR
         /FVCSzrPmHWT9nqHNoHwB4ub41QOCT+mA9FsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjlkWiKh+g3cKf2mHxhVG1Q3e4MbsjG1T7AKRjtPSkI=;
        b=EV42U1nr6t/N5gQYAzkzHL/0LLMEjBHsMEvvuqCOmvg9QKu33Gy3w6fisrFs0LRDeV
         izJXWMz8O696oz6celdCuZ0V89p43HS6iJdAvDSwpZST9/d2Q06yYOCBPA14eXcW3xxe
         InDwdNc75c6CbnKljhoqEGExOSQlGm6GmEAm2gnmk11vVDXow8NcGTIUtAQRBi70vFhX
         T0DruhVFmWzwIvsJB0zhRuWJjrYW2IREp2pUeC5Sb7FRaT+F0CGUiQfumiq5psCIvC7R
         6wh0cR1V20NsuyU/TAgJbxx8bGt3P8xJadXOfdQ8T0V2AQg8SLzum8xpfHrZxiJOPHps
         PLjw==
X-Gm-Message-State: APjAAAXSgl7waZpXboZZBUl05FroFaUdCfXtybtPS6lu4YXew9L1Rlvq
        RRG1CWW7Ypj5c+WRNaJ4a6ByE3Foj6Q=
X-Google-Smtp-Source: APXvYqzCgYoCPrYnzJGsu76pjYsj0EP+XJTU+bFuIKwSg2Wa0NBKuO7VrNFDxglHxw8ONuKSXWSrPg==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr922058plj.197.1578420313576;
        Tue, 07 Jan 2020 10:05:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t63sm207916pfb.70.2020.01.07.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:05:12 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:05:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] fs: pstore: fix double-free on ramoops_init_przs
Message-ID: <202001071002.A236EBCA0@keescook>
References: <20200107110445.162404-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107110445.162404-1-cengiz@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:04:46PM +0300, Cengiz Can wrote:
> According to Coverity scanner (CID 1457526) kfree on ram.c:591 frees
> label which has already been freed.
> 
> Here's the flow as I have understood (this is my first time reading
> pstore's files):
> 
> Whenever `persistent_ram_new` fails, it implicitly calls
> `persistent_ram_free(prz)` which already does `kfree(prz->label)` and a
> `kfree(prz)` consequently.
> 
> Removed `kfree(label)` to prevent double-free.

I think this is a false positive (have you actually hit the
double-free?). The logic in this area is:

label = kmalloc(...)
prz[i] = persistent_ram_new(..., label, ...)
if (IS_ERR(prz[i])) {
    kfree(label)
    while (i > 0) {
        i--;
        persistent_ram_free(prz[i]);
    }
}

nothing was freeing the label on the failed prz, but all the other prz
labels were free (i.e. there is a "i--" that skips the failed prz
alloc).

-Kees

> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  fs/pstore/ram.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 487ee39b4..e196aa08f 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -588,7 +588,6 @@ static int ramoops_init_przs(const char *name,
>  			dev_err(dev, "failed to request %s mem region (0x%zx@0x%llx): %d\n",
>  				name, record_size,
>  				(unsigned long long)*paddr, err);
> -			kfree(label);
>  
>  			while (i > 0) {
>  				i--;
> -- 
> 2.24.1
> 

-- 
Kees Cook
