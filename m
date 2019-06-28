Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E540C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352592070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF1Ioh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:44:37 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53737 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1Ioh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:44:37 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D638BFF813;
        Fri, 28 Jun 2019 08:44:23 +0000 (UTC)
Date:   Fri, 28 Jun 2019 10:44:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add Macronix Raw NAND controller
Message-ID: <20190628104423.5eb3058a@xps13>
In-Reply-To: <OF2EDB7089.FAD92F61-ON48258427.002D122A-48258427.002ECEF3@mxic.com.tw>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw>
        <1561443056-13766-2-git-send-email-masonccyang@mxic.com.tw>
        <20190627193635.29abff43@xps13>
        <OFDDC43C05.7B4092B5-ON48258427.001EE57E-48258427.002122D1@mxic.com.tw>
        <20190628091836.3148d450@xps13>
        <OF2EDB7089.FAD92F61-ON48258427.002D122A-48258427.002ECEF3@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Fri, 28 Jun 2019 16:31:16 +0800:

> Hi Miquel,
> 
> > >   
> > > > > Add a driver for Macronix raw NAND controller.   
> > > > 
> > > > Could you pass userspace major MTD tests and can you   
> attach/mount/edit
> > > > a UBI/UBIFS storage?   
> > > 
> > > mtd_debug passed and using dd utility to read and write 
> > > with md5sum checking passed.  
> > 
> > Please don't use dd, use nanddump/nandwrite/flasherase/nandbiterrs and
> > run the other tests from the mtd-utils test suite (available in
> > Buildroot for instance).
> >   
> 
> Got it.
> 
> But may I know why 'dd' utility is not preferences ?
> I generate a random data file and write to Flash by
> using dd with bs=page size and read data back from Flash.
> Checking data by md5sum.

Because dd works on block devices. MTD devices are way different. You
cannot write to OOB with dd. You cannot erase before write with dd. And
dd does not know about bad blocks. Please simply avoid using dd.

> The write and read testing data size is easily adjustable.

So are the MTD utils.

Thanks,
Miquèl
