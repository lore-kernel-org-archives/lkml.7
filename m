Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93810C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D35520848
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562559171;
	bh=Z4vk7mVRT8EztIag0rUhGUeHxNVQ35Bv5DXVMPCwSCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gkC0zVsjvxdf73xJG+WbGqdfLmGqVt1kMDvDifhPu6Mu8EdCam0mpMd6SOw36QXCG
	 QuZdU4E4gpwjFttNJ21jS/GCpa0GDlxWctZcn5HC8B++RHLc0X+o+v/g74d385cGME
	 KoyAqRni1o3ieiJMoF1JuTfkD/iA54ifrZaNvOpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGHEMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfGHEMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:12:48 -0400
Received: from localhost (unknown [49.207.58.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C9620659;
        Mon,  8 Jul 2019 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562559167;
        bh=Z4vk7mVRT8EztIag0rUhGUeHxNVQ35Bv5DXVMPCwSCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0S+38m2yKXez1xDC8vjH36iNHJgAnJy1mYZjSaq+Bq53wkAX7PDFYGRp9ZGOOPJk
         P6GLPc7NV0rk1M+ijQpA2s6UFvhBOqmq5DK10POK1AWxcbNKXeSHn1AlRIHi2HAO6I
         DpoNEGhCbXNanQCq5OcO1u9U5i9XYzF8n9KWB1EY=
Date:   Mon, 8 Jul 2019 09:39:31 +0530
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
Message-ID: <20190708040931.GJ2911@vkoul-mobl>
References: <20190704173108.0646eef8@canb.auug.org.au>
 <VE1PR04MB6638782ADA8BFB8A17BAF19D89F40@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20190706144324.GH2911@vkoul-mobl>
 <VE1PR04MB6638DAA60BE5910113D5DE0E89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638DAA60BE5910113D5DE0E89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 02:01, Robin Gong wrote:
> On 06-07-19, 22:43, Vinod Koul <vkoul@kernel.org> wrote:
> > > 	That's caused by 'of_irq_count' NOT export to global symbol, and I'm
> > > curious why it has been here for so long since Zhangfei found it in
> > > 2015.
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fpatch%2F7404681%2F&amp;data=02%7C01%7Cyibin.gon
> > g%40
> > >
> > nxp.com%7C6172242dfadd4f71c09a08d70220bf6f%7C686ea1d3bc2b4c6fa92
> > cd99c5
> > >
> > c301635%7C0%7C0%7C636980211986259586&amp;sdata=L8v%2B1o5zfgIAS
> > go4qr3pu
> > > cQ%2Byox1irANsvRv5ZNLlLM%3D&amp;reserved=0
> > 
> > Yes this does not seem to be applied, perhaps Rob can explain why. But this was
> > not exported how did you test it?
> I had no such issue because I built in fsl-edma instead of Stephen's config with building module.

But you support it as a module, right? I am inclined to revert the patch
now!

-- 
~Vinod
