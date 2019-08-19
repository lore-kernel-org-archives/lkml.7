Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8EC3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7A2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfHSDN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 23:13:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31290 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726261AbfHSDN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 23:13:26 -0400
X-UUID: ee80ecc5facb4d3ba5cfca1ea8ca1f48-20190819
X-UUID: ee80ecc5facb4d3ba5cfca1ea8ca1f48-20190819
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1125332097; Mon, 19 Aug 2019 11:13:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 11:13:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 11:13:20 +0800
Message-ID: <1566184400.6182.0.camel@mtksdaap41>
Subject: Re: [PATCH v12 11/12] soc: mediatek: cmdq: add
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
Date:   Mon, 19 Aug 2019 11:13:20 +0800
In-Reply-To: <20190819025359.11381-12-bibby.hsieh@mediatek.com>
References: <20190819025359.11381-1-bibby.hsieh@mediatek.com>
         <20190819025359.11381-12-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Mon, 2019-08-19 at 10:53 +0800, Bibby Hsieh wrote:
> GCE cannot know the register base address, this function
> can help cmdq client to get the cmdq_client_reg structure.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 29 ++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  | 21 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 340a92a254e5..1bed07362b7a 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -27,6 +27,35 @@ struct cmdq_instruction {
>  	u8 op;
>  };
>  
> +int cmdq_dev_get_client_reg(struct device *dev,
> +			    struct cmdq_client_reg *client_reg, int idx)
> +{
> +	struct of_phandle_args spec;
> +	int err;
> +
> +	if (!client_reg)
> +		return -ENOENT;
> +
> +	err = of_parse_phandle_with_fixed_args(dev->of_node,
> +					       "mediatek,gce-client-reg",
> +					       3, idx, &spec);
> +	if (err < 0) {
> +		dev_err(dev,
> +			"error %d can't parse gce-client-reg property (%d)",
> +			err, idx);
> +
> +		return err;
> +	}
> +
> +	client_reg->subsys = (u8)spec.args[0];
> +	client_reg->offset = (u16)spec.args[1];
> +	client_reg->size = (u16)spec.args[2];
> +	of_node_put(spec.np);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_dev_get_client_reg);
> +
>  static void cmdq_client_timeout(struct timer_list *t)
>  {
>  	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index a345870a6d10..6215d4fc4ba3 100644
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
> @@ -24,6 +30,21 @@ struct cmdq_client {
>  	u32 timeout_ms; /* in unit of microsecond */
>  };
>  
> +/**
> + * cmdq_dev_get_client_reg() - parse cmdq client reg from the device
> + *			       node of CMDQ client
> + * @dev:	device of CMDQ mailbox clienti
> + * @client_reg: CMDQ client reg pointer
> + * @idx:	the index of desired reg
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Help CMDQ client pasing the cmdq client reg
> + * from the device node of CMDQ client.
> + */
> +int cmdq_dev_get_client_reg(struct device *dev,
> +			    struct cmdq_client_reg *client_reg, int idx);
> +
>  /**
>   * cmdq_mbox_create() - create CMDQ mailbox client and channel
>   * @dev:	device of CMDQ mailbox client


