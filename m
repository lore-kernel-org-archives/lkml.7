Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A96C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C67206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfHOBko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 21:40:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2250 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726221AbfHOBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:40:43 -0400
X-UUID: 153b63453c964d65b347271be224daca-20190815
X-UUID: 153b63453c964d65b347271be224daca-20190815
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 817517570; Thu, 15 Aug 2019 09:40:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 15 Aug 2019 09:40:36 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 15 Aug 2019 09:40:36 +0800
Message-ID: <1565833236.24305.2.camel@mtksdaap41>
Subject: Re: [PATCH v2 0/2] drm/mediatek: make imported PRIME buffers
 contiguous
From:   CK Hu <ck.hu@mediatek.com>
To:     Alexandre Courbot <acourbot@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Aug 2019 09:40:36 +0800
In-Reply-To: <20190729053335.251379-1-acourbot@chromium.org>
References: <20190729053335.251379-1-acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandre:

On Mon, 2019-07-29 at 14:33 +0900, Alexandre Courbot wrote:
> The default DMA segment size was used when importing PRIME buffers,
> which resulted in a chance of them not being contiguous in the virtual
> IO space of the device and mtk_gem_prime_import_sg_table() complaining
> that the SG table was not contiguous as it expects.
> 
> This series fixes this issue by
> 
> 1) Using the correct DMA device when importing PRIME buffers,
> 2) Setting a more suitable DMA segment size on the DMA device than the
> default 64KB.

For the series, applied to mediatek-drm-fixes-5.3 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.3

> 
> Changes since v1:
> - Split into two patches,
> - Fixed an error path that would have returned 0.
> 
> Alexandre Courbot (2):
>   drm/mediatek: use correct device to import PRIME buffers
>   drm/mediatek: set DMA max segment size
> 
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 49 ++++++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
>  2 files changed, 48 insertions(+), 3 deletions(-)
> 


