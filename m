Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C17C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903B20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2I2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:28:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42459 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbfE2I2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:28:30 -0400
X-UUID: 725f9bdff6c840129cdc26316ed95433-20190529
X-UUID: 725f9bdff6c840129cdc26316ed95433-20190529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1005367912; Wed, 29 May 2019 16:28:18 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 16:28:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 16:28:16 +0800
Message-ID: <1559118496.4226.11.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] drm: mediatek: fix unbind functions
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 29 May 2019 16:28:16 +0800
In-Reply-To: <CAJMQK-jDhDNViUA3dpixG=_Pe7x0qH4utBWy3k+D_+oKwEOPig@mail.gmail.com>
References: <20190527045054.113259-1-hsinyi@chromium.org>
         <20190527045054.113259-2-hsinyi@chromium.org>
         <1559093711.11380.6.camel@mtksdaap41>
         <CAJMQK-jDhDNViUA3dpixG=_Pe7x0qH4utBWy3k+D_+oKwEOPig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: A023916AAC1D56E857E7DE6AAAEAA623764789450FCB15420F9FB9F4341CEE5A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

On Wed, 2019-05-29 at 15:06 +0800, Hsin-Yi Wang wrote:
> On Wed, May 29, 2019 at 9:35 AM CK Hu <ck.hu@mediatek.com> wrote:
> 
> >
> > I think mtk_dsi_destroy_conn_enc() has much thing to do and I would like
> > you to do more. You could refer to [2] for complete implementation.
> >
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/exynos/exynos_drm_dsi.c?h=v5.2-rc2#n1575
> >
> Hi CK,
> 
> Since drm_encoder_cleanup() would already call drm_bridge_detach() to
> detach bridge, I think we only need to handle panel case here.
> We don't need to call mtk_dsi_encoder_disable() since
> mtk_output_dsi_disable() is called in mtk_dsi_remove() and
> dsi->enabled will be set to false. Calling second time will just
> returns immediately.
> So, besides setting
> 
> dsi->panel = NULL;
> dsi->conn.status = connector_status_disconnected;

Sorry, I think your original patch is good enough, and you need not to
do the besides setting.

Regards,
CK

> 
> are there other things we need to do here?
> 
> Original code doesn't have drm_kms_helper_hotplug_event(), and I'm not
> sure if mtk dsi would need this.
> Also, mtk_dsi_stop() would also stop irq.
> 
> Thanks



