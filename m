Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63629C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3117B20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxG002Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCHVOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:14:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39998 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHVOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:14:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so15020038pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRWE1lHX+Mj/xh6hvsg2z7vx/3R/zckb6ztaJjp++DU=;
        b=ZxG002Quuvow3SIBk9BMCJ7y/395zpH+Kx08JHBTMymrinwD7nww/nIKEtHQCmH5hi
         zjd+AzTesnM6FVeklfHbsbTxsaBtA4nsJ2aVSqqaGVOCAdkomC59pEM+/zMRofzAHuDj
         zLuozzNdonQa2tALWmWAiVjI+yuBuw/dJNUmxlE10if/NTXD7c/6Fo/ibUWmR+UiOZsn
         pFDdSEiWlXiz8eOVx/5+PY4c6cxjWXIa530f1LjOIeo0Tisj5VkrMTSULBg0cKeOX0Bc
         SfekJNxlK5eE9Xp5sAuhZ8XrnwrUJcF32bkkuBCqUl08Es0w3hwEeb+7dZWt4cY4YYdZ
         xQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRWE1lHX+Mj/xh6hvsg2z7vx/3R/zckb6ztaJjp++DU=;
        b=lYU3RuwLzzzuV3ACbD0DNE7wCXfbR/Ts2ivVQDw/eEARKa7eVrgrN49k29XeITX260
         fQKI9HeMHhuuZGlgU6gAihOIVcsaX+c8J0nB6LLr99fdlNuXzyfZBjSD8E2pf8Ti6nog
         ITHoU1nUOS0fgvWUgnHHaGDJs6G3R8ZkQBa/1Z7xUWcKFCSt1YDtXakobpEYZ9PlK5u5
         xpaz9Hhu9k+POULQh9o/PJ0IR4iUixdIKa8qrpBoRqEYVfB8duABR3j75iTrlhKw4BJ/
         OFQyGG8J79gwH8wERVaQUfQuco6HhDB1Zs5oZR1CUE7KpoIwjb2RDnSxX0XbuyNEdOzd
         oWZA==
X-Gm-Message-State: APjAAAVsJM+aJvDMxJ+C+sG17gGx3i237eGl17/RsUVgSGCvLvq6vF/X
        uqKLUdsjKYKWUltMnd3g0ALJwC345Dv+3sUPTB35Sc18n4o=
X-Google-Smtp-Source: APXvYqzeM7GWxmzgNuQA1s5rVsn7Y2Z7pAYn+4Sf9TOCiIUf/V4C88j0YgtfbuAycxj7NYqneOykQ7jAuj16f23UATc=
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr9224697plc.238.1552079676001;
 Fri, 08 Mar 2019 13:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20190307231839.3330-1-natechancellor@gmail.com>
In-Reply-To: <20190307231839.3330-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 13:14:25 -0800
Message-ID: <CAKwvOd=PZUW1U0KiBgn8z8ReHeRX=s8xEtS7Gebf9-AXxguNNQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not
 NULL in ioc_general
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:19 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
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
>         rval = 0;
>  out_free_buf:
> -       dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
> -                       paddr);
> +       if (buf)
> +               dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len,
> +                                 buf, paddr);
>         return rval;
>  }
>
> --
> 2.21.0
>

Alternatively, paddr is a dma_addr_t defined in include/linux/types.h:

#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
typedef u64 dma_addr_t;
#else
typedef u32 dma_addr_t;
#endif

Just initializing it to zero might be simpler than complicating the
control flow of this function further. Thoughts?

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index e7f1dd4f3b66..5a3f849ebf64 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -3643,7 +3643,7 @@ static int ioc_general(void __user *arg, char *cmnd)
        gdth_ioctl_general gen;
        gdth_ha_str *ha;
        char *buf = NULL;
-       dma_addr_t paddr;
+       dma_addr_t paddr = 0U;
        int rval;

        if (copy_from_user(&gen, arg, sizeof(gdth_ioctl_general)))
-- 
Thanks,
~Nick Desaulniers
