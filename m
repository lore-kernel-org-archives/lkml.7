Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93812C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA6F2051A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgAIT31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:29:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgAIT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:29:27 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E24D29389F;
        Thu,  9 Jan 2020 19:29:25 +0000 (GMT)
Date:   Thu, 9 Jan 2020 20:29:22 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: spi: rework detect procedure for different
 read id op
Message-ID: <20200109202922.744a6739@collabora.com>
In-Reply-To: <20200109075551.357179-1-gch981213@gmail.com>
References: <20200109075551.357179-1-gch981213@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jan 2020 15:54:00 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:

> @@ -215,15 +204,22 @@ struct spinand_manufacturer_ops {
>   * struct spinand_manufacturer - SPI NAND manufacturer instance
>   * @id: manufacturer ID
>   * @name: manufacturer name
> + * @devid_len: number of bytes in device ID
> + * @spinand_table: array with info for spi nands under current manufacturer
> + * @nchips: number of chips available in spinand_table
>   * @ops: manufacturer operations
>   */
>  struct spinand_manufacturer {
>  	u8 id;
>  	char *name;
> +	u8 devid_len;

IIRC, some manufacturers support more than one scheme which means you
can't really take this decision at the manufacturer level. How about
adding a readid_method field to spinand_info?

enum spinand_readid_method {
	SPINAND_READID_METHOD_OPCODE,
	SPINAND_READID_METHOD_OPCODE_ADDR,
	SPINAND_READID_METHOD_OPCODE_DUMMY,
};

> +	const struct spinand_info *spinand_table;

s/spinand_table/chips/

> +	size_t nchips;
>  	const struct spinand_manufacturer_ops *ops;
>  };

