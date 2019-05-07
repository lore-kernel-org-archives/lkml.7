Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD816C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E212054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHGTsQ3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfEGQzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:55:10 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36021 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEGQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:55:10 -0400
Received: by mail-it1-f196.google.com with SMTP id o190so9767094itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItNUzKiQktZ8tRatFK3EANWC6VYaqJXLrYpbccD+kyg=;
        b=OHGTsQ3xW+AeuFa3i/yt5q6LQHW/sLQPH7o2eGd7aSRSbmVeJiabwQjwY1JJR8K2ES
         fq6R+/cpFFMR5gKzerEGUiMhv1uVe5u4T6HhlMK7Arw+4c9j5o7NXSrN1pEclW993OcN
         wcskeVgwDuHn4H/uLAcsMIGG8qblNv+OJ0Tqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItNUzKiQktZ8tRatFK3EANWC6VYaqJXLrYpbccD+kyg=;
        b=fmONmGv4LyXdANscHrsP+CcL0SsY21L2wg3APF+1F4jg86CznY0HPdcbNg7zf5i3NC
         w5ax+oYOGzW6DV9VZ2M8jfVw6mJPzRsH0rnfBaYYiOwoh8Bh3EHfdXa6lrszyDF5UOlV
         Kadj+9kaLq0m9StpF5OgRtjSvIS3s2YyUzy9B5iCzQYehiMRfS0P2cywfBN6p7D35A+N
         AhY4mnYAYhTme4ySr6Plqe6Nq6Eh5H/SKqQWGsNLgXUnDFUEC6c4Ug4uPsngFVIsC7+y
         caqGn7qe5PSqXO02mVn0UnrjTV++W+A5Dz80Yij4RFrcGd+AE0609fLSW4I1mwfcYdY1
         LtAQ==
X-Gm-Message-State: APjAAAVuDk/rEIc5pYgekzyQIAhP+I6h/tq222RkHVQVun8VnYIy8zdj
        PUyZ078r6BhzDBsuAT+jDKH6x71Hkx/YojIHar/5sQ==
X-Google-Smtp-Source: APXvYqyq65GxMEAgdu0nfbFID23F8qPQmyxacCisKRD6UI64kiPDsyvRApQTomOFzIDkZYUwgk2e2se761+mN8NT9Ag=
X-Received: by 2002:a24:90f:: with SMTP id 15mr22727243itm.100.1557247624916;
 Tue, 07 May 2019 09:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190506182736.21064-1-evgreen@chromium.org> <20190506182736.21064-2-evgreen@chromium.org>
In-Reply-To: <20190506182736.21064-2-evgreen@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 7 May 2019 09:46:53 -0700
Message-ID: <CAPUE2utMUPmOntOsgV5+dOeQtVPu_LJ4vJCHD=G6L=h3cgakvA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] loop: Report EOPNOTSUPP properly
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, May 6, 2019 at 11:30 AM Evan Green <evgreen@chromium.org> wrote:
>
> Properly plumb out EOPNOTSUPP from loop driver operations, which may
> get returned when for instance a discard operation is attempted but not
> supported by the underlying block device. Before this change, everything
> was reported in the log as an I/O error, which is scary and not
> helpful in debugging.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Updated tags
>
> Changes in v2:
> - Unnested error if statement (Bart)
>
>  drivers/block/loop.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bf1c61cab8eb..bbf21ebeccd3 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -458,7 +458,9 @@ static void lo_complete_rq(struct request *rq)
>
>         if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
>             req_op(rq) != REQ_OP_READ) {
> -               if (cmd->ret < 0)
> +               if (cmd->ret == -EOPNOTSUPP)
> +                       ret = BLK_STS_NOTSUPP;
> +               else if (cmd->ret < 0)
>                         ret = BLK_STS_IOERR;
>                 goto end_io;
>         }
> @@ -1892,7 +1894,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>   failed:
>         /* complete non-aio request */
>         if (!cmd->use_aio || ret) {
> -               cmd->ret = ret ? -EIO : 0;
> +               if (ret == -EOPNOTSUPP)
> +                       cmd->ret = ret;
> +               else
> +                       cmd->ret = ret ? -EIO : 0;
>                 blk_mq_complete_request(rq);
>         }
>  }
> --
> 2.20.1
>
