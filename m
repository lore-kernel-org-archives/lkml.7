Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1D2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfH0EHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 00:07:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41559 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbfH0EHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:07:45 -0400
X-UUID: 1541c87a783d4fbe9bd5d7381a2f4456-20190827
X-UUID: 1541c87a783d4fbe9bd5d7381a2f4456-20190827
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1160898092; Tue, 27 Aug 2019 12:07:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 27 Aug 2019 12:07:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Aug 2019 12:07:46 +0800
Message-ID: <1566878857.29523.4.camel@mtksdaap41>
Subject: Re: [RESEND, PATCH v13 10/12] soc: mediatek: cmdq: add polling
 function
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
Date:   Tue, 27 Aug 2019 12:07:37 +0800
In-Reply-To: <2dfb6a69-c325-9caf-e11b-bf0f0fbf4bb6@gmail.com>
References: <20190820084932.22282-1-bibby.hsieh@mediatek.com>
         <20190820084932.22282-11-bibby.hsieh@mediatek.com>
         <2dfb6a69-c325-9caf-e11b-bf0f0fbf4bb6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 34024C2035332237CE94BB97C522852CCDEB6CCC7296B54A2D16406976ACB8382000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 16:05 +0200, Matthias Brugger wrote:
> 
> On 20/08/2019 10:49, Bibby Hsieh wrote:
> > add polling function in cmdq helper functions
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-cmdq-helper.c   | 28 ++++++++++++++++++++++++
> >  include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
> >  include/linux/soc/mediatek/mtk-cmdq.h    | 15 +++++++++++++
> >  3 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > index e3d5b0be8e79..c53f8476c68d 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -221,6 +221,34 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
> >  }
> >  EXPORT_SYMBOL(cmdq_pkt_clear_event);
> >  
> > +int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
> > +		  u16 offset, u32 value, u32 mask)
> > +{
> > +	struct cmdq_instruction *inst;
> > +
> > +	if (mask != 0xffffffff) {
> 
> Is this necessary? Can't we just always set the mask, even if it's 0xffffffff?
> 
> Regarding interfaces, depending on how often you expect the mask being ~0 we
> might think of adding a cmdq_pkt_poll_mask call.
> What I want to say, if in the end most of the callers will use the mask with
> 0xffffffff, then we should add a call cmdq_pkt_poll_mask which actually allows
> to set the mask and let cmdq_pkt_poll set the mask in it's function body.
> As I already said, this depends on how often you think a caller will use/not-use
> the mask.
> Does this make sense?

It's better to have two function: cmdq_pkt_poll_mask and cmdq_pkt_poll,
client can choose which they need by themselves.

Thanks for the comments.

Bibby
> > +		inst = cmdq_pkt_append_command(pkt);
> > +		if (!inst)
> > +			return -ENOMEM;
> > +
> > +		inst->op = CMDQ_CODE_MASK;
> > +		inst->value = ~mask;
> > +		offset = offset | 0x1;
> > +	}
> > +
> > +	inst = cmdq_pkt_append_command(pkt);
> > +	if (!inst)
> > +		return -ENOMEM;
> > +
> > +	inst->op = CMDQ_CODE_POLL;
> > +	inst->value = value;
> > +	inst->offset = offset;
> > +	inst->subsys = subsys;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_poll);
> > +
> >  static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> >  {
> >  	struct cmdq_instruction *inst;
> > diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> > index c8adedefaf42..9e3502945bc1 100644
> > --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> > +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> > @@ -46,6 +46,7 @@
> >  enum cmdq_code {
> >  	CMDQ_CODE_MASK = 0x02,
> >  	CMDQ_CODE_WRITE = 0x04,
> > +	CMDQ_CODE_POLL = 0x08,
> >  	CMDQ_CODE_JUMP = 0x10,
> >  	CMDQ_CODE_WFE = 0x20,
> >  	CMDQ_CODE_EOC = 0x40,
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> > index 9618debb9ceb..a345870a6d10 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -99,6 +99,21 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
> >   */
> >  int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
> >  
> > +/**
> > + * cmdq_pkt_poll() - Append polling command to the CMDQ packet, ask GCE to
> > + *		     execute an instruction that wait for a specified hardware
> > + *		     register to check for the value. All GCE hardware
> > + *		     threads will be blocked by this instruction.
> > + * @pkt:	the CMDQ packet
> > + * @subsys:	the CMDQ sub system code
> > + * @offset:	register offset from CMDQ sub system
> > + * @value:	the specified target register value
> > + * @mask:	the specified target register mask
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
> > +		  u16 offset, u32 value, u32 mask);
> >  /**
> >   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> >   *                          packet and call back at the end of done packet
> > 



