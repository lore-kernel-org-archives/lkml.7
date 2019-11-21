Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B88C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1421820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKUH3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:29:47 -0500
Received: from verein.lst.de ([213.95.11.211]:44413 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUH3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:29:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 517D368B05; Thu, 21 Nov 2019 08:29:43 +0100 (CET)
Date:   Thu, 21 Nov 2019 08:29:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, darren@stevens-zone.net,
        "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Message-ID: <20191121072943.GA24024@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 08:06:05AM +0100, Christian Zigotzky wrote:
> /*
>  *  DMA addressing mode.
>  *
>  *  0 : 32 bit addressing for all chips.
>  *  1 : 40 bit addressing when supported by chip.
>  *  2 : 64 bit addressing when supported by chip,
>  *      limited to 16 segments of 4 GB -> 64 GB max.
>  */
> #define   SYM_CONF_DMA_ADDRESSING_MODE CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
> 
> Cyrus config:
> 
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> 
> I will configure “0 : 32 bit addressing for all chips” for the RC8. Maybe this is the solution.

0 means you are going to do bounce buffering a lot, which seems
generally like a bad idea.

But why are we talking about the sym53c8xx driver now?  The last issue
you reported was about video4linux allocations.
