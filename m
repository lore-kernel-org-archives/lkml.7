Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCACC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EECA208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MsCyNc81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbfGRVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:25:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33730 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:25:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so30239832wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fE3j1M48YetGYsmwun7MuCaX2WiWt2pV6+i9IwrmXBQ=;
        b=MsCyNc81dVMUW7L4PkKgUMpEODm8R/N2VxLIJoj3QA5Uzt7SdUpc3IUaygZheC7BTP
         gb/d8ol90QGVKJoKw2NKGSxJH0nMDDJUjBXdmqaH+m43x43Snn4ZzNGO5cPfFSpjKfy+
         3fBSWWuDNygK9I3gso9DDbQRfI9S3O8m3AUNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fE3j1M48YetGYsmwun7MuCaX2WiWt2pV6+i9IwrmXBQ=;
        b=X1pKmU3cH/FmuBgPRPXRqy+M1NnzoObYS/jyUzAM7h+vksSkzNx0t5R6EljRZG7ILA
         DRnfZxNgl8bQYs3jLgCLVmlL0AeRfmlcjgzsgfqQFhKY0v3zg4oVQ5pJtkxYHM0ueUVy
         vuci24gPSy89fazb9b62tEawDEQf3Ckh2cSNcJzBNEjE9mKSDTPXI/V33i5rYmajCpbQ
         1D/wvKIcYVKe6ALfqS5UPIGrH1GFD8s35JPF60yDgPACxOgl3d1Q0IWrfTcKcV+ax4oF
         2f1w/1Wekrmfhpw3qNGwmpjMgv1sNkIxL925u+YqpQpwwm7qyF9Xgr7o4cZDQybSLx+C
         b3Mg==
X-Gm-Message-State: APjAAAXr8Gsl9jamQ+bkhw5leBFlbNQHDFUg7vOkI4KGhqD3Rw7A9PFw
        Wep7vOJgUvedBsH5IEhcx9laL72ZcTT5Ah5yq8ICGw==
X-Google-Smtp-Source: APXvYqxUtlLnEY0IJUuKJ9otuknVQwWWrY+C3ugexaAka+HKnnm59voz4bDMgxFTsE8EPefj542ZAn6ubeRBZwjh9NU=
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr49218665wrm.315.1563485100052;
 Thu, 18 Jul 2019 14:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-6-sudeep.holla@arm.com>
In-Reply-To: <20190708154730.16643-6-sudeep.holla@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 18 Jul 2019 17:24:48 -0400
Message-ID: <CA+-6iNzgXj5iF5k73s6x0Ot4Wcx7UrkQpStUOyNFmBfyTJMKDw@mail.gmail.com>
Subject: Re: [PATCH 05/11] firmware: arm_scmi: Add receive buffer support for notifications
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

Would it make sense to save commits that support notifications for
when you actually support them (correct me if I wrong, but this
commit-set does not implement notifications.

Jim

On Mon, Jul 8, 2019 at 11:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> With all the plumbing in place, let's just add the separate dedicated
> receive buffers to handle notifications that can arrive asynchronously
> from the platform firmware to OS.
>
> Also add check to see if the platform supports any receive channels
> before allocating the receive buffers.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 1a7ffd3f8534..eb5a2f271806 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -112,6 +112,7 @@ struct scmi_chan_info {
>   * @version: SCMI revision information containing protocol version,
>   *     implementation version and (sub-)vendor identification.
>   * @tx_minfo: Universal Transmit Message management info
> + * @rx_minfo: Universal Receive Message management info
>   * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>   * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>   * @protocols_imp: List of protocols implemented, currently maximum of
> @@ -125,6 +126,7 @@ struct scmi_info {
>         struct scmi_revision_info version;
>         struct scmi_handle handle;
>         struct scmi_xfers_info tx_minfo;
> +       struct scmi_xfers_info rx_minfo;
>         struct idr tx_idr;
>         struct idr rx_idr;
>         u8 *protocols_imp;
> @@ -615,13 +617,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
>         return 0;
>  }
>
> -static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +static int __scmi_xfer_info_init(struct scmi_info *sinfo, bool tx)
>  {
>         int i;
>         struct scmi_xfer *xfer;
>         struct device *dev = sinfo->dev;
>         const struct scmi_desc *desc = sinfo->desc;
> -       struct scmi_xfers_info *info = &sinfo->tx_minfo;
> +       struct scmi_xfers_info *info = tx ? &sinfo->tx_minfo : &sinfo->rx_minfo;
>
>         /* Pre-allocated messages, no more than what hdr.seq can support */
>         if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
> @@ -656,6 +658,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>         return 0;
>  }
>
> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +{
> +       int ret = __scmi_xfer_info_init(sinfo, true);
> +
> +       if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
> +               ret = __scmi_xfer_info_init(sinfo, false);
> +
> +       return ret;
> +}
> +
>  static int scmi_mailbox_check(struct device_node *np, int idx)
>  {
>         return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> @@ -792,10 +804,6 @@ static int scmi_probe(struct platform_device *pdev)
>         info->desc = desc;
>         INIT_LIST_HEAD(&info->node);
>
> -       ret = scmi_xfer_info_init(info);
> -       if (ret)
> -               return ret;
> -
>         platform_set_drvdata(pdev, info);
>         idr_init(&info->tx_idr);
>         idr_init(&info->rx_idr);
> @@ -808,6 +816,10 @@ static int scmi_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       ret = scmi_xfer_info_init(info);
> +       if (ret)
> +               return ret;
> +
>         ret = scmi_base_protocol_init(handle);
>         if (ret) {
>                 dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> --
> 2.17.1
>
