Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FCA2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553750962;
	bh=WwD3FZpLpENsdUAVLdfIEmwYDcs5P1X4BUDIANr2viQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AUPLpI8pAaIwfcTM+dUunQddWrSSQPIiWYAAHzNvUupSqfc9MNnRdvKeVNzrF0/Ac
	 xVOeym7kuyZ/PdJVFAevjgc8jdlml/Hfex6zUlxjVP3kkUlBvPi5IRAsW9CgSS0LpJ
	 i8nJrL1bOrHqJsD7zdkAhc5kcih15GB9bpwFAAns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfC1F3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfC1F3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:29:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7583C20811;
        Thu, 28 Mar 2019 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553750960;
        bh=WwD3FZpLpENsdUAVLdfIEmwYDcs5P1X4BUDIANr2viQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yE25EW4aFL57MusACL2gL2GG6X39XHGGiNrHuIdT0mYySSdoSL6SAp08m5rRWR27z
         976sEtbuB2bEGoal9TWSKRFRdN0Ov28RLOhA3DIjFdJcxtP7nuRzMpFt3YNBb4LZyW
         9HFkS19oH+LOwl+qoZmsxF6SaudcGpECHJtBCqDc=
Date:   Thu, 28 Mar 2019 06:29:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Message-ID: <20190328052917.GB18668@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328002817.GF24753@innovation.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> 
> On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > instead of straight printk() to match other dev_xxx() logging functions.
> > > ---
> > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/device.h | 15 +++++++++++++++
> > >  2 files changed, 58 insertions(+)
> > 
> > No signed-off-by?
> 
> Aargh! Apologies, fixed for the future.
> 
> > Anyway, no, please do not do this.  Please do not dump large hex values
> > like this to the kernel log, it does not help anyone.
> > 
> > You can do this while debugging, sure, but not for "real" kernel code.
> 
> As used by this driver, it is definitely called for debugging only and
> must be explicitly enabled via a module param. But having the ability
> for folks to easily generate and print out debugging info has proven
> quite valuable.

We have dynamic debugging, no need for module parameters at all.  This
isn't the 1990's anymore :)

thanks,

greg k-h
