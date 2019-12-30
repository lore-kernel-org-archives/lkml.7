Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22102C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86FE206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmO0ccq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfL3Tqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:46:32 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45965 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Tqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:46:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so7361835oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nhLBznDpPIkcA99MosSeV1eijWyqBw1QQ9xRXNnYWQY=;
        b=NmO0ccq9LT71pij3I3wXVtkLl7bnRikqwOagCbEDuQ3z4KX2e9cfQBEuxfG1dGfJll
         LTZmZMCcGour2Lo01PrTULZKJBnAAIqtbY1vc4S0vMmstsMJdIDZbbn+0LnObUG0NVwo
         7GM6G2cOL6mfs5o6PMkzDqio3xhTbvZl+UxtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhLBznDpPIkcA99MosSeV1eijWyqBw1QQ9xRXNnYWQY=;
        b=r2CSMPANIH73kgufFIvpBIiScjMEClw2YiI2+ZQVekJBTJ43ziP+4Rn5ByIrWIkziK
         KphgY0fWVchElQx+Bo7ckZpRN0YY/rZQ5G5Xb+OZz0IeZBHbmpWgJV7jeykb96yE8FwO
         e9S7D4LBkkE0duBOWhe9LryeJ9SFKGn1WRouocza/MkdHAebz0H8FPwlFkGE33inZsY+
         SnJHhfD4A/OP3JeiwWksbXvKGzZ/9CjgTQD/+aIAyiRKi1sIIYFibnGqMO7Y28cmQNej
         nDK/DujQ/oNwU5BfDiUWo1oTsrFkBCOIxlL4grpMg8Z/fcP69uDWzLLrv6lNS4IwKOes
         LOqg==
X-Gm-Message-State: APjAAAWfw/0pjERPPtep8K9WblsEe4orQyYTGOtv2AaWoTO7ThIGUBJZ
        zm/y/UyiERW98nRcEKHU8pewiA==
X-Google-Smtp-Source: APXvYqyGIu/RzAxD1rIwLNfFj7XiiK45wLcBNxaGCNxUZ8fr7pV+cv1nJjkKw1U4StoTDg7RZB6YPA==
X-Received: by 2002:aca:43c1:: with SMTP id q184mr296079oia.116.1577735191691;
        Mon, 30 Dec 2019 11:46:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c11sm1194282oth.81.2019.12.30.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:46:30 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:46:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Anton Vorontsov <anton.vorontsov@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, emamd001@umn.edu
Subject: Re: [PATCH] pstore/ram: Fix memory leak in persistent_ram_new
Message-ID: <201912301144.7CCEF23E@keescook>
References: <20191211191353.14385-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211191353.14385-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 01:13:51PM -0600, Navid Emamdoost wrote:
> In the implementation of persistent_ram_new(), if the allocation for prz
> fails, "label" should be released as part of error handling. Release the
> label via kfree().
> 
> Fixes: 8cf5aff89e59 ("staging: android: persistent_ram: Introduce persistent_ram_new()")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

You're right about the need to clean up the allocation, but I think it's
on the caller to do this, not persistent_ram_new(), in case a const char
string is used in the future.

I think the "Fixes" should also be:
Fixes: 1227daa43bce ("pstore/ram: Clarify resource reservation labels")

-Kees

> ---
>  fs/pstore/ram_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 8823f65888f0..7d2d86999211 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -568,6 +568,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
>  	prz = kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
>  	if (!prz) {
>  		pr_err("failed to allocate persistent ram zone\n");
> +		kfree(label);
>  		goto err;
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
