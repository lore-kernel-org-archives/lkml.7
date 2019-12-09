Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2DE206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWanMLzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLIU7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:59:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41006 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:59:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so6291775plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpvdFtIrHJ93xklcEdnw8CFDEly30iA3CTZfPDFPOFw=;
        b=qWanMLzRxrW3n6Fdlwrrnacj/Q+HT8Y0+06jJAxIxLn6prT1m6Tx1De+VhQ6ANZtSd
         NBqoERjy/ErMXVA8b74zcBfzHr4faMk5wWsNCRVkVXilYtViEtJHza97svQEnB+H19ck
         L+CTptX4L2LazL3QGmg/1Mp9hvzKDcNIPPlhd+nyQwrCHaMSaCUQu8aDJUyDf5/icfEP
         Dnopl1VCrlUNvBBb1jeXojEHHlG5SV04c4x//RIgRUgw6nBGVdDi7Y/q6LoypxUsyc3O
         q7RXMJ8ZvGygcodRIwnSTiREyO5Syt9q1gJBu2U6ZXUK2uRreedoNZsx6Gni/ky1qvzg
         32Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpvdFtIrHJ93xklcEdnw8CFDEly30iA3CTZfPDFPOFw=;
        b=H8ohteJVRdttV4PbQ5WsGplX6i2BoSAiwO39efCCM5omNFR5bDtNRLVoBKXmtlKabJ
         EmPJBlQWjzXnvYszzKN/MjH5+2W0I/Mza2IlIzviCF01TQJRy2CZb/ct/xp0iKtU6wtq
         S0rkbCpQlODx3KFjlqNqG95HXq0oc0a0gKdAwUUhJcm2tFsd5gwgipsO/q1MAEAqroDZ
         PI4H3AhB6uY5XaDUUaN3sU44+69N+S99bt/ntDfgaSLMJtaKyeAhSi6a3A5S4Pyok3t4
         dBxMP7BfLJaKSScnUCtZ4hzImu5tnN79mpo5bcXitLphWJvZJhkbMwGIucecV2XWNXVo
         jrGg==
X-Gm-Message-State: APjAAAWHwO/ggh6LSOFGpBkbZdN3DdjPXZI2YSHWiAyIWlU6lSH2wBhZ
        GYlZhwXreET+XUCKu+3jqp7VcrFqDgAQDf+2AxCqug==
X-Google-Smtp-Source: APXvYqyFheMkQokdT7S76lx3rhO73BZgzMaXkYbn9bEc24l0zUWhn8sQs10dhQou/MWFZxgLNWPF4yVi1kUvKFdgtLU=
X-Received: by 2002:a17:90a:1505:: with SMTP id l5mr223430pja.73.1575925140481;
 Mon, 09 Dec 2019 12:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20191209205010.4115-1-natechancellor@gmail.com>
In-Reply-To: <20191209205010.4115-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 12:58:49 -0800
Message-ID: <CAKwvOdnNsWxY+ejhbToMqdzbWUP6dVP9=USZrW6neqHBoWA+2w@mail.gmail.com>
Subject: Re: [PATCH] mtd: onenand_base: Adjust indentation in onenand_read_ops_nolock
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 12:50 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/mtd/nand/onenand/onenand_base.c:1269:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         while (!ret) {
>         ^
> ../drivers/mtd/nand/onenand/onenand_base.c:1266:2: note: previous
> statement is here
>         if (column + thislen > writesize)
>         ^
> 1 warning generated.
>
> This warning occurs because there is a space before the tab of the while
> loop. There are spaces at the beginning of a lot of the lines in this
> block, remove them so that the indentation is consistent with the Linux
> kernel coding style and clang no longer warns.
>
> Fixes: a8de85d55700 ("[MTD] OneNAND: Implement read-while-load")
> Link: https://github.com/ClangBuiltLinux/linux/issues/794
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mtd/nand/onenand/onenand_base.c | 64 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 77bd32a683e1..c84ac749d70e 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -1266,26 +1266,26 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,

There is more in this function before this hunk that could be cleaned
up as well.

>         if (column + thislen > writesize)
>                 thislen = writesize - column;
>
> -       while (!ret) {
> -               /* If there is more to load then start next load */
> -               from += thislen;
> -               if (read + thislen < len) {
> +       while (!ret) {
> +               /* If there is more to load then start next load */
> +               from += thislen;
> +               if (read + thislen < len) {
>                         this->command(mtd, ONENAND_CMD_READ, from, writesize);
> -                       /*
> -                        * Chip boundary handling in DDP
> -                        * Now we issued chip 1 read and pointed chip 1
> +                       /*
> +                        * Chip boundary handling in DDP
> +                        * Now we issued chip 1 read and pointed chip 1
>                          * bufferram so we have to point chip 0 bufferram.
> -                        */
> -                       if (ONENAND_IS_DDP(this) &&
> -                           unlikely(from == (this->chipsize >> 1))) {
> -                               this->write_word(ONENAND_DDP_CHIP0, this->base + ONENAND_REG_START_ADDRESS2);
> -                               boundary = 1;
> -                       } else
> -                               boundary = 0;
> -                       ONENAND_SET_PREV_BUFFERRAM(this);
> -               }
> -               /* While load is going, read from last bufferRAM */
> -               this->read_bufferram(mtd, ONENAND_DATARAM, buf, column, thislen);
> +                        */
> +                       if (ONENAND_IS_DDP(this) &&
> +                           unlikely(from == (this->chipsize >> 1))) {
> +                               this->write_word(ONENAND_DDP_CHIP0, this->base + ONENAND_REG_START_ADDRESS2);
> +                               boundary = 1;
> +                       } else
> +                               boundary = 0;
> +                       ONENAND_SET_PREV_BUFFERRAM(this);
> +               }
> +               /* While load is going, read from last bufferRAM */
> +               this->read_bufferram(mtd, ONENAND_DATARAM, buf, column, thislen);
>
>                 /* Read oob area if needed */
>                 if (oobbuf) {
> @@ -1302,23 +1302,23 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
>                 }
>
>                 /* See if we are done */
> -               read += thislen;
> -               if (read == len)
> -                       break;
> -               /* Set up for next read from bufferRAM */
> -               if (unlikely(boundary))
> -                       this->write_word(ONENAND_DDP_CHIP1, this->base + ONENAND_REG_START_ADDRESS2);
> -               ONENAND_SET_NEXT_BUFFERRAM(this);
> -               buf += thislen;
> +               read += thislen;
> +               if (read == len)
> +                       break;
> +               /* Set up for next read from bufferRAM */
> +               if (unlikely(boundary))
> +                       this->write_word(ONENAND_DDP_CHIP1, this->base + ONENAND_REG_START_ADDRESS2);
> +               ONENAND_SET_NEXT_BUFFERRAM(this);
> +               buf += thislen;
>                 thislen = min_t(int, writesize, len - read);
> -               column = 0;
> -               cond_resched();
> -               /* Now wait for load */
> -               ret = this->wait(mtd, FL_READING);
> -               onenand_update_bufferram(mtd, from, !ret);
> +               column = 0;
> +               cond_resched();
> +               /* Now wait for load */
> +               ret = this->wait(mtd, FL_READING);
> +               onenand_update_bufferram(mtd, from, !ret);
>                 if (mtd_is_eccerr(ret))
>                         ret = 0;
> -       }
> +       }
>
>         /*
>          * Return success, if no ECC failures, else -EBADMSG
> --
> 2.24.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191209205010.4115-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
