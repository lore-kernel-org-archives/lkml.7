Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CECC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44872173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558450417;
	bh=AjUIu/ylmOl1CFi7JWDOg4hBOHxxuVBfcLwEBhgOb04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=07C9Y5UFklf+6ovREkAnzqd41uUf3dcSgkOIB77nmelxS1If5cpP1c7h2e6q1pqMA
	 77b8g0bzdhUmuD/dBjN2nu6kVml+B7szQ9cyRSFcENV+CYNLQI/ok6UQ4zPH0Bz+B3
	 0cV+sP6ag+wPbzN1fhDFC4GqyQA8K4zkYypCm71g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfEUOxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfEUOxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:53:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F269208C3;
        Tue, 21 May 2019 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558450416;
        bh=AjUIu/ylmOl1CFi7JWDOg4hBOHxxuVBfcLwEBhgOb04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2LL4MO6xFmvTJU8dsdLggafCdcnhpALUcbLH7G5g2ZEFKhyziOLQL5060cX4VFo2A
         7rcfVmUp6Kc7ndLsp+8aq4Ixh/s2zULsYzKiMSyaDRIzNtilOPiACwlOfqGSfWI2Ok
         Hdg4RQduSz5p4xRxeZRib2kaMQJ7qFNqTe724Fvk=
Date:   Tue, 21 May 2019 16:53:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Message-ID: <20190521145333.GA3491@kroah.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com>
 <20190521131131.GA19685@kroah.com>
 <878suzn9wx.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878suzn9wx.fsf@haabendal.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 04:45:34PM +0200, Esben Haabendal wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
> >> Allow getting memory resource (mapbase or iobase) as well as irq from
> >> platform_device resources.
> >> 
> >> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> >> resources are to be used.  When not set, driver behaves as before.
> >
> > Nothing actually sets this flag in this patch, so I can't take this as
> > you are adding new features that no one uses :(
> >
> > Where is the driver that sets this?
> 
> It sits here.

Where is "here"?

> It is a rather big and clunky mfd driver, not ready for
> upstreaming in its current form.  I hope to get around to clean it up.
> But it is for a very specific hardware that is really available or
> usable for anybody else.  Does it make sense to spend effort on
> submitting such a driver?

I can not take kernel apis/features being added for no in-kernel user,
that's just how Linux kernel development works.  I'll be glad to review
this if we have an actual user for this code, but it also needs to be
submitted at the same time.

That's how we have always worked, nothing new here :)

thanks,

greg k-h
