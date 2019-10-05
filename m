Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65425C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E748222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570258403;
	bh=Ae3CoYHyQyeGJxzoUlqKsX4JVnFfMox8TRhou//5Oe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCzCoYlgNWpudHeoAhexMK3NAJJ4+OPEY/wwzSRrkDLeZRlSUm7tJrL6g5OVyeqqf
	 8sjqo8+KrKsJVH3GuWdNjCALMvvZXhuDD4Rriqo+K4v2NCGPXS++rKWXwkNN/JPh/d
	 FgHZtq6TjiukUKUBIvBe1uIacOT9eZonSrAK+sSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfJEGxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 02:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEGxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 02:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F192133F;
        Sat,  5 Oct 2019 06:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570258400;
        bh=Ae3CoYHyQyeGJxzoUlqKsX4JVnFfMox8TRhou//5Oe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sybu7AavQJ1mF1KnXqEHtAtbHX+f8Nb48d/qVSnRpV3EURppeFZcy/pM1BTcajzOM
         4wAjMozHpsBXQqx0nuDi0iR+YPZW2j+6rD72L5xucP9KjwyDUN7Ptkj+1Lh7rMbekv
         UFOU5Kgu6MwGe7oYJyTIhlsODd44qM64LnRTttwE=
Date:   Sat, 5 Oct 2019 08:53:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 05/10] serial: stm32: Use of_device_get_match_data()
Message-ID: <20191005065317.GC928719@kroah.com>
References: <20191004214334.149976-1-swboyd@chromium.org>
 <20191004214334.149976-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004214334.149976-6-swboyd@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:43:29PM -0700, Stephen Boyd wrote:
> This driver casts away the constness of struct stm32_usart_info that is
> pointed to by the of match table. Use of_device_get_match_data() instead
> of of_match_device() here and push the const throughout the code so that
> we don't cast away const. This nicely avoids referencing the match table
> when it is undefined with configurations where CONFIG_OF=n and fixes the
> const issues.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please ack or pick for immediate merge so the last patch can be merged.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
