Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67FF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDKmKl1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfKYPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:15:23 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38207 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfKYPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:15:22 -0500
Received: by mail-wm1-f52.google.com with SMTP id z19so16391790wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2e8atIpq5wHkQYzwJBKMcz9j6oQ/6fS/TGFVTRvgBmc=;
        b=CDKmKl1eS0ZuvZZuyMc8GeAIR1AVwWTWWbhbNmWkxCOXYk7EX3DUQY4Ueas/nyRTYq
         OH+QK+mEravSn2lvF4wG9LIxP7wNpUuE5PgVVF4W4wZYNOPiD/jdZnWIUeTuQPUOiXTg
         sOT+okPdMyv3ed7q/+XgZUkfnDfmSCbH6uRO2LUpcqgv4wi534oAClbhEBsjbDQ/ODQA
         3DbqrlierkAZNY3vvR4Lyn4fB6do6T5/hek+pjD6DNlTZ2lKM+oVsn0lw2wlqxcmV9wA
         7TuDLLQsq+v/b46kUZexnIg3RmzCPz2m350Hn8v7wWRy2cjlqb6/9DSjvPUtFLmkrFZj
         xGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2e8atIpq5wHkQYzwJBKMcz9j6oQ/6fS/TGFVTRvgBmc=;
        b=B1jiC7GZPs5ZamGSDXSofuD1NB1LgIOfHSGmsMIsMT//xDVi0Jx1ATBkdl1I6p1TD2
         oYZVpda1noUWucrdwP+Z/5552Uro7W0RA6i9rdBpDS0vuEjjXu8l5ply+gTrwDx+dUiB
         /xMcUFyDs6x99nN2vrmqbSfpXFFxKGtmU4GIQTFwborV4tYh3gWbgHCw8xnuCZwK1Zia
         IejNaEKdYhyxz3GDtL8HIqGoxIhR2bDsIVn6tS5F+M82LDD5nMTEbSnv7JRUpF7niL3N
         wEJzrImJjvoIgqy7QmGF/rVOSNi4LRvSWFWBE1yQhuM+OBCOZNFI9OuShweUxmSWqfQN
         Mxxw==
X-Gm-Message-State: APjAAAX8RRR9pkhBapdoTL9Fb6obOHMHL7de8qNu9qWz4mRXXpprCWcC
        lIG44+ciUgVmA7i4Z9Jis3vaVc1V7KLphG0Y0fg=
X-Google-Smtp-Source: APXvYqxghyvx1jkPcUDgdPxir+0bmwzReEZdqf7LJpD3R7pzdk4Kx6P1GT0/XU/Wv8MHK0eSJq5KaspqeHZxqNKHHRY=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr29227430wml.102.1574694919884;
 Mon, 25 Nov 2019 07:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20191125145445.21648-1-yuehaibing@huawei.com>
In-Reply-To: <20191125145445.21648-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Nov 2019 10:15:07 -0500
Message-ID: <CADnq5_Ms09to8Pr7BedmTZ37an=bBO+6ghHQQGJZBiefctRMZA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'msg_out'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:00 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c: In function mod_hdcp_hdcp2_enable_encryption:
> drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:633:77: warning: variable msg_out set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c: In function mod_hdcp_hdcp2_enable_dp_stream_encryption:
> drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:710:77: warning: variable msg_out set but not used [-Wunused-but-set-variable]
>
> It is never used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> index 2dd5fee..468f5e6 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> @@ -630,14 +630,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
>         struct psp_context *psp = hdcp->config.psp.handle;
>         struct ta_hdcp_shared_memory *hdcp_cmd;
>         struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
> -       struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>         struct mod_hdcp_display *display = get_first_added_display(hdcp);
>
>         hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>         memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>
>         msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
> -       msg_out = &hdcp_cmd->out_msg.hdcp2_prepare_process_authentication_message_v2;
>
>         hdcp2_message_init(hdcp, msg_in);
>
> @@ -707,14 +705,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
>         struct psp_context *psp = hdcp->config.psp.handle;
>         struct ta_hdcp_shared_memory *hdcp_cmd;
>         struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
> -       struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>         uint8_t i;
>
>         hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>         memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>
>         msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
> -       msg_out = &hdcp_cmd->out_msg.hdcp2_prepare_process_authentication_message_v2;
>
>         hdcp2_message_init(hdcp, msg_in);
>
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
