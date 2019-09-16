Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA6C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E521670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2S9vcgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbfIPNT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:19:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41949 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbfIPNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:19:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id x4so11502528qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aZ3prQ2MeDSXxYktZG7mMEIanf5iPS/oBCM9iozvwW4=;
        b=d2S9vcgs6v4gH4OH8OAVymCe0ul6kgViLHGVsU2o7gdBBjPqtcg5nPzrutJ8NVS1w9
         jN6XJnJNsLtzv+lHlHhbFX8Zgd9uxTOavAntQD7SSJP76Bmwlf0P3YxBOuquds5uqeXE
         1UKflEppxqF9sSy1aL0yVKr7GfeSLAGmqFXMYr6Hs/2s8teCdwfYEs9nUX8U6UN4hBPC
         yz3q/9dvLxDCnxIfChxvJY90K+oood2mjlmleDLfuxcwWHHQCc432CKRd3bqikAwdmFb
         QrEmDy/ygRBGUliTSLu1fvrTa12WWA0/B8mbcQsS/mKagDAh73kWIx3SyuBvkJ5BZFwF
         vLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aZ3prQ2MeDSXxYktZG7mMEIanf5iPS/oBCM9iozvwW4=;
        b=VBiYw4DKeBQa8TGLFkqwVAJKdIGp1mR8VNzgToNl2LCCLjKLchyl06rTP/5ns26x8a
         s8Q+qSC5sg8+XrAGsXREDJzn9oKFL+6NRonGqG9otVLOi1y+tU7PBbRBzJFhPYyEtnq/
         I80PkWw+V98hmukqheJsso9HhNnzyumKBVW3U+g1gxNDfmLN64moaSeifTksOGKszm/y
         8R8OKTQGu8A9GunnFRkp2b+ThgPU+XWr9jnH5PVq7fvmU7HT4vCGc9ALlTTnwC+FSNku
         iBhSHvvQW7DMhr4dZKMj7YE+UYRJfNRrQCWi1FcIBRpmDr8iO4zcDFIMh2xCEuzdaBNA
         AbOw==
X-Gm-Message-State: APjAAAWAXOcPMLBqRfcarWQI7QIaoN5Py4+olIyxeWboyts71KysCMMz
        lpDPM7lapuUKh1UJQqGS8/dGwc8+dbuL9ZX01JYVUH8Q
X-Google-Smtp-Source: APXvYqw+2su+EJJYEJ0WNUOevzruDoc5jnoVjvf91q9E+XMfpPxafQbGoC6EOHRsKgVqJNo8zwiU/q114VoLMVGFA4U=
X-Received: by 2002:a0c:e5c6:: with SMTP id u6mr5136904qvm.106.1568639966038;
 Mon, 16 Sep 2019 06:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190909135205.10277-1-benjamin.gaignard@st.com> <20190909135205.10277-2-benjamin.gaignard@st.com>
In-Reply-To: <20190909135205.10277-2-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 16 Sep 2019 15:19:15 +0200
Message-ID: <CA+M3ks7Y998qW+dOLPD+WLUH-Qi-=-okTYwDh7SBB0xo5XAs_w@mail.gmail.com>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 9 sept. 2019 =C3=A0 16:41, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Fix warnings with W=3D1.
> Few for_each macro set variables that are never used later.
> Prevent warning by marking these variables as __maybe_unused.
>

A little up on this one because it may exist others ways to fix these warni=
ngs.
Get feedback on this path could give the direction for similar ones in drm.

Thanks,
Benjamin

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++-------------=
-----
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index aa16ea17ff9b..b69d17b0b9bd 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
>               struct drm_encoder *encoder)
>  {
>         struct drm_crtc_state *crtc_state;
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *old_connector_state, *new_connector_s=
tate;
>         int i;
>
> @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
>  {
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *new_crtc_state;
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *new_conn_state;
>         int i;
>         int ret;
> @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_device *de=
v,
>  {
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *old_connector_state, *new_connector_s=
tate;
>         int i, ret;
>         unsigned connectors_mask =3D 0;
> @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
>  static void
>  disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_sta=
te)
>  {
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *old_conn_state, *new_conn_state;
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_at=
omic_state *old_state)
>  {
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *new_crtc_state;
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *new_conn_state;
>         int i;
>
> @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables(struc=
t drm_device *dev,
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *old_crtc_state;
>         struct drm_crtc_state *new_crtc_state;
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *new_conn_state;
>         int i;
>
> @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_de=
vice *dev,
>                                       struct drm_atomic_state *state,
>                                       bool pre_swap)
>  {
> -       struct drm_plane *plane;
> +       struct drm_plane __maybe_unused *plane;
>         struct drm_plane_state *new_plane_state;
>         int i, ret;
>
> @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_devic=
e *dev,
>                 struct drm_atomic_state *old_state)
>  {
>         struct drm_crtc *crtc;
> -       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +       struct drm_crtc_state __maybe_unused *old_crtc_state, *new_crtc_s=
tate;
>         int i, ret;
>         unsigned crtc_mask =3D 0;
>
> @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *work)
>  int drm_atomic_helper_async_check(struct drm_device *dev,
>                                    struct drm_atomic_state *state)
>  {
> -       struct drm_crtc *crtc;
> +       struct drm_crtc __maybe_unused *crtc;
>         struct drm_crtc_state *crtc_state;
>         struct drm_plane *plane =3D NULL;
>         struct drm_plane_state *old_plane_state =3D NULL;
> @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm_atomi=
c_state *state,
>  {
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> -       struct drm_connector *conn;
> +       struct drm_connector __maybe_unused *conn;
>         struct drm_connector_state *old_conn_state, *new_conn_state;
> -       struct drm_plane *plane;
> +       struct drm_plane __maybe_unused *plane;
>         struct drm_plane_state *old_plane_state, *new_plane_state;
>         struct drm_crtc_commit *commit;
>         int i, ret;
> @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
>   */
>  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state=
)
>  {
> -       struct drm_crtc *crtc;
> +       struct drm_crtc __maybe_unused *crtc;
>         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>         struct drm_crtc_commit *commit;
>         int i;
> @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done=
);
>  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
>                                      struct drm_atomic_state *state)
>  {
> -       struct drm_connector *connector;
> +       struct drm_connector __maybe_unused *connector;
>         struct drm_connector_state *new_conn_state;
>         struct drm_plane *plane;
>         struct drm_plane_state *new_plane_state;
> @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_device=
 *dev,
>  {
>         struct drm_atomic_state *state;
>         struct drm_connector_state *conn_state;
> -       struct drm_connector *conn;
> +       struct drm_connector __maybe_unused *conn;
>         struct drm_plane_state *plane_state;
> -       struct drm_plane *plane;
> +       struct drm_plane __maybe_unused *plane;
>         struct drm_crtc_state *crtc_state;
>         struct drm_crtc *crtc;
>         int ret, i;
> @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_state(str=
uct drm_atomic_state *state,
>  {
>         int i, ret;
>         struct drm_plane *plane;
> -       struct drm_plane_state *new_plane_state;
> +       struct drm_plane_state __maybe_unused *new_plane_state;
>         struct drm_connector *connector;
> -       struct drm_connector_state *new_conn_state;
> +       struct drm_connector_state __maybe_unused *new_conn_state;
>         struct drm_crtc *crtc;
> -       struct drm_crtc_state *new_crtc_state;
> +       struct drm_crtc_state __maybe_unused *new_crtc_state;
>
>         state->acquire_ctx =3D ctx;
>
> --
> 2.15.0
>
