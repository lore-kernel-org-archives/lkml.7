Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5B820727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6V9SCS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfKRJen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:34:43 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35689 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:34:43 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so15371747ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lr/4E5ZW9jz9oShySXGCc5V6Txdcr0g9QJ5gIXifIGk=;
        b=W6V9SCS3NzD7+ytXHksdvuTMYaJofAh3nWAX40damlaaJWjWjZHtQ+k6ikYy6z6QM1
         VHwrlguvhMqY7NmZM9gTooG0Z9XHILEXYgbysYUT6DYzcl/XH1wIjioMeK/75YCyLtb/
         aUi3Yq3X/P9iXf6Kg85iW+swL8ttWmJ0SlonE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lr/4E5ZW9jz9oShySXGCc5V6Txdcr0g9QJ5gIXifIGk=;
        b=LR4PU5hQa8lXqb+xLi4SctAhfMOc5m7rGthpsASc1w5Y5F/JRRqCLanXn4NmD1ayZG
         8UJOG9nTMr+U6TkQFfD80G+eNnTI7d2JvhaheHxeflnLape7MsVr3jNfXq1U6paYdvOJ
         Sq3jV+2tp+u4InQShqLbCisDDOWOnJh+E6KH3YHP2+kwsBAIXz4rEnH0OH46RNgugjCI
         IJbxpjXnlHDt2hDUG5ElXLCBot0VfI5EUlcDqB5gqw0fA4S3bNIa2qQUqCeXG9uYRkHh
         bQf2jnwVLHEDB93kQE5Aj5OgxHEr+FJwGTDPrhANnN2HG6e2af8tSdS4Gf2ynkYQK0B8
         dEOg==
X-Gm-Message-State: APjAAAV+Yhrn6ldEmdo1EF3XmkpaLPXinPBrpnZ1lJsldItQ5Tow68wq
        zSaiJDmqa8M4xbdfIwLUKcVkm6fDeWcNHrqHERHXWg==
X-Google-Smtp-Source: APXvYqxLrh5aVv3p0xE1Cuv2M9Lu4EqPeULGldZRnOqi6Hjy+4RMLF1tR9vxtOQ6RJa0zB6OkWOb0ZxRDT43EqGIS1Q=
X-Received: by 2002:a92:d608:: with SMTP id w8mr14471824ilm.308.1574069682145;
 Mon, 18 Nov 2019 01:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20190830074103.16671-1-bibby.hsieh@mediatek.com> <20190830074103.16671-3-bibby.hsieh@mediatek.com>
In-Reply-To: <20190830074103.16671-3-bibby.hsieh@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 18 Nov 2019 17:34:16 +0800
Message-ID: <CAJMQK-ir=8ukNZw8XN=prLuh3znjbjNszVB=dcDxa_bVnFwVAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mediatek: Apply CMDQ control flow
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>, tfiga@chromium.org,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 7:41 AM Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:

> @@ -405,26 +458,69 @@ void mtk_drm_crtc_cursor_update(struct drm_crtc *crtc, struct drm_plane *plane,
>                 return;
>
>         mutex_lock(&priv->hw_lock);
> -       plane_helper_funcs->atomic_update(plane, plane_state);
> -       for (i = 0; i < mtk_crtc->layer_nr; i++) {
> -               struct drm_plane *plane = &mtk_crtc->planes[i];
> -               struct mtk_plane_state *plane_state;
> +       if (IS_ENABLED(CONFIG_MTK_CMDQ) && mtk_crtc->cmdq_client) {
> +               struct mtk_crtc_state *mtk_crtc_state =
> +                               to_mtk_crtc_state(crtc->state);
> +               struct mtk_cmdq_cb_data *cb_data;
> +
> +               mtk_crtc_state->cmdq_handle =
> +                               cmdq_pkt_create(mtk_crtc->cmdq_client,
> +                                               PAGE_SIZE);
> +               cmdq_pkt_clear_event(mtk_crtc_state->cmdq_handle,
> +                                    mtk_crtc->cmdq_event);
> +               cmdq_pkt_wfe(mtk_crtc_state->cmdq_handle, mtk_crtc->cmdq_event);
> +               plane_helper_funcs->atomic_update(plane, plane_state);
> +               cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
Check kmalloc failure?
> +               cb_data->cmdq_handle = mtk_crtc_state->cmdq_handle;
> +               cmdq_pkt_flush_async(mtk_crtc_state->cmdq_handle,
> +                                    ddp_cmdq_cursor_cb, cb_data);

> @@ -494,13 +599,29 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>                                       struct drm_crtc_state *old_crtc_state)
>  {
>         struct drm_atomic_state *old_atomic_state = old_crtc_state->state;
> +       struct drm_crtc_state *crtc_state = crtc->state;
> +       struct mtk_crtc_state *state = to_mtk_crtc_state(crtc_state);
> +       struct cmdq_pkt *cmdq_handle = state->cmdq_handle;
>         struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
>         struct mtk_drm_private *priv = crtc->dev->dev_private;
> +       struct mtk_cmdq_cb_data *cb_data;
>         unsigned int pending_planes = 0;
>         int i;
>
> -       if (mtk_crtc->event)
> -               mtk_crtc->pending_needs_vblank = true;
> +       DRM_DEBUG_DRIVER("[CRTC:%u] [STATE:%p(%p)->%p(%p)]\n", crtc->base.id,
> +                        old_crtc_state, old_crtc_state->state,
> +                        crtc_state, crtc_state->state);
> +
> +       if (IS_ENABLED(CONFIG_MTK_CMDQ) && mtk_crtc->cmdq_client) {
> +               drm_atomic_state_get(old_atomic_state);
> +               cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
Check kmalloc failure?
> +               cb_data->state = old_crtc_state;
> +               cb_data->cmdq_handle = cmdq_handle;
