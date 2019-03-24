Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03666C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C482520823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWNlsDmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfCXQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:48:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46551 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfCXQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:48:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so5704039lja.13;
        Sun, 24 Mar 2019 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1U9n/t18wnXKhRjLFYD2gjH0o+xCH9hI2JLlh3jrEQ=;
        b=jWNlsDmZfw1BhmENeKMJNFMpaoNMtEohfdG1sudB7Tdo64fVoty7f328ILDHh9ICb1
         Ux+U58FUO7yQx6lmVeKrebPKHqDKvX8uZnUxNZqsYTHGodj8yDAtNqVNEun4YJg9ZE3I
         0CjWQ6iCdVxxIRPL8MSCilpybL5PT59OZa1J11uabZqsSiiz5erKO/y9yoJHvgttJrlD
         ZpEX3VcOclRn1mLZ/iRF43y5ntEUFhnW07+ek6h0136axxQK568bNmsYgSQQeldDPTYj
         /Jf2Qs9mqVs/v8RY9Opzj4ucJuqgZopK8UQrZBZ3VCDUJlNgyhkzy3bYMRUupsz9Cc1q
         JvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1U9n/t18wnXKhRjLFYD2gjH0o+xCH9hI2JLlh3jrEQ=;
        b=mMUAG7FQKzKd2xw3VSkdIyZijmaAAWZ1fytMLKwPUlPRxcLWBT69j2+ZJW5SM7wdGk
         wv+HUgJ56d9nIZGtTHpWUH+LJs52d/ShOEVwJ7YTsgtgxqSQB3IXjQXtn7nvDdKBEseC
         EWNgqoBka41XV4NcES7paITh/GExCWLA0EFQQnVeQMCghBHk1hjcGbGA15nIHJe0sncT
         j3MyiQrVXIycLKsDI144/sn/F9K32Ujv3H8R5r4lkJkKd7s5SHqnsNvZzqzkGbB2KRJT
         qtd73vQptsH7bseyCyAK09u0IMpVAnP2nq5j9s6YZ+17yfy22v0Yn3ysrIp/nX6ba7E5
         RK5w==
X-Gm-Message-State: APjAAAUAHafZ5035ZtmnOurtAcAB6IU1vJaxaJKkJV+qxrjDnZSeGTZ4
        kxjXAhLTKXFBFrxQZ/naumU=
X-Google-Smtp-Source: APXvYqyRT39fP1KHInPKbhDDKFdmjTM2OITzznmI5qvR/PHnqi5ZpwANDdHcX1mmV0TJkTvbc0GNyQ==
X-Received: by 2002:a2e:4715:: with SMTP id u21mr10582949lja.156.1553446106051;
        Sun, 24 Mar 2019 09:48:26 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id b15sm3007352ljj.70.2019.03.24.09.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:48:24 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Sun, 24 Mar 2019 17:48:22 +0100
Message-ID: <2631901.52Nzq63B5o@z50>
In-Reply-To: <20190320011630.GB7872@darkstar.musicnaut.iki.fi>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190320011630.GB7872@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaro,

Thanks for your review.

On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
> On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
> > After recent modifications, only a hardcoded partition info makes
> > the driver device specific.  Other than that, the driver uses GPIO
> > exclusively and can be used on any hardware.
> > 
> > Drop the partition info and use MTD partition parser with default
> > list of partition types instead.
> > 
> > Amstrad Delta users should append the followig partition info to their
>                                         ^^^^^^^^
> Should be "following".
> 
> > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
> > convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
> > Kconfig automatically if this NAND driver is also selected.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Could we move the fixed partition setup to the board file
> instead? Otherwise this kind of change is not really nice for the users,
> as it will likely break existing setups. The default partition layout
> should remain the same.

I'm wondering if it would be acceptable to pass partition info from a .dts 
file.  I think that would be a better, more modern approach than adding a new 
header under include/linux/platform_data.

The problem with a device tree based implementation is, I know of no u-boot 
version supporting both Amstrad Delta and FDT.  However, I've already tested 
two solutions that work for me.

One uses CONFIG_ARM_APPENDED_DTB and requires a user to manually append the 
blob to zImage and (re)generate uImage.  I'm not sure how much more user-
friendly it looks for you, compared to the command line version I proposed 
initially.

If the above is not acceptable. I can propose still another approach. The blob 
is automagically built and embedded into the kernel with some assembler glue, 
then unflattened from the board init_machine(), somehow similar to the way 
drivers/of/unittest.c does it.

Please advise which approach sounds best to you (platform_data, 
CONFIG_ARM_APPENDED_DTB or unittest like).

Thanks,
Janusz


> 
> A.
> 




