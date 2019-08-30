Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E5C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22452341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q36KFh9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH3PKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:10:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46194 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfH3PKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:10:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so5985713wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IX37xBGf5R5k6PbsX8zWqg1WxUYZJX8p+B51wVl4L5c=;
        b=q36KFh9FWXeiY7g0nLMvI/C8mlM9r6+D7Pq1xIxoB4DYMyN3UJNWG1qQbbXyBj90w4
         j6TBYQEcVNvNYbRKrHUydZ+Ftz1xUB9yoRW5NvDlliv5GoD90h/oOXxzgBfKKZdVV883
         c9xOUk2sVtI+M8K6+4nUA+dfyr/Bci3jUglrB5CpaGLw0BlCH8bya8kEOxGxQsSlJOEF
         QUCxobPT0A6LguDpYz0FFZeqCw9F6aU5Hxav/NPi5Ci1Y6XwUjL6h9gfkIZeorZQkgx0
         Vb/an/BD/1au+NHGmQUdTSq87ZrC4DihinhaWnj9lZRSdTN5sTOXfg9+KIBqpxinXbV7
         xVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX37xBGf5R5k6PbsX8zWqg1WxUYZJX8p+B51wVl4L5c=;
        b=DC18jusB70sTXd6Xg7TLYmUtYc18UDJKmdcpM2dRFKh+l4/wPQ8Umztpk6eQs2FYQC
         3Pel7EIPk9iARvr9rtj7ab5vN4R0eDjHOSK+sb1fDT8J84iUVVKjVVVmJTpNlYszXKYl
         0PrTACYT5cP00S47+zh99ZeyOREAf5wkndJ4VaGaU2vPwlL1GwNoz4dy5S5kVD3q0G++
         QruJOnOVMfBLF+IW7e2z2QlEeOme9L249B0Mt7d5Y8RpSCZDnQWlj/yM6Uq0duJhifHf
         IaJUTLDkADKhOcMWgx9pAHqpp3+A8ElxQ48x38hOqHldSy8w6WEv1AsbEMH/RIUlpfIS
         aAMw==
X-Gm-Message-State: APjAAAUUVlKQln6JHVk3LNpeZU64jST7TYDXU143yx0SEh1hVi4xv+wZ
        icX2TKBFYW3kZ4GwAb3nOQnAWXs/1Y1RffxU58s=
X-Google-Smtp-Source: APXvYqzZWxQhU7m8QEFCBHKWxT0rNy/0O2XDxDnWFdaE5Ry3PnbMsh2r9rE7CU+9Q7ik5LA8xZXXt54YpijGAL/MkYQ=
X-Received: by 2002:adf:8004:: with SMTP id 4mr18038118wrk.341.1567177798350;
 Fri, 30 Aug 2019 08:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190830080704.GA29599@LGEARND20B15>
In-Reply-To: <20190830080704.GA29599@LGEARND20B15>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 30 Aug 2019 11:09:43 -0400
Message-ID: <CADnq5_PZ8cuQBVXAAH8mefHbnbK9M4QexbTN_9X-yyqdeaLcbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Move null pointer dereference check
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:43 AM Austin Kim <austindh.kim@gmail.com> wrote:
>
> Null pointer dereference check should have been checked,
> ahead of below routine.
>         struct amdgpu_device *adev = hwmgr->adev;
>
> With this commit, it could avoid potential NULL dereference.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> index 8189fe4..4728aa2 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> @@ -722,16 +722,17 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *hwmgr)
>
>  static int smu8_start_smu(struct pp_hwmgr *hwmgr)
>  {
> -       struct amdgpu_device *adev = hwmgr->adev;
> +       struct amdgpu_device *adev;
>
>         uint32_t index = SMN_MP1_SRAM_START_ADDR +
>                          SMU8_FIRMWARE_HEADER_LOCATION +
>                          offsetof(struct SMU8_Firmware_Header, Version);
>
> -
>         if (hwmgr == NULL || hwmgr->device == NULL)
>                 return -EINVAL;
>
> +       adev = hwmgr->adev;
> +
>         cgs_write_register(hwmgr->device, mmMP0PUB_IND_INDEX, index);
>         hwmgr->smu_version = cgs_read_register(hwmgr->device, mmMP0PUB_IND_DATA);
>         pr_info("smu version %02d.%02d.%02d\n",
> --
> 2.6.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
