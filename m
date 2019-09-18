Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C33C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC48C21924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nfn4vYYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfIRVpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:45:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46788 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388087AbfIRVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:45:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id k25so875180oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7dgmGEb7jiXcDVOoTR3Y60qv1W+YIvlHIEXooqB17k=;
        b=Nfn4vYYmqahbw5bImjcKKNhaG/umEZbk35DywdJMi8vFUMvoVbQL06VrdNGdNwpJAM
         q0TyWW1phTEmA+8WxooalcEWilGfeV+b9QN/Vpnw2mR3wcVegp0T2KS7FqygdQ9Sjc8+
         MIY/jDimM/1cJvKeEfud3N1KUM+igqZtQJBUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7dgmGEb7jiXcDVOoTR3Y60qv1W+YIvlHIEXooqB17k=;
        b=p7z0PsvnQoIdB3sbEV0Ta2nSQJ7kQGDXVKLXL+vseU4nKCdI3ZZcN8dkxwD2qjhYjN
         4Vm/eivWgjXZZKPrrlaQTd9nyk/h6I49xyJbglaizbT4zREGjlY2y2eWYoPrxmAqJ4yP
         kROEfC4ctRWjHZAavl+YnF9RSR+wAyQ+0a8h+HBGPie38vs9SNaV7aQXLLqArPUUTy5i
         fHOFkjWgPBG4LEKnl0dq8Cldko2ugpdeD2a+f30tBR79oHPaWcU/sxBZfCuG1kvzKpee
         RX0qt5pWwgmwwkBchDMEf38Exd2npqMbDWzIVbJnaPDl1GWgcUm4lexx6gHuZDhwYdrz
         Gd7Q==
X-Gm-Message-State: APjAAAXpw4N22cydcG78ozeW7/AgmebaO2pXhMKazbdQp9irRmk4bnsu
        RpXTRuwCjEduekYWq/A9x6WPgCB480g=
X-Google-Smtp-Source: APXvYqxnYcUT168L/hLkmc4rg+BR772gC3kdEcprHb2jlFRmKL19iMFwZzZScsGSIpAfCJWW1ErRGw==
X-Received: by 2002:aca:b902:: with SMTP id j2mr18474oif.169.1568843110117;
        Wed, 18 Sep 2019 14:45:10 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id t207sm2210887oif.11.2019.09.18.14.45.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 14:45:09 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id k20so971087oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:45:08 -0700 (PDT)
X-Received: by 2002:aca:da87:: with SMTP id r129mr19681oig.177.1568843108323;
 Wed, 18 Sep 2019 14:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190918204316.237342-1-campello@chromium.org>
In-Reply-To: <20190918204316.237342-1-campello@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 18 Sep 2019 15:44:57 -0600
X-Gmail-Original-Message-ID: <CAHX4x85JkU706D8mmMJ1Ahu2=8oSvU1o_sz3VeVHDD1BZ_fKMQ@mail.gmail.com>
Message-ID: <CAHX4x85JkU706D8mmMJ1Ahu2=8oSvU1o_sz3VeVHDD1BZ_fKMQ@mail.gmail.com>
Subject: Re: [PATCH v4] platform/chrome: wilco_ec: Add debugfs test_event file
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming that the Kbuild bot doesn't get mad about the format string
now, LGTM. Thanks Daniel!

Reviewed-by: Nick Crews <ncrews@chromium.org>

On Wed, Sep 18, 2019 at 2:43 PM Daniel Campello <campello@chromium.org> wrote:
>
> This change introduces a new debugfs file 'test_event' that when written
> to causes the EC to generate a test event.
>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
> Changes for v2:
>   - Cleaned up and added comments.
>   - Renamed and updated function signature from write_to_mailbox to
>     send_ec_cmd.
> Changes for v3:
>   - Switched NULL format string to empty format string
>   - Renamed val parameter on send_ec_cmd to out_val
> Changes for v4:
>   - Provided a format string to avoid -Wformat-zero-length warning
>
>  drivers/platform/chrome/wilco_ec/debugfs.c | 46 +++++++++++++++++-----
>  1 file changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index 8d65a1e2f1a3..ba86c38421ff 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -160,29 +160,29 @@ static const struct file_operations fops_raw = {
>
>  #define CMD_KB_CHROME          0x88
>  #define SUB_CMD_H1_GPIO                0x0A
> +#define SUB_CMD_TEST_EVENT     0x0B
>
> -struct h1_gpio_status_request {
> +struct ec_request {
>         u8 cmd;         /* Always CMD_KB_CHROME */
>         u8 reserved;
> -       u8 sub_cmd;     /* Always SUB_CMD_H1_GPIO */
> +       u8 sub_cmd;
>  } __packed;
>
> -struct hi_gpio_status_response {
> +struct ec_response {
>         u8 status;      /* 0 if allowed */
> -       u8 val;         /* BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL */
> +       u8 val;
>  } __packed;
>
> -static int h1_gpio_get(void *arg, u64 *val)
> +static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *out_val)
>  {
> -       struct wilco_ec_device *ec = arg;
> -       struct h1_gpio_status_request rq;
> -       struct hi_gpio_status_response rs;
> +       struct ec_request rq;
> +       struct ec_response rs;
>         struct wilco_ec_message msg;
>         int ret;
>
>         memset(&rq, 0, sizeof(rq));
>         rq.cmd = CMD_KB_CHROME;
> -       rq.sub_cmd = SUB_CMD_H1_GPIO;
> +       rq.sub_cmd = sub_cmd;
>
>         memset(&msg, 0, sizeof(msg));
>         msg.type = WILCO_EC_MSG_LEGACY;
> @@ -196,13 +196,37 @@ static int h1_gpio_get(void *arg, u64 *val)
>         if (rs.status)
>                 return -EIO;
>
> -       *val = rs.val;
> +       *out_val = rs.val;
>
>         return 0;
>  }
> +/**
> + * h1_gpio_get() - Gets h1 gpio status.
> + * @arg: The wilco EC device.
> + * @val: BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL
> + */
> +static int h1_gpio_get(void *arg, u64 *val)
> +{
> +       return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> +}
>
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
>
> +/**
> + * test_event_set() - Sends command to EC to cause an EC test event.
> + * @arg: The wilco EC device.
> + * @val: unused.
> + */
> +static int test_event_set(void *arg, u64 val)
> +{
> +       u8 ret;
> +
> +       return send_ec_cmd(arg, SUB_CMD_TEST_EVENT, &ret);
> +}
> +
> +/* Format is unused since it is only required for get method which is NULL */
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_test_event, NULL, test_event_set, "%llu\n");
> +
>  /**
>   * wilco_ec_debugfs_probe() - Create the debugfs node
>   * @pdev: The platform device, probably created in core.c
> @@ -226,6 +250,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
>         debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
>         debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
>                             &fops_h1_gpio);
> +       debugfs_create_file("test_event", 0200, debug_info->dir, ec,
> +                           &fops_test_event);
>
>         return 0;
>  }
> --
> 2.23.0.237.gc6a4ce50a0-goog
>
