Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A643206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEPK2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:28:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbfEPK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:28:02 -0400
X-UUID: 9a679317c85841b5ab9d58d9ece93467-20190516
X-UUID: 9a679317c85841b5ab9d58d9ece93467-20190516
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1700159974; Thu, 16 May 2019 18:27:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 16 May 2019 18:27:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 16 May 2019 18:27:52 +0800
Message-ID: <1558002472.26743.2.camel@mtksdaap41>
Subject: Re: [PATCH v6 11/12] soc: mediatek: cmdq: add cmdq_dev_get_event
 function
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
Date:   Thu, 16 May 2019 18:27:52 +0800
In-Reply-To: <20190516090224.59070-12-bibby.hsieh@mediatek.com>
References: <20190516090224.59070-1-bibby.hsieh@mediatek.com>
         <20190516090224.59070-12-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 340E37131E274E309CCD55145B936522FE76AA128486110F5FC92DCAA60C875A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Thu, 2019-05-16 at 17:02 +0800, Bibby Hsieh wrote:
> When client ask gce to clear or wait for event,
> client need to pass event number to the API.
> We suggest client store the event information in device node,
> so we provide an API for client parse the event property.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 18 ++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index a64060a34e01..e9658063c3d4 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -52,6 +52,24 @@ struct cmdq_subsys *cmdq_dev_get_subsys(struct device *dev, int idx)
>  }
>  EXPORT_SYMBOL(cmdq_dev_get_subsys);
>  
> +s32 cmdq_dev_get_event(struct device *dev, int index)
> +{
> +	s32 result;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	if (of_property_read_u32_index(dev->of_node, "mediatek,gce-events",
> +				       index, &result)) {
> +		dev_err(dev, "can't parse gce-events property");
> +
> +		return -ENODEV;
> +	}
> +
> +	return result;

This function just does one thing, so client driver could just directly
call of_property_read_u32_index().

Regards,
CK

> +}
> +EXPORT_SYMBOL(cmdq_dev_get_event);
> +
>  static void cmdq_client_timeout(struct timer_list *t)
>  {
>  	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 574006c5cd76..525713bf79b5 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -160,4 +160,16 @@ int cmdq_pkt_flush(struct cmdq_pkt *pkt);
>   */
>  struct cmdq_subsys *cmdq_dev_get_subsys(struct device *dev, int idx);
>  
> +/**
> + * cmdq_dev_get_event() - parse event from the device node of CMDQ client
> + * @dev:	device of CMDQ mailbox client
> + * @index:	the index of desired event
> + *
> + * Return: CMDQ event number
> + *
> + * Help CMDQ client pasing the event number
> + * from the device node of CMDQ client.
> + */
> +s32 cmdq_dev_get_event(struct device *dev, int index);
> +
>  #endif	/* __MTK_CMDQ_H__ */


