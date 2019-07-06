Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25DC468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52F120856
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562424398;
	bh=knYcU2Aa2Ho+pdnq/bJk+Ot/7i4nJwilFpkw41OHVkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fmgSBDCLippL9SX0TWg+zVYGiaD/RkRulfaORXsu5YuQfAcLOc4N/pqVUEM7Utogm
	 z1XveRLrlNUgr+cvvRz7qBJbZhBKBqp9MDSM9db/z9QI0crBgSAna7lI8TxFyd5pIs
	 87+0x+6Lc0nl2wzrBQ7CQVPiae3h02RGi//gL/9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGFOqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 10:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfGFOqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 10:46:34 -0400
Received: from localhost (unknown [49.207.57.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0509D20838;
        Sat,  6 Jul 2019 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562424393;
        bh=knYcU2Aa2Ho+pdnq/bJk+Ot/7i4nJwilFpkw41OHVkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WmVn8W91aCfS152h9t6f9AOye+flepkY5uYIzPO4QH4JS6MqV5pkUWiKxGsRwWYU0
         LNus9lW/ru0xQ7q5bdPPUMK5a3riFHy6rVfs5tFcnaSbzm11ngiRrNAu38eHzeUi47
         ocVwO/t/UiAiZcwy6VVmgjuz/yzCVBTIDLiL0bZ4=
Date:   Sat, 6 Jul 2019 20:13:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: Re: linux-next: build failure after merge of the slave-dma tree
Message-ID: <20190706144324.GH2911@vkoul-mobl>
References: <20190704173108.0646eef8@canb.auug.org.au>
 <VE1PR04MB6638782ADA8BFB8A17BAF19D89F40@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638782ADA8BFB8A17BAF19D89F40@VE1PR04MB6638.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-19, 13:43, Robin Gong wrote:
> Hi Stephen,

Please **do not** top post!

> 	That's caused by 'of_irq_count' NOT export to global symbol, and I'm curious why it has been
> here for so long since Zhangfei found it in 2015. https://patchwork.kernel.org/patch/7404681/

Yes this does not seem to be applied, perhaps Rob can explain why. But
this was not exported how did you test it?

> Hi Rob,
> 	Is there something I miss so that Zhangfei's patch not accepted finally?

Rob, the commit in question is [1] and uses of_irq_count. Should it use
that if not what is the alternate?

> On 04-07-19, 15:31 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> > 
> > After merging the slave-dma tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > ERROR: "of_irq_count" [drivers/dma/fsl-edma.ko] undefined!
> > 
> > Caused by commit
> > 
> >   7144afd025b2 ("dmaengine: fsl-edma: add i.mx7ulp edma2 version
> > support")
> > 
> > I have reverted that commit for today.
> > 
> > --
> > Cheers,
> > Stephen Rothwell

[1]: http://git.infradead.org/users/vkoul/slave-dma.git/commitdiff/7144afd025b23b042c158582160d7d2b10a754b7?hp=a7c5c6f6bc295d6c158db4ef9d1ca6770032669d

-- 
~Vinod
