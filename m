Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E37CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF220873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIr27p3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfJaQEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:04:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:04:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so6480313wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAUaCVnXVTPu4BHWIU8/SeyN5F4/2lpyjJPrdXmye2A=;
        b=aIr27p3xRf3wx/8Ig/NxHG/TnRXX42pulbg7LBm9id8owkQ9UVVxSghoKWCMRFf1AB
         o34uMEp06rWCI0sws9XQeZrViu6n+zyLSWiA1kpH2lwz6y6HfXhOyuWGj65UHFHhZmn7
         k9quYkcXb1UwUoYAxTXpkzq1VvPXwJoIBGjaU0CkqD3mtZYYN7PiS2KoeKyuN7bRYjMP
         mL7ouFdyILHIKPhg9Kca+0aQiQMi948radfDyRVneQoUGNUHUCEhwb9MPpQbbJku9gI8
         ugFAv5LartJijjpVp+p0P4prHxQLUHBf24tZO1KaFEP5uqzr6gm57bjgUQsSy6TIQaAr
         W9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAUaCVnXVTPu4BHWIU8/SeyN5F4/2lpyjJPrdXmye2A=;
        b=NvDSqIHW0eD0smaKe0AuP4YrCLCiMDcz9FmiiV5BFsl4rdsDK76q2KeSZoT9wCBFPF
         JJ7UU10s87rvgbN6xxRHMpHeTlJOUPpoKSnHSlHvzRDyyXe40lGs29Hg/KjAQw36KC7R
         AX3DVWWoLOdMr2oWKRLqa5gPMXPeK5dTBcxRV2QVRd8pjyBAnUxczDpDo/VWmJ1ULJhW
         p8pjv5cPnsepO1/UpU/7lBNy4prbUj7YIES/1I+D0mcT5ME0HAgsWYtnC/sBAjh2DIVT
         +W/UioDVAheonWLeZ83QWEIXPWxyG+5biHPqSaoy6fU8frT7w8qVIWKsn0CD4zoqmXHL
         BD4w==
X-Gm-Message-State: APjAAAWpKRTNI2fP8wryujprs4r5DpZ6/s1j4BtxPTOmXcyhp1Rdg5EQ
        QFjRsOZg3fxS8gSycSIUFmU=
X-Google-Smtp-Source: APXvYqwebx/lwR5sk//7d0OTnx/JnYZerIAInuf8LuhOZHdlp+WjeA/S155x0lP90Xh1d2q21GhlvQ==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr964031wml.158.1572537841801;
        Thu, 31 Oct 2019 09:04:01 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id c14sm4234480wru.24.2019.10.31.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 09:04:01 -0700 (PDT)
Date:   Thu, 31 Oct 2019 17:03:56 +0100
From:   Roi Martin <jroi.martin@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: exfat: replace kmalloc with kmalloc_array
Message-ID: <20191031160356.GB6924@miniwopr.localdomain>
References: <20191031123139.32361-1-jroi.martin@gmail.com>
 <20191031132503.GD1705@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031132503.GD1705@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> > index f71235c6a338..f4f82aecc05d 100644
> > --- a/drivers/staging/exfat/exfat_core.c
> > +++ b/drivers/staging/exfat/exfat_core.c
> > @@ -713,8 +713,8 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
> >  
> >  	u32 checksum = 0;
> >  
> > -	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
> > -						GFP_KERNEL);
> > +	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
> > +	p_fs->vol_utbl = upcase_table;
> 
> This patch is fine, but one idea for future patches is that you could
> remove the "upcase_table" variable and use "p_fs->vol_utbl" everywhere
> instead.

Thanks for the suggestion.

This is my first contribution and I tried to introduce the minimum
number of changes necessary to fix the issues reported by checkpatch.pl.
Also, I'm still immersed in getting familiar with the contribution
process and the code.

Do you think it makes sense to include this change in a future patch
series along with other refactoring? Or, should I modify this patch?

By the way, upcase_table is sometimes accessed in quite complex ways.
For instance:

	upcase_table[col_index][get_row_index(index)] = uni;

Where having an intermediate variable instead of using the struct field
directly seems to improve readability a bit. Otherwise:

	p_fs->vol_utbl[col_index][get_row_index(index)] = uni;

I assume, in cases like this, from a coding style perspective, the
following approach is preferred:

	row_index = get_row_index(index);
	p_fs->vol_utbl[col_index][row_index] = uni;

Is that correct?

Regards,

	Roi Martin
