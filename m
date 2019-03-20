Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE34FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C5720850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7UfZTT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCTTMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:12:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42119 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfCTTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:12:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id j89so2954450edb.9;
        Wed, 20 Mar 2019 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TL+8kxvyagAH2+UQJWdEe0qicZtZcsa3JWStB/XAppQ=;
        b=U7UfZTT4afuFunh2nfXOy2fZPqzz2Z4fag1zu500d1CkGYOZoM62Pf9o0gCMpRzng3
         luZ3+drZbO9QsmaaoQT/fUHJR+2EoN5zo0WEz9Q8pDQeJDki01AJOu7mFzr2PNBK6zOw
         Ux26gNgKpAADo7KEMJb45+Vhq+ovbOq3bMJdE/LK++1oIGaeItHWtWpG5pXaqG4gbRZF
         EX59us9pI1pw44BN7AkgymAG2Rj91Gk+H5D7/3YHCNfBbLISCAMjEkv9HAfITMArkIrL
         b+9OKRgSKZJBhiUGMfUCc3eLi97huHMdG431E8xlvyumgHB9Xywrqkwmm4v1GR2tI6g9
         zR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TL+8kxvyagAH2+UQJWdEe0qicZtZcsa3JWStB/XAppQ=;
        b=pIQSNbT04FKNQh/DRKFCJ0qiPMYmOEflY96HiFRe+Gmwyvd5vfAgH8kgyv0MJj6y5D
         DcQKL182bplS2hYgqNOAYMAWeEfT4HmMH2ldCh6o2bkI3ZQxZM+4r659dW25NCTbhzG4
         wiJU77Fo2e0/7RLi0Aeuu8JpuG2LFeSb9GfMb7GfhYQAnvVQdYpRt/wdCXLdMngr75tB
         UbyBhHcLh1rRhPqLz3Qy0F1chEjfk8k1rUg6RElCgQDyVZdz86dck/AtcaBdNIPDYlJJ
         exAwyjE3Sy+QUweU976UyqqM/mNHVQTD2UrhFPMYWI8y1X7Qg69E4eNozdpBGJDZJ+eu
         gl1g==
X-Gm-Message-State: APjAAAU+PjPxuPOqlr7e/X0umN+2zV3nUb5QRb/RsieFNDB+cgqL2seO
        OWyFWMiRywilDxQg3aGFpR8=
X-Google-Smtp-Source: APXvYqzf8cvXyWRG3dRyFTgxZTUZNTzAEIsU7x/76Y/DWUmGs2BjAbWOlRKOtQ2AMkI1//tMn7Z9vg==
X-Received: by 2002:a17:906:3d41:: with SMTP id q1mr17659033ejf.71.1553109161579;
        Wed, 20 Mar 2019 12:12:41 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id i46sm894046ede.32.2019.03.20.12.12.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 12:12:40 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:12:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not
 NULL in ioc_general
Message-ID: <20190320191238.GF28744@archlinux-ryzen>
References: <20190307231839.3330-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307231839.3330-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:18:39PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/scsi/gdth.c:3662:6: warning: variable 'paddr' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
> 
> Don't attempt to call dma_free_coherent when buf is NULL (meaning that
> we never called dma_alloc_coherent and initialized paddr), which avoids
> this warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/402
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/gdth.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
> index e7f1dd4f3b66..0ca9b4393770 100644
> --- a/drivers/scsi/gdth.c
> +++ b/drivers/scsi/gdth.c
> @@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)
>  
>  	rval = 0;
>  out_free_buf:
> -	dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
> -			paddr);
> +	if (buf)
> +		dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len,
> +				  buf, paddr);
>  	return rval;
>  }
>   
> -- 
> 2.21.0
> 

Gentle ping (if there was a response to this, I didn't receive it). I
know I sent it in the middle of a merge window so I get if it slipped
through the cracks.

Thanks,
Nathan
