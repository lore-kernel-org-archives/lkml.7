Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25794C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F047A2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="telupOue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFZMmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:42:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38099 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:42:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so1952625wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/89S57mpuhANqW7P0SQuk594h6BbB5jqPDSQ9Ds3jmA=;
        b=telupOueO49ezANV6MQ9EP6YOmXIXr3OEqq4W2xMbkHOazxjKzw6L5r+7c3baP7aQw
         Dy0tp1ggBs4bVBadpnGIQ9dkM+WLRGom/doa5TEgaRI2VYef8ZRiytfaVUaTg0G4BUzk
         0BbUel2tFKFOJ/xiwl2uTdiG1JgTb0beJ65TZRC+iDFzCizZ+mmDIQ77RutpM4d5mIC2
         1ygaaz5tnB7cv3SUQV0+W5NbCbzdpp/uc+FY51Dg6cGyY7geNRpWjX/Zxu+jj2xwhgoo
         4ub8y+pd1gCHMlwMy0SGFnSpG5VQMMbPdbx02mkw+e/jRv26oy7C4WlaZUjet4Za+u0Z
         avfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/89S57mpuhANqW7P0SQuk594h6BbB5jqPDSQ9Ds3jmA=;
        b=LlegymJm82vfgBmysYS1byaTw6YJbDcIAjFJbIC2MDaN4MoOG9b2omTxqksrrl0s35
         AjtO4o+NKc8gCgYUE855QWFk9ze5HOSr09ahetqbgTSF0CTB/s7wBfYfOiatfLrjrT9t
         IuJKfiNFYdUa3a18cLodK8lDso8Yw11LYJ50Pxprp8Yf/hQa7pMQexYdyndfvMZtc9rm
         z1WbBZOYO8dKmDzv/3KyHSl0ImXuiiTFkQ2g4CFRS8Fp1MQsjuSBgsmnsXKhiQz3IQkU
         jfQ/KxZs7EdXaPdJBY5p1b7lCjrTSO/bJcTMsNZC6p6p4H/VJ4V5hAbleib57vms5FH4
         J/Hw==
X-Gm-Message-State: APjAAAUjwuCnzSccmG6sDIWwkWZ+0nsyEXVOWe3pvoK7/ZwLK1TZ/o8L
        vZRXlu4lrTD6uzvPN9C72OkSC8Nt7eBr0GFMcd8=
X-Google-Smtp-Source: APXvYqzEfG/o6BpKhYhz+f0gbYiJr1+1nFyKt/FO8KIHz8nHEc7l11ldGst5RGwz25NqYdt6zog6+MR/Rj+QBG17bbo=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr2584418wmc.25.1561552926103;
 Wed, 26 Jun 2019 05:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190626070706.24930-1-Anson.Huang@nxp.com>
In-Reply-To: <20190626070706.24930-1-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 26 Jun 2019 15:41:54 +0300
Message-ID: <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
Subject: Re: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:06 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add i.MX SCU SoC's UID(unique identifier) support, user
> can read it from sysfs:
>
> root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> 7B64280B57AC1898
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/soc-imx-scu.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
> index 676f612..8d322a1 100644
> --- a/drivers/soc/imx/soc-imx-scu.c
> +++ b/drivers/soc/imx/soc-imx-scu.c
> @@ -27,6 +27,36 @@ struct imx_sc_msg_misc_get_soc_id {
>         } data;
>  } __packed;
>
> +struct imx_sc_msg_misc_get_soc_uid {
> +       struct imx_sc_rpc_msg hdr;
> +       u32 uid_low;
> +       u32 uid_high;
> +} __packed;
> +
> +static ssize_t soc_uid_show(struct device *dev,
> +                           struct device_attribute *attr, char *buf)
> +{
> +       struct imx_sc_msg_misc_get_soc_uid msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +       u64 soc_uid;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_MISC;
> +       hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
> +       hdr->size = 1;
> +
> +       /* the return value of SCU FW is in correct, skip return value check */

Why do you mean by "in correct"?
> +       imx_scu_call_rpc(soc_ipc_handle, &msg, true);
> +
> +       soc_uid = msg.uid_high;
> +       soc_uid <<= 32;
> +       soc_uid |= msg.uid_low;
> +
> +       return sprintf(buf, "%016llX\n", soc_uid);

snprintf?

> +}
> +
> +static DEVICE_ATTR_RO(soc_uid);
> +
>  static int imx_scu_soc_id(void)
>  {
>         struct imx_sc_msg_misc_get_soc_id msg;
> @@ -102,6 +132,11 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
>                 goto free_revision;
>         }
>
> +       ret = device_create_file(soc_device_to_device(soc_dev),
> +                                &dev_attr_soc_uid);
> +       if (ret)
> +               goto free_revision;
> +
>         return 0;
>
>  free_revision:
> --
> 2.7.4
>
