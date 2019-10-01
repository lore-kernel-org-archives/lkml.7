Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EEBC32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC1D21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJACRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 22:17:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1326 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726504AbfJACRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:17:31 -0400
X-UUID: 73cd5557a7e94fa093ed51b06b075a34-20191001
X-UUID: 73cd5557a7e94fa093ed51b06b075a34-20191001
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 114613699; Tue, 01 Oct 2019 10:17:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Oct 2019 10:17:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Oct 2019 10:17:22 +0800
Message-ID: <1569896243.21654.8.camel@mtksdaap41>
Subject: Re: [PATCH v15 1/4] soc: mediatek: cmdq: define the instruction
 struct
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Tue, 1 Oct 2019 10:17:23 +0800
In-Reply-To: <20190927114254.6258-2-bibby.hsieh@mediatek.com>
References: <20190927114254.6258-1-bibby.hsieh@mediatek.com>
         <20190927114254.6258-2-bibby.hsieh@mediatek.com>
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

On Fri, 2019-09-27 at 19:42 +0800, Bibby Hsieh wrote:
> Define an instruction structure for gce driver to append command.
> This structure can make the client's code more readability.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

You've modified this patch in this version, so you should drop this
'Reviewed-by' tag.

> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c   | 106 +++++++++++++++++------
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  10 +++
>  2 files changed, 90 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 7aa0517ff2f3..7af327b98d25 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -9,12 +9,24 @@
>  #include <linux/mailbox_controller.h>
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>  
> -#define CMDQ_ARG_A_WRITE_MASK	0xffff
>  #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
>  #define CMDQ_EOC_IRQ_EN		BIT(0)
>  #define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
>  				<< 32 | CMDQ_EOC_IRQ_EN)
>  
> +struct cmdq_instruction {
> +	union {
> +		u32 value;
> +		u32 mask;
> +	};
> +	union {
> +		u16 offset;
> +		u16 event;
> +	};
> +	u8 subsys;
> +	u8 op;
> +};
> +
>  static void cmdq_client_timeout(struct timer_list *t)
>  {
>  	struct cmdq_client *client = from_timer(client, t, timer);
> @@ -110,10 +122,10 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_destroy);
>  
> -static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> -				   u32 arg_a, u32 arg_b)
> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt,
> +				   struct cmdq_instruction *inst)
>  {
> -	u64 *cmd_ptr;
> +	struct cmdq_instruction *cmd_ptr;
>  
>  	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>  		/*
> @@ -129,8 +141,9 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>  			__func__, (u32)pkt->buf_size);
>  		return -ENOMEM;
>  	}
> +
>  	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> -	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> +	*cmd_ptr = *inst;
>  	pkt->cmd_buf_size += CMDQ_INST_SIZE;
>  
>  	return 0;
> @@ -138,24 +151,42 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>  
>  int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
>  {
> -	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
> -		    (subsys << CMDQ_SUBSYS_SHIFT);
> +	struct cmdq_instruction *inst = kzalloc(sizeof(*inst), GFP_KERNEL);

Frequently allocate/free increase CPU loading. The simpler way is

struct cmdq_instruction inst = { 0 };

cmdq_pkt_append_command(pkt, &inst);


> +	int err = 0;

No need to assign initial value.

> +
> +	if (!inst)
> +		return -ENOMEM;
> +
> +	inst->op = CMDQ_CODE_WRITE;
> +	inst->value = value;
> +	inst->offset = offset;
> +	inst->subsys = subsys;
>  
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
> +	err = cmdq_pkt_append_command(pkt, inst);
> +	kfree(inst);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL(cmdq_pkt_write);
>  

[snip]

>  
>  static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>  {
> -	int err;
> +	struct cmdq_instruction *inst = kzalloc(sizeof(*inst), GFP_KERNEL);
> +	int err = 0;
> +
> +	if (!inst)
> +		return -ENOMEM;
>  
>  	/* insert EOC and generate IRQ for each command iteration */
> -	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> +	inst->op = CMDQ_CODE_EOC;
> +	inst->value = CMDQ_EOC_IRQ_EN;
> +	err = cmdq_pkt_append_command(pkt, inst);
>  
>  	/* JUMP to end */
> -	err |= cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +	inst->op = CMDQ_CODE_JUMP;
> +	inst->value = CMDQ_JUMP_PASS;
> +	err |= cmdq_pkt_append_command(pkt, inst);

OR the err value looks strange. If you OR err 0x1 and err 0x10, you
would get the new err 0x11. How do you know that err 0x11 is the
combination of 0x1 and 0x10?

This bug seems exist in previous patch, so I would like you to fix this
bug first and then apply this patch.

Regards,
CK


> +	kfree(inst);
>  
>  	return err;
>  }
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index e6f54ef6698b..678760548791 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -20,6 +20,16 @@
>  #define CMDQ_WFE_WAIT			BIT(15)
>  #define CMDQ_WFE_WAIT_VALUE		0x1
>  
> +/*
> + * WFE arg_b
> + * bit 0-11: wait value
> + * bit 15: 1 - wait, 0 - no wait
> + * bit 16-27: update value
> + * bit 31: 1 - update, 0 - no update
> + */
> +#define CMDQ_WFE_OPTION			(CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | \
> +					CMDQ_WFE_WAIT_VALUE)
> +
>  /** cmdq event maximum */
>  #define CMDQ_MAX_EVENT			0x3ff
>  


