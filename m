Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8BEC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012C821873
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYzjO4m8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHRT6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:58:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35751 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:58:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34so11912475qte.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q4h4AAkSwtddxhD1rcEhxl/4C2CCtZRHzKErT0Cnp1c=;
        b=bYzjO4m8Pz5KgkK1Fzm0xdlan5DrBx5ZIGvOjNDe8zywDUCBOwaEYG6c9rbyYeOfkV
         RL4ivE6SiZra9nJ809T4SHEpPX8Jw5tMYR7FDiwLWbB5QyzwRSh4MroTKW06LgybptFh
         eDYTpCf7SFSF36WRuOq3s0rdK/zMVA/wvYp34jbzuSvxDd0ylhEpW2VyACu3IYsXsW0t
         ONJVqY3NI8N6UbQYpUL9Lx/etqSsJA6dCXb0OkM7UoQt5Q4GqeJI0yRUxDAKgPvoHhN6
         rXP78biQicwZesBcaTCRScaO3OFzqS6SnQtfk1PlzqIMxoaD5z/d2AEsRRXhYClBwZAx
         l9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q4h4AAkSwtddxhD1rcEhxl/4C2CCtZRHzKErT0Cnp1c=;
        b=IUbo7X0kdoZiXU0jIPeHGZFrpSXVKjBVC8IOm+Qy595GZ369fTQ2OGhZe0ZTt//5oe
         0OMoAdnP5WgY4XL3adQTg3/8EUasBbQ8GXP/GmgFEl7KZ2BwUka/Yz6wm7DsZK4WPuBz
         ttUnRFFgtW6exuewZ3RngymKqcbHI0jGMlEgDUMg6nuq2BfHz6u8zrx8xhR2vT5vgYCO
         W+ZAcBI9h8oICkWGMTxnAtIoNLNrL88LC/QHDqFJynaweAHGSA6FbZD1akmG2Nyibto0
         3PbMO8/ztHqeHzW606nFVndBRC5grwy03fCd34rEE9BT8TMttb5nuGa1OKvPLz/hFvg6
         bfBQ==
X-Gm-Message-State: APjAAAUCM2oeyWdorzcCMJ4b1KDuMwQ8MPD8ftWU+tJUKWV9o2ydn9ST
        M/tzXGKUgfQkOnhQ8dvaqACWT/rq
X-Google-Smtp-Source: APXvYqyB4mZN3GlDyvJdXkICz5BRy65BhfRAC8N/94OuA2dp6JDNM2regMC1kAMDyvg5+0O6i9VXZg==
X-Received: by 2002:a65:518a:: with SMTP id h10mr14874008pgq.117.1566157908156;
        Sun, 18 Aug 2019 12:51:48 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id 16sm23529953pfc.66.2019.08.18.12.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 12:51:47 -0700 (PDT)
Date:   Mon, 19 Aug 2019 01:21:40 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, jhubbard@nvidia.com
Cc:     jglisse@redhat.com, ira.weiny@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH 2/2] sgi-gru: Remove uneccessary
 ifdef for CONFIG_HUGETLB_PAGE
Message-ID: <20190818195140.GC4487@bharath12345-Inspiron-5559>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-3-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566157135-9423-3-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing lkml.

On Mon, Aug 19, 2019 at 01:08:55AM +0530, Bharath Vedartham wrote:
> is_vm_hugetlb_page will always return false if CONFIG_HUGETLB_PAGE is
> not set.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel-mentees@lists.linuxfoundation.org
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 61b3447..bce47af 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -180,11 +180,11 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
>  {
>  	struct page *page;
>  
> -#ifdef CONFIG_HUGETLB_PAGE
> -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> -#else
> -	*pageshift = PAGE_SHIFT;
> -#endif
> +	if (unlikely(is_vm_hugetlb_page(vma)))
> +		*pageshift = HPAGE_SHIFT;
> +	else
> +		*pageshift = PAGE_SHIFT;
> +
>  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
>  		return -EFAULT;
>  	*paddr = page_to_phys(page);
> @@ -238,11 +238,12 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
>  		return 1;
>  
>  	*paddr = pte_pfn(pte) << PAGE_SHIFT;
> -#ifdef CONFIG_HUGETLB_PAGE
> -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> -#else
> -	*pageshift = PAGE_SHIFT;
> -#endif
> +
> +	if (unlikely(is_vm_hugetlb_page(vma)))
> +		*pageshift = HPAGE_SHIFT;
> +	else
> +		*pageshift = PAGE_SHIFT;
> +
>  	return 0;
>  
>  err:
> -- 
> 2.7.4
> 
