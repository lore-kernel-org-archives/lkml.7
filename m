Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F0CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F85420652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw4cF24v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCHVbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:31:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45172 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCHVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:31:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id f19so17495152eds.12;
        Fri, 08 Mar 2019 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RwsqCdHvR3rbiOCETjcmDCfMp3jBGc/+lyHTDiVUUJ8=;
        b=pw4cF24vO/hqrKcjVG8Z+vpxkpf62pd1fhKKUpDrQTUe1BK+7rxcA9hmKfaDIirDze
         wnJSuDdzlqu5UBI+Lq8BnHljzC1LfKFtIvgDLSeJadN+pDbgIaCXpKYFU5m5lHsRg97+
         9BYrh4NsoXCAHSUwmV2XVgv8STegPQwv1ZXTX56MREdsiholGTYB2DtwW/Ha+SLHe/NW
         4o9IwyFhgSWmzM/0BE6NW9LVGNVfq32YqYppGpoint/lRH46uc2SWBDSjBwZ20m7KP4b
         OcuCWpJoagt5B4B2NiaA/3WbuHf/U+kfP/g0hvBt9x2jqyGlEERww0TpVlxwc1uWQnsB
         ex8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwsqCdHvR3rbiOCETjcmDCfMp3jBGc/+lyHTDiVUUJ8=;
        b=MKujTHSDMbbtER3O4CHJN8hrnKnqzPt+947n20UhZmlRcbHcU1ylpdDJ2h1NnzjwiB
         8Yr7jMd4Qy0hUi4jG9YR9+ghTPs017/smdijaLYAKQi+JTLaKmmc26dH8+A5CGEZx+ZV
         VHREmGr6dt4F8vX02VRQf6tdx7QVQwOg1mxXj5rtN2Wa+YHc6gOqnOEAwYm5E0XMK6nF
         0nysYk9P8ZVnIQxCUy/7RuyXdiucAmLb3Rqv6/LSeLxdHWJR9PiZdLydyFmDEjnOL4mf
         iHa5f6RK+/IcY94ockhRi291wJjVtuULEXgASPFUdqxGTkrbMwztL0Q1Nj5LJQovtDZG
         Q9Rw==
X-Gm-Message-State: APjAAAWXJEL4XsY0zWZAuWdnCzvIA7N8LE1roXzaVt+mLidmo4NXn+IF
        XNm9azUo0SZwBLrM7YgdSPo=
X-Google-Smtp-Source: APXvYqyfcZ+P/67O+FDFj5UvG7yQYcnigWBpQ21woVLlkX0cVDF3ENSOVbI+0eVvTjFojrFSnDl63w==
X-Received: by 2002:a50:b3cd:: with SMTP id t13mr34053028edd.150.1552080706151;
        Fri, 08 Mar 2019 13:31:46 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v1sm1609810eja.7.2019.03.08.13.31.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Mar 2019 13:31:45 -0800 (PST)
Date:   Fri, 8 Mar 2019 14:31:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not
 NULL in ioc_general
Message-ID: <20190308213143.GA27509@archlinux-ryzen>
References: <20190307231839.3330-1-natechancellor@gmail.com>
 <CAKwvOd=PZUW1U0KiBgn8z8ReHeRX=s8xEtS7Gebf9-AXxguNNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=PZUW1U0KiBgn8z8ReHeRX=s8xEtS7Gebf9-AXxguNNQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:14:25PM -0800, Nick Desaulniers wrote:
> On Thu, Mar 7, 2019 at 3:19 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/scsi/gdth.c:3662:6: warning: variable 'paddr' is used
> > uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > Don't attempt to call dma_free_coherent when buf is NULL (meaning that
> > we never called dma_alloc_coherent and initialized paddr), which avoids
> > this warning.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/402
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/scsi/gdth.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
> > index e7f1dd4f3b66..0ca9b4393770 100644
> > --- a/drivers/scsi/gdth.c
> > +++ b/drivers/scsi/gdth.c
> > @@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)
> >
> >         rval = 0;
> >  out_free_buf:
> > -       dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
> > -                       paddr);
> > +       if (buf)
> > +               dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len,
> > +                                 buf, paddr);
> >         return rval;
> >  }
> >
> > --
> > 2.21.0
> >
> 
> Alternatively, paddr is a dma_addr_t defined in include/linux/types.h:
> 
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> typedef u64 dma_addr_t;
> #else
> typedef u32 dma_addr_t;
> #endif
> 
> Just initializing it to zero might be simpler than complicating the
> control flow of this function further. Thoughts?
> 
> diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
> index e7f1dd4f3b66..5a3f849ebf64 100644
> --- a/drivers/scsi/gdth.c
> +++ b/drivers/scsi/gdth.c
> @@ -3643,7 +3643,7 @@ static int ioc_general(void __user *arg, char *cmnd)
>         gdth_ioctl_general gen;
>         gdth_ha_str *ha;
>         char *buf = NULL;
> -       dma_addr_t paddr;
> +       dma_addr_t paddr = 0U;
>         int rval;
> 
>         if (copy_from_user(&gen, arg, sizeof(gdth_ioctl_general)))
> -- 
> Thanks,
> ~Nick Desaulniers

I suppose it depends on if it's okay to call dma_free_coherent without
dma_alloc_coherent. I did a scan of the tree before sending this out
and pretty much all sites that have error handling check that the third
parameter is not NULL before calling it.

I should have added Christoph to this thread when I initially sent it
out since commit 9f475ebff8e4 ("scsi: gdth: refactor ioc_general")
introduced this. Done now.

Cheers,
Nathan
