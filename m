Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FD9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IbpQgqpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCEGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:37:10 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44881 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:37:10 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x256b0Qe025608
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 15:37:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x256b0Qe025608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551767821;
        bh=JbIazAa1ZSJRKnDzcfc5Qsq/YvL6BKExSfpDOizLBOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IbpQgqpuQIyIm4w3dGAF2QD9J64Y+sWrwC1TigKqFKCmbPyT0/4hm1piC6QOnINe0
         1Vxm84JAQQxxmErBSzifjSTnkdkj1Mk2aE9twlx/KkpgsiF8IN/64p4A9stI+6mlGR
         Dh+nKe56SdHYRmzm7u6g/KyfNFUvuAFkx7U+tzHCX8n9CCzcP7WUDNX08hNkz7r95A
         sVkBW4M13chUMELQbyQacCqdunvKpih2kqfN2H8wum+Bx7L4bIruREStolV+16VdVL
         9jIw2vLL2r5a5MJ7ZCBGXH9tSFPhSlg501QAFkTLcvpC9DIK82QRB9AeIcSOJh5sN7
         XZIZSP6NvxA0Q==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id s15so6774524uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 22:37:00 -0800 (PST)
X-Gm-Message-State: APjAAAXdWyfg4bTsmmG2ehVCl6mS3Egf3/UupTwkMrRRJAYhEsMAS4Vf
        YlmiuCRz4R6npkk86HBiFLrGfT9qdXQgRxm/YuM=
X-Google-Smtp-Source: APXvYqylV0ZTHhoN/LtvtPh6WbpZJq6c2NEePNdBGGxxDLZ3+qkE3EhSp3as7/KkS18Pu71R6Ddhs+Z6wqxpyC22LAg=
X-Received: by 2002:a67:7bd3:: with SMTP id w202mr339247vsc.179.1551767819908;
 Mon, 04 Mar 2019 22:36:59 -0800 (PST)
MIME-Version: 1.0
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
 <1549955582-30346-6-git-send-email-yamada.masahiro@socionext.com> <20190304094346.3b62e6cd@xps13>
In-Reply-To: <20190304094346.3b62e6cd@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Mar 2019 15:36:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4cxLHB_iVZvKdon--4x69HUh0_uJ_zAw89S4XN6aDcg@mail.gmail.com>
Message-ID: <CAK7LNAQ4cxLHB_iVZvKdon--4x69HUh0_uJ_zAw89S4XN6aDcg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mtd: rawnand: denali: use more precise timeout
 for NAND_OP_WAITRDT_INSTR
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,



On Mon, Mar 4, 2019 at 5:44 PM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 12 Feb
> 2019 16:12:57 +0900:
>
> > Currently, wait_for_completion_timeout() is always passed in the
> > hard-coded msec_to_jiffies(1000). There is no specific reason for
> > 1000 msec, but it was chosen to be long enough.
> >
> > With the exec_op() conversion, NAND_OP_WAITRDY_INSTR provides more
> > precise timeout value, depending on the preceding command. Let's use
> > it (+ 100 msec) to bail out earlier in error case. The 100 msec extra
> > is in case the heavy load on the system.
> >
> > I am still keeping the hard-coded values for other higher level hooks
> > such as page_read, page_write, etc. We know the value of tR, tPROG, but
> > we have unknowledge about the data transfer speed of the DMA engine.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I really am not convinced by this change. Please just define a timeout
> big enough for most cases (1000 is okay) and use it systematically.


OK, I will drop this patch.
and ignore ctx.waitrdy.timeout_ms.





> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--
Best Regards
Masahiro Yamada
