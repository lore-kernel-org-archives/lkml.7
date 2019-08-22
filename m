Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86838C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A105233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QXr/IunZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392084AbfHVTn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:43:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36602 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbfHVTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:43:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id k18so6606068otr.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuWKFSzvEpg74qi2KyP9BM/RBYpRpZTScI16525W/sM=;
        b=QXr/IunZYtdgAcsEXj6VOEp8s+icCzq5F3829lta0k7zPYYwFza2YJg+Yyp+3E/fuI
         Ho2qPZwMbvm/pAGn6je2trSwuHBaszDSNl3le02HCvQg4BeZcOn+U+de07DCdLXnB8dn
         mxiWQFMxPzGAd0QZpQ+Xkg3jLXYu+9hpQb1Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuWKFSzvEpg74qi2KyP9BM/RBYpRpZTScI16525W/sM=;
        b=RerYrXtBfZ0S1qG+nzGgOMKvlX67XK4EEXU8mZErPspWmIqvhCgYuuL5MJwmeWxoiR
         RxPi6aLM+aB3M2sOvxM5bKF8JrhaDccoc8JhY8J83fbRoShnDBxz34DgRYK8C4FMRV25
         Td7NVBwyCBPr4hzFh9s5p8ux/iVwrbR4IYsn5Ke46Mrd0klXI0fziIUakFiH6JPKTW9R
         os5N5GzcZzPNN8gSS/4j/5PkjaDODnI5oZQ7VNkONeITMqENZ3pS7hOyBlRHRDnjWrgk
         F+kLIA4f4/2Q+gIs4YkECaTVJ4VFKT5lYb7MCaqgzHh98IWe3ct5X7byUR8AThrbDUhC
         xgsQ==
X-Gm-Message-State: APjAAAWmaSaju09liu0PWGvTQ2AARrYPtzWRVLUyuwQN1VraM3VLbN5H
        lSvvVwMSNd6Aegqw8WF0is/nY/tc6Bc=
X-Google-Smtp-Source: APXvYqwgS1ZzGrXFhKfIoN6buvmUWQXOykuvgc0o3ENVFDsCgptBhYGyqqJt/2Z9jWXEKf95uIvHIQ==
X-Received: by 2002:a05:6830:1f10:: with SMTP id u16mr1102443otg.229.1566503007081;
        Thu, 22 Aug 2019 12:43:27 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id m7sm200738otm.5.2019.08.22.12.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 12:43:26 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id c34so6577851otb.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 12:43:25 -0700 (PDT)
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr1106878otp.236.1566503005173;
 Thu, 22 Aug 2019 12:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190805202214.3408-1-ncrews@chromium.org>
In-Reply-To: <20190805202214.3408-1-ncrews@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 22 Aug 2019 13:43:14 -0600
X-Gmail-Original-Message-ID: <CAHX4x86jrJAUqCGD51AY65B=Sp0fnwsbgs9Erbyg4zPK_jhFMg@mail.gmail.com>
Message-ID: <CAHX4x86jrJAUqCGD51AY65B=Sp0fnwsbgs9Erbyg4zPK_jhFMg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add batt_ppid_info command to
 telemetry driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly bump on this :)

