Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D8C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9288B204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DgfDvK7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391297AbfGRViX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:38:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43965 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:38:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so30169656wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+FGbujzBVRUzZS3EuvBY5bVX5YXWlOtTiKoMmRz84Y=;
        b=DgfDvK7FGxLI/O77JY/2aKRy1KXlsW37LgMzM6vJNeTtF5x85mBfk54kbS2ywxYNAz
         6jHI038QczhddKegJule4a0vq8ElgD2SIRgMebNFKLxQqkp01dxgn8cyXsYpcG+x9Asg
         egRrh1gHYjPXrJS3bBLQ0BNATWFeR0u2ZE3KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+FGbujzBVRUzZS3EuvBY5bVX5YXWlOtTiKoMmRz84Y=;
        b=YUv7e5cE//96MD+Tm3IZ1OEDKQdbtgCqbzdpYSHR7B7xZLG9Cg6QEHxh8DPK8XGw/s
         KR26PMHV8ieP9RiAJ+PrVrsKX0Do1aprhi9TN/xZtUHkrkhNxH266GaUYixNs5OqbLVV
         A0kw3I+gweCHF+1P4yth/tXH5Q2jpGQDgm6Xs4UDpyrxSH3+rINnjFFjXjemhmfOBpHJ
         Cj9zzM2Nd4Fq9Wo+6ZU/7jysmM799dnRICJsLJ8XyIBpTVWX7riWvhD14aePL6+cblUW
         pipWr9bkzJ3BYckQuvtjM1pcjvfR6/ELG9dD/Vehs9A8t2P7ytMMi2imkIrl8lOZYkGM
         q9yw==
X-Gm-Message-State: APjAAAUorhgzSohg4r4aaiVSz+rqUH/n/w4kdE+G8zT8etDADdWppUdO
        MOYu5CAmm4nhwMOhxaVq3kWNQ86QgXT3TupRtVCWFw==
X-Google-Smtp-Source: APXvYqxEvfjjloxKtJ0h+W7vsorcEIGkrZ172Ps6WcXS/yeZ8sglb8k+n2yK4Ev7ZboM9yozm6Qc82RKhGWhXeyKYZQ=
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr1671177wrt.295.1563485899977;
 Thu, 18 Jul 2019 14:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-8-sudeep.holla@arm.com>
In-Reply-To: <20190708154730.16643-8-sudeep.holla@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 18 Jul 2019 17:38:06 -0400
Message-ID: <CA+-6iNyFToC8QSf042OcqvAStvaF=voy_ohayvQBVCppgtyD7A@mail.gmail.com>
Subject: Re: [PATCH 07/11] firmware: arm_scmi: Add support for asynchronous
 commands and delayed response
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Just a comment in general.  The asynchronous commands you are
implementing are not really asynchronous to the caller.  Yes it is is
"async" at the low level, but there is no way to use scmi_do_xfer() or
scmi_do_xfer_with_response()  and have the calling thread be able to
continue on in parallel with the command being processed by the
platform.   This will limit the types of applications that can use
SCMI (perhaps this is intentional).  I was hoping that true async
would be possible, and that the caller could also register a callback
function to be invoked  when the command was completed.  Is this
something that may be added in the future?  It does overlap with
notifications, because with those messages you will need some kind of
callback or handler thread.

BTW, if scmi_do_xfer_with_response()  returns --ETIMEDOUT the caller
has no way of knowing whether it was the command ack timeout or the
command execution timeout.

Regards,
Jim

On Mon, Jul 8, 2019 at 11:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Messages that are sent to platform, also known as commands and can be:
>
> 1. Synchronous commands that block the channel until the requested work
> has been completed. The platform responds to these commands over the
> same channel and hence can't be used to send another command until the
> previous command has completed.
>
> 2. Asynchronous commands on the other hand, the platform schedules the
> requested work to complete later in time and returns almost immediately
> freeing the channel for new commands. The response indicates the success
> or failure in the ability to schedule the requested work. When the work
> has completed, the platform sends an additional delayed response message.
>
> Using the same transmit buffer used for sending the asynchronous command
> even for the delayed response corresponding to it simplifies handling of
> the delayed response. It's the caller of asynchronous command that is
> responsible for allocating the completion flag that scmi driver can
> complete to indicate the arrival of delayed response.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h |  6 ++++-
>  drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 4349d836b392..f89fa3f74a6f 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -84,17 +84,21 @@ struct scmi_msg {
>   * @rx: Receive message, the buffer should be pre-allocated to store
>   *     message. If request-ACK protocol is used, we can reuse the same
>   *     buffer for the rx path as we use for the tx path.
> - * @done: completion event
> + * @done: command message transmit completion event
> + * @async: pointer to delayed response message received event completion
>   */
>  struct scmi_xfer {
>         struct scmi_msg_hdr hdr;
>         struct scmi_msg tx;
>         struct scmi_msg rx;
>         struct completion done;
> +       struct completion *async_done;
>  };
>
>  void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
>  int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
> +int scmi_do_xfer_with_response(const struct scmi_handle *h,
> +                              struct scmi_xfer *xfer);
>  int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
>                        size_t tx_size, size_t rx_size, struct scmi_xfer **p);
>  int scmi_handle_put(const struct scmi_handle *handle);
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index b384c818d8dd..049bb4af6b60 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -347,6 +347,8 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
>   */
>  static void scmi_rx_callback(struct mbox_client *cl, void *m)
>  {
> +       u8 msg_type;
> +       u32 msg_hdr;
>         u16 xfer_id;
>         struct scmi_xfer *xfer;
>         struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
> @@ -355,7 +357,12 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
>         struct scmi_xfers_info *minfo = &info->tx_minfo;
>         struct scmi_shared_mem __iomem *mem = cinfo->payload;
>
> -       xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
> +       msg_hdr = ioread32(&mem->msg_header);
> +       msg_type = MSG_XTRACT_TYPE(msg_hdr);
> +       xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
> +
> +       if (msg_type == MSG_TYPE_NOTIFICATION)
> +               return; /* Notifications not yet supported */
>
>         /* Are we even expecting this? */
>         if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
> @@ -368,7 +375,11 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
>         scmi_dump_header_dbg(dev, &xfer->hdr);
>
>         scmi_fetch_response(xfer, mem);
> -       complete(&xfer->done);
> +
> +       if (msg_type == MSG_TYPE_DELAYED_RESP)
> +               complete(xfer->async_done);
> +       else
> +               complete(&xfer->done);
>  }
>
>  /**
> @@ -472,6 +483,34 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>         return ret;
>  }
>
> +#define SCMI_MAX_RESPONSE_TIMEOUT      (2 * MSEC_PER_SEC)
> +
> +/**
> + * scmi_do_xfer_with_response() - Do one transfer and wait until the delayed
> + *     response is received
> + *
> + * @handle: Pointer to SCMI entity handle
> + * @xfer: Transfer to initiate and wait for response
> + *
> + * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
> + *     return corresponding error, else if all goes well, return 0.
> + */
> +int scmi_do_xfer_with_response(const struct scmi_handle *handle,
> +                              struct scmi_xfer *xfer)
> +{
> +       int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
> +       DECLARE_COMPLETION_ONSTACK(async_response);
> +
> +       xfer->async_done = &async_response;
> +
> +       ret = scmi_do_xfer(handle, xfer);
> +       if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
> +               ret = -ETIMEDOUT;
> +
> +       xfer->async_done = NULL;
> +       return ret;
> +}
> +
>  /**
>   * scmi_xfer_get_init() - Allocate and initialise one message for transmit
>   *
> --
> 2.17.1
>
