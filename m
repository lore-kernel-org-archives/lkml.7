Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97010C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A165217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfHEJ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:56:15 -0400
Received: from shell.v3.sk ([90.176.6.54]:60334 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfHEJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:56:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0AEE0D5DDB;
        Mon,  5 Aug 2019 11:56:10 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q-7FVgH1G8-P; Mon,  5 Aug 2019 11:56:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E7E5CD5DD8;
        Mon,  5 Aug 2019 11:56:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lqHkZW8HlhTz; Mon,  5 Aug 2019 11:56:01 +0200 (CEST)
Received: from zimbra.v3.sk (zimbra.v3.sk [10.13.37.31])
        by zimbra.v3.sk (Postfix) with ESMTP id 346F0D5DDB;
        Mon,  5 Aug 2019 11:56:01 +0200 (CEST)
Date:   Mon, 5 Aug 2019 11:56:00 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1387772868.4330.1564998960018.JavaMail.zimbra@v3.sk>
In-Reply-To: <20190803085824.GB8224@amd>
References: <20190802103326.531250-1-lkundrak@v3.sk> <20190802103326.531250-7-lkundrak@v3.sk> <20190803085824.GB8224@amd>
Subject: Re: [PATCH v2 6/6] ARM: dts: mmp2: add OLPC XO 1.75 machine
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.13.37.1]
X-Mailer: Zimbra 8.6.0_GA_1153 (ZimbraWebClient - FF68 (Linux)/8.6.0_GA_1153)
Thread-Topic: mmp2: add OLPC XO 1.75 machine
Thread-Index: tSI++o0iWICeZ1TARJ86vAWcjaSjHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 3, 2019, at 10:58 AM, Pavel Machek pavel@ucw.cz wrote:

> On Fri 2019-08-02 12:33:26, Lubomir Rintel wrote:
>> This is a fairly complete description of an OLPC XO 1.75 laptop.
>> What's missing for now is the GPU, LCD controller, DCON, the panel and
>> audio.
> 
> Ok, but I need GPU/LCD/panel... that's my only output. Is video
> expected to work in 5.2? Does the firmware pass right device tree,
> including the GPU/LCD/DCON?

The firmware (and the dts) uses a simple-framebuffer. You won't get
any nifty features, but you'll get a framebuffer.

Hopefully we'll get a proper DRM video soon. The status is roughly
as follows:

LCDC: potentially supported by the Armada DRM driver. Patches sent to
Russell King some months ago, not there yet. I'd prefer not to nag him.

DCON: Russell dislikes the idea of a DRM bridge, DRM maintainers prefer
if the driver was not a DRM encoder driver. This seems to require
quite some work to fix [1].

[1] https://www.spinics.net/lists/dri-devel/msg201927.html

GPU: supported by the etnaviv driver, good enough for 2D acceleration
to work with xorg-x11-video-armada driver. 3D (weston and mutter alike)
is broken. To add this to the device tree, the clock and power needs
to be figured out.

> Is there config somewhere I could use?
> 
> Thanks a lot,
>								Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
