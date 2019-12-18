Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC479C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B2024672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576651834;
	bh=VBdg0J6ty6QcJFBg28FlHO+nPnjtajw/gEgQgovgVrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QwgNR8Nk3RXoTZDmGfOWXoZVsx69bJ0/xDuWQqHTW6+b0tP+ypZ7mSugPfInAZOpS
	 Z0+gKDwo3MCKuabxtoU/amjqJFFZUiaCvxYMWQ+WI1MtoACnfCO8Us57EMsutGsVUe
	 CPqHn1qQe2GeH8AQ8DBWZqkmPHkliGNpOG69v7+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLRGud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:50:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA18218AC;
        Wed, 18 Dec 2019 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576651832;
        bh=VBdg0J6ty6QcJFBg28FlHO+nPnjtajw/gEgQgovgVrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JG1N9hV76SNT/Fh2u1Euo/BM0OhYdJZX71HVQr6hn8GUjBfVYzbIyHDrfbHQ/iYpS
         K2zsALv1e7cMaKp1dd96VTQDcFiTzI9vRLxZPtEU4aonEKZHgrnF1njrHgPyuLgNeq
         v5mzcd8tKHTZHJXLue7lhQ1RYoprG1wENf62y2QE=
Date:   Wed, 18 Dec 2019 07:50:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH-tty-testing] tty/serial/8250: Add has_sysrq to
 plat_serial8250_port
Message-ID: <20191218065030.GA1270813@kroah.com>
References: <20191218040111.346846-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218040111.346846-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:01:11AM +0000, Dmitry Safonov wrote:
> In contrast to 8250/8250_of, legacy_serial on powerpc does fill
> (struct plat_serial8250_port). The reason is likely that it's done on
> device_initcall(), not on probe. So, 8250_core is not yet probed.
> 
> Propagate value from platform_device on 8250 probe - in case powepc
> legacy driver it's initialized on initcall, in case 8250_of it will be
> initialized later on of_platform_serial_setup().
> 
> Fixes: ea2683bf546c ("tty/serial: Migrate 8250_fsl to use has_sysrq").
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  It's probably better to squash this into the 8250_fsl patch.
>  I've added Fixes tag in case the branch won't be rebased.
>  Tested powerpc build manually with ppc64 cross-compiler.

I have squashed this into that original 8250_fsl patch now, and rebased
the series.  Let's see what kbuild does...

thanks,

greg k-h
