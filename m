Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3DC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BCF216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSu6+dlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE2HGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:06:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33499 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2HGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:06:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so1359132qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA9B1CIdYn7uFQh9agY6VqwI4z4QDnUm8YBBmahDu4U=;
        b=RSu6+dlro0iGo/wUkUotKEAtoX5JlmpVTXx83cweGW1rp3wkzwJvCnwrRTU9LabdhH
         WJzxoaT/USBOZMKWfosrpwqhOlCtxQhy0+dWLhm1GUa4vdZxi4ALhT4Gsa6dE7h4rntu
         4rNayUppH/l8daDhNYVSVWru1i7bkr9B8Pxdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA9B1CIdYn7uFQh9agY6VqwI4z4QDnUm8YBBmahDu4U=;
        b=ZzE1K7KNV/FcCtCPDPFpJZ0/Is8v1s/JmSGt4Su4MKDheLIjRtR0n7GJq+dMHPbUGO
         rTVkVjBJcixDHZRPZtfI9jmqciWx+iwbHX3vfdHcD3jHBF2vHiKkJ0CefhNZiuH7aG8x
         VQx0xHNWPpiAYasANk3SzHizqFB0Y16HkmtzUScab9EBYcvey1EH2Sa6s8mH4Mb0ZWPM
         TNl26QV/JKvJABZQQSG+sV+SKDjgrcyF1LPFrRWxh6/doW953uRcYVInvZsdE/XDgAmF
         EmjUS0MKZZOILzB9/oWlFqqR+YLasSpA7jtJRhFpdkFOo76uT5ooM/qpPtE6ZK29Q5jn
         bn0A==
X-Gm-Message-State: APjAAAUNUzhORmuzSzFtLUt/07CSQDF/KfskoNZpVvHIIP/SJQs8Z+fw
        q76yqgRp0jxtSBqCOzL0Ih0UZ33109FWm1ra55tevQ==
X-Google-Smtp-Source: APXvYqwaIhOfv/yjZJUEyrJh1Af7NiK3bC572neTGlR+hYHK4lhLZttmwCQu3ZrIVWJojbIsz1dCv5ftzO/ZJKndKPs=
X-Received: by 2002:a0c:b66f:: with SMTP id q47mr24087512qvf.102.1559113613462;
 Wed, 29 May 2019 00:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190527045054.113259-1-hsinyi@chromium.org> <20190527045054.113259-2-hsinyi@chromium.org>
 <1559093711.11380.6.camel@mtksdaap41>
In-Reply-To: <1559093711.11380.6.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 29 May 2019 15:06:27 +0800
Message-ID: <CAJMQK-jDhDNViUA3dpixG=_Pe7x0qH4utBWy3k+D_+oKwEOPig@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: mediatek: fix unbind functions
To:     CK Hu <ck.hu@mediatek.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 9:35 AM CK Hu <ck.hu@mediatek.com> wrote:

>
> I think mtk_dsi_destroy_conn_enc() has much thing to do and I would like
> you to do more. You could refer to [2] for complete implementation.
>
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/exynos/exynos_drm_dsi.c?h=v5.2-rc2#n1575
>
Hi CK,

Since drm_encoder_cleanup() would already call drm_bridge_detach() to
detach bridge, I think we only need to handle panel case here.
We don't need to call mtk_dsi_encoder_disable() since
mtk_output_dsi_disable() is called in mtk_dsi_remove() and
dsi->enabled will be set to false. Calling second time will just
returns immediately.
So, besides setting

dsi->panel = NULL;
dsi->conn.status = connector_status_disconnected;

are there other things we need to do here?

Original code doesn't have drm_kms_helper_hotplug_event(), and I'm not
sure if mtk dsi would need this.
Also, mtk_dsi_stop() would also stop irq.

Thanks
