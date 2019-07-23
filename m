Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A81AC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADF321841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kngDeBL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbfGWStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:49:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50273 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfGWStH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:49:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so39557553wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50RPD9GLsElecVaxEmMiICG57vQta+1Z/U/1fgFGurI=;
        b=kngDeBL36QOC6g0JB7S6cR1lhpzLh4otWj87pagk/hSxoPfkAndr5cH4/zmDAli2AW
         cUoCnBxw+utC2sshc7SB2UL281hJy/Ti+dwzeOCuF40/ARDSPiEI/YDfhudVDoyhrZ0Z
         ZsPbtuXe8KQtx4Ez/0YtuX3NZBfXLXwZn7UlsTguuCPmsXA39d792G18XFG0n2yR7SNY
         BzkFr47/947Tfaz2eO/kaQsroOs1iFrBUKKai5hUv/1YCLKWHTRIBga747rT8oYtJH2E
         ChgD3vpjkhHdBdjwK158ckcINm4Zc/37GjZSN6UhYfLjv7J89ujaFKcr7u567HLut6/F
         WCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50RPD9GLsElecVaxEmMiICG57vQta+1Z/U/1fgFGurI=;
        b=etIIPb9MhbbTvZh3kEsdGeSEw3eXd5BKh1zBXZch2eMgoTlk04eZG2pZHwuajwbKVa
         7GdGIW4KCCLovsrNQ0AkHmCDPev3xO+H6ZpnFVRfKZcgFxGYhjn4U4NcFqzO3MTbEim9
         F0vV0iCNQ61HM3++UeLCO0n7irabrOYiHKwdTAHkYExHi4b53hHreILYDEsRLZKT9jBU
         /KQKYGQZ44bx0kzQapJ88uGitDGojGHYn9vs9BgMAVrqg/m30VkdXjysDi8I+uZy2v0s
         yP3vQdnAmr7FLJmZJyPQswKJo164TE/PX5doEWVAXSvmoQ/hnViIQ0AQ7XZ8/cJST0J+
         I+KQ==
X-Gm-Message-State: APjAAAVugwJc4vJX/O/B6+Uwe0aippLhxvBLsVc220VIihPX2ucvNPmu
        6lq1FdUmO0jjZvh7MQuT/cxl0s9J1LbuZTY3cRE=
X-Google-Smtp-Source: APXvYqwfFCxzxMG4Rw0FkgyLPquRnXTJljFQ0apnOe1Uic6Ota67JuvnbXBpFbgYNAhVzHzyYRhqESyOM8sHO7spKkQ=
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr70227662wme.102.1563907745335;
 Tue, 23 Jul 2019 11:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190723090421.27532-1-hslester96@gmail.com>
In-Reply-To: <20190723090421.27532-1-hslester96@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Jul 2019 14:48:54 -0400
Message-ID: <CADnq5_P02i=5uBqTun1-CoX9hiHzYiJD3zGYGjnct+MAcpTs=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:36 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4a29f72334d0..524e1e19017e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2428,8 +2428,7 @@ static ssize_t s3_debug_store(struct device *device,
>  {
>         int ret;
>         int s3_state;
> -       struct pci_dev *pdev = to_pci_dev(device);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(device);
>         struct amdgpu_device *adev = drm_dev->dev_private;
>
>         ret = kstrtoint(buf, 0, &s3_state);
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
