Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122F9C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD93217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="r03fdaNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfKFI2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:28:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45262 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfKFI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:28:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id v8so17297680lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucyWnZTb08Kz+XLZc748AyyMVAhHeNNS7JX/C/XNmYE=;
        b=r03fdaNAZ7U381lbC6TcKDfuOFCkCOAQc2krSSfYDLprHpTtU/u007d+9oVtsfX2gq
         MUwo8WsB6FPqidZCoSZ2gDpqgp7bTh3A07L1SaTHG/dHvva4OwNfXYFJiartQvnu+8Y2
         9NNDcEtzAIoMo9uXgo6sGwJXQd/KNmkFsw+eSalOb4CLjaqsyDE21T4ot2u6sZqElzln
         CANEFS6cfSzYx7fvtBkGLBJkF7jL9Xyn/gTk3TFNuHcU7Id6cDXPcrK4Nk8zbO5nE+ZQ
         xD2fycjkVdRJER074Phslq5Y47YdY9DR2Z5KFeqBXseM01XpUV8inks4j4tZLw6pVFsM
         2sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucyWnZTb08Kz+XLZc748AyyMVAhHeNNS7JX/C/XNmYE=;
        b=EnieARsTdAjvV9xe0NC0PACZDfSqRuVrEDjtht6QagD+KnQ2bsuMwYFE4vNiwmdw6L
         Dc5ctgKteEkBogqaaCljGYFoxniifZ06wFhqaZpjukPL7OhSAgoW3k/0dsnICYMnKbAN
         7mw09cw/Pa9wl/uA59LCbEnpL9qUr5e1TzKJiNl5fBwhJPBp+fgjuSsX4sGR5G0bb/bg
         RsBJxBaXuA1Np4oHSfVSQrzH+nwsLOIgiKBCRxPGKeZJ6/SkQ3PjvI9jG/B/UXWbWORf
         L+AEw9Y3CQ4w7moy4TrKEix7Fc7V0JAdw2S0MRBlDRfJFQEC95biKGix1xQjRqy/wf7L
         kzrQ==
X-Gm-Message-State: APjAAAWnBW9ljPtEvs+NvONKA485m5QFFyvU517MvGDFtkEDPpqxAons
        GLfwYd7klsdnQNzyANiNvT6PwDcA+qtdmg==
X-Google-Smtp-Source: APXvYqye1zBZCOxIERc/ngm2M5//JQap3QWc+gDHjwKvjW1783JV9LVXNckqA6BHBwAsuXwfs0rSsg==
X-Received: by 2002:a19:5e0e:: with SMTP id s14mr9273100lfb.30.1573028925442;
        Wed, 06 Nov 2019 00:28:45 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c14sm10241986ljd.3.2019.11.06.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 00:28:44 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6BAA9100918; Wed,  6 Nov 2019 11:28:48 +0300 (+03)
Date:   Wed, 6 Nov 2019 11:28:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: rmap: use VM_BUG_ON() in __page_check_anon_rmap()
Message-ID: <20191106082848.eukf2jnjqxlvxgnx@box>
References: <1572973416-18532-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572973416-18532-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:03:36AM +0800, Yang Shi wrote:
> The __page_check_anon_rmap() just calls two BUG_ON()s protected by
> CONFIG_DEBUG_VM, the #ifdef could be eliminated by using VM_BUG_ON().
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/rmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d17cbf3..39178eb 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1055,7 +1055,6 @@ static void __page_set_anon_rmap(struct page *page,
>  static void __page_check_anon_rmap(struct page *page,
>  	struct vm_area_struct *vma, unsigned long address)
>  {
> -#ifdef CONFIG_DEBUG_VM
>  	/*
>  	 * The page's anon-rmap details (mapping and index) are guaranteed to
>  	 * be set up correctly at this point.
> @@ -1068,9 +1067,8 @@ static void __page_check_anon_rmap(struct page *page,
>  	 * are initially only visible via the pagetables, and the pte is locked
>  	 * over the call to page_add_new_anon_rmap.
>  	 */
> -	BUG_ON(page_anon_vma(page)->root != vma->anon_vma->root);
> -	BUG_ON(page_to_pgoff(page) != linear_page_index(vma, address));
> -#endif
> +	VM_BUG_ON(page_anon_vma(page)->root != vma->anon_vma->root);
> +	VM_BUG_ON(page_to_pgoff(page) != linear_page_index(vma, address));

Why not VM_BUG_ON_PAGE()?

-- 
 Kirill A. Shutemov
