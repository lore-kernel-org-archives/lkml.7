Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B4BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5936E207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUJR+4Gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgAFXFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:05:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38120 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgAFXFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:05:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so51809398wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFPtgmu7am1f4EYBfi4KkzbAOi/FXMPKhu8S1KpGb/4=;
        b=aUJR+4GbxeThYylY61qSlLQa/j+gyCDHOWZzYTVFfkL0RK++xm94Psbe64jO0Cm3ZY
         MJbKj2jOr3eNOfv3KewqjyvRvtLA4H3Tr/n1d0pCI/Z3goBsKkLZfM+tLHQO7a6iXmy5
         CMzw4bBchTzItKgZxoZmjvnfNubjGupSEospQES7nFYGosxM69MnuPxtl+fQWxAP5+X/
         D8Ver0mwlHhyCya8SsAWss6btFwNRwUmY97Xzwq7ooasO6w0sJ2IT3Pf2XzdcfoRvaWF
         /HostWtyE+6n9RSu7mCIMcemhqU2QJaFV7o2RlCOgfMN5IwVkWrQerOBcH74z4l/h7dw
         GfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFPtgmu7am1f4EYBfi4KkzbAOi/FXMPKhu8S1KpGb/4=;
        b=DgB8D/DAzU+k6U9p84qxuN/itkSF9iVew36ayF/ulFDz/4F+IicWMiAhKy7lJKNaRv
         WKCQkeP/9xca924uLVEEoZDxr0wt4eYoR8mmG5w7RuiYippMoIfHTf1t8L5BIuUpID4Y
         qgkLisuDbm4ZXvyV7PKYUM2C4QzIldVoShGN2Km53M5knaQuMOZSYC7jTjNwBM11T3Ze
         wIhm6VyO30G/WZMy1lGKkgbMo2TLLCr5Tv4JPrk/iZ2I4o5CWfDM3WWIfGtfUyUMaA5g
         Ktdt8byJ2+HmLlS7cPe7mppUzJEG003XVIWbGOn2dhrQCMxIvE9s8mlIWRSGkotUqtf5
         +QIQ==
X-Gm-Message-State: APjAAAUZ1dG3ZLlrPcn9iJhR88SQG9lG4teQBmPpm1p4fHdYxOCthuX3
        A1f1B+Ue/5yNe3jn6uIJeRBVm+2eNxBYkfWhf+dSuQ==
X-Google-Smtp-Source: APXvYqwATAYO1fo/4+rjXeWQuxn8GwzWJd2sBicOKRI8Nw8ohzmJbJdlRJizBiyOxLYpN0dNPXoC1OZ2ZvQDLTyP6yI=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr105033883wru.40.1578351915043;
 Mon, 06 Jan 2020 15:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20200103191852.15357-1-wambui.karugax@gmail.com>
In-Reply-To: <20200103191852.15357-1-wambui.karugax@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Jan 2020 18:05:03 -0500
Message-ID: <CADnq5_MSd5YkfnmoJnv0ydYmW45U+Vwvtnrw5wmFpR59GtQRLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: use list_for_each_entry for list iteration.
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 2:34 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> list_for_each() can be replaced by the more concise
> list_for_each_entry() here for iteration over the lists.
> This change was reported by coccinelle.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 64445c4cc4c2..cbcf504f73a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -111,17 +111,12 @@ static void init_handler_common_data(struct amdgpu_dm_irq_handler_data *hcd,
>   */
>  static void dm_irq_work_func(struct work_struct *work)
>  {
> -       struct list_head *entry;
>         struct irq_list_head *irq_list_head =
>                 container_of(work, struct irq_list_head, work);
>         struct list_head *handler_list = &irq_list_head->head;
>         struct amdgpu_dm_irq_handler_data *handler_data;
>
> -       list_for_each(entry, handler_list) {
> -               handler_data = list_entry(entry,
> -                                         struct amdgpu_dm_irq_handler_data,
> -                                         list);
> -
> +       list_for_each_entry(handler_data, handler_list, list) {
>                 DRM_DEBUG_KMS("DM_IRQ: work_func: for dal_src=%d\n",
>                                 handler_data->irq_source);
>
> @@ -528,19 +523,13 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
>                                          enum dc_irq_source irq_source)
>  {
>         struct amdgpu_dm_irq_handler_data *handler_data;
> -       struct list_head *entry;
>         unsigned long irq_table_flags;
>
>         DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
>
> -       list_for_each(
> -               entry,
> -               &adev->dm.irq_handler_list_high_tab[irq_source]) {
> -
> -               handler_data = list_entry(entry,
> -                                         struct amdgpu_dm_irq_handler_data,
> -                                         list);
> -
> +       list_for_each_entry(handler_data,
> +                           &adev->dm.irq_handler_list_high_tab[irq_source],
> +                           list) {
>                 /* Call a subcomponent which registered for immediate
>                  * interrupt notification */
>                 handler_data->handler(handler_data->handler_arg);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
