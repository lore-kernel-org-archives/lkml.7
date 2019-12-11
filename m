Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED36C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68BB214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576066421;
	bh=Xb2LGz2eTWzVl5uyo4dQX6iViMnhQ99Qr/UakTyz5ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gI25BGvp47ahEWjNIkhxmhBKJbE4kf18mMarZk0t2PH5XaOSWtmeZG4UoBUWLGjRG
	 bDgzFW46fMrUzfxskq/PSBk+F2XD896TfNJjnZbTT2dendS5dFY5J4BtQtAJTDhdh2
	 RuQdPZDKRXnV1H1994ouLC1JxYi6BGc2Tk7xugfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfLKMNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfLKMNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:13:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBE620836;
        Wed, 11 Dec 2019 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576066418;
        bh=Xb2LGz2eTWzVl5uyo4dQX6iViMnhQ99Qr/UakTyz5ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wS6Hac2ka68LJuY+urNJ7+TrhlmTCBY5xL+AA+llIbqf2M33Ffqik8jPjVZn/54bF
         hun7b58MV5IkBsHOBvcmhySsVO9QPQ7wGHH2x1+SlmfYSO2H16B+tUYcsIKZ/citOH
         Rd+DoVV05ECek/dMk6YYOsdNJJCK6Of5FT1ClazU=
Date:   Wed, 11 Dec 2019 13:13:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] tty: serial: samsung_tty: fix build warning
Message-ID: <20191211121335.GA513966@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-2-gregkh@linuxfoundation.org>
 <181db297-2865-5b34-6ef1-e410babaf3bb@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181db297-2865-5b34-6ef1-e410babaf3bb@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:01:28PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 10.12.19 15:36, Greg Kroah-Hartman wrote:
> 
> Hi,
> 
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index 83fd51607741..67c5a84d0a26 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -1851,7 +1851,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> >  
> >  /* Device driver serial port probe */
> >  
> > +#ifdef CONFIG_OF
> >  static const struct of_device_id s3c24xx_uart_dt_match[];
> > +#endif
> > +
> 
> By the way: I've got some patch for conditionally declaring of match
> tables (including MODULE_DEVICE_TABE() call), so such ifdef's aren't
> needed anymore.

That's not why this #ifdef is needed.

greg k-h
