Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4EEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B206B20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221495;
	bh=+WbavMlUKYGr1ZDi1CRg0fUacKJqI5fSp3MW8bgjmtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bA0e9TTvq6FVBlg+U1IUJwJRlpA3Li0dAOTZoiNSr+kINdoyDR+5m6YqNbiZE4TTa
	 pzCqeS7ckJEHyQo7GqfCDYDZR8ZIIN6zaIM4Of93YYdGrtmsa81DC6PXsyRyjxzVRo
	 hmYn3dB3SqbmrJ2AisutHpGPwNj28+Kb8gr38rd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfDYToy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDYTox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:44:53 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19250205ED;
        Thu, 25 Apr 2019 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221493;
        bh=+WbavMlUKYGr1ZDi1CRg0fUacKJqI5fSp3MW8bgjmtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWjqPpiNpc/JRSMEIGJRruva0t/q03uMvb1NujGEDZM2gjjeS+wwLvWgxJpKVmsf1
         Db8vcghQqpdnLIcISnVJTfyeCihKRK+5IWtvnVjyxt8SbL98sFwMIhmO23cDeZSaUD
         RPavxocu7vnpbjT6fwG14PPsovBfPDKA6F9kZsuw=
Date:   Thu, 25 Apr 2019 21:44:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
Message-ID: <20190425194451.GA14552@kroah.com>
References: <20190330141637.22632-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330141637.22632-1-boris.brezillon@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 03:16:37PM +0100, Boris Brezillon wrote:
> The AT25 protocol fits pretty well in the spi-mem model. Convert the
> at25 spi driver to a spi-mem driver and use the dirmap API instead of
> forging SPI messages manually.
> This makes the driver compatible with spi-mem-only controllers
> (controllers implementing only the spi_mem ops).
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/misc/eeprom/at25.c | 282 +++++++++++++++++++++++--------------
>  1 file changed, 176 insertions(+), 106 deletions(-)

Will there be a new version of this to fix up the problems that 0-day
found in it?

thanks,

greg k-h
