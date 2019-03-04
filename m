Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65955C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A3520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfCDIn5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:43:57 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:55647 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:43:55 -0500
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CDF63FF807;
        Mon,  4 Mar 2019 08:43:48 +0000 (UTC)
Date:   Mon, 4 Mar 2019 09:43:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 05/10] mtd: rawnand: denali: use more precise timeout
 for NAND_OP_WAITRDT_INSTR
Message-ID: <20190304094346.3b62e6cd@xps13>
In-Reply-To: <1549955582-30346-6-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
        <1549955582-30346-6-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Feb
2019 16:12:57 +0900:

> Currently, wait_for_completion_timeout() is always passed in the
> hard-coded msec_to_jiffies(1000). There is no specific reason for
> 1000 msec, but it was chosen to be long enough.
> 
> With the exec_op() conversion, NAND_OP_WAITRDY_INSTR provides more
> precise timeout value, depending on the preceding command. Let's use
> it (+ 100 msec) to bail out earlier in error case. The 100 msec extra
> is in case the heavy load on the system.
> 
> I am still keeping the hard-coded values for other higher level hooks
> such as page_read, page_write, etc. We know the value of tR, tPROG, but
> we have unknowledge about the data transfer speed of the DMA engine.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I really am not convinced by this change. Please just define a timeout
big enough for most cases (1000 is okay) and use it systematically.

Thanks,
Miquèl
