Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F1EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E9323BCC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P05Kj5Q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfE2PNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:13:04 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37932 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2PND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:13:03 -0400
Received: by mail-yb1-f196.google.com with SMTP id x7so922022ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpwyIulcRQkY84yGPtCOtrEz0M0rIMePfKkpqEjIVgA=;
        b=P05Kj5Q85eCIDmbWrMpIsrPr79Ex0qm2tSzDKgxacdZ5//KuFT2eGsyCCSN6Zv6zQx
         Emo1jmdqF7egaW43NvtCGjnygZE7qmLPdlUA7FFVpcCS0OBDwd0ND2HPBvn3L8/+7zlx
         oHmM4OZTklxY3EpKfGiCCVAbFT5UfbYHwGtJlg9IO2r73ZHBdaFkSht4BYtpqi/61aUr
         RUk27zQoNRIxbEx0HFLKkpQtvAo69083yfIx0BtTQ9xtjbUF7oX6UOs++OpwrJHdbhXg
         sGvJyfYpoPLuB8C7b/qePhz8LT0+8sfZ7V2MuONfXCLlNDdoHB3BTDs45VUkL7IAzgNg
         rllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpwyIulcRQkY84yGPtCOtrEz0M0rIMePfKkpqEjIVgA=;
        b=C/G5202yljz7jiGEuj/wZjKtYZOZUlgpa9SmDeHiiSKhX48CLJp9I1zzsLQn3Dbiwn
         gvq5mpFA/rSWbqImtK63ZSlBwB4oDBQPrC6hV2JqCEzxcvVE7c11XcmoeoQvsRawC1MD
         Gbw+xmJD2mTv3kWWuxsoFTsrmIDC1kRDiiU4MA45d3Ftyitt+rdeubE15wkkzHiKdOC2
         SoU2gpR7ZITTKyns7omNYDAFYZnPWbnbxosuE2hYLQdtwrMo2bPAZ7gHIJqet3tnA8k0
         IAJj5wOPgnbrOgFfs9V1rgvX34y+yZd+ui9xu6CcMu8xgCpL6WRtpC9nQ0mpOzcO0ZHz
         DnIg==
X-Gm-Message-State: APjAAAVCeM6tuOlKzXVs/1Qs8PDQukiQfQD9v8DHzl6F1yTeiYNOuzQO
        7WswlxxkECHXhNT+FJAbmJEUZT0h+v3duC9xNbVGUg==
X-Google-Smtp-Source: APXvYqwm/J4O6GVQ0wnM1Dnl8TVOU/Y00HBnm86LMRHO4ZASojXJpmQhzftpxWsmB8kSEnd2QPqCbK3B8oK1R2Xb1+M=
X-Received: by 2002:a25:5ed4:: with SMTP id s203mr9489716ybb.226.1559142777493;
 Wed, 29 May 2019 08:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190529150749.8032-1-yuehaibing@huawei.com>
In-Reply-To: <20190529150749.8032-1-yuehaibing@huawei.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 29 May 2019 08:12:46 -0700
Message-ID: <CABXOdTfbfWsan3MH0e=pnQ2DKw5p===1s4hKcnDdbRUwARPSDg@mail.gmail.com>
Subject: Re: [PATCH -next] platform/chrome: cros_ec_lpc: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 8:08 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/platform/chrome/cros_ec_debugfs.c:256:30: warning: symbol 'cros_ec_console_log_fops' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_debugfs.c:265:30: warning: symbol 'cros_ec_pdinfo_fops' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_lightbar.c:550:24: warning: symbol 'cros_ec_lightbar_attr_group' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_sysfs.c:338:24: warning: symbol 'cros_ec_attr_group' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_vbc.c:104:24: warning: symbol 'cros_ec_vbc_attr_group' was not declared. Should it be static?
> drivers/platform/chrome/cros_ec_lpc.c:408:25: warning: symbol 'cros_ec_lpc_pm_ops' was not declared. Should it be static?
>

The subject is misleading: The patch does not only affect cros_ec_lpc.

Guenter

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/platform/chrome/cros_ec_debugfs.c  | 4 ++--
>  drivers/platform/chrome/cros_ec_lightbar.c | 2 +-
>  drivers/platform/chrome/cros_ec_lpc.c      | 2 +-
>  drivers/platform/chrome/cros_ec_sysfs.c    | 2 +-
>  drivers/platform/chrome/cros_ec_vbc.c      | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 4c2a27f6a6d0..4578eb3e0731 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -241,7 +241,7 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>                                        read_buf, p - read_buf);
>  }
>
> -const struct file_operations cros_ec_console_log_fops = {
> +static const struct file_operations cros_ec_console_log_fops = {
>         .owner = THIS_MODULE,
>         .open = cros_ec_console_log_open,
>         .read = cros_ec_console_log_read,
> @@ -250,7 +250,7 @@ const struct file_operations cros_ec_console_log_fops = {
>         .release = cros_ec_console_log_release,
>  };
>
> -const struct file_operations cros_ec_pdinfo_fops = {
> +static const struct file_operations cros_ec_pdinfo_fops = {
>         .owner = THIS_MODULE,
>         .open = simple_open,
>         .read = cros_ec_pdinfo_read,
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index d30a6650b0b5..23a82ee4c785 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -547,7 +547,7 @@ static struct attribute *__lb_cmds_attrs[] = {
>         NULL,
>  };
>
> -struct attribute_group cros_ec_lightbar_attr_group = {
> +static struct attribute_group cros_ec_lightbar_attr_group = {
>         .name = "lightbar",
>         .attrs = __lb_cmds_attrs,
>  };
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index c9c240fbe7c6..aaa21803633a 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -405,7 +405,7 @@ static int cros_ec_lpc_resume(struct device *dev)
>  }
>  #endif
>
> -const struct dev_pm_ops cros_ec_lpc_pm_ops = {
> +static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
>         SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
>  };
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index fe0b7614ae1b..3edb237bf8ed 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -335,7 +335,7 @@ static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
>         return a->mode;
>  }
>
> -struct attribute_group cros_ec_attr_group = {
> +static struct attribute_group cros_ec_attr_group = {
>         .attrs = __ec_attrs,
>         .is_visible = cros_ec_ctrl_visible,
>  };
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index 8392a1ec33a7..2aaefed87eb4 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -101,7 +101,7 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>         NULL
>  };
>
> -struct attribute_group cros_ec_vbc_attr_group = {
> +static struct attribute_group cros_ec_vbc_attr_group = {
>         .name = "vbc",
>         .bin_attrs = cros_ec_vbc_bin_attrs,
>  };
> --
> 2.17.1
>
>
