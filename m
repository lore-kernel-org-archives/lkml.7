Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696BCC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829720815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfETMQc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:16:32 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34067 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732983AbfETMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:16:29 -0400
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 42E9E100003;
        Mon, 20 May 2019 12:16:20 +0000 (UTC)
Date:   Mon, 20 May 2019 14:16:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jeff Kletsky <lede@allycomm.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spinand: Add #define-s for page-read ops
 with three-byte addresses
Message-ID: <20190520141620.52bb06d9@xps13>
In-Reply-To: <d62d64a9-c7c3-3b0b-a3ba-71ab2a4f61e4@allycomm.com>
References: <20190514215315.19228-1-lede@allycomm.com>
        <20190514215315.19228-2-lede@allycomm.com>
        <355bcf8d-bce6-1b82-0f57-539c8d9b6cac@gmail.com>
        <efcbdd61-d60e-a5d1-9f91-f8f747fadecf@kontron.de>
        <d62d64a9-c7c3-3b0b-a3ba-71ab2a4f61e4@allycomm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Jeff Kletsky <lede@allycomm.com> wrote on Sun, 19 May 2019 13:27:58
-0700:

> On 5/14/19 11:49 PM, Schrempf Frieder wrote:
> 
> > On 15.05.19 08:17, Marek Vasut wrote:  
> >> On 5/14/19 11:53 PM, Jeff Kletsky wrote:  
> >>> From: Jeff Kletsky <git-commits@allycomm.com>  
> >> That #define in $subject is called a macro.
> >>
> >> Seems this patch adds a lot of almost duplicate code, can it be somehow
> >> de-duplicated ?  
> > We could add another parameter naddr or addrlen to the
> > SPINAND_PAGE_READ_FROM_CACHE_XX_OPs and pass the value 2 for all
> > existing chips except for GD5F1GQ4UFxxG which needs 3 bytes address length.
> >
> > This would cause one more argument to each of the macro calls in all
> > chip drivers. As long as there are only two flavors (2 and 3 bytes) I'm
> > not sure if this really would make things easier and also this is "only"
> > preprocessor code.
> >
> > So anyways, I would be fine with both approaches, Jeff's current one or
> > one with another parameter for the address length.
> >
> > By the way: Jeff, you didn't carry my Reviewed-by tag to v2. So I will
> > just reply again to add the tags.
> >  
> >>> The GigaDevice GD5F1GQ4UFxxG SPI NAND utilizes three-byte addresses
> >>> for its page-read ops.
> >>>
> >>> http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/
> >>>
> >>> Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>
> >>> ---
> >>>    include/linux/mtd/spinand.h | 30 ++++++++++++++++++++++++++++++
> >>>    1 file changed, 30 insertions(+)
> >>>
> >>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> >>> index b92e2aa955b6..05fe98eebe27 100644
> >>> --- a/include/linux/mtd/spinand.h
> >>> +++ b/include/linux/mtd/spinand.h
> >>> @@ -68,30 +68,60 @@
> >>>    		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> >>>    		   SPI_MEM_OP_DATA_IN(len, buf, 1))  
> >>>    >>> +#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(fast, addr, ndummy, buf, len) \  
> >>> +	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
> >>> +		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> >>> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> >>> +		   SPI_MEM_OP_DATA_IN(len, buf, 1))
> >>> +
> >>>    #define SPINAND_PAGE_READ_FROM_CACHE_X2_OP(addr, ndummy, buf, len)	\
> >>>    	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
> >>>    		   SPI_MEM_OP_ADDR(2, addr, 1),				\
> >>>    		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> >>>    		   SPI_MEM_OP_DATA_IN(len, buf, 2))  
> >>>    >>> [ _3A addition repeated three more times for similar ops ... ]  
> 
> It's easy enough to change the wording, and will do so on the next revision.
> 
> However, it's not clear to me that there is consensus on if the present
> set of macros is acceptable/preferred over definition of a set of ones
> that accept an additional parameter.
> 
> At least from my perspective and as Schrempf Frieder has hinted at,
> these macros are syntactic sugar and all result in equivalent C code.
> 
> Either should compile to the same run-time size and performance (assuming
> reasonably that a construct like `true ? 0x0b : 0x03` is optimized out).
> 
> Adding an additional parameter, at least for me, wouldn't improve readability
> of the code and is offset by the need to refactor four other files. Even
> though it should be a simple/trivial refactor, I do not have any examples
> of the four other manufacturers' chips to be able to confirm proper operation.
> 
> I'll prepare a reworded set of patches with the present macro structure.
> 
> If there is strong feeling for refactoring the macro set, please let me know.

On my side I would rather not add this extra argument, I know it is not
very conventional to add so much macros but once you've read one you
read all of them and I think it improves the readability of the code
using it.


Thanks,
Miquèl
