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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5BEC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C9E21873
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnKaNuRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfHRT7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:59:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:59:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so5629526pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OOdaQ3Y1UMODtL7IlKujR0VdVVo4BsF1PHOf0vyDCEk=;
        b=SnKaNuRnHt/L6jr+prABwlBFB7rPkwIoFUeGfETvUKgl56MYOBao69wU8gKBM4Zd4H
         kNNVYrtljpMzuoHgZogsfIEU3l0//1Tkz/XFHrRmeXcnNeYjvdeZM4vMNGklqFweHxVs
         s9fLLEfZmtJq81sYYwx9LO66pEWILb6O2KNaqJsCQsYUS2vGqKYvCWwkc/xyC4MEqXTa
         hCnsKmJRph4IpNqO4sbTYpkzTyzM0Pfv55ROJTTRvdrvypDapE+8bPEHi84Ai3v1L2TW
         LQUm6QeAxElBg7mFG0D753dO1qTj8UWdubCjVQmiIAHpIvV68xvNgIkMIUzBnNLuRKad
         jNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OOdaQ3Y1UMODtL7IlKujR0VdVVo4BsF1PHOf0vyDCEk=;
        b=uiU72nneFfbiMk5WmGPdC8zNU+gP2cyd4oVURm0+VHL2omWjUyg0Ep2Km163s1cnH4
         nudyUa4zKSAg0KvDyCMozSFMNXu9ju3DJJFVFF58kbBCiMo8BgVurrxmQNOcivlK4MtC
         wu2lMygXIHXGluYufkFj8k5aTbWdsQQqIg66BM4/yysnAMG3FaZT/kI/xOp3L0NHOypg
         W/GNsFHBo259McKd/8PfymsFBxXPj+FT6ns3krl+c3Iy0g3ItBZ0oWxWpuKBRvGog/S+
         n/OVhn41Nu+C4Fiu96Bs2K1Hx+6En4RlUEPm/sJdGgtxTJRNQGWuQ0AqxCA26WfJTbGm
         JQ2A==
X-Gm-Message-State: APjAAAWMFzMxBibGeMLcnCMTfZzDqGNJcODixZqPspEYZ35tHQsNwS/w
        go/rZWicA3qzQ+Vb1zZX604=
X-Google-Smtp-Source: APXvYqywsXHVLnsMztcWvA7KqJ8DMmhUpplqYZivz2ti2P2zqYn45dlCq2YJCfnJZLcDP4zxXsZSRw==
X-Received: by 2002:aa7:8202:: with SMTP id k2mr21313582pfi.31.1566157883100;
        Sun, 18 Aug 2019 12:51:23 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id y14sm23518034pfq.85.2019.08.18.12.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 12:51:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 01:21:15 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, jhubbard@nvidia.com
Cc:     jglisse@redhat.com, ira.weiny@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page()
 to put_user_page*()
Message-ID: <20190818195115.GB4487@bharath12345-Inspiron-5559>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing lkml.

On Mon, Aug 19, 2019 at 01:08:54AM +0530, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
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
>  drivers/misc/sgi-gru/grufault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 4b713a8..61b3447 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
>  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
>  		return -EFAULT;
>  	*paddr = page_to_phys(page);
> -	put_page(page);
> +	put_user_page(page);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
