Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829FCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE320640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeUIdf7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfLBRGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:06:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44293 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLBRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:06:11 -0500
Received: by mail-io1-f68.google.com with SMTP id z23so39282iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcglRaGep1GKTanrUcF7KHchUGiMPbVv1u4sFWn/C04=;
        b=CeUIdf7zfJkvsqlV1h8nSKP+ClCgoWj5xy62q0+PEiDKFA2Z++Rp/4hquyCRzLmqz+
         /w3EEp7905sgnqlRvpttWRk6M2B8VtT0i50nh+QyiW9q7DeIwC9YYlCTN/GBZB+ku2LE
         Ur7QJZlAGnpNlkaXw8RI71YbNDNw+g5qNyDAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcglRaGep1GKTanrUcF7KHchUGiMPbVv1u4sFWn/C04=;
        b=llckw1OxeFwcGsftZJGcCM43nU8o1m5W89yp5vQyw+SnJ63jc3kBnQ1d4gvC9oHZZ6
         QTHp9eyyLNNa/H3tcCS1LVwaW6uudOZO4vD/YTOfWdKHAxbvR/IZhM3zOXI9KYGgBefg
         efPux6aEmfODxnkn/mx/mTH+0M1Gm76/TDMFlc3cUrmLIwvJu7LwdQFyVA4NUbm6gI0p
         +fxYvwvdfpXJ7X00s3tgAojvV+WHw8836k60k317CeEd88bs1JUa+qbAcA0R3JcngNtl
         KqbEtlGK3FbAj/RcLg94E6dzBB2JGaMDP3SDbSqWYLqRbAnupOn7/xHtz87CgOWDYQK6
         hOsQ==
X-Gm-Message-State: APjAAAX+tmjIB5eRhqqyiNH0ojR9Z48yyfVxbclpp6+IpZa4KCGp8qzs
        rA/OzkubAMhBgn4nsJNCSt51wtUtlq1Hk+bQzbTpjA==
X-Google-Smtp-Source: APXvYqxA8DLcRZblCZY7UyL1SA9gkefXuH49Fgg09Zfae13kxAmKaY7QDwjfrFl7LLEFEHeZBjNaScoCNLcsigxnDTc=
X-Received: by 2002:a6b:ec0f:: with SMTP id c15mr6648604ioh.149.1575306370163;
 Mon, 02 Dec 2019 09:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20191114235008.185111-1-evgreen@chromium.org> <20191114154903.v7.1.I0b2734bafaa1bd6831dec49cdb4730d04be60fc8@changeid>
In-Reply-To: <20191114154903.v7.1.I0b2734bafaa1bd6831dec49cdb4730d04be60fc8@changeid>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 2 Dec 2019 09:05:59 -0800
Message-ID: <CAPUE2utX4LC8k7o9_Dr8ZOOiMr3sVdNFH81S2fP_8+meBACLdA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] loop: Report EOPNOTSUPP properly
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Thu, Nov 14, 2019 at 3:50 PM Evan Green <evgreen@chromium.org> wrote:
>
> Properly plumb out EOPNOTSUPP from loop driver operations, which may
> get returned when for instance a discard operation is attempted but not
> supported by the underlying block device. Before this change, everything
> was reported in the log as an I/O error, which is scary and not
> helpful in debugging.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v7:
> - Use errno_to_blk_status() (Christoph)
>
> Changes in v6:
> - Updated tags
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Updated tags
>
> Changes in v2:
> - Unnested error if statement (Bart)
>
>  drivers/block/loop.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ef6e251857c8..6a9fe1f9fe84 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -461,7 +461,7 @@ static void lo_complete_rq(struct request *rq)
>         if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
>             req_op(rq) != REQ_OP_READ) {
>                 if (cmd->ret < 0)
> -                       ret = BLK_STS_IOERR;
> +                       ret = errno_to_blk_status(cmd->ret);
>                 goto end_io;
>         }
>
> @@ -1950,7 +1950,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
> 2.21.0
>
