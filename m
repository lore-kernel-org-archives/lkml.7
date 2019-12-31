Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D2C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6E7206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMkSUVL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLaCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:11:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hNTSsqiKyv+nxMzXdDAnZK9rKMztespJdwdLOLLSblM=; b=QMkSUVL3j2oL/sBOLhg4GEYDj
        B2bPkmPRwVu/7xiPmJrtnMfsXvGxCSu3J0nn2/qpt3V+jIDTa0atOCZBA/PoPqSdVUl7znfQZzHvC
        sRwc8cANhcufQIIZfTTO+f0sYPnhX1Tg5SHjJPQsJNQ5roC6oOpnuUJ4jeRP6Yhne9HsBCAmRau7L
        CpEUM15IdwfufGzHwnYXkLmiOZtpHKGetBVITZblqx0y2zPm57gUUzl3W9qo4VxFUxEdiJWe8xMBr
        +t9GdrWkC7NdnBXsaLiD+oAJ46g/p8ZVcqjQF15JjPhR5oYcHyhC32M6cDs0U0U8sMyObnVhww2rZ
        bddQcJq6Q==;
Received: from [2601:1c0:6280:3f0::34d9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im70I-0001MA-0O; Tue, 31 Dec 2019 02:11:26 +0000
Subject: Re: [PATCH] stmmac: debugfs entry name is not be changed when udev
 rename device name.
To:     Jiping Ma <jiping.ma2@windriver.com>, peppe.cavallaro@st.com,
        alexandre.torgue@st.com
Cc:     joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
References: <20191231020302.71792-1-jiping.ma2@windriver.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b10a5ff-8428-48c7-a60d-69dd62009716@infradead.org>
Date:   Mon, 30 Dec 2019 18:11:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191231020302.71792-1-jiping.ma2@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/30/19 6:03 PM, Jiping Ma wrote:
> Add one notifier for udev changes net device name.
> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 38 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b14f46a57154..c1c877bb4421 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4038,6 +4038,40 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
>  
> +/**

Just use /* here since this is not a kernel-doc comment.
/** is reserved for kernel-doc comments/notation.

> + * Use network device events to create/remove/rename
> + * debugfs file entries
> + */
> +static int stmmac_device_event(struct notifier_block *unused,
> +			       unsigned long event, void *ptr)
> +{


> @@ -4050,7 +4084,6 @@ static int stmmac_init_fs(struct net_device *dev)
>  
>  		return -ENOMEM;
>  	}
> -
>  	/* Entry to report DMA RX/TX rings */
>  	priv->dbgfs_rings_status =
>  		debugfs_create_file("descriptors_status", 0444,

I don't see a problem with the blank line.  Why remove it?


thanks.
-- 
~Randy

