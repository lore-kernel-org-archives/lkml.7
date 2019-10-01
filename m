Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BFD21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpRrrSiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfJARH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:07:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46808 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfJARHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:07:55 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so49732543ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vk3Mw429iAwCdwc7SoNkJsPN3ePx/CtMd1YUMIkxouI=;
        b=DpRrrSiy2xqm+WuqU/qzUWhykUlmDHUMJ8f33kVHDaSQ7j0Bxm4M6/55DZ1MJ2shxI
         I8It6az9KX7i7VXjaGlI7V39TLjndjJV8ZU2jnGANWB/UueeuCyueujkW3318S0jGNmn
         insyfUCduOB06yfV7xbCbHXIpOnfNiVVcJxgKFP1oCmLcN/o0lIU9TpurGBc6sOCknpG
         sKOmo2yZNV1ozbkZT+RGPYirIkPk8fV1yzK6Xe00phCkOsEc5KbYcSRviGMqDMY/01uj
         rntRlgx4T/DGxN5+VW0oXR//cQxo0w6O9h9SCLKnfSnY/bGLcziG2mPHOO4HDOgVEAAt
         NDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vk3Mw429iAwCdwc7SoNkJsPN3ePx/CtMd1YUMIkxouI=;
        b=YGxZPfeekV1IZSHll84X15E/EQLn3URIn/OAqa5vQXlotQwDqfZOyEY4mM+0pRn31o
         nU7jGD28BCU7+cJ04qB3YLggFWMOO05rpLtKqm3wcX7WVlBI7yQWgK8ce2kyZG/UKHNv
         gePKRqysag7vqvVZkO5EoU3wYWXlcsOknmhdpmqEax6P+lZtuEsiP0BIdI9Y+CkI9hcI
         a1GB8oZsbXqBBoa7eMB26gnZfhxnG6M6ouSfy/iRtxtDZFE/f4QasSEq1/Dw3e/WIoO6
         2vr8Caq6TV/wr4mPgdJAmRnHi/TkQ8xEvQgXJO75iH/jozdqXk+InvNh9qApXv8PP+81
         VwVg==
X-Gm-Message-State: APjAAAWS6IAtVIRR4Tqc3bRWoPfaR9wWNZlbmIay1faIqYj4YVQJnwFP
        dsWho/lL1tb1ULJzVEm+L1wXRAYEx1d/rpMtHXc=
X-Google-Smtp-Source: APXvYqy7Cii0rhNBf7stnDBIl3iClh8mjr74Jlu/0i2ZnHP/yEo45fiD35+XGFzAdFr+g2fXuBQGeklsdkeIiUILLiI=
X-Received: by 2002:a05:6e02:8e9:: with SMTP id n9mr25603130ilt.21.1569949675097;
 Tue, 01 Oct 2019 10:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190906194719.15761-1-kdasu.kdev@gmail.com> <20190906194719.15761-2-kdasu.kdev@gmail.com>
 <CAC=U0a1qvKO+t_62df_JcQBETAuNq0pwRkAb-Ofi3ski2rfdEQ@mail.gmail.com>
 <20190930182458.761e8077@collabora.com> <CAKekbevBxGh9HRLX_4N98NwKm4GnXWvy9kwi6i=nRVnmfmJ-vw@mail.gmail.com>
 <724490481.10665.1569872374621.JavaMail.zimbra@nod.at>
In-Reply-To: <724490481.10665.1569872374621.JavaMail.zimbra@nod.at>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Tue, 1 Oct 2019 13:07:43 -0400
Message-ID: <CAC=U0a0Jqf68zmB9TvkkCsUHjZ1tLrPBR2Bodj+odkTh+BE6_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: use bounce buffer when vmalloced data
 buf detected
To:     Richard Weinberger <richard@nod.at>
Cc:     Kamal Dasu <kamal.dasu@broadcom.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing with UBI/UBIFS where vmalloced  data buffers can be
passed to the nand_base and then o the controller driver. Probably
applies to older kernel 4.1.

Can the Patch1/2 be accepted or you want me to send it separately by
removing the nand_base changes ?.

Kamal

Kamal

On Mon, Sep 30, 2019 at 3:39 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Kamal Dasu" <kamal.dasu@broadcom.com>
> > This has been observed on MIPS4K and MIPS5K architectures. There is a
> > check on the controller driver to use pio in such cases.
>
> I fear your kernel misses commit:
> 074a1e1167af ("MIPS: Bounds check virt_addr_valid")
>
> Thanks,
> //richard
