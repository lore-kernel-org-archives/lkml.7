Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD8DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DA52146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfEMJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:41:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36057 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfEMJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:41:08 -0400
X-Originating-IP: 83.204.64.206
Received: from windsurf.home (anantes-658-1-8-206.w83-204.abo.wanadoo.fr [83.204.64.206])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 607CE1BF20E;
        Mon, 13 May 2019 09:41:01 +0000 (UTC)
Date:   Mon, 13 May 2019 11:40:59 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190513114059.3934b0bb@windsurf.home>
In-Reply-To: <OF1EDBA487.7723094D-ON482583F9.00297ABF-482583F9.0029E3EE@mxic.com.tw>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510153704.33de9568@windsurf.home>
        <OF1EDBA487.7723094D-ON482583F9.00297ABF-482583F9.0029E3EE@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 13 May 2019 15:37:39 +0800
masonccyang@mxic.com.tw wrote:

> -------------------------------------------------------------------
>  static void macronix_nand_onfi_init(struct nand_chip *chip)
>  {
>           struct nand_parameters *p = &chip->parameters;
>           struct nand_onfi_vendor_macronix *mxic = (void 
> *)p->onfi->vendor;

Why cast to void*, instead of casting directly to struct
nand_onfi_vendor_macronix * ?

Also,  you are dereferencing p->info before checking whether it's NULL
or not.

>           if (!p->onfi ||
>               ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0))
>                   return;

So, the code should be:

	struct nand_onfi_vendor_macronix *mxic;

	if (!p->onfi)
		return;

	mxic = (struct nand_onfi_vendor_macronix *) p->info->vendor;

	if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
		return;

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
