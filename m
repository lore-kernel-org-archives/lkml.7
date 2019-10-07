Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DCA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aexpecD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJGQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:06:04 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36673 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:06:03 -0400
Received: by mail-wr1-f53.google.com with SMTP id y19so16016482wrd.3;
        Mon, 07 Oct 2019 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UO5DnHkttF/IxDQcQKOk9eSbt7yoz0JBUdSNkQ1IXmg=;
        b=aexpecD6viCna85hBK3lWtRFaA408/UmysRT8DRcBfpZSg93NgPsWcA4y17eJpv98+
         Lr4S9qqYNqBe2aZaO23qbggLovVN5X3oA6Ns8RQwEbPekQN8UhAkBzKmOYpqDLiWZd1C
         McFyohhiA3d+zVqkfkOp6KSjYyjy/Po+Uc5rT7Vqnu6YpiMwh6kljvYVoeljT5Oxy3QE
         nrtrW7VQFOt4wI1D3bbGyRtHwkOzagybm6YggBHiXszScbjYaq8rwtiNweixbcqQMk18
         y7OYLkU4b7xpVV7vWkW7LPNyOojdyyd0wK6FKRQMxGELi7/VnMEX/IBK9F0zv9GWPm/G
         bClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UO5DnHkttF/IxDQcQKOk9eSbt7yoz0JBUdSNkQ1IXmg=;
        b=eWJLuUNa/L3h5tbJ56LyjA3zuU26skSSJtV0/5HCxEgudzRXeMg5MLseccqlZfcjkF
         fvjvlo1yh7xADquNPqH1HmGZcj/w1oUtSrue4PG3ZxC6eC5Jc4EC0shC73itH9348wfq
         QHmCpA5HuqYwTOC6i8zQ+4FRKaTKo9E6ajxHnW8YqF3QiDG+gvsMrhtLRrJ68IZcchIQ
         ANQ/JXMvbQ2TSU6xsgCu7Yusn7ZTLRQTBf/aLEdlj1hx/9dIEvoZPDammorXnINdV4Pe
         ariUKGnLZsPjZ/h2A28/ysIc5qfumQA8N42bclILFda3qgfiP1WwMdpMMh+IBgXTv+aX
         ASsw==
X-Gm-Message-State: APjAAAX+172k4cZ+m5vC2EEzHC9Zf2NgPVe3SzP2pYhYsgAqt4HRiSa0
        5+QkRSknJYM3CqsrA5ZTU+Ou0teajvIrVdwEPds=
X-Google-Smtp-Source: APXvYqxlLQThATUxba72YxTF1mD0OWv8L5tcMETwDHaKLYWk4rFG+XmRyDyxq5Y7AfjRXQzKbNQaRcLVVW6sbUA0UYA=
X-Received: by 2002:a5d:6052:: with SMTP id j18mr12867036wrt.40.1570464361311;
 Mon, 07 Oct 2019 09:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191006074404.48416-1-yuehaibing@huawei.com>
In-Reply-To: <20191006074404.48416-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Oct 2019 12:05:48 -0400
Message-ID: <CADnq5_Pjh2xXFHOSHg2NVQfYju21LUnWeAC4+rv-G2_hJVmOYw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove duplicated include from mmhub_v1_0.c
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, "Le.Ma" <le.ma@amd.com>,
        Yong Zhao <Yong.Zhao@amd.com>,
        Trigger Huang <Trigger.Huang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Sun, Oct 6, 2019 at 11:05 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 4c7e8c64a94e..6965e1e6fa9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -31,7 +31,6 @@
>  #include "vega10_enum.h"
>
>  #include "soc15_common.h"
> -#include "amdgpu_ras.h"
>
>  #define mmDAGB0_CNTL_MISC2_RV 0x008f
>  #define mmDAGB0_CNTL_MISC2_RV_BASE_IDX 0
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
