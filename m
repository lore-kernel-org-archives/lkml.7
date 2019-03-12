Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3304E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3KCMP/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfCLS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:58:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40567 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:58:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id w6so3292608ljd.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwH0Un1bztIvQMcMoACjNCx8wtPMdcdiCF16B+OpEI4=;
        b=p3KCMP/lMW0Y13EOCf7LL7Yd2SVozELVEQrkB7v35Ztos2GpOPGt3qvVQ8879quoKi
         XgBPE0N/5hbAStXXpQq9HwyQ/WaKgbt1QLVCCO4flBMGbB7rfovJxvtalu/r6RACFM+M
         Lhw+4jp6txmO9jCxntLQSN8AeH/abCfXBJYFuwxtLSmZqYjEgqQMlAHzGxddzcmvPqR2
         /I6Y/A9mXf+96jKZsdgULcg7UQcTaPUZWn1TmbA1lk6HqTlFBJ12KzIf0BUSEs7XXFCX
         X7Y2kSal6c8gYe8w6FTs5HB5hdsH2fALsVBrJSrtqXUBloqtOUo6SdZrmLgI5dGHv9+I
         CT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwH0Un1bztIvQMcMoACjNCx8wtPMdcdiCF16B+OpEI4=;
        b=MIZ04Nf/Rkb60ziCxxgRe2ehDk9cxFkeIy0G8KTTob1X3Qu475/eJEZQ0ZcAhXQZx2
         QviYGn5XjNvfqBoR5jjiCB4IUyh1ftbcdXy6g4N8amrXne3ixcnkIldbP8EiNhauiMzU
         UPaAD1dNq7szbdDI16yKGOkx9lNIa8X4Ndn6sZV5ohWK5g/EjHNvhGALX/qG+KEOFGD/
         VvMV02DOCuU2ibKsg+m4qnKPuCKaBPMaZvoaPHS6guaY0sPah3e/MP1WbS8/32sHOo+S
         ZUEUjP0sE3UPChhm6614lE4GjTntXDNIt3POMdapqHbcUCtTG2KNRx2BPIixIyFSPhqj
         Mc+w==
X-Gm-Message-State: APjAAAXHHcaMyNLx9TYEGt0bNVLgi0xwWTAQFLJKtMfjE4pW2ikqC5/R
        z1f4/nHo1cC3OUPAScto+VCdgL/9cxIPe+7z3YE=
X-Google-Smtp-Source: APXvYqx2yDY/JdcWlH8pBbmIcSH8pA3pgEW8gNo8PACoFi7WiE+L1RQdfZ8taVUWoJ4bKcMp6C3N1AmnUhMWdZXPci8=
X-Received: by 2002:a2e:9105:: with SMTP id m5mr21399530ljg.100.1552417086691;
 Tue, 12 Mar 2019 11:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190311184928.25988-1-andrew.smirnov@gmail.com>
 <CAOMZO5DwA0jgfwOgvgWUq1j9qFQUTHz+SVcD3oPdUhkwAfG=GQ@mail.gmail.com> <CAHQ1cqGhDVgjV+YBZg3OxVNtxried1_wx8K9WVj-8dVpDum8ZA@mail.gmail.com>
In-Reply-To: <CAHQ1cqGhDVgjV+YBZg3OxVNtxried1_wx8K9WVj-8dVpDum8ZA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Mar 2019 15:58:17 -0300
Message-ID: <CAOMZO5BvyxfBMWgzOoVT2ByY+P-brv=0gQF-YqR-D=40FLFMvg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SPB4 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Mar 12, 2019 at 3:47 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> OK, will do. Although, "flash" seem to be more popular in ZII files
> (used by RDU1 and RDU2), so I am inclined to use that instead, if you
> don't mind.

That's fine.

> I am sure you've noticed that already, but just in case you didn't,
> all of the non-generic names actually came from DTS for SPU3, so it
> looks like we missed that when that file was upstreamed.

Correct. I will help fixing the node names on other zii dts files for
consistency.
