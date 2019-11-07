Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DBC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DA02187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKGHP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:15:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8794 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbfKGHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:15:57 -0500
X-UUID: b11b76dd42084d7490932811380484ea-20191107
X-UUID: b11b76dd42084d7490932811380484ea-20191107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1064647133; Thu, 07 Nov 2019 15:15:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 7 Nov 2019 15:15:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Nov 2019 15:15:46 +0800
Message-ID: <1573110948.14882.4.camel@mtksdaap41>
Subject: Re: [PATCH v16 3/5] soc: mediatek: cmdq: add polling function
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Thu, 7 Nov 2019 15:15:48 +0800
In-Reply-To: <20191024052732.7767-4-bibby.hsieh@mediatek.com>
References: <20191024052732.7767-1-bibby.hsieh@mediatek.com>
         <20191024052732.7767-4-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: E72920FB50E9CDA4E818AB70337E995D8F31672B236627B66B63AF03102282332000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Thu, 2019-10-24 at 13:27 +0800, Bibby Hsieh wrote:
> add polling function in cmdq helper functions
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c   | 35 ++++++++++++++++++++++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
>  include/linux/soc/mediatek/mtk-cmdq.h    | 32 ++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 11bfcc150ebd..8743c6ae7ac5 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -214,6 +214,41 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_clear_event);
>  
> +int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
> +		  u16 offset, u32 value)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +	int err;
> +
> +	inst.op = CMDQ_CODE_POLL;
> +	inst.value = value;
> +	inst.offset = offset;
> +	inst.subsys = subsys;
> +	err = cmdq_pkt_append_command(pkt, inst);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_poll);
> +
> +int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
> +		       u16 offset, u32 value, u32 mask)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +	int err;
> +
> +	inst.op = CMDQ_CODE_MASK;
> +	inst.mask = ~mask;
> +	err = cmdq_pkt_append_command(pkt, inst);
> +	if (err < 0)
> +		return err;
> +
> +	offset = offset | 0x1;

In write mask, there is a bit which has a naming CMDQ_WRITE_ENABLE_MASK,
does this bit has a naming?

Regards,
CK

> +	err = cmdq_pkt_poll(pkt, subsys, offset, value);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_poll_mask);
> +
>  static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>  {
>  	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index 678760548791..a4dc45fbec0a 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -55,6 +55,7 @@
>  enum cmdq_code {
>  	CMDQ_CODE_MASK = 0x02,
>  	CMDQ_CODE_WRITE = 0x04,
> +	CMDQ_CODE_POLL = 0x08,
>  	CMDQ_CODE_JUMP = 0x10,
>  	CMDQ_CODE_WFE = 0x20,
>  	CMDQ_CODE_EOC = 0x40,
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 9618debb9ceb..92bd5b5c6341 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -99,6 +99,38 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
>   */
>  int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
>  
> +/**
> + * cmdq_pkt_poll() - Append polling command to the CMDQ packet, ask GCE to
> + *		     execute an instruction that wait for a specified
> + *		     hardware register to check for the value w/o mask.
> + *		     All GCE hardware threads will be blocked by this
> + *		     instruction.
> + * @pkt:	the CMDQ packet
> + * @subsys:	the CMDQ sub system code
> + * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
> +		  u16 offset, u32 value);
> +
> +/**
> + * cmdq_pkt_poll_mask() - Append polling command to the CMDQ packet, ask GCE to
> + *		          execute an instruction that wait for a specified
> + *		          hardware register to check for the value w/ mask.
> + *		          All GCE hardware threads will be blocked by this
> + *		          instruction.
> + * @pkt:	the CMDQ packet
> + * @subsys:	the CMDQ sub system code
> + * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
> + * @mask:	the specified target register mask
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
> +		       u16 offset, u32 value, u32 mask);
>  /**
>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
>   *                          packet and call back at the end of done packet


