Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CAC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726B4207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560186788;
	bh=sT/rZSZYEkVXc+vfxxISMm6Asd7SJoGF8UinSixDpnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWqG9RuDkBiVim7IUn8Xva10Cz6Puc/pRtFv+n2g2RTWPJJ/CZzBhFKRQ9rrTb10F
	 pDwqUVybp9q3wYTjMJkBUxMejeirQ494z4twQDoyc6yXXq0ILCnD8J5Rea5lbqV9a5
	 omYlWhexJr1VUU+t2X7TZy5P+E7PMwH2+/SGYQHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbfFJRNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387500AbfFJRNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41AE5207E0;
        Mon, 10 Jun 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560186785;
        bh=sT/rZSZYEkVXc+vfxxISMm6Asd7SJoGF8UinSixDpnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bSwVDIRlZNG9xrSaFEIuayW/tn8kHGx1Y+QO1S18vHPPtZ9tJlabLj8ZLJC6+Tz2
         y8zMJ6kOVtka73LQLBRNh+BCMJSvcylXJPydtkd+yOr2W2daDYUUczRmRC32TVuVqy
         9Ynq/LYS1yDKhy4KOLZhtUGXm2SmfunmUR5jtq2A=
Date:   Mon, 10 Jun 2019 19:13:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] serial: uartps: Use the same dynamin major number
 for all ports
Message-ID: <20190610171303.GA14134@kroah.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
 <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:44:56AM +0200, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Let kernel to find out major number dynamically for the first device and
> then reuse it for other instances.
> This fixes the issue that each uart is registered with a
> different major number.
> 
> After the patch:
> crw-------    1 root     root      253,   0 Jun 10 08:31 /dev/ttyPS0
> crw--w----    1 root     root      253,   1 Jan  1  1970 /dev/ttyPS1
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does not apply without patch 1/2, so dropping it from my queue.

Which is ALWAYS a good reason why you should submit bug fixes or other
things before code cleanup patches.

thanks,

greg k-h
