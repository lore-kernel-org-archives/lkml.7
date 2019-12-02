Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED15C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FDC215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=home.nl header.i=@home.nl header.b="Qeyz9euu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBMDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:03:03 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:45986 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfLBMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:03:03 -0500
X-Greylist: delayed 1242 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 07:03:02 EST
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <karsdejong@home.nl>)
        id 1ibk5q-0004qu-SW
        for linux-kernel@vger.kernel.org; Mon, 02 Dec 2019 12:42:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=home.nl;
        s=201809corplgsmtpnl; h=To:Subject:Date:From;
        bh=YLXC0XBbzlwCAGXJDXKrvYIocVCl4uJewEHmpw/A/Xg=; b=Qeyz9euu5PUo2yiYsI0e02mHAK
        A/onbgBUpQpLbVD5NFfcAE2SulZ3YalcVU0bEz9bsnMTFTZMTgM/EfNjA+pFxOa1Wh/Y3+g5ZJ0N9
        TUxWeLJmm0C/LK1jae3MzdeQaUzpk7/bewGPp4WSfMOPLQLlHo15EOUaRPdZQe1KxUGACU/bzO5eD
        N5gPN/4CzYf1fpwQkilDU6VpFejJX7Wu73Fax26ASw0Iuu8zKofWNHRr7KINRp46Qzmm2as0xom2u
        tndeoww+nFmqe7gj66l9xHoWNA2kfKeNl1VnJjJYkMoa793iSvz0QzVA+FwM2hnmpb2WsBkxzcXKb
        d9MrWn5A==;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <karsdejong@home.nl>)
        id 1ibk5q-00029O-Np
        for linux-kernel@vger.kernel.org; Mon, 02 Dec 2019 12:42:18 +0100
Received: by mail-wr1-f41.google.com with SMTP id t2so43786963wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 03:42:18 -0800 (PST)
X-Gm-Message-State: APjAAAX7S7CcJrP7gxDU2FiW7wxDBN6/cRHJo9mdStyS32doshD9/AF8
        Csb1d6zWxEAzpbUYfAKRy9MACyGEzHC0HPnR7CA=
X-Google-Smtp-Source: APXvYqz7beAF7NVKzbZBeYsQhk6HkVllb6e0glkpL5bjyQ+026De230D24PuabZGNA1S9X13vvdS040AL9ds4Hlfc24=
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr21525943wrv.250.1575286938367;
 Mon, 02 Dec 2019 03:42:18 -0800 (PST)
MIME-Version: 1.0
References: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org> <CAMuHMdVLusDDB5G1R7=-53sK1bd2+3=s42hr9xkgPtWyjOrozg@mail.gmail.com>
In-Reply-To: <CAMuHMdVLusDDB5G1R7=-53sK1bd2+3=s42hr9xkgPtWyjOrozg@mail.gmail.com>
From:   Kars de Jong <karsdejong@home.nl>
Date:   Mon, 2 Dec 2019 12:42:07 +0100
X-Gmail-Original-Message-ID: <CACz-3rjOPg_rMt_FbJ5_nKLpjTK-Bv=amGsJpXwqbTBNX4YA7w@mail.gmail.com>
Message-ID: <CACz-3rjOPg_rMt_FbJ5_nKLpjTK-Bv=amGsJpXwqbTBNX4YA7w@mail.gmail.com>
Subject: Re: m68k Kconfig warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.221.41
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=ZLepZkzb c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pxVhFHJ0LMsA:10 a=tBb2bbeoAAAA:8 a=JfrnYn6hAAAA:8 a=_nT3hX5ytRn4k0QMb7MA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert & Randy,

Op wo 27 nov. 2019 om 08:12 schreef Geert Uytterhoeven <geert@linux-m68k.org>:
> On Wed, Nov 27, 2019 at 2:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > Just noticed this.  I don't know what the right fix is.
> > Would you take care of it, please?
> >
> > on Linux 5.4, m68k allmodconfig:
> >
> > WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
> >   Depends on [n]: DISCONTIGMEM [=n] || NUMA
> >   Selected by [y]:
> >   - SINGLE_MEMORY_CHUNK [=y] && MMU [=y]
>
> This has been basically there forever, but working.

The reason for SINGLE_MEMORY_CHUNK depending on NEED_MULTIPLE_NODES is
historic due to the way it is implemented.
I played with it this weekend and I got a working version of FLATMEM,
which can replace SINGLE_MEMORY_CHUNK.

I'll clean it up and send a patch later this week. A possible next
step might be to replace DISCONTIGMEM with SPARSEMEM (since
DISCONTIGMEM has been deprecated).

Kind regards,

Kars.
