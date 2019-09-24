Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3FDC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16AF207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1cLxsIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbfIXVnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:43:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45380 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388876AbfIXVnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:43:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so2865919oti.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jo7KMnGMlw2EvAK40FDpAYQt3DwapEeHVln6qFxCGxc=;
        b=n1cLxsIkHizCYgb2WjgS0IzXBOYov55QakxHt2w7cMSxtO6/WOAI3QHFpbjnP68FJw
         6uj1aWqVq/ixtT8dS7UqH5u57arqiPIDo+F29J1QZCkkR2aEpPUxYfYtO7pnxID+TNH7
         81C57L6h5RLkN74ENS4D9y+V8sE3x623d4Seo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jo7KMnGMlw2EvAK40FDpAYQt3DwapEeHVln6qFxCGxc=;
        b=Vps82Q8+CxeMLLOSXf4+R3q3BxdjTnYhKhhyFlrSdygcCBi94eSioNU5V4zLGg/N7B
         8YfPrHEYiz+7TUdKiDXORJtaG8QFXXWt/20M+lJ54RpWV5/CMpEWRvf0KMhNKun+tQnw
         b+/g6+BWDNm/XDgUFNUedK4wTX9QHsC8ujZUUWhzpBH/52Scz1Ht0lqHEOc7puF9NVu4
         8q+zsHokqnwLVgolLFXBcHKqs7nnB/uzTH3C4tz9F9Z45rzVANV211Si3lcuXuRiR5gP
         9z3Wuc9AW8IpJbOmU6a07iy2Gbwzj02JT3I16A3dgr+q7wdK53hcSG1jZ9R1t6U0ddHV
         OPnw==
X-Gm-Message-State: APjAAAVq8FVz/3murbbF1LUBbHg60j8ctqxpA8QJmJp7Rx0MYSSkiRkF
        PwLxzdakB3CH63dkphrL1oEwp/Vk3kE=
X-Google-Smtp-Source: APXvYqwIq7IdYpkLXWaEcWrmFVrEK6Xzrjx5wIkAtYR1qNP/jVnI8kmf7r1albt4jbfx9E9G+IVdOQ==
X-Received: by 2002:a9d:3675:: with SMTP id w108mr3842883otb.75.1569361383704;
        Tue, 24 Sep 2019 14:43:03 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id v24sm907954ote.23.2019.09.24.14.43.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 14:43:03 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id w144so3057623oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:43:03 -0700 (PDT)
X-Received: by 2002:aca:da87:: with SMTP id r129mr2005270oig.177.1569361382496;
 Tue, 24 Sep 2019 14:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190924203716.209420-1-campello@chromium.org>
In-Reply-To: <20190924203716.209420-1-campello@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 24 Sep 2019 15:42:51 -0600
X-Gmail-Original-Message-ID: <CAHX4x874q6smw3SSdUL1a7jvqBWfN2QaA3Z++fK+krAG_+=vTQ@mail.gmail.com>
Message-ID: <CAHX4x874q6smw3SSdUL1a7jvqBWfN2QaA3Z++fK+krAG_+=vTQ@mail.gmail.com>
Subject: Re: [PATCH v5] platform/chrome: wilco_ec: Add debugfs test_event file
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

Thanks Daniel, looks even better.

On Tue, Sep 24, 2019 at 2:37 PM Daniel Campello <campello@chromium.org> wrote:
>
> This change introduces a new debugfs file 'test_event' that when written
> to causes the EC to generate a test event.
> This adds a second sub cmd for the test event, and pulls out send_ec_cmd
> to be a common helper between h1_gpio_get and test_event_set.
>
> Signed-off-by: Daniel Campello <campello@chromium.org>

Reviewed-by: Nick Crews <ncrews@chromium.org>

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
> Changes for v5:
>   - Updated commit message to include more implementation details
>   - Restored removed empty line between functions
>
>  drivers/platform/chrome/wilco_ec/debugfs.c | 47 +++++++++++++++++-----
>  1 file changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index 8d65a1e2f1a3..df5a5f6c3ec6 100644
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
> @@ -196,13 +196,38 @@ static int h1_gpio_get(void *arg, u64 *val)
>         if (rs.status)
>                 return -EIO;
>
> -       *val = rs.val;
> +       *out_val = rs.val;
>
>         return 0;
>  }
>
> +/**
> + * h1_gpio_get() - Gets h1 gpio status.
> + * @arg: The wilco EC device.
> + * @val: BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL
> + */
> +static int h1_gpio_get(void *arg, u64 *val)
> +{
> +       return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> +}
> +
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
> @@ -226,6 +251,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
>         debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
>         debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
>                             &fops_h1_gpio);
> +       debugfs_create_file("test_event", 0200, debug_info->dir, ec,
> +                           &fops_test_event);
>
>         return 0;
>  }
> --
> 2.23.0.351.gc4317032e6-goog
>
