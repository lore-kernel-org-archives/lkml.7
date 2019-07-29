Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66ADC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A56E2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzRXW84t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfG2HO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:14:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44828 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2HO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:14:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so60533817wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cPhNW6XM/DWjYpp1TRsuuPPfo9D+4pBgDNYFFKehphM=;
        b=VzRXW84tovUMshRZqE7B2N33RTcWhzQpxbZnLaZjI88d/N8Q+d1/XwrNy2AzEU7E8L
         2v2xXFyEHVtiU1kqgIuoRko0Uyz4ddLof+jzG+XuqQNWkLpl5QhrSraek22QpOvYc63o
         H3bVGEtUaEhCfq75+62X+3m0kdbhq2n6KHTxhY/CLgurtjBkt7qlsygME7cf7YmRc7A3
         rM1Z/l+8pRJnCYwzWPjanCWNmyW3AmYIX1JV2jX188aPg+s2mORYhhHXPw2w1WdLaRtY
         LxXOFY687g7D+9GzktpvvcFAsSPlwgc2CMtGeti3TUXujzsxa2phpy9iNo+gk5HhRF4i
         /a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cPhNW6XM/DWjYpp1TRsuuPPfo9D+4pBgDNYFFKehphM=;
        b=pXpAZK0hBmzO174h3DfafLHM66qt5Dkn1+d/J033R5uTYBL14cW8H7NB5mVQkegCr7
         rGsCzJPZp54hp9mlBx1xNhP46l0PVDiornsZp7LbyHvNfVcMdYn34SS3GgzdevoUDJ+R
         cwqM9d3kuguYrXai3gml1I2UkqQQB6QsE4sTrVlCSgqMegNyY4dYic32A+zuH5Pv45Ei
         Q1UNoew/Q0X8KjCTPAUgviip4s9+pwS91V6WqhRQrgPnI4kEL+k+KRY75PB9eDUibGGr
         afsLMB1l0CdmQcXljeXdJZVyeNl4WmaJBMEb8nQyMIbeBBcRTLU4eByduQqYfpo3dOgt
         ye5w==
X-Gm-Message-State: APjAAAV3gYs0qeGU8ix0pjgwDtUsjQlRMkumwp2M5Cz6cS1JwU7qvV0i
        9TqpRpRkF0wlThBMW61Tqgwx1MBE13QBjSqh/wM=
X-Google-Smtp-Source: APXvYqxlE5EC8FXImrLCZo8M6Mps0ppkoTKD0q4f3M3xR+b39DLEtMg49EXST++vclsWjzxqN6WplQUIOBJnkwTD/Ys=
X-Received: by 2002:adf:e602:: with SMTP id p2mr81437019wrm.306.1564384465878;
 Mon, 29 Jul 2019 00:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190618030926.30616-1-yamada.masahiro@socionext.com>
 <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at> <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com>
 <957967732.18164.1561621143523.JavaMail.zimbra@nod.at> <CAK7LNAQLheA3E0UrjirNHzpS2x+xmjc2YCupCBMNoHOwviz6GQ@mail.gmail.com>
 <1574230514.38485.1563091693340.JavaMail.zimbra@nod.at>
In-Reply-To: <1574230514.38485.1563091693340.JavaMail.zimbra@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 29 Jul 2019 09:14:14 +0200
Message-ID: <CAFLxGvxYa9AZiSLBVeDtXznab41me8jBUMoGNvcMDfAZQ8wr7g@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
To:     Richard Weinberger <richard@nod.at>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 10:08 AM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Looks like this trivial patch missed the pull request.
> >
> >
> > My motivation is to make sure UAPI headers
> > are really compilable in user-space,
> > and now checked by the following commit:
> >
> > commit d6fc9fcbaa655cff2d2be05e16867d1918f78b85
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Mon Jul 1 09:58:40 2019 +0900
> >
> >    kbuild: compile-test exported headers to ensure they are self-contai=
ned
> >
> >
> >
> > Is there a chance for it being merged,

Appled.

--=20
Thanks,
//richard
