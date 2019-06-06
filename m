Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE727C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C7520883
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559804306;
	bh=/AotUYAn81Yvabr0QOuYw3tgELf9Sx7jAvd3vMMU3kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nQcwSo14z3YKv2o7lzCJv7p31QhSEMU7U8Nd2i4qjhYbdPljQsLfhzy7OIJKVC5Tu
	 b5ldr3UPLraj0AFDcXCXDn6fHhhsMOHTrERy0Aqn+57PJybNiLCS6LusYXwp+S0y5B
	 +YGr6Lil2QmvtoO15Gfgs7k1ABknGCW197/TiPe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFFG60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFG6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:58:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8752207E0;
        Thu,  6 Jun 2019 06:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559804305;
        bh=/AotUYAn81Yvabr0QOuYw3tgELf9Sx7jAvd3vMMU3kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loi3rC5hpwqc/ItwOijTJjtZsZuRbo9pg0ZFutYYR/BfAfq7OxiyuXfyiod69OYcM
         ykyNP7GpIsHdSWwKHqY4ppeG7Kya1j5n+9jllVJz6BFPiB17yIxD5L300a0TaTn8Sz
         ijLeZZ+AGRzmaXxhGzDwgga8F1Q3++6lFMxc6ZqI=
Date:   Thu, 6 Jun 2019 08:58:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] USB: move usb debugfs directory creation to the usb
 common core
Message-ID: <20190606065822.GA29436@kroah.com>
References: <20190605092816.GA23758@kroah.com>
 <20190605124440.GD17558@kroah.com>
 <1559788368.8487.109.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559788368.8487.109.camel@mhfsdcap03>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:32:48AM +0800, Chunfeng Yun wrote:
> On Wed, 2019-06-05 at 14:44 +0200, Greg Kroah-Hartman wrote:
> > The USB gadget subsystem wants to use the USB debugfs root directory, so
> > move it to the common "core" USB code so that it is properly initialized
> > and removed as needed.
> > 
> > In order to properly do this, we need to load the common code before the
> > usb core code, when everything is linked into the kernel, so reorder the
> > link order of the code.
> > 
> > Also as the usb common code has the possibility of the led trigger logic
> > to be merged into it, handle the build option properly by only having
> > one module init/exit function and have the common code initialize the
> > led trigger if needed.
> > 
> > Reported-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Chunfeng, can you try testing this again?
> 
> Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Thank you, Greg, Felipe

Thanks for the review, and all of the different iterations for this.
For something so "simple" it sure took us all a number of tries :)

I'll go queue it up now so that your future work can rely on it.

thanks,

greg k-h
