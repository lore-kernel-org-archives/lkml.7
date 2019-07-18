Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D45C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF9321849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CJMMhnK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391404AbfGRVX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:23:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51573 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:23:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so26890780wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTeODaKvEbGduLnT+ZiEic+vhU663P9DSXpW7oWR/pw=;
        b=CJMMhnK8IRoy1n1wBMe5Ov6KSOA3KDOjIrKj8nHEnWaWiHZtIWpRWBlnhfteZw4rIV
         T3sFv460HqjsYtWfi53s5wZ/E8cX2SHKtfXdKIqre1+w74s/RTRBjRqpWH4VdylXkpfT
         50vycOhxUq1noQT40jkgcwXcIR69g5HZIhDq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTeODaKvEbGduLnT+ZiEic+vhU663P9DSXpW7oWR/pw=;
        b=AVAslPX6s/vzRCwqhjIBMhs/Q/2/65J5PpDcGbkKmqkfPT+I7vV9mP6JlCmwFQZH+Q
         qDQEX4iSQmzbHTQfxVxhfjEmbe+vLDSsxO6GwsXXUo9SgMvSg/37+H3F5KofySX5xDty
         Ih3YCnv3zLNJHkbEdp88v8sLGm0fUKFWYp6+MLnztE8ei4VElbI9P3/7AvHyT3kK97Q4
         2Oacaoo2u76KIaQ5U/aMUa6AgMzjLSp9vjVP+qKudfSygRpNNHO3kG7gubgItLv53R02
         d7E1XSI9DI6xXR+yDB5hlbqktJ0NMg4fnaBcHZME+B6LnIJGX0pXgEjeIAy+SiCGRlmK
         mePQ==
X-Gm-Message-State: APjAAAU5ObIoUBmcZCBffVeG0AqGKZ/olk+57Gd3X7BKAsFoArwTkufB
        ymi6CNDWv4G9QfdRjj6y5Q+v5sqrgP3Tr++KxmumJqusm26nfg==
X-Google-Smtp-Source: APXvYqwAhjJyh5fZpT0TCxCi5Ta9Up+ml1rkmJFpmvMC9hgvc2NjVzIIWY6MC3aLJALucAE1CD4TuqmdVkSABnN5L+E=
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr45376665wme.145.1563485002580;
 Thu, 18 Jul 2019 14:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-3-sudeep.holla@arm.com>
In-Reply-To: <20190708154730.16643-3-sudeep.holla@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 18 Jul 2019 17:23:10 -0400
Message-ID: <CA+-6iNzmkT26cEdpD_C=L0bJ4TOEZwGuakin+GR4brSjSETfRA@mail.gmail.com>
Subject: Re: [PATCH 02/11] firmware: arm_scmi: Segregate tx channel handling
 and prepare to add rx
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

On Mon, Jul 8, 2019 at 11:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The transmit(Tx) channels are specified as the first entry and the
> receive(Rx) channels are the second entry as per the device tree
> bindings. Since we currently just support Tx, index 0 is hardcoded at
> all required callsites.
>
> In order to prepare for adding Rx support, let's remove those hardcoded
> index and add boolean parameter to identify Tx/Rx channels when setting
> them up.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 33 ++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 0bd2af0a008f..f7fb6d5bfc64 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -112,7 +112,7 @@ struct scmi_chan_info {
>   * @version: SCMI revision information containing protocol version,
>   *     implementation version and (sub-)vendor identification.
>   * @minfo: Message info
> - * @tx_idr: IDR object to map protocol id to channel info pointer
> + * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>   * @protocols_imp: List of protocols implemented, currently maximum of
>   *     MAX_PROTOCOLS_IMP elements allocated by the base protocol
>   * @node: List head
> @@ -640,22 +640,26 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>         return 0;
>  }
>
> -static int scmi_mailbox_check(struct device_node *np)
> +static int scmi_mailbox_check(struct device_node *np, int idx)
>  {
> -       return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, NULL);
> +       return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> +                                         idx, NULL);
>  }
>
> -static inline int
> -scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
> +static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
> +                               int prot_id, bool tx)
>  {
> -       int ret;
> +       int ret, idx;
>         struct resource res;
>         resource_size_t size;
>         struct device_node *shmem, *np = dev->of_node;
>         struct scmi_chan_info *cinfo;
>         struct mbox_client *cl;
>
> -       if (scmi_mailbox_check(np)) {
> +       /* Transmit channel is first entry i.e. index 0 */
> +       idx = tx ? 0 : 1;
> +
> +       if (scmi_mailbox_check(np, idx)) {
>                 cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
>                 goto idr_alloc;
>         }
> @@ -669,11 +673,11 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
>         cl = &cinfo->cl;
>         cl->dev = dev;
>         cl->rx_callback = scmi_rx_callback;
> -       cl->tx_prepare = scmi_tx_prepare;
> +       cl->tx_prepare = tx ? scmi_tx_prepare : NULL;
>         cl->tx_block = false;
> -       cl->knows_txdone = true;
> +       cl->knows_txdone = tx;
>
> -       shmem = of_parse_phandle(np, "shmem", 0);
> +       shmem = of_parse_phandle(np, "shmem", idx);
Hi Sudeep,

You can't see it in the diff but you have two error messages that use
"Tx"; should this be changed to "Tx/Rx"?

Jim
>         ret = of_address_to_resource(shmem, 0, &res);
>         of_node_put(shmem);
>         if (ret) {
> @@ -688,8 +692,7 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
>                 return -EADDRNOTAVAIL;
>         }
>
> -       /* Transmit channel is first entry i.e. index 0 */
> -       cinfo->chan = mbox_request_channel(cl, 0);
> +       cinfo->chan = mbox_request_channel(cl, idx);
>         if (IS_ERR(cinfo->chan)) {
>                 ret = PTR_ERR(cinfo->chan);
>                 if (ret != -EPROBE_DEFER)
> @@ -721,7 +724,7 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
>                 return;
>         }
>
> -       if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id)) {
> +       if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id, true)) {
>                 dev_err(&sdev->dev, "failed to setup transport\n");
>                 scmi_device_destroy(sdev);
>                 return;
> @@ -741,7 +744,7 @@ static int scmi_probe(struct platform_device *pdev)
>         struct device_node *child, *np = dev->of_node;
>
>         /* Only mailbox method supported, check for the presence of one */
> -       if (scmi_mailbox_check(np)) {
> +       if (scmi_mailbox_check(np, 0)) {
>                 dev_err(dev, "no mailbox found in %pOF\n", np);
>                 return -EINVAL;
>         }
> @@ -769,7 +772,7 @@ static int scmi_probe(struct platform_device *pdev)
>         handle->dev = info->dev;
>         handle->version = &info->version;
>
> -       ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE);
> +       ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE, true);
>         if (ret)
>                 return ret;
>
> --
> 2.17.1
>
