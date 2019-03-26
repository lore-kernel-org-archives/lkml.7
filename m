Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65152080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553561723;
	bh=YHd0EllFEA3WjOjR4Io1FeKzCEZ/Yp9iijFAELuKM4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TpF1mNLX+NKD/fuhBpSMSIV/ob8RDAqJ4uEbtkxiEgRpcEk/NhKJz3gdBgKku/oHo
	 s7AF2VMFHemGL4Yr2PuHOnnk20Ow322EJd3m0FAC0l0ikUfrlSqSuV2k2i6Huv1Otu
	 Q7Kx88F44vv2be3IV36y7dRIQbU676DLHkkEcQlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZAzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZAzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:55:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB4E2075D;
        Tue, 26 Mar 2019 00:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553561721;
        bh=YHd0EllFEA3WjOjR4Io1FeKzCEZ/Yp9iijFAELuKM4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybpkX2jBwDrR8PKRCzP+LHXdm0IYMrsZHqdRs6FYH/bmc1lZF1cZLN2IIwnU8p2Ac
         Em2nNXA368LnwMh0I424Gvo/Van+2FIZBDUGsHTq0tgQAuf1OPn8XPzyOhb92yeT3z
         FoZ92ahSLa+LG4hID8XX76hztf3vZ1bgeWW39wLU=
Date:   Tue, 26 Mar 2019 09:55:09 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     shuah <shuah@kernel.org>, David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel
 versions
Message-ID: <20190326005509.GA32180@kroah.com>
References: <20190306214730.6545-1-valleau@chromium.org>
 <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
 <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
 <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
 <20190326001353.GA4315@kroah.com>
 <CA+ASDXMR_HPSnAWRGYV_fDq6kSR7WdgTq3pgW9VaTwA7fA7=qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXMR_HPSnAWRGYV_fDq6kSR7WdgTq3pgW9VaTwA7fA7=qA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:49:07PM -0700, Brian Norris wrote:
> > Not to say that this shouldn't be fixed if at all possible, but realize
> > that this is not the "normal" case of "we do not break userspace" here,
> > given the tool involved, and the apis being used.
> 
> I think I sort of understand what you're going for here, but can you
> elaborate so I don't have to assume?

To be specific, tools at the "very low level" that are used to configure
the kernel for userspace, or to interact with the kernel such that other
programs work on top of things properly (like udev), we have broken apis
such that we can fix issues with old mistakes and move on to more secure
or "correct" apis.

So we do change things at this layer at times, and normally no one
notices as they have moved on to newer userspace programs in the past 3
years.  Sometimes we do keep kernel support for really old userspace
systems, until they die out, and then we can finally drop the kernel
code.  Again, udev has done this over the years as we worked to figure
out a sane way to handle stuff.  We have rolled back kernel changes
until people finally killed their old Fedora 3 ppc32 systems for
example :)

To be honest, with the USB3 support added to usbip, no one noticed that
things broke, and the fact that it took 4 years to notice implies that
maybe it wasn't that big of a deal as no one used this.  But, as you
show, that assumption was not correct, so if we can fix things, we
should.

Did that help?

thanks,

greg k-h
