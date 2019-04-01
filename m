Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2802070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="J7f2vPmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDAQ7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:59:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:25954 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfDAQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554137979;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=AA7Zbv+zNWErh6FEar2Ilg87a9MVIqPnoExbkc37AJ8=;
        b=J7f2vPmbMGoO7Fw7qEIXTyDwH40T8pXld5bb9QzLSG2+SUgus1v9EQNeljbMenpnoV
        4DVBCgIh/ySB7b6wKioyi6KeWbEnDihuBXwvUGtrIM/cv9QQszYEU+rZXHT8EyYHnaQH
        J6M8gwRLsHXwaEQObPcBpe0hl0t+/J29JUD4rijSqgz1noLrJz9uEnuEBGnsIUGNj+df
        4fDtdKuCf3TIilbbqDZCxjMTEsuc/tWUmttVSXm+kX2jGOhH0ehyqL+gF7oKRke1I90D
        8c8Y1pxQhVpoHNsyHlFeFz6WouCJULE+sbl4PglldyLJjCZojDkui1siuf1aCi7r98Iu
        0Nzg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCytSXx+xTv55Mr4wfVNE9oh5GZKX9cwIoXd1A5a"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:268d:9f00:4c7b:603c:d32e:111a]
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id K07648v31GxNdW1
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 1 Apr 2019 18:59:23 +0200 (CEST)
Subject: Re: [BUG/PATCH 0/4] gpiolib: fix issues with legacy spi-cs-high handling
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
Date:   Mon, 1 Apr 2019 18:59:22 +0200
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org
Content-Transfer-Encoding: 7bit
Message-Id: <2D0BC383-A57A-4C36-AC48-539B4E8811C0@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
To:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> Am 31.03.2019 um 12:07 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> 2018-07-25 07:55:28: 
> 
> H. Nikolaus Schaller (4):
>  DTS: GTA04: SPI / gpiolib: work around a regression that unhides a
>    broken legacy handler, which makes the gta04 display inoperable
>  REVERT: DTS: GTA04: SPI / gpiolib: no no no, we do not want to "fix"
>    our device tree file
>  gpiolib: make legacy handling for spi-cs-high optional
>  gpiolib: spi-cs-high is checking the wrong node (the controller and
>    not the SPI slave device)
> 
> drivers/gpio/Kconfig      | 8 ++++++++
> drivers/gpio/gpiolib-of.c | 8 +++++---
> 2 files changed, 13 insertions(+), 3 deletions(-)
> 
> -- 
> 2.19.1
> 

I learned just some minutes ago that a new patch for gpiolib
came through 5.1-rc3 which does fix this in almost the same way
as I proposed.

Except that it seems to check for "cs-gpios" and then disable the
legacy handling.

So we do not need to add a config option for this legacy
handling (although I'd prefer to have it anyways to remove
some dead code).

Summary: this series can now be ignored.

BR and thanks,
Nikolaus

