Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B675BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8648420870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555420879;
	bh=eSlvZBx3RSgyXDglpPkHPrbxVYN2yz9vYzaGNa8DjsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VyWKhbQDuL7BivSND5dnBSv4/QxE9h4VgnkqJd0Dyz5GXJLEcjJDw4OmDvXTLnYJu
	 cU4kmtiSvwRQ+m8JlfC3y3Hs3ug4LwqtbYoDrcQT4r/O1sx01U4K6X1aWpTBoLj18k
	 XHYSPfXN1bwLNdV7Vze9H/5DRq57ApSXZ9o+KzGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfDPNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfDPNVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:21:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A3E2077C;
        Tue, 16 Apr 2019 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555420875;
        bh=eSlvZBx3RSgyXDglpPkHPrbxVYN2yz9vYzaGNa8DjsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ls2O6DCVSbbz0zWOVyKYiIBsAwc1/6fDW8kRzO4gIi+rBBEntEI3oHfyryVZqj3sR
         wHHUvbDXpESIW7WobCJHpj9Irb8XKjoHU98bPExcEHWUXeGNkVpWKFDEgsPYhJBtm7
         itcnIkVimhxkOl7CriAlxlc07S7Waoiswf6waKbc=
Date:   Tue, 16 Apr 2019 15:11:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Slaby <jslaby@suse.com>, Phil Elwell <phil@raspberrypi.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Mao Wenan <maowenan@huawei.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: fix unused label warning
Message-ID: <20190416131101.GD7406@kroah.com>
References: <20190416123321.3577638-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416123321.3577638-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:33:14PM +0200, Arnd Bergmann wrote:
> A bugfix introduced a harmless warning:
> 
> drivers/tty/serial/sc16is7xx.c:1523:1: error: unused label 'err_spi' [-Werror,-Wunused-label]
> 
> Move each label inside the correct #ifdef.
> 
> Fixes: ac0cdb3d9901 ("sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Someone sent this same patch a week earlier.  I'll merge yours into
it...

thanks,

greg k-h