On Mon, Aug 5, 2019 at 2:22 PM Nick Crews <ncrews@chromium.org> wrote:
>
> Add the GET_BATT_PPID_INFO=0x8A command to the allowlist of accepted
> telemetry commands. In addition, since this new command requires
> verifying the contents of some of the arguments, I also restructure
> the request to use a union of the argument structs. Also, zero out the
> request buffer before each request, and change "whitelist" to
> "allowlist".
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/platform/chrome/wilco_ec/telemetry.c | 64 +++++++++++++-------
>  1 file changed, 43 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
> index 94cdc166c840..b9d03c33d8dc 100644
> --- a/drivers/platform/chrome/wilco_ec/telemetry.c
> +++ b/drivers/platform/chrome/wilco_ec/telemetry.c
> @@ -9,7 +9,7 @@
>   * the OS sends a command to the EC via a write() to a char device,
>   * and can read the response with a read(). The write() request is
>   * verified by the driver to ensure that it is performing only one
> - * of the whitelisted commands, and that no extraneous data is
> + * of the allowlisted commands, and that no extraneous data is
>   * being transmitted to the EC. The response is passed directly
>   * back to the reader with no modification.
>   *
> @@ -59,21 +59,10 @@ static DEFINE_IDA(telem_ida);
>  #define WILCO_EC_TELEM_GET_TEMP_INFO           0x95
>  #define WILCO_EC_TELEM_GET_TEMP_READ           0x2C
>  #define WILCO_EC_TELEM_GET_BATT_EXT_INFO       0x07
> +#define WILCO_EC_TELEM_GET_BATT_PPID_INFO      0x8A
>
>  #define TELEM_ARGS_SIZE_MAX    30
>
> -/**
> - * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
> - * @command: One of WILCO_EC_TELEM_GET_* command codes.
> - * @reserved: Must be 0.
> - * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
> - */
> -struct wilco_ec_telem_request {
> -       u8 command;
> -       u8 reserved;
> -       u8 args[TELEM_ARGS_SIZE_MAX];
> -} __packed;
> -
>  /*
>   * The following telem_args_get_* structs are embedded within the |args| field
>   * of wilco_ec_telem_request.
> @@ -122,6 +111,32 @@ struct telem_args_get_batt_ext_info {
>         u8 var_args[5];
>  } __packed;
>
> +struct telem_args_get_batt_ppid_info {
> +       u8 always1; /* Should always be 1 */
> +} __packed;
> +
> +/**
> + * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
> + * @command: One of WILCO_EC_TELEM_GET_* command codes.
> + * @reserved: Must be 0.
> + * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
> + */
> +struct wilco_ec_telem_request {
> +       u8 command;
> +       u8 reserved;
> +       union {
> +               u8 buf[TELEM_ARGS_SIZE_MAX];
> +               struct telem_args_get_log               get_log;
> +               struct telem_args_get_version           get_version;
> +               struct telem_args_get_fan_info          get_fan_info;
> +               struct telem_args_get_diag_info         get_diag_info;
> +               struct telem_args_get_temp_info         get_temp_info;
> +               struct telem_args_get_temp_read         get_temp_read;
> +               struct telem_args_get_batt_ext_info     get_batt_ext_info;
> +               struct telem_args_get_batt_ppid_info    get_batt_ppid_info;
> +       } args;
> +} __packed;
> +
>  /**
>   * check_telem_request() - Ensure that a request from userspace is valid.
>   * @rq: Request buffer copied from userspace.
> @@ -133,7 +148,7 @@ struct telem_args_get_batt_ext_info {
>   * We do not want to allow userspace to send arbitrary telemetry commands to
>   * the EC. Therefore we check to ensure that
>   * 1. The request follows the format of struct wilco_ec_telem_request.
> - * 2. The supplied command code is one of the whitelisted commands.
> + * 2. The supplied command code is one of the allowlisted commands.
>   * 3. The request only contains the necessary data for the header and arguments.
>   */
>  static int check_telem_request(struct wilco_ec_telem_request *rq,
> @@ -146,25 +161,31 @@ static int check_telem_request(struct wilco_ec_telem_request *rq,
>
>         switch (rq->command) {
>         case WILCO_EC_TELEM_GET_LOG:
> -               max_size += sizeof(struct telem_args_get_log);
> +               max_size += sizeof(rq->args.get_log);
>                 break;
>         case WILCO_EC_TELEM_GET_VERSION:
> -               max_size += sizeof(struct telem_args_get_version);
> +               max_size += sizeof(rq->args.get_version);
>                 break;
>         case WILCO_EC_TELEM_GET_FAN_INFO:
> -               max_size += sizeof(struct telem_args_get_fan_info);
> +               max_size += sizeof(rq->args.get_fan_info);
>                 break;
>         case WILCO_EC_TELEM_GET_DIAG_INFO:
> -               max_size += sizeof(struct telem_args_get_diag_info);
> +               max_size += sizeof(rq->args.get_diag_info);
>                 break;
>         case WILCO_EC_TELEM_GET_TEMP_INFO:
> -               max_size += sizeof(struct telem_args_get_temp_info);
> +               max_size += sizeof(rq->args.get_temp_info);
>                 break;
>         case WILCO_EC_TELEM_GET_TEMP_READ:
> -               max_size += sizeof(struct telem_args_get_temp_read);
> +               max_size += sizeof(rq->args.get_temp_read);
>                 break;
>         case WILCO_EC_TELEM_GET_BATT_EXT_INFO:
> -               max_size += sizeof(struct telem_args_get_batt_ext_info);
> +               max_size += sizeof(rq->args.get_batt_ext_info);
> +               break;
> +       case WILCO_EC_TELEM_GET_BATT_PPID_INFO:
> +               if (rq->args.get_batt_ppid_info.always1 != 1)
> +                       return -EINVAL;
> +
> +               max_size += sizeof(rq->args.get_batt_ppid_info);
>                 break;
>         default:
>                 return -EINVAL;
> @@ -250,6 +271,7 @@ static ssize_t telem_write(struct file *filp, const char __user *buf,
>
>         if (count > sizeof(sess_data->request))
>                 return -EMSGSIZE;
> +       memset(&sess_data->request, 0, sizeof(sess_data->request));
>         if (copy_from_user(&sess_data->request, buf, count))
>                 return -EFAULT;
>         ret = check_telem_request(&sess_data->request, count);
> --
> 2.20.1
>
