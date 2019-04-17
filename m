Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55958C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162E22183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj/mjyUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfDQXKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:10:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35896 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387567AbfDQXKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:10:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so90061lfi.3;
        Wed, 17 Apr 2019 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6w3zue5X4ss1i9XwPCmZZh7K7NlmRcPYFqdH4lUvRc=;
        b=Tj/mjyUvr9jfgRhCZlNJeeMYEB1aUyvlVjPHhoz9McyDdZtgvf2qptNn5di/2+2AHl
         0CXBQNPXXi3qSva7yTWVY1xfk8s80IXeRa5LtwPrkJAuMNNuDXwRmPND/uqVP/MYFKAI
         DIqsSAufmpNegYC5kjWL66orfVPyzWFIJbEIfxH9PvS2PxDjVYLHHD/gVf7NJt+1KXXN
         xADds/mWJOnKvwbdWYV7wy41V9sI6OWRKXHvWcVKDWSeJU1NDw15ORTkTjG7CDsixmK/
         OFNYvBzEB14ueKxkuCgkGjI+KdLOGpLF3ihkEvcJLbkybzuUlARn+wQ3SHfqqq2Zg/4t
         pBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6w3zue5X4ss1i9XwPCmZZh7K7NlmRcPYFqdH4lUvRc=;
        b=H+/HPYKHe5vRRhscfOLDLZMXeclNS/X6GifSQloCdkKhv9VwWmt91B7JeiwCxkvCu9
         703yCMK0ww+N1iYrr54uDGglM9V37Zc4AAdxCHjX5JWqZ7UYm26Y85/z4FYuSfbD4fn3
         o3nQDvrXhHBQ7z/3Q9169C/P1QoXD8NxE49myUO6+nUC1XmUmeJbqi/n8u/daUBozYah
         6jGNKZIq44v2rrzgiSAUnt5kxFPx3Z+jKRgReowAbXarUi7LHI+a9y+yc90bZ2oRZikJ
         yFwy6q9JdfghSsnLx/9vL3fjJVuN+oL4QXIDFvLSmsWsBRfOhLkrICj5CeUFb/ttL2g9
         ZIFw==
X-Gm-Message-State: APjAAAUNuqg9FZAGL/7aJmUkItGztonOpfCeFB5IxHMAZxSbB0lr0Ho5
        jBuPLtfcIqLAmKVbbNvL1/A=
X-Google-Smtp-Source: APXvYqzHnumzJ7s9XZ5BTvVY1IhFTlq5xEJOTTPGBVeSqYaZ2kg+b/ehcVg+QqfJfG3vVG/muZjv1A==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr28612306lfk.125.1555542603114;
        Wed, 17 Apr 2019 16:10:03 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id x2sm59290lfg.59.2019.04.17.16.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:10:01 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Thu, 18 Apr 2019 01:09:59 +0200
Message-ID: <3638685.4RdFRBT8kZ@z50>
In-Reply-To: <20190417114010.774693cf@xps13>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190324223344.24590-1-jmkrzyszt@gmail.com> <20190417114010.774693cf@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaro, Tony,

On Wednesday, April 17, 2019 11:40:10 AM CEST Miquel Raynal wrote:
> Hi Janusz,
>=20
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Sun, 24 Mar 2019
> 23:33:44 +0100:
>=20
> > After recent modifications, only a hardcoded partition info makes
> > the driver device specific.  Other than that, the driver uses GPIO
> > exclusively and can be used on any hardware.
> >=20
> > Drop the partition info and use MTD partition parser with default list
> > of parser names instead.  For the OF parser to work correctly, pass
> > device of_node to mtd.
> >=20
> > Amstrad Delta users should append the following partition info to their
> > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> >=20
> > mtdparts=3Dams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params=
),\
> > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).
> >=20
> > For their convenience, CONFIG_MTD_CMDLINE_PARTS symbol is selected
> > automatically from that board Kconfig if this NAND driver is also
> > selected.
> >=20
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
>=20
> FYI I am okay with the change but I am waiting for acks before applying
> it.

May we have an ack from you?

If still not convinced with my clarifications, I can add a comment to help =
text=20
in Kconfig, either squashed or in a follow up patch, on the requirement of=
=20
appending mtdparts parameter to command line.  What do you think?

Thanks,
Janusz

>=20
> Thanks,
> Miqu=E8l
>=20




