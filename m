Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474992171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfCMJMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:12:10 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:53229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbfCMJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:12:09 -0400
X-UUID: a4ae4db5cc434582a9148da334c2e57d-20190313
X-UUID: a4ae4db5cc434582a9148da334c2e57d-20190313
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 650479586; Wed, 13 Mar 2019 17:11:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Mar
 2019 17:11:53 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Mar 2019 17:11:53 +0800
Message-ID: <1552468313.7433.14.camel@mhfsdcap03>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>, <arnd@arndb.de>,
        <srv_heupstream@mediatek.com>, Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <yingjoe.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 13 Mar 2019 17:11:53 +0800
In-Reply-To: <709d7d66-9610-eeb3-128e-e2156bcfb616@arm.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
         <709d7d66-9610-eeb3-128e-e2156bcfb616@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

sorry for reply so late.

On Wed, 2019-02-27 at 19:30 +0000, Robin Murphy wrote:
> On 01/01/2019 04:51, Yong Wu wrote:
> > MediaTek IOMMU don't have its power-domain. all the consumer connect
> > with smi-larb, then connect with smi-common.
> > 
> >          M4U
> >           |
> >      smi-common
> >           |
> >    -------------
> >    |         |    ...
> >    |         |
> > larb1     larb2
> >    |         |
> > vdec       venc
> > 
> > When the consumer works, it should enable the smi-larb's power which
> > also need enable the smi-common's power firstly.
> > 
> > Thus, First of all, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> > 
> > This patch adds device_link between the consumer and the larbs.
> > 
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
> >   drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
> >   2 files changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 202e41b..735ae8d 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >   	struct mtk_smi_larb_iommu    *larb_mmu;
> >   	unsigned int                 larbid, portid;
> >   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct device_link *link;
> >   	int i;
> >   
> >   	for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >   		dev_dbg(dev, "%s iommu port: %d\n",
> >   			enable ? "enable" : "disable", portid);
> >   
> > -		if (enable)
> > +		if (enable) {
> >   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -		else
> > +			/* Link the consumer with the larb device(supplier) */
> > +			link = device_link_add(dev, larb_mmu->dev,
> > +					       DL_FLAG_PM_RUNTIME |
> > +					       DL_FLAG_AUTOREMOVE_CONSUMER);
> 
> This looks technically wrong, since we get here from 
> mtk_iommu_attach_device(), and in theory a device could get attached to 
> any number of domains over its lifetime, so adding a link at this point 
> when there's no corresponding cleanup on detach is definitely 
> unbalanced. If you want this layer to manage the link on behalf of the 
> consumer, it would probably be better to do it at the point of 
> mtk_iommu_add_device(), and either track it for manual cleanup in 
> mtk_iommu_remove_device() or rely on AUTOREMOVE_SUPPLIER.

Thanks. I will try to move the "device_link_add" in add_device in next
version.

> 
> Robin.
> 
> > +			if (!link) {
> > +				dev_err(dev, "Unable to link %s\n",
> > +					dev_name(larb_mmu->dev));
> > +				return;
> > +			}
> > +		} else {
> >   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +		}
> >   	}
> >   }
> >   
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 9386aee..022bad9 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >   	struct mtk_smi_larb_iommu    *larb_mmu;
> >   	unsigned int                 larbid, portid;
> >   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct device_link *link;
> >   	int i;
> >   
> >   	for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >   		dev_dbg(dev, "%s iommu port: %d\n",
> >   			enable ? "enable" : "disable", portid);
> >   
> > -		if (enable)
> > +		if (enable) {
> >   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -		else
> > +			link = device_link_add(dev, larb_mmu->dev,
> > +					       DL_FLAG_PM_RUNTIME |
> > +					       DL_FLAG_AUTOREMOVE_CONSUMER);
> > +			if (!link) {
> > +				dev_err(dev, "Unable to link %s\n",
> > +					dev_name(larb_mmu->dev));
> > +				return;
> > +			}
> > +		} else {
> >   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +		}
> >   	}
> >   }
> >   
> > 


