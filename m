Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63257C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F95920665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1+dT3FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfG3J2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:28:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45969 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfG3J2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:28:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so28676200plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=YuvsEbvLeu9gpGlnWN7D2YTCXaShfpJvy1rRpc/g3Gw=;
        b=W1+dT3FF153FvLmzoTVoZurqL3wtEb4gbI7pQA4NaeHwdA4jHLKXe/Y8AHo8GYMJJc
         FwYJwg+yfou7K8KVWBENyT27o41tc/NVPcWSnwtIjj7v1Elu/QZgVxi/WXMXzfCszk1P
         5MHRR/kHw3x8mDFbR8KEdbTUQ7u12A5LuEYutVQ2gWN6Aw+eDQBCjGh49nhPm49xAO29
         CK9UE/Kpx5xt2tNdczt1sFwipf2fPEhP+WTy8uAUDZC3g3h8aWQ3pQ3Pv2nZH87dq72n
         cXeqbo7zQRhHI1DBciVPgd39acSyhjfhEH3ggZz9a4MbBwfdvZ9n4R0VAXyPirTFAadh
         mxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=YuvsEbvLeu9gpGlnWN7D2YTCXaShfpJvy1rRpc/g3Gw=;
        b=CdU5uEzAOjxx0YxI8VZE9GdwZZDClKXP6lWTd5PruDj7q7XdflDqDJGmRKniPBdBVR
         aibM/EXFK7wZMvVzxkJyWbfjSZica2n3yWtdK3OLVI81TPKGovqNf2ozydf/GYtqIMIn
         d1HENJtWaq6gzsQMhYD/uJhkNV6xe+Z8U916bqEKydYz25WnCuJ0TkaUDgpNkdFAkml+
         3IDf91nzVa9fi2vAvkiToKU6ittmWB74HLDLCL6ix0rQfHgWnZ5jpetytGHXcHnBb2O9
         zGwNFPIfC+Rc3TlpvV7PUpOb9uCW3PGqWljl/DY7maI2q3ZWEPRoQOOBWENdJxHxXScm
         wg7A==
X-Gm-Message-State: APjAAAVT0VycugLMiXyRM1//V03ECr8F5t1NSqrJzSJ01RDxXGBvM+YO
        8KPfRHgxEKWAeFLZ1g7Qg4Q5KG/d
X-Google-Smtp-Source: APXvYqxOaGD4tc0XVSmbTm2kbit39tXgiR323mk2jyG0N6edIIeiUIciSLvziX46b8Be1tKtESIWBw==
X-Received: by 2002:a17:902:2baa:: with SMTP id l39mr115483897plb.280.1564478931663;
        Tue, 30 Jul 2019 02:28:51 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id f3sm102458535pfg.165.2019.07.30.02.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:28:51 -0700 (PDT)
Date:   Tue, 30 Jul 2019 14:58:44 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, Matt.Sickler@daktronics.com
Cc:     Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v4] staging: kpc2000: Convert
 put_page to put_user_page*()
Message-ID: <20190730092843.GA5150@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_page() to put_user_page*()
Reply-To: 
In-Reply-To: <1564058658-3551-1-git-send-email-linux.bhar@gmail.com>

On Thu, Jul 25, 2019 at 06:14:18PM +0530, Bharath Vedartham wrote:
[Forwarding patch to linux-kernel-mentees mailing list]
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Matt Sickler <Matt.Sickler@daktronics.com>
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v1
>         - Improved changelog by John's suggestion.
>         - Moved logic to dirty pages below sg_dma_unmap
>          and removed PageReserved check.
> Changes since v2
>         - Added back PageResevered check as
>         suggested by John Hubbard.
> Changes since v3
>         - Changed the changelog as suggested by John.
>         - Added John's Reviewed-By tag.
> Changes since v4
>         - Rebased the patch on the staging tree.
>         - Improved commit log by fixing a line wrap.
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index 48ca88b..f15e292 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -190,9 +190,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
>  	sg_free_table(&acd->sgt);
>   err_dma_map_sg:
>   err_alloc_sg_table:
> -	for (i = 0 ; i < acd->page_count ; i++) {
> -		put_page(acd->user_pages[i]);
> -	}
> +	put_user_pages(acd->user_pages, acd->page_count);
>   err_get_user_pages:
>  	kfree(acd->user_pages);
>   err_alloc_userpages:
> @@ -211,16 +209,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
>  	BUG_ON(acd->ldev == NULL);
>  	BUG_ON(acd->ldev->pldev == NULL);
>  
> -	for (i = 0 ; i < acd->page_count ; i++) {
> -		if (!PageReserved(acd->user_pages[i])) {
> -			set_page_dirty(acd->user_pages[i]);
> -		}
> -	}
> -
>  	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
>  
> -	for (i = 0 ; i < acd->page_count ; i++) {
> -		put_page(acd->user_pages[i]);
> +	for (i = 0; i < acd->page_count; i++) {
> +		if (!PageReserved(acd->user_pages[i]))
> +			put_user_pages_dirty(&acd->user_pages[i], 1);
> +		else
> +			put_user_page(acd->user_pages[i]);
>  	}
>  
>  	sg_free_table(&acd->sgt);
> -- 
> 2.7.4
> 
