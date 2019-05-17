Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F3BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635832087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfEQDc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:32:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31767 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbfEQDc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:32:57 -0400
X-UUID: 7c00949786d04952aa8af5a7eec0004e-20190517
X-UUID: 7c00949786d04952aa8af5a7eec0004e-20190517
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1375638928; Fri, 17 May 2019 11:32:48 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 17 May 2019 11:32:39 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 17 May 2019 11:32:39 +0800
Message-ID: <1558063959.14401.18.camel@mtksdaap41>
Subject: Re: [PATCH v6 08/12] soc: mediatek: cmdq: define the instruction
 struct
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "YT Shen" <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh 
        <dennis-yc.hsimediatek/mtkcam/drv/fdvt/4.0/cam_fdvt_v4l2.cppeh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>
Date:   Fri, 17 May 2019 11:32:39 +0800
In-Reply-To: <20190516090224.59070-9-bibby.hsieh@mediatek.com>
References: <20190516090224.59070-1-bibby.hsieh@mediatek.com>
         <20190516090224.59070-9-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 9C00DE444E660D85CDFD1DC30AAFFABEDB58AFC441998971D133D2E68A8E916E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Thu, 2019-05-16 at 17:02 +0800, Bibby Hsieh wrote:
> Define a instruction structure for gce driver to append command.
> This structure can make the client's code more readability.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c   | 113 +++++++++++++++--------
>  include/linux/mailbox/mtk-cmdq-mailbox.h |   2 +
>  include/linux/soc/mediatek/mtk-cmdq.h    |  14 +--
>  3 files changed, 84 insertions(+), 45 deletions(-)
> 

[snip]

>  
>  /**
>   * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
>   * @pkt:	the CMDQ packet
> - * @value:	the specified target register value
>   * @subsys:	the CMDQ sub system code
>   * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
>   * @mask:	the specified target register mask
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> -			u32 subsys, u32 offset, u32 mask);
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> +			u32 value, u32 mask);

You have do two things for this interface: one is reordering the
parameter, another one is changing type of subsys from u32 to u8.

Define the instruction struct is not necessary to change the order and
type. I would like you to separate these two things to another patches.
So the patch sequence may be:

1. Reorder parameter of cmdq_pkt_write_mask()
2. Change subsys type to u8
3. define the instruction struct

Regards,
CK

>  
>  /**
>   * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> @@ -88,7 +88,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
>  
>  /**
>   * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> @@ -97,7 +97,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
>  
>  /**
>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ


