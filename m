Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C540C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85472184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566846801;
	bh=SOFeZdgaZD9HZz/S+0Ok1/wz5guU3PCw9Qao16OP8MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nHNDNhakMgOotgMttHmzv/8SYdD0rYERZmjmtHdaMM0Bp0Nl47hic2v/CSSXynI3O
	 rS0MT6yEjDoSOxtRlVJJ1cOPLH3BUv66EWHJCaYNoZK5HyE4CxQDi7EEinBPkYqq9c
	 CA3LbUl4CNswg3oo1L/g6CETI7UGfB1fuc4yz+jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfHZTNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:13:20 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:41674 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbfHZTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:13:19 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1i2KQV-0007jY-Pj; Mon, 26 Aug 2019 21:13:16 +0200
Date:   Mon, 26 Aug 2019 20:13:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
Message-ID: <20190826201313.246208e9@why>
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 15:00:50 -0400
Pavel Tatashin <pasha.tatashin@soleen.com> wrote:

> Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
> However, it is still not possible todo on systems with device trees.
> 
> Here is EFI fixes from Marc:
> https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com
> 
> For Device Tree variant: lets allow reserve a memory region in interrupt
> controller node, and use this property to allocate interrupt tables.

There is no such thing as a "device tree variant". As long as your
bootloader implements EFI, everything will work correctly, whether
you're using DT, ACPI, or the anything else.

This already works today, without any need to add anything to the
kernel (I have systems using EDK II and u-boot, both implementing EFI,
and I'm able to kexec without any issue). If your bootloader doesn't
support EFI, here's a good opportunity to implement it!

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
