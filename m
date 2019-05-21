Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA40C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE482075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEUDaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:30:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42512 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726511AbfEUDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:30:35 -0400
X-UUID: 7d869cde9c4749b087a8b3304ded80b8-20190521
X-UUID: 7d869cde9c4749b087a8b3304ded80b8-20190521
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 77106509; Tue, 21 May 2019 11:30:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 11:30:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 11:30:25 +0800
Message-ID: <1558409425.25526.13.camel@mtksdaap41>
Subject: Re: [PATCH v7 11/12] soc: mediatek: cmdq: add
 cmdq_dev_get_client_reg function
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
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>
Date:   Tue, 21 May 2019 11:30:25 +0800
In-Reply-To: <20190521011108.40428-12-bibby.hsieh@mediatek.com>
References: <20190521011108.40428-1-bibby.hsieh@mediatek.com>
         <20190521011108.40428-12-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 798B638221290F7BC5D8959C66269264E402B2FA60D529F582211C428B8D881B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 09:11 +0800, Bibby Hsieh wrote:
> GCE cannot know the register base address, this function
> can help cmdq client to get the cmdq_client_reg structure.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  | 18 ++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 70ad4d806fac..815845bb5982 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -27,6 +27,31 @@ struct cmdq_instruction {
>  	u8 op;
>  };
>  
> +struct cmdq_client_reg  *cmdq_dev_get_client_reg(struct device *dev, int idx)
> +{
> +	struct cmdq_client_reg *client_reg;
> +	struct of_phandle_args spec;
> +
> +	client_reg  = devm_kzalloc(dev, sizeof(*client_reg), GFP_KERNEL);
> +	if (!client_reg)
> +		return NULL;
> +
> +	if (of_parse_phandle_with_args(dev->of_node, "mediatek,gce-client-reg",
> +				       "#subsys-cells", idx, &spec)) {
> +		dev_err(dev, "can't parse gce-client-reg property (%d)", idx);

I think you should call devm_kfree(client_reg) here because this
function may not be called in client driver's probe function. But in
another view point, I would like you to move the memory allocation out
of this function. When client call cmdq_dev_get_client_reg() to get a
pointer, it's easy that client does not free it because you does not
provide free API, Some client may embed struct cmdq_client_reg with its
client structure together,

struct client {
	struct cmdq_client_reg client_reg;
};

Because each client may have different memory allocation strategy, so I
would like you to move memory allocation out of this function to let
client driver have the flexibility.

Regards,
CK

> +
> +		return NULL;
> +	}
> +
> +	client_reg->subsys = spec.args[0];
> +	client_reg->offset = spec.args[1];
> +	client_reg->size = spec.args[2];
> +	of_node_put(spec.np);
> +
> +	return client_reg;
> +}
> +EXPORT_SYMBOL(cmdq_dev_get_client_reg);
> +
>  static void cmdq_client_timeout(struct timer_list *t)
>  {
>  	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index a345870a6d10..d0dea3780f7a 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -15,6 +15,12 @@
>  
>  struct cmdq_pkt;
>  
> +struct cmdq_client_reg {
> +	u8 subsys;
> +	u16 offset;
> +	u16 size;
> +};
> +
>  struct cmdq_client {
>  	spinlock_t lock;
>  	u32 pkt_cnt;
> @@ -142,4 +148,16 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>   */
>  int cmdq_pkt_flush(struct cmdq_pkt *pkt);
>  
> +/**
> + * cmdq_dev_get_client_reg() - parse cmdq client reg from the device node of CMDQ client
> + * @dev:	device of CMDQ mailbox client
> + * @idx:	the index of desired reg
> + *
> + * Return: CMDQ client reg pointer
> + *
> + * Help CMDQ client pasing the cmdq client reg
> + * from the device node of CMDQ client.
> + */
> +struct cmdq_client_reg  *cmdq_dev_get_client_reg(struct device *dev, int idx);
> +
>  #endif	/* __MTK_CMDQ_H__ */


