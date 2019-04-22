Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D676EC282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CCF20811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPfK8PCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDVGoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:44:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36641 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfDVGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:44:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id o74so8829685ota.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRqDGxjL9KGk8AXcmMq33XQi7fUb9V0NGGNIF1+Zqkg=;
        b=lPfK8PCKkA9k/rv6VCsZ3GdDEsbpHH+ey5EA++ZoKT0NONYTbhyWpd87V3IqKHtB07
         HJLSZBxyeBsTLFDiP/aY+NQVFp1kkAlCE6QmndoVNfHFamQxAq7E0yOkcgscnTV9pIZT
         eoks5qL4y+tC8El8FePnTcmFPZmvSTQ+fEdGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRqDGxjL9KGk8AXcmMq33XQi7fUb9V0NGGNIF1+Zqkg=;
        b=rHfzy7NGVZyVazcyv6EM3P0p6dmSFM9zKUU9e8+82fTg1XPyprORpfT+Ua/6kBdXhO
         5jgBh26T3pZtlPp9uy9rueT/HBMmILuNJuq8FaRj1Ce2T/0BQZ7QRouCWlNe6UPqkg2E
         7Ot8lbsCFlhHChWO3z2SnOWL6NSyPsDChrZQ9G4LIP4dYO7syRNkA6PD4xKpZZO8Uj0F
         312so7BpE7FYbRi2BC4sDZ9d5vK2gCrkq0VJQC5M4wwNkOljrNzVVUKxuTBa+T48xzpA
         u4Jvq0ytGObOamNR7N6ryn17c9+3Sr1oDCz4gmrSHX9e/3ZceF2i5pF8300nL1Pkz/Le
         aGBg==
X-Gm-Message-State: APjAAAXvVYA4OVDxj2lAmO/cGCNI73sOromDpCrjUa7htQ5HSXxFAIXg
        ZFSWIqIUqDUf0Dy194unjtBHc7M/woKGuw==
X-Google-Smtp-Source: APXvYqw2Kk8FIkp5qccycO1SKTOu7/muwMVzOcZCpQA25gGnpU1i7ZGV56OpIdWqm6bXIOcVTw2NQA==
X-Received: by 2002:a9d:da9:: with SMTP id 38mr10634081ots.183.1555915481317;
        Sun, 21 Apr 2019 23:44:41 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id m206sm5358243oif.50.2019.04.21.23.44.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 23:44:40 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id t8so8825296otp.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 23:44:39 -0700 (PDT)
X-Received: by 2002:a9d:3f61:: with SMTP id m88mr10124811otc.147.1555915479110;
 Sun, 21 Apr 2019 23:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <1554106718-23107-1-git-send-email-maoguang.meng@mediatek.com>
In-Reply-To: <1554106718-23107-1-git-send-email-maoguang.meng@mediatek.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 22 Apr 2019 15:44:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CUL=yE2-igsAPrt42DWW=4Xjzcyb_8zGWHRtiC5Acs6g@mail.gmail.com>
Message-ID: <CAAFQd5CUL=yE2-igsAPrt42DWW=4Xjzcyb_8zGWHRtiC5Acs6g@mail.gmail.com>
Subject: Re: [PATCH,v1] media: mtk-vcodec: fix vp9 content playback error with
 show exist frame
To:     maoguang.meng@mediatek.com
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        gtk_ruiwang@mediatek.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 5:19 PM <maoguang.meng@mediatek.com> wrote:
>
> From: Maoguang Meng <maoguang.meng@mediatek.com>
>
> Update referenced frame buffer's reference count when playing vp9
> content which has show_existing_frame flag, and copy enough buffer
> data to current shown frame.
>
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> ---
>  .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> index bc8349b..d950837 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> @@ -481,15 +481,15 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
>                  */
>                 if ((frm_to_show->fb != NULL) &&
>                         (inst->cur_fb->base_y.size >=
> -                       frm_to_show->fb->base_y.size)) {
> +                       frm_to_show->fb->base_y.size) &&
> +                       (inst->cur_fb->base_c.size >=
> +                       frm_to_show->fb->base_c.size)) {
>                         memcpy((void *)inst->cur_fb->base_y.va,
>                                 (void *)frm_to_show->fb->base_y.va,
> -                               vsi->buf_w *
> -                               vsi->buf_h);
> +                               frm_to_show->fb->base_y.size);
>                         memcpy((void *)inst->cur_fb->base_c.va,
>                                 (void *)frm_to_show->fb->base_c.va,
> -                               vsi->buf_w *
> -                               vsi->buf_h / 2);
> +                               frm_to_show->fb->base_c.size);
>                 } else {
>                         /* After resolution change case, current CAPTURE buffer
>                          * may have less buffer size than frm_to_show buffer
> @@ -895,7 +895,7 @@ static int vdec_vp9_decode(unsigned long h_vdec, struct mtk_vcodec_mem *bs,
>
>                 if (vsi->resolution_changed) {
>                         if (!vp9_alloc_work_buf(inst)) {
> -                               ret = -EINVAL;
> +                               ret = -EIO;
>                                 goto DECODE_ERROR;
>                         }
>                 }
> @@ -924,14 +924,12 @@ static int vdec_vp9_decode(unsigned long h_vdec, struct mtk_vcodec_mem *bs,
>
>                 if (vsi->show_existing_frame && (vsi->frm_to_show_idx <
>                                         VP9_MAX_FRM_BUF_NUM)) {
> -                       mtk_vcodec_err(inst,
> +                       mtk_vcodec_debug(inst,
>                                 "Skip Decode drv->new_fb_idx=%d, drv->frm_to_show_idx=%d",
>                                 vsi->new_fb_idx, vsi->frm_to_show_idx);
>
>                         vp9_ref_cnt_fb(inst, &vsi->new_fb_idx,
>                                         vsi->frm_to_show_idx);
> -                       ret = -EINVAL;
> -                       goto DECODE_ERROR;
>                 }
>
>                 /* VPU assign the buffer pointer in its address space,
> --
> 1.7.9.5
>

Thanks for the patch!

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
