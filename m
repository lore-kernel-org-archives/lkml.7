Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B9D2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfH0D7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:59:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46880 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728820AbfH0D7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:59:34 -0400
X-UUID: e45fd75da6594be69814b2941f255a4a-20190827
X-UUID: e45fd75da6594be69814b2941f255a4a-20190827
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 838284026; Tue, 27 Aug 2019 11:59:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 27 Aug 2019 11:59:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Aug 2019 11:59:36 +0800
Message-ID: <1566878368.29523.1.camel@mtksdaap41>
Subject: Re: [RESEND, PATCH v13 11/12] soc: mediatek: cmdq: add
 cmdq_dev_get_client_reg function
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>
Date:   Tue, 27 Aug 2019 11:59:28 +0800
In-Reply-To: <ccd3782e-b1bb-7887-f4a5-d7774183c7b7@gmail.com>
References: <20190820084932.22282-1-bibby.hsieh@mediatek.com>
         <20190820084932.22282-12-bibby.hsieh@mediatek.com>
         <ccd3782e-b1bb-7887-f4a5-d7774183c7b7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 16:21 +0200, Matthias Brugger wrote:
> 
> On 20/08/2019 10:49, Bibby Hsieh wrote:
> > GCE cannot know the register base address, this function
> > can help cmdq client to get the cmdq_client_reg structure.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-cmdq-helper.c | 29 ++++++++++++++++++++++++++
> >  include/linux/soc/mediatek/mtk-cmdq.h  | 21 +++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > index c53f8476c68d..80f75a1075b4 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -27,6 +27,35 @@ struct cmdq_instruction {
> >  	u8 op;
> >  };
> >  
> > +int cmdq_dev_get_client_reg(struct device *dev,
> > +			    struct cmdq_client_reg *client_reg, int idx)
> > +{
> 
> Can't we do/call this in cmdq_mbox_create parsing the number of gce-client-reg
> properties we have and allocating these using a pointer to cmdq_client_reg in
> cmdq_client?
> We will have to free the pointer then in cmdq_mbox_destroy.
> 
> Regards,
> Matthias

I don't think we need to keep the cmdq_client_reg in cmdq_client
structure.
Because our client will have own data structure, they will copy the
client_reg information into their own structure.

In the design now, we do not allocate the cmdq_client_reg, client pass
the cmdq_client_reg pointer into this API.
Client will destroy the pointer after they get the information they
want.

Thanks for the comments so much.

Bibby

> 
> > +	struct of_phandle_args spec;
> > +	int err;
> > +
> > +	if (!client_reg)
> > +		return -ENOENT;
> > +
> > +	err = of_parse_phandle_with_fixed_args(dev->of_node,
> > +					       "mediatek,gce-client-reg",
> > +					       3, idx, &spec);
> > +	if (err < 0) {
> > +		dev_err(dev,
> > +			"error %d can't parse gce-client-reg property (%d)",
> > +			err, idx);
> > +
> > +		return err;
> > +	}
> > +
> > +	client_reg->subsys = (u8)spec.args[0];
> > +	client_reg->offset = (u16)spec.args[1];
> > +	client_reg->size = (u16)spec.args[2];
> > +	of_node_put(spec.np);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_dev_get_client_reg);
> > +
> >  static void cmdq_client_timeout(struct timer_list *t)
> >  {
> >  	struct cmdq_client *client = from_timer(client, t, timer);
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> > index a345870a6d10..02ddd60b212f 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -15,6 +15,12 @@
> >  
> >  struct cmdq_pkt;
> >  
> > +struct cmdq_client_reg {
> > +	u8 subsys;
> > +	u16 offset;
> > +	u16 size;
> > +};
> > +
> >  struct cmdq_client {
> >  	spinlock_t lock;
> >  	u32 pkt_cnt;
> > @@ -24,6 +30,21 @@ struct cmdq_client {
> >  	u32 timeout_ms; /* in unit of microsecond */
> >  };
> >  
> > +/**
> > + * cmdq_dev_get_client_reg() - parse cmdq client reg from the device
> > + *			       node of CMDQ client
> > + * @dev:	device of CMDQ mailbox client
> > + * @client_reg: CMDQ client reg pointer
> > + * @idx:	the index of desired reg
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + *
> > + * Help CMDQ client parsing the cmdq client reg
> > + * from the device node of CMDQ client.
> > + */
> > +int cmdq_dev_get_client_reg(struct device *dev,
> > +			    struct cmdq_client_reg *client_reg, int idx);
> > +
> >  /**
> >   * cmdq_mbox_create() - create CMDQ mailbox client and channel
> >   * @dev:	device of CMDQ mailbox client
> > 


