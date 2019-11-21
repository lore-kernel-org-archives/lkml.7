Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ABC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CD42068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfCzA/xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKUSSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:18:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKUSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:18:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so3773883oti.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLh+wq2FKhAOzMh5cYk9TfhwRQ3GNGiwiSyRjHesiO4=;
        b=AfCzA/xcPYfKAiPT09NYITrqZxU0TdI+ZO6qx+Go4PDPhF8W1qK428wuZjVPlsEcbo
         fbZ+L7IZENZ0tDIhhYv23CBtqdLjjNWQ2XckHg7Cm26FtGW25svaOb0fgMBUu2uScxa0
         8pxd/Dt0Cx+K/qmpa99ApYW36a/ym+R+16o99cJEhl4C5qxUsHnzUk1WpKQscG8Ykucl
         fRBw03q35Ob/fQL3qywJogesTmEZt0t5l3kIQcUkr3s5xEVzVj/0pRWb1syCdUvmoaCL
         LZ/T6s1bAmBpJ4UjQxsqO702DBI9qiHRPXsIbMfcZXmKjpdhyfWe1ctSCh2M5vZGya7o
         fjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLh+wq2FKhAOzMh5cYk9TfhwRQ3GNGiwiSyRjHesiO4=;
        b=Tx/bGpV6UVQuqByuj91gDbFgeJYIvLXMNkjv+r3FNg3yRYN49i+V0Q2cfLlCEAc6Ma
         vDJrJdSwOUyRwE/HXLa1Ly3rudvgAZ2CWjQ5FUFXAXJmMsHG37dLrit4C00OiXYiHQvW
         gCCmmV9cOHoq/FgpMW9KOeptIcxyjzvmiBfvLrgdi4LanBvmxCEtB4neRXJtdkRsqZeh
         kVyCiPaNvKGa2AlvnVQQhfsDVn94wUgcNgATuxaBoo1R3qEqZpkVNZ0jB2CPHEfZTFZD
         3xk50ZFshCDLnSz8R+aFAujDSwNUdFAFeKT7Mvizb/Jr1ZopEPwJH5VLRD+iw1VoBVMn
         60sQ==
X-Gm-Message-State: APjAAAUnd4hu/+4UW7DdZ4tCLt2SoLUCDc6zw3MfTx4/eE7uSoNbJgb8
        MKAscBVW80c9tfK0E7k4FOd5Iw7j6Wqku/q0JvwfayJW
X-Google-Smtp-Source: APXvYqyP8jT97drkLxAOQj9i4dbSNbCEbWv6Btfk7/zmrzrazKpqzfQGZHvSu0NazVBk2BmpBQqhJr5kv4zzgQ4ZpPM=
X-Received: by 2002:a9d:6149:: with SMTP id c9mr7367377otk.279.1574360283417;
 Thu, 21 Nov 2019 10:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20190925043800.726-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190925043800.726-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 21 Nov 2019 12:17:52 -0600
Message-ID: <CAEkB2ESR+GictT00W95pADAeakAuLrTECqUxEt=b7TG2x=FgVw@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:38 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In vmw_cmdbuf_res_add if drm_ht_insert_item fails the allocated memory
> for cres should be released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Would you please review this patch?

Thanks,

> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
> index 4ac55fc2bf97..44d858ce4ce7 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
> @@ -209,8 +209,10 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager *man,
>
>         cres->hash.key = user_key | (res_type << 24);
>         ret = drm_ht_insert_item(&man->resources, &cres->hash);
> -       if (unlikely(ret != 0))
> +       if (unlikely(ret != 0)) {
> +               kfree(cres);
>                 goto out_invalid_key;
> +       }
>
>         cres->state = VMW_CMDBUF_RES_ADD;
>         cres->res = vmw_resource_reference(res);
> --
> 2.17.1
>


-- 
Navid.
