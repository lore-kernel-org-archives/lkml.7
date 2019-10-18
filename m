Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A2B21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505956AbfJRTTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:19:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35427 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbfJRTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:19:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so10720251qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3U4XGKYJwhdQD0/oZgkQawFhyEgJU1s1iV2DJRNVE0=;
        b=E4K3fsEpbGRU96ifyfJUBhRH5+3380tM/UpQFIYcemC62gkZ4ZP59P+fSvWJAME/kL
         pEdZZC5lTMx83uCHQPhH5YOqM5RlUirv3kd1AHZJJtFjEiZkPkxTfN36iotbE0A2IEbV
         otMXVknkWOJY8WzevPbXfoJ9I96zG+uxMpgNJf/8uh3xSDNyh237AJM/RtEkrX4etDEh
         qBQc3jPGOuGdlynDT+1IxaSJxgZvikH1ycupDizIKatodjqF461G4Ep5k2Ax0Pf+Q1ur
         mK4tHo4m1RPffdrztqjyb23+AWImxDIaKktds0RzcwREmiOiAbvDc+5QmkeA898QDFO9
         anKg==
X-Gm-Message-State: APjAAAX4203WzXybwDHZu9/dbMZVBYK9wtco94jaMKrfekHj2j/9rBSo
        LlOVCJYGxqLrGa4nVdBQ49lqz68xK366hmXhdEw=
X-Google-Smtp-Source: APXvYqxSdwLbuKUmnS6HRUngapjYIWC2HNoTLspIqQPpMjTGmKepluzI6LCX3jGsQESRx9rOP5yHQqeQSsLxa9EJpzQ=
X-Received: by 2002:aed:3c67:: with SMTP id u36mr11534406qte.142.1571426348391;
 Fri, 18 Oct 2019 12:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de> <20191018163047.1284736-6-arnd@arndb.de>
 <20191018190135.GF24810@lunn.ch>
In-Reply-To: <20191018190135.GF24810@lunn.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Oct 2019 21:18:52 +0200
Message-ID: <CAK8P3a1hw7Zi_g=F2ZThDW0FCKO1941f0yM8b0OA4d0toTRpUQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: orion: unify Makefile/Kconfig files
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 18, 2019 at 06:29:19PM +0200, Arnd Bergmann wrote:
> > +config MACH_TERASTATION_WXL
> > +     bool "Buffalo WLX (Terastation Duo) NAS"
> > +     help
> > +       Say 'Y' here if you want your kernel to support the
> > +       Buffalo WXL Nas.
> > +
> > +endif
> > +
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menuconfig ARCH_ORION5X
> > +     bool "Marvell Orion"
> > +     depends on MMU && ARCH_MULTI_V5
> > +     select CPU_FEROCEON
> > +     select GENERIC_CLOCKEVENTS
> > +     select FORCE_PCI
> > +     select PHYLIB if NETDEVICES
> > +     select PLAT_ORION_LEGACY
> > +     help
> > +       Support for the following Marvell Orion 5x series SoCs:
> > +       Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
> > +       Orion-2 (5281), Orion-1-90 (6183).
>
> Hi Arnd
>
> I don't think this SPDX line should be in the middle of the file?

Fixed now, thanks!

      Arnd
