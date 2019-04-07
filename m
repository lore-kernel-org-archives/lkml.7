Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BFBC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4319B20B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554637328;
	bh=aAvSguYGM9UGIXRblqX5xACz5jTPq40U7EHlQ8KwK1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ej87HG5+CunOrSqwkGGq58C8OaNM1lUoQekZh75t6sFWRsdLbr1/C/lPzquIQiM7f
	 QwmONdPPIlyprddyXW9aZz5Byjp8R2tbVyAHa0VeqWEn+dh09Ad/bPcb65YYka+PRZ
	 pmf/nOKUAa0amS8kl8zPz7+/3GyhVQ7DQ1ceHwlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDGLmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:42:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150F220879;
        Sun,  7 Apr 2019 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554637324;
        bh=aAvSguYGM9UGIXRblqX5xACz5jTPq40U7EHlQ8KwK1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SdALsWAKkhMNT/sG6tidJa5ocGvQpY98XX+nPS5tFvgtszeI/BPWjNYg3dMJ7CulI
         GLnTWiJ9M6v1VSGw081dAdTGeKLF8n1XEKlei1Yr0tc/3k8G1ZZzdzCZO/wVhTjAtb
         xq98thEJgTL3pXw9IclbZWv6AL0saJ5myom79NoM=
Date:   Sun, 7 Apr 2019 12:41:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] iio mount matrix - revitalize missing bindings
 documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
Message-ID: <20190407124157.1b3f1cd3@archlinux>
In-Reply-To: <3A50A918-61AB-4710-B9DA-DF041A898944@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <CAHp75VeMTd32S+bTgU2f1AS-NB67iuM+erT8qNJgPS7O0E1Cjg@mail.gmail.com>
        <20190303153201.440ac325@archlinux>
        <3A50A918-61AB-4710-B9DA-DF041A898944@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 08:29:12 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Jonathan,
> 
> > Am 03.03.2019 um 16:32 schrieb Jonathan Cameron <jic23@kernel.org>:
> > 
> > Thanks to Linus and Andy for reviews.
> > I've picked up all but they documentation patch.  I think
> > it is 'very nearly there', but would like a few really minor
> > tweaks.  Seemed silly to stall the other patches on that though!  
> 
> Seems they have stalled elsewhere since they did not yet arrive in linux-next.
The iio tree is not directly pulled into linux-next.  Hence IIO patches
only turn up there once I've sent a pull request to Greg and they have
entered the staging-next tree.

They still haven't quite made it into linux-next, but I'd imagine they
will tomorrow.

Jonathan

> 
> The documentation patch is still on my todo list and will need a little more time
> but that should not block the others.
Absolutely, this was just tree handling delays and me messing up a pull
request to slow things down even more.

Jonathan

> 
> BR and thanks,
> Nikolaus
> 

