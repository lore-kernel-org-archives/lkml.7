Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE00C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48562068D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPDatIoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKTS7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:59:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574276363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C35wC9q1jgeXmU7JqR3NZOFZzSw/nsQvCT6e5UF4sJQ=;
        b=jPDatIoyM4fLCbiALwAJBgde1mhP1gatYxrzfLKRzyGVL+fCV9+TjGmnK7LCb+vp+fFPZB
        uAHdCRkygTeUJIJevapZ56RwLk7i1Cd0c99jkDWv8H4l6OiOZNTRqBYImYO0TWIaSNMM7f
        9J35GGMbWrx7XajeSdtdIaBEccgR5FE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-n-w5F-KVPUSQCygg-wZtYw-1; Wed, 20 Nov 2019 13:59:22 -0500
Received: by mail-qt1-f200.google.com with SMTP id f14so520490qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=jjpGzChSbAE/VjBP60NsRZKdsVloFbVJytDXjEcLDt4=;
        b=Ed68HRqRgGZAk0tjSzcervN2QBYE4GpCGgvCl7KP3O8zf3twE7a0U8mkcaMjMvxxCi
         K4LgE6XFVM2oww1c+oYXeb8CEwRZKpN2dIeRiJECe+3uK741TsfAukUBJS26ko+143wl
         k9Y7uBrLK3Cizp4QqWREc7fujf/OdZuBAqRfLQbrAHXP7zO4obg50qkxk6C3nKzx6gOk
         acazDfg8LJLN5Fi2BMOKNDge5R0SuMS1A42Ysc4sTwoigSx2URw2OM0qXLIrDeSz0KxO
         SRPwuZxwPC7taE7qY1qCsED0oPez/oLBEAaHQkUsm2X40rnyz0mmNUOWUKhGbhNL+tap
         BqOg==
X-Gm-Message-State: APjAAAVqXDy1cFv32NL62KoqJ1hJ2fYprVomhYmu2fOTrGT7AuW5q5wP
        fuXlwmMrmEkgOh2aFcpdM2d34SEkhS+mZ9jfQK+8DkYNuMcxLMneSO/K08L5Kc7to2TKGFWAc+F
        ICJME0eoqy5DFccxkQXWYh/yk
X-Received: by 2002:ac8:7282:: with SMTP id v2mr4163994qto.75.1574276361736;
        Wed, 20 Nov 2019 10:59:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuGeUbqVAJvgnf+jTL+SyQquhjCPMRcnZFI4gqIIOO+GhNZaN7NJrRHGgM5rw14Qhz3gcGlg==
X-Received: by 2002:ac8:7282:: with SMTP id v2mr4163971qto.75.1574276361495;
        Wed, 20 Nov 2019 10:59:21 -0800 (PST)
Received: from dhcp-10-20-1-46.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id x1sm41244qke.125.2019.11.20.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:59:20 -0800 (PST)
Message-ID: <f6c44c85a63c89e548cafa55d89caccd7e868268.camel@redhat.com>
Subject: Re: [PATCH][next] drm/dp_mst: fix multiple frees of tx->bytes
From:   Lyude Paul <lyude@redhat.com>
To:     Colin King <colin.king@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Nov 2019 13:59:19 -0500
In-Reply-To: <20191120173509.347490-1-colin.king@canonical.com>
References: <20191120173509.347490-1-colin.king@canonical.com>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: n-w5F-KVPUSQCygg-wZtYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, surprised I missed this one!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Do you need me to push this to drm-misc, or do you have commit rights alrea=
dy?

On Wed, 2019-11-20 at 17:35 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently tx->bytes is being freed r->num_transactions number of
> times because tx is not being set correctly. Fix this by setting
> tx to &r->transactions[i] so that the correct objects are being
> freed on each loop iteration.
>=20
> Addresses-Coverity: ("Double free")
> Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> selftests")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ae5809a1f19a..2754e7e075e7 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -517,8 +517,10 @@ drm_dp_decode_sideband_req(const struct
> drm_dp_sideband_msg_tx *raw,
>  =09=09=09}
> =20
>  =09=09=09if (failed) {
> -=09=09=09=09for (i =3D 0; i < r->num_transactions; i++)
> +=09=09=09=09for (i =3D 0; i < r->num_transactions; i++) {
> +=09=09=09=09=09tx =3D &r->transactions[i];
>  =09=09=09=09=09kfree(tx->bytes);
> +=09=09=09=09}
>  =09=09=09=09return -ENOMEM;
>  =09=09=09}
> =20
--=20
Cheers,
=09Lyude Paul

