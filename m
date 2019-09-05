Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDEFC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC732145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfIEJME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733051AbfIEJMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:12:01 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E487E882EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 09:12:00 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id a20so2348497iok.21
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YgkTckHnd+oBCtkJ3PeDRAfoIVwhj7X9BQME1lU8Rk=;
        b=EvpaixDuxt7HJLf5hgXI6SCr7Q58EKBJI6zrHan+DeRTXVEvbbqFeJJZ6aOINCxF8t
         0LIAuhOeSP9do4Zq68MWCR8X8CzkYWVh4Qezj3zzT5hsDjqO9nQlKauvVhbCZV2VmJyi
         RhS8JP4T8wEOPDJAQieGfKQ4Cu4qTufqSeacpe+OpvLxohS4YNWQtBIr5CNMbhfrzNhR
         K6CGgKv1BXPEKmp4EcgrtXJV4eoAQhXuOBqG7NY8n3WRBeBoqsEBdhoAl1f72yYpWaaT
         HH0wli91IdxMrF9v1zVTddyYtkJ/ziSf+ue5YXkBvscCW5ccfU0M9GX7YU+EYbH6ep58
         u4OA==
X-Gm-Message-State: APjAAAUsYOv54NzS8JaH+lilwVspVzkpzxlyWljGtqGPkTuJsSfgTCIV
        m4YlNIWmUZZgqo3FIuouiTd93o3/H5CDj/SZQLjUxjB2V8T93tW8ve6JuOkS2eHhMEAB3zPFRfw
        D9BSXOQShJt5v20BZDYl+qRr4PB5A+v1H12uFMkTy
X-Received: by 2002:a5e:9509:: with SMTP id r9mr2974892ioj.100.1567674720332;
        Thu, 05 Sep 2019 02:12:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrAdsLGhijKZkQDVkShWA1yVxV6uG4TFkYu7Bb2m8Nd+GkGxi48OkzyFxBIWpeZjPbwU+pUog6KRuQLHZzDhI=
X-Received: by 2002:a5e:9509:: with SMTP id r9mr2974868ioj.100.1567674720115;
 Thu, 05 Sep 2019 02:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190904141857.196103-1-weiyongjun1@huawei.com>
In-Reply-To: <20190904141857.196103-1-weiyongjun1@huawei.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 5 Sep 2019 11:11:49 +0200
Message-ID: <CACO55tsJt2Z-EQBpPw1=yq_jya2kJ5u5xs_xg=nhB8ZHwhjCoA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: add missing single_release()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Thu, Sep 5, 2019 at 9:14 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> When using single_open() for opening, single_release() should be
> used, otherwise there is a memory leak.
>
> This is detected by Coccinelle semantic patch.
>
> Fixes: 6e9fc177399f ("drm/nouveau/debugfs: add copy of sysfs pstate interface ported to debugfs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 7dfbbbc1beea..35695f493271 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -202,6 +202,7 @@ static const struct file_operations nouveau_pstate_fops = {
>         .open = nouveau_debugfs_pstate_open,
>         .read = seq_read,
>         .write = nouveau_debugfs_pstate_set,
> +       .release = single_release,
>  };
>
>  static struct drm_info_list nouveau_debugfs_list[] = {
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
