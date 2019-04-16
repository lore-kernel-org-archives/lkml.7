Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1544206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555426056;
	bh=Z4GWK4zt9/mb999OoqGoRlZSSvxM3Al0ieaQI3Id3P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZcqIJft5YbL+AnDUeIZ06z1ZmkZHZEJMQGKShckieOvJ3I9ebq46bOeJ2S3YmEMQ
	 ocOAvs6eWr2hDQf+6mjWb2UXVsr2rwtG8il14ksZ8DvHER1Wlb0hMtL5t9V/wjKrnm
	 XPG6n7uhizrqGit+Ci2/MSx1sPfz7oGJzP5AmPZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfDPOrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:47:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36523 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:47:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id k130so12306964qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0+l6FTGfnWimBOLodz1v2xMz2DpyjOFmTOvNncQbzjY=;
        b=poELPxgVPbPuCAlPCYM26IozQ75Zw3Ch/UM9jw9h8xeQWc9VJdftv0tl8P4rTMCIWV
         Bj65bpXeJQchx2RJHEyqAI6ALa9/SfWsRR/IyZnMNBAdRGpYaoL8yzwcBIDm26N1vfha
         NWRMvBC4Sg6wataQni3qdy9hv/sfAuuDdRRp7WKK9cftAMrRlRnmbo4jhWlZxScinRix
         Cp2fvgZm0nERtmIYPajLkq7lrrmcAupWB7b6gJGxCnOV6HE9/ZONHkp4wHYb7Hgff08Y
         9G1U/DJxNQhteFgYiYpNURVmmFqNjibk93wx8/MV6whqp/lu+RTJsoLlkLEM7AhDOXS3
         XrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0+l6FTGfnWimBOLodz1v2xMz2DpyjOFmTOvNncQbzjY=;
        b=VpcnB4+6GUBKmxxBq5nF3hF1vYDv86/D8v2x1DgoVkqsxbF8UJcO2MARo0Y2UNaHFo
         MW42zO1d67iVwYFtXSG6+G5lXXgfT8bMqD1lZr+p39oWfXviuPFNBWm6iXRuRcMLyvn8
         mngXSeqP90W2gM/IlxRzhEyHITfcF2H3SkmCV9YD8X/twUPyWeH7P7VhjGzNxlrxv0kp
         GKYyqV4N7MDmkeirD8eYzbzqZP8WYvPCI1/QrSMimckDfK0CIlPPs1SG5goBdySkWNRa
         JveYPNPlU09FgUxgiaI1M/ISZUgMg662I9NuznOsNbJGyZ4V0Tn2Y592+G49FRWtgKls
         Dv3Q==
X-Gm-Message-State: APjAAAVKa1FqMaEdxx8jOB9n5QJA6Ij3hOa+R6Z5GUYdd/6TDuRzc5pt
        Gc3bwgImRY6x0vnIJL+DauA=
X-Google-Smtp-Source: APXvYqw/wj/5juWRznW6fHEokbDAMM9Ov94hixd8y3cn6F0Gk5DEyunCKC7YQ4/xnAzde8HWKSkTnA==
X-Received: by 2002:a37:8bc7:: with SMTP id n190mr60402363qkd.108.1555426053539;
        Tue, 16 Apr 2019 07:47:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::c7e0])
        by smtp.gmail.com with ESMTPSA id j93sm32285151qtd.82.2019.04.16.07.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:47:32 -0700 (PDT)
Date:   Tue, 16 Apr 2019 07:47:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix barrier usage in __kernfs_new_node()
Message-ID: <20190416144617.GA349476@devbig004.ftw2.facebook.com>
References: <1555417031-27356-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555417031-27356-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:17:11PM +0200, Andrea Parri wrote:
> smp_mb__before_atomic() can not be applied to atomic_set().  Remove the
> barrier and rely on RELEASE synchronization.
> 
> Fixes: ba16b2846a8c6 ("kernfs: add an API to get kernfs node from inode number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>  fs/kernfs/dir.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index b84d635567d38..1e7a74b8e0647 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -650,11 +650,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	kn->id.generation = gen;
>  
>  	/*
> -	 * set ino first. This barrier is paired with atomic_inc_not_zero in
> +	 * set ino first. This RELEASE is paired with atomic_inc_not_zero in
>  	 * kernfs_find_and_get_node_by_ino
>  	 */
> -	smp_mb__before_atomic();
> -	atomic_set(&kn->count, 1);
> +	atomic_set_release(&kn->count, 1);

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
