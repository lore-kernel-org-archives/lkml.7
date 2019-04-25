Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46773C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1530720811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="VBn1SO2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfDYLbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:31:09 -0400
Received: from mail.intenta.de ([178.249.25.132]:43877 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfDYLbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=labrIMZHzxpCaXBdQod/UvvCoeBNd9NwvtHV6HFSVmE=;
        b=VBn1SO2y2FEbHYIKuYVAxx+DoY03KP7oppl+FnpouCcgEASlYE+Z6xY1lctjW9TVn9JHgM6U2LbrpBMClp9wD41DElDvnYITaardTGdW3WoB3QvBbdkpuymZ5/BUnPjLnRA5fdwFQiMbCSG8B/C+rDwPH9q/RFEj7zgYt9LRq4fKYt6AJyMAJGQ6LP8yvrHFJiLUpndf58HJRRsO+idhwofLbDNIQUPN6hsOGB/M4sD0yuyKLRnQTQGuWsUYxohwuTpKKcAzq7ukFpfjD1C5jY12RxqJJJYMzfHpMTOp6v5dBNL4sGqK7inaMH+liR+FVMrzqGVMH8dG7vVz9JCupw==;
X-CTCH-RefID: str=0001.0A0C0208.5CC198BA.0014,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Thu, 25 Apr 2019 13:23:37 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190425112337.wno2a6dccptffldz@laureti-dev>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190423124525.axaprwy4qofbqfhj@laureti-dev>
 <DM6PR02MB47797E4A5ADFC87DE4B04A81AF3C0@DM6PR02MB4779.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB47797E4A5ADFC87DE4B04A81AF3C0@DM6PR02MB4779.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:04:38AM +0000, Naga Sureshkumar Relli wrote:
> > You previously used cond_resched (via nand_wait_ready) here. Why did you change it to
> > cpu_relax()?
> I just replicated the pl353_wait_for_ecc_done() API definition.
> But did you see any issue with this?
> Anyway I will replace it with cond_resched(), instead of cpu_releax()

This was an observation and it made me ask for reasons. I did not have
any practical issues here.

> Did you follow the same thing that you tried earlier?
> i.e. updated "nand-bus-width" property and "nand-ecc-mode" ?

Yes, I used the same device tree that made v13 partially work here.

> > After trying the driver, the flash chip was bricked. Neither the old driver nor the uboot-xlnx
> > driver nor the Xilinx fsbl are able to talk to the chip afterwards. This behaviour persists even
> > after a full power cycle. I'll try reinitializing the flash chip next. I've only seen this behaviour
> > once, so there is a slight chance that the cause is something else.
> Sometimes I also faced the same problem during driver development.
> What I did is, in standalone nandps driver example,  I forcibly created BBT in the init and once
>  it is done. I just reloaded the actual example. Then after wards u-boot and Linux are able to scan
> the BBT.

I confirm. It was just the BBT being bad. It can also be recreated using
u-boot with "nand scrib.chip".

I also spent some time reviewing the code and will send another mail
about that.

Helmut
