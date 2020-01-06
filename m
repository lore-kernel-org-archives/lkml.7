Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A6AC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075532072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578337101;
	bh=JqFB7SxHrWcyOP4N5DEnQmENuaUMIVm+HFB3PT0FOAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ppm+ghJ+9iIwsUolUSRnkBYA/ctpE6OiRKMACpby04T3HfGTy5wuOn9C+Fy3PWPY8
	 Lct4vk7D0asNKU1Bis4xuIdT+MW7gDhsfx0PRQhrPdAQr8DYLsu3oGTgFgwy7kF0LO
	 7HepjVJyAnxm16pwKkwZfLF1bxe3po2iTvvsRF6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAFS6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFS6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:58:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B150E2072A;
        Mon,  6 Jan 2020 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578337099;
        bh=JqFB7SxHrWcyOP4N5DEnQmENuaUMIVm+HFB3PT0FOAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVqz9/iIhSuobLqKYxE3K2Q8yDobIT1SpgZ5vcfEmmZK+hiiFdi9Ju9xE1iGOEjSI
         3FHHSBVr3f30wbOoOqvsBbA2V6yHLdKXFpM9d61vw81/okq03pJyxwn/dVfFdEbE8L
         ShwxkmNHzrCNt2fXelnDXpO3BXOy1E/BI2fIKpiU=
Date:   Mon, 6 Jan 2020 19:58:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: st-asc: switch to using devm_gpiod_get()
Message-ID: <20200106185816.GA597279@kroah.com>
References: <20200104202314.GA13591@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104202314.GA13591@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 12:23:14PM -0800, Dmitry Torokhov wrote:
> The node pointer in question is not a child node, but the node assigned
> to the port device itself, so we should not be using
> devm_fwnode_get_gpiod_from_child() [that is going away], but standard
> devm_gpiod_get().
> 
> To maintain the previous labeling we use gpiod_set_consumer_name() after
> we acquire the GPIO.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/tty/serial/st-asc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

What changed from v1 of this patch?  Please put that below the --- line
and versino your patches.

v3?

thanks,

greg k-h
