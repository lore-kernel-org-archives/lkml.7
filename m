Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E75C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FDB207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzMXb7o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfKYO5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:57:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:57:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so18505728wrr.0;
        Mon, 25 Nov 2019 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMq2KmDJf7iQgH3rZI9pg6UxlMOPDJy2jieZWQCQ8nI=;
        b=rzMXb7o0TAY6RWesHVl44pC4iQEZk1ctSEX4GZHqmoWPZbrWKl8jb4vRyaFN4ggRw6
         5PM+TypGT8XJRM7wGBV4OabX5ZxYTUbGu3rJRJYmuQjdCEEq7QL3zDokS8q9Ua9ZqNzD
         5E32LPcycp+Ex493L681zivfN6C9fCq2suxi+Zir3hfzxKF/ZiaIj4GAGBPrQb5hevBf
         NbE640+GHW6QnGlDHF1u7UdIm1oRRhrl3f18iRx2KaSd6Uk5j8BKAgOIQ6VZMF8RM8Yq
         dj4hgxZLihzHNERrxlVZZhYy1fiMwd7Y4bSb6smaApqcL/UwG/6iWoC9mM+VUCM+Pqn7
         F5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMq2KmDJf7iQgH3rZI9pg6UxlMOPDJy2jieZWQCQ8nI=;
        b=P8XG2GtV7zUyV9Zgn80WQYBR0MkHgM3TWMGi39yRTFpGbBiQJ/zF/dvJrf/HMcXMQ6
         AikWQipS/hCwJDhTOxvyp1Z0n+JEWV6DV142b74OiTk8CbX/e7cyw7e2pLNtNp66TqDE
         FUY6x5m0ed/2zlUszC3hXhp3vcoT0ECcPyTYcVit5u+uYHNU4CObr3pxnSoDiu4VmRdK
         n7gweh4jMZlG/OP3l3Ux8xXyBAqlVaoARbdfJFGcWQTM3Wyy4HEzSEO/sy5DFtFjmF+U
         xXqd2aC03RxTnj/4WqhlxrpBxsY/sQgoOEnYnwk2XNvUQ16zmmTwAhcKwWI/JBirmR+x
         d2oA==
X-Gm-Message-State: APjAAAWZ2zetqN6l/wFS5csaP0/6/w61r3buqs1fX16fIA8mowGJkVTX
        AXg0kST7d96m3d6gzV7YMWnpf9jwqp4ls4CfSKA=
X-Google-Smtp-Source: APXvYqyBEBz4DLhGwEqnQXuuwgtnvhxvND5xJo5P1g3sikTl//dUv2f4kUmgIXuJ3Pa/Vhr3kgUox46acpI1LPdnN2M=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr12269294wre.11.1574693853836;
 Mon, 25 Nov 2019 06:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20191122231504.109948-1-colin.king@canonical.com>
In-Reply-To: <20191122231504.109948-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Nov 2019 09:57:20 -0500
Message-ID: <CADnq5_OhXB-FC8ZGVUpv3LSk2WJ1RMymHfnv5ge0yiqErFxNUA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 6:15 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/si_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index 8148a7883de4..346315b3eebe 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5899,7 +5899,7 @@ static int si_patch_single_dependency_table_based_on_leakage(struct radeon_devic
>
>  static int si_patch_dependency_tables_based_on_leakage(struct radeon_device *rdev)
>  {
> -       int ret = 0;
> +       int ret;
>
>         ret = si_patch_single_dependency_table_based_on_leakage(rdev,
>                                                                 &rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk);
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
