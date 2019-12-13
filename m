Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6749C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD826227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576221531;
	bh=SNoGhGHQqlnJ0YqCuKB0MMwQfW1ylbS1THlpD4JTQrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iEIFm9N9ytQhY+FJ1xLkM3dLaLGEFvjO549azRZwSxeT8eqboAECWT3NMPyYCh0r1
	 gZQWClujnZ2nQSS4pgnHx+1+vsTltvMjIH9Zpk8jKXKUs3h4D7DnRnm8fbPlaCtjio
	 4KW0ubD4l1+OisRQF4lUNSDvBkY+JWbpuesbUfHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLMHSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfLMHSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:18:50 -0500
Received: from localhost (unknown [84.241.199.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F2022527;
        Fri, 13 Dec 2019 07:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576221530;
        bh=SNoGhGHQqlnJ0YqCuKB0MMwQfW1ylbS1THlpD4JTQrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElDQf2nsGZl1rXjXDt50YCK2t3pOTND7sCLAPa0rkryOROHjT1WeZWoRBVdHMGpWA
         lBSF6XH72LoimogbB8DjD0BQ6Cl1P2/u6d7wPKvZjhI5E36XKmri3CVnkuRlrWcnkw
         M7a913AxoslxlFo5KNHKa/NYaOTKB10tQ1w1oXXk=
Date:   Fri, 13 Dec 2019 08:18:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 03/58] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
Message-ID: <20191213071845.GB1750354@kroah.com>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213000657.931618-4-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:06:02AM +0000, Dmitry Safonov wrote:
> The SUPPORT_SYSRQ is messy: every .c source should define it before
> including "serial_core.h" if sysrq is supported or struct uart_port will
> differ in sizes. Also this prevents moving to serial_core.c functions:
> uart_handle_sysrq_char(), uart_prepare_sysrq_char(),
> uart_unlock_and_check_sysrq().
> 
> It doesn't save many bytes in the structure, and a better way to reduce
> it's size would be making rs485 and iso7816 pointers.
> 
> Introduce `has_sysrq` member to be used by serial line drivers further.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Ah, you did what I asked here in patch 3.  Nevermind on my comments on
patch 2 :)

looks good, thanks!

greg k-h
