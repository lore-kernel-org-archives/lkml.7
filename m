Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82174C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47506206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uW7KM0kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLIVSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:18:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41822 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLIVSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:18:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so7736896pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sHrzINyOkYNGQIQ9XXaLWKRmil7He9/vhOTZUxiLLw=;
        b=uW7KM0kdul8udjx+VGXxVZkx3nIsZrbTLdHzXY6E6egwpRT1L3B8lKi8xx53yKTK5g
         c+s2jBB0b1IEkjhSwxqkUsz+gLchSAkiJyaBJXocl29G5xa1l+cK59XREHl4pxIXP9ZH
         PVF2TUcOJl0o4+42k4numsNxHmTiYIsoRguDOzbNI/yxZCQCC3qU2oDA3h2S1kjGoDNG
         ymJFefPu0zTuNc7eSegY4sWWQAEPFtKJat+jilFe2eTBqPsD2uEN/qKFFIGqn1K6K9Mm
         FuKgtcfk9+yFAzlJV+SguKDnWBov3wK1LWXoHGTbvNqyMCwKjMHMhuocdS+fCTBCi2AP
         qlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sHrzINyOkYNGQIQ9XXaLWKRmil7He9/vhOTZUxiLLw=;
        b=GV4sJ9Kw9m832tYwwvcQV8ZRYF2PKmtDHzj9V4H4XWKjT9qE65q+JyB0gaAwDRupCS
         hYOBs9BMobCLnbC0epQnPP7q4f8m9lYyzld1xeUHUwEagabNvjSashGSqmEp66XMC1UA
         mhF+4mbaE4NDWfNoGTImSKiR85WqBXixvYHTXAHVePDip1WsDLy9tXMKvvugoMn3OBUr
         6VOCS5olq6zbbN+zvHhDpc3r9ClvN6cwSRpU3zoH/SmEQbb+CFjq/jitY6JksCjNYrzP
         or1haetqJzmRebT7HgBVL++wkYwfdGtg98f2GkcGe1905NuquE9gpkSSi7dsun7Qat/0
         9Jeg==
X-Gm-Message-State: APjAAAXMH54aTfJ5IiQ8K8/GpAVC5MmmVxfUXxN/UYjH3tdBojIbIZ3E
        vdRKhOI4AolSEtR+eM1G89Q+e2MC823x+wg81giTjw==
X-Google-Smtp-Source: APXvYqxsdIDMfz7N8k5QAyut9TYtchslk0l1X3EQIaFJPMPBYjWBQrkZ0ibJBDa/mh0YI1EgXFRT3s5C4jgAa2w+vuk=
X-Received: by 2002:aa7:9151:: with SMTP id 17mr31823690pfi.3.1575926320653;
 Mon, 09 Dec 2019 13:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20191209205010.4115-1-natechancellor@gmail.com> <20191209210328.18866-1-natechancellor@gmail.com>
In-Reply-To: <20191209210328.18866-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 13:18:29 -0800
Message-ID: <CAKwvOd=GYWaoxQg_xH-gOHfqKeTZ_qaw35ucjFxcjd69AK+pyw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: onenand_base: Adjust indentation in onenand_read_ops_nolock
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

On Mon, Dec 9, 2019 at 1:04 PM Nathan Chancellor
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
>
> v1 -> v2:
>
> * Clean up the block before the one that warns, which was added as part
>   of the fixes commit (Nick).
>
>  drivers/mtd/nand/onenand/onenand_base.c | 80 ++++++++++++-------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 77bd32a683e1..13c69eb021a6 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -1248,44 +1248,44 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
>
>         stats = mtd->ecc_stats;
>
> -       /* Read-while-load method */
> +       /* Read-while-load method */
>
> -       /* Do first load to bufferRAM */
> -       if (read < len) {
> -               if (!onenand_check_bufferram(mtd, from)) {
> +       /* Do first load to bufferRAM */
> +       if (read < len) {
> +               if (!onenand_check_bufferram(mtd, from)) {
>                         this->command(mtd, ONENAND_CMD_READ, from, writesize);
> -                       ret = this->wait(mtd, FL_READING);
> -                       onenand_update_bufferram(mtd, from, !ret);
> +                       ret = this->wait(mtd, FL_READING);
> +                       onenand_update_bufferram(mtd, from, !ret);
>                         if (mtd_is_eccerr(ret))
>                                 ret = 0;
> -               }
> -       }
> +               }
> +       }
>
>         thislen = min_t(int, writesize, len - read);
>         column = from & (writesize - 1);
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

With this applied, I see a missed instance right here ^ (L1304).
In vim:


^ \t

In my .vimrc, I set:
https://github.com/nickdesaulniers/dotfiles/blob/37359525f5a403b4ed2d3f9d1bbbee2da8ec8115/.vimrc#L35-L41
to make tabs glaringly visible.

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
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191209210328.18866-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
