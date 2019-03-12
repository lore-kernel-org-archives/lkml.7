Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3F0214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Qq7SGnw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCLJss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:48:48 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19450 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:48:44 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2C9mUUN012713
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 18:48:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2C9mUUN012713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552384110;
        bh=nqtQQgIghgL7gl2TZAKCsDcSE1QTJXRDcz/iacpzpX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qq7SGnw88xOAec5aXk7NSpDNrpJRUVpu9+fMQKCLfsJtrOIl6duasWgnomSCdEV3c
         jhZYl85UgC40dH7ZWIZrLe1wJsJZfK8o7oku9oq/NqWlM7Hhsk459/f4hSP4DolnAU
         yWuNYEXn6WE7LsW3ffwVsTgnfEWeS+MLJ1huO8kLqrpsmeRDYU5M5d0Jn0u5mJN+Hb
         9SzSDChp2cWhqOiAbO5vXsK2ShrQ5yJXnvifTk7S8Rt0KPfTUZqJQAxhlf3FsKLs1o
         iD/o9U7eL6psmNTpwCApC1AGo/NONdapVnHL1aZCYMVdK4n905CcytR0hiBQAjW+P8
         SVnEigcy4TMFA==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id z18so1177812vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:48:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWfWXUdAC3gcNzz1edHeoHXZFNuVLueFsVEgYmCRKwl6+7Vay/R
        6UzGNvVOTS9HwCnaFvgfpBooQCRqG3UfCP5niDY=
X-Google-Smtp-Source: APXvYqzyhwpDYDOLjk/nx68I0IQln6FHPCO8p6SjDi3kParpEr2PZ1W1uNyVLIELXUZYZvVgNIDfHv5pOhe8Wn4wAOk=
X-Received: by 2002:a67:76d1:: with SMTP id r200mr1095129vsc.54.1552384109540;
 Tue, 12 Mar 2019 02:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
 <1552380290-19951-5-git-send-email-yamada.masahiro@socionext.com> <20190312100257.4fa142d1@collabora.com>
In-Reply-To: <20190312100257.4fa142d1@collabora.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 18:47:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVdQOfG_5Y9ZijiqgE2wxPVbsNXRmsyn0oQ65si4+DDw@mail.gmail.com>
Message-ID: <CAK7LNARVdQOfG_5Y9ZijiqgE2wxPVbsNXRmsyn0oQ65si4+DDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] mtd: rawnand: denali: switch over to ->exec_op()
 from legacy hooks
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 6:03 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 Mar 2019 17:44:45 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>
> > +
> > +static int denali_exec_instr(struct nand_chip *chip,
> > +                          const struct nand_op_instr *instr)
> > +{
> > +     struct denali_nand_info *denali = to_denali(chip);
> > +     bool width16 = chip->options & NAND_BUSWIDTH_16;
> > +
> > +     switch (instr->type) {
> > +     case NAND_OP_CMD_INSTR:
> > +             denali_exec_out8(denali, DENALI_MAP11_CMD,
> > +                              &instr->ctx.cmd.opcode, 1);
> > +             return 0;
> > +     case NAND_OP_ADDR_INSTR:
> > +             denali_exec_out8(denali, DENALI_MAP11_ADDR,
> > +                              instr->ctx.addr.addrs,
> > +                              instr->ctx.addr.naddrs);
> > +             return 0;
> > +     case NAND_OP_DATA_IN_INSTR:
> > +             (!instr->ctx.data.force_8bit && width16 ?
> > +              denali_exec_in16 :
> > +              denali_exec_in8)(denali, DENALI_MAP11_DATA,
> > +                               instr->ctx.data.buf.in,
> > +                               instr->ctx.data.len);
>
> I agree with Miquel, this statement tends to obfuscate the code, and
> it's not like an extra if will make a huge difference in term of LOC.


OK, I will add the following helpers. Before sending v4, I will wait
for more comments.



static void denali_exec_in(struct denali_controller *denali, u32 type,
                           u8 *buf, unsigned int len, bool width16)
{
        if (width16)
                denali_exec_in16(denali, type, buf, len);
        else
                denali_exec_in8(denali, type, buf, len);
}


static void denali_exec_out(struct denali_controller *denali, u32 type,
                            const u8 *buf, unsigned int len)
{
        if (width16)
                denali_exec_out16(denali, type, buf, len);
        else
                denali_exec_out8(denali, type, buf, len);
}




>
> > +             return 0;
> > +     case NAND_OP_DATA_OUT_INSTR:
> > +             (!instr->ctx.data.force_8bit && width16 ?
> > +              denali_exec_out16 :
> > +              denali_exec_out8)(denali, DENALI_MAP11_DATA,
> > +                                instr->ctx.data.buf.out,
> > +                                instr->ctx.data.len);
>
> Ditto.
>
> > +             return 0;
> > +     case NAND_OP_WAITRDY_INSTR:
> > +             return denali_exec_waitrdy(denali);
> > +     default:
> > +             WARN_ONCE(1, "unsupported NAND instruction type: %d\n",
> > +                       instr->type);
> > +
> > +             return -EINVAL;
> > +     }
> > +}
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Best Regards
Masahiro Yamada
