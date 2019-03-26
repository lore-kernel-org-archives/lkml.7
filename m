Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9CB2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553560507;
	bh=Ik6pN7fErD8VDFwrY6fD1Eh44qIUCNBjeT1GwChEzyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DaiI8ueCxvuNiRfhC71eYuDxePseoDsVeF4pL68xdydH5idQE7O0ZH24waYxzvxoO
	 OXchZJa+zT0ezqhGI/NBotrkjXokPQqFhZfNBZpes6qznd5wfgGicMZG26TVnCINda
	 zIe/g1Bw+88onfls1lOuI8GNA+NZ7F/L2CDjcbhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCZAfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfCZAfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:35:01 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B63F206DF;
        Tue, 26 Mar 2019 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553560501;
        bh=Ik6pN7fErD8VDFwrY6fD1Eh44qIUCNBjeT1GwChEzyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UV22yiTDG/MpmTyvq5Ozo6lpc4xi3hx7Tp6VO8vB+U5QvlyFMOEE9b+M75axkguNn
         VwGLDVWbU/DFwFGmwQJ7HSLx/geEZKin0Kp0MNgN3U6yjK7mi8HGdHp3uGrBfS2P00
         R9zNaLT3iDnRHTzWXfTbLGpHaHNVnrCeDDb6vwwQ=
Date:   Tue, 26 Mar 2019 09:13:53 +0900
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
Message-ID: <20190326001353.GA4315@kroah.com>
References: <20190306214730.6545-1-valleau@chromium.org>
 <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
 <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
 <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:02:30PM -0700, Brian Norris wrote:
> On Mon, Mar 25, 2019 at 3:07 PM shuah <shuah@kernel.org> wrote:
> > On 3/25/19 11:56 AM, Brian Norris wrote:
> > > On Mon, Mar 25, 2019 at 8:51 AM shuah <shuah@kernel.org> wrote:
> > >> In general the ABI is stable.
> > >
> > > No, it really isn't. This commit was a breaking change:
> ...
> > > But this one is definitely a break:
> > >
> > > commit 1c9de5bf428612458427943b724bea51abde520a
> > > Author: Yuyang Du <yuyang.du@intel.com>
> > > Date: Thu Jun 8 13:04:10 2017 +0800
> > >
> > >    usbip: vhci-hcd: Add USB3 SuperSpeed support
> > >
> > > You can't just arbitrarily add columns to the beginning of a file like
> > > that and claim that you're not breaking ABI. And I shouldn't need to
> > > remind you that Thou Shalt Not Break User Space.
> >
> > USB 3.0 driver and tool support went in, I would say it was oversight to
> > not make sure the tool continues to work on older kernels.
> 
> While that's true, you're still not grokking my main point when asking
> about ABI stability:
> 
>   *old* tools should still work on *new* kernels

For some defintion of "old" and "new" :)

We do break lower-level apis like this at times, for when it makes
sense, and for when the "old" kernel is just too old (and when you can
just run the tool that came with that kernel).

3.18 was released at the end of 2014, and as the tool that came with
that kernel still works just fine, you are just pushing the boundry here
really hard :)

Why do you want to update your userspace tool and not update your
kernel?  What is forcing your userspace tool to be updated?

Not to say that this shouldn't be fixed if at all possible, but realize
that this is not the "normal" case of "we do not break userspace" here,
given the tool involved, and the apis being used.

thanks,

greg k-h
