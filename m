Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7459CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CF7213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391603AbfETObm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:31:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50209 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfETObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:31:42 -0400
X-Originating-IP: 90.88.22.185
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7DCA260005;
        Mon, 20 May 2019 14:31:32 +0000 (UTC)
Date:   Mon, 20 May 2019 16:31:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     bbrezillon@kernel.org, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH] mtd: rawnand: use longest matching pattern
Message-ID: <20190520163131.7c143ebe@xps13>
In-Reply-To: <20190419074717.22576-1-stefan@agner.ch>
References: <20190419074717.22576-1-stefan@agner.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Stefan Agner <stefan@agner.ch> wrote on Fri, 19 Apr 2019 09:47:17 +0200:

> Sometimes the exec_op parser does not choose the optimal pattern if
> multiple patterns with optional elements are available. Since the stack
> automatically splits operations in multiple exec_op calls, a non-optimal
> pattern gets broken up into multiple calls. E.g. an OOB read using the
> vf610 driver:
>   nand: executing subop:
>   nand:     ->CMD      [0x00]
>   nand:     ->ADDR     [5 cyc: 00 08 ea 94 02]
>   nand:     ->CMD      [0x30]
>   nand:     ->WAITRDY  [max 200000 ms]
>   nand:       DATA_IN  [64 B]
>   nand: executing subop:
>   nand:       CMD      [0x00]
>   nand:       ADDR     [5 cyc: 00 08 ea 94 02]
>   nand:       CMD      [0x30]
>   nand:       WAITRDY  [max 200000 ms]
>   nand:     ->DATA_IN  [64 B]
> 
> However, the vf610 driver has a pattern which can execute the complete
> command in a single go...
> 
> This patch makes sure that the longest matching pattern is chosen
> instead of the first (potentially only partial) match. With this
> change the vf610 reads the OOB in a single exec_op call:
>   nand: executing subop:
>   nand:     ->CMD      [0x00]
>   nand:     ->ADDR     [5 cyc: 00 08 c0 1d 00]
>   nand:     ->CMD      [0x30]
>   nand:     ->WAITRDY  [max 200000 ms]
>   nand:     ->DATA_IN  [64 B]
> 
> Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Tested-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Applied, thanks.

Miquèl
