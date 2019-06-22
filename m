Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3E2C4646C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 02:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6352089E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 02:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFVCmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 22:42:55 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40257 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbfFVCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 22:42:55 -0400
X-UUID: 3a5c12a496284309aaa64221c992f670-20190622
X-UUID: 3a5c12a496284309aaa64221c992f670-20190622
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1618682078; Sat, 22 Jun 2019 10:42:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 22 Jun
 2019 10:42:48 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Jun 2019 10:42:47 +0800
Message-ID: <1561171367.4850.8.camel@mhfsdcap03>
Subject: Re: [PATCH v2 02/12] iommu/mediatek: Add probe_defer for smi-larb
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Evan Green" <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>
Date:   Sat, 22 Jun 2019 10:42:47 +0800
In-Reply-To: <a11fa818-cf62-cc24-2c41-4688fda5a88f@gmail.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
         <1560171313-28299-3-git-send-email-yong.wu@mediatek.com>
         <a11fa818-cf62-cc24-2c41-4688fda5a88f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 62D4D809DF879D30713C1D085668025D905896208B75832BE651A5243713B1D32000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2019-06-19 at 15:52 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:55, Yong Wu wrote:
> > The iommu consumer should use device_link to connect with the
> > smi-larb(supplier). then the smi-larb should run before the iommu
> > consumer. Here we delay the iommu driver until the smi driver is
> > ready, then all the iommu consumer always is after the smi driver.
> > 
> > When there is no this patch, if some consumer drivers run before
> > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > device_link_add, then device_links_driver_bound will use WARN_ON
> > to complain that the link_status of supplier is not right.
> > 
> > This is a preparing patch for adding device_link.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 2 +-
> >  drivers/iommu/mtk_iommu_v1.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6fe3369..f7599d8 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -664,7 +664,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  			id = i;
> >  
> >  		plarbdev = of_find_device_by_node(larbnode);
> > -		if (!plarbdev) {
> > +		if (!plarbdev || !plarbdev->dev.driver) {
> 
> can't we use:
> device_lock()
> device_is_bound(struct device *dev)
> device_unlock()

A new API for me. Thanks the hint. I have tried. it is ok.


> 
> >  			of_node_put(larbnode);
> >  			return -EPROBE_DEFER;
> >  		}
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 0b0908c..c43c4a0 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -604,7 +604,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  			plarbdev = of_platform_device_create(
> >  						larb_spec.np, NULL,
> >  						platform_bus_type.dev_root);
> > -			if (!plarbdev) {
> > +			if (!plarbdev || !plarbdev->dev.driver) {
> >  				of_node_put(larb_spec.np);
> >  				return -EPROBE_DEFER;
> >  			}
> > 



