Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39FD20651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011583;
	bh=kz4IhatFXf46gUFuUUXsCZznBc6ohCoNL4N8twIq4lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jzB5hR/8Zb7IyYC43NdrDXrDotDHqC96lpjvvlRnJIW3QUOLGfx40ecJjkabzE3fo
	 bRDbIzFembGPEPChnA+Lx/8TNMGf1vPSq4O3aMYdxm1udwxy36fXnYR51U+PFi305E
	 j7tPPD8eN0r/AyxebMxP39uFOrw5Q0YbRskgBWpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfHEN0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731395AbfHEN0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E8220651;
        Mon,  5 Aug 2019 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011575;
        bh=kz4IhatFXf46gUFuUUXsCZznBc6ohCoNL4N8twIq4lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZFBe8/AkcnYLk4tfbGogE+A4zQ0BR0UMJUVmfqchUwAsDiE6efqFyuP3Ir8Qg1ig
         gmJQojfPE/+PfpNaalnSGUO40Eb6vNrXCRcf6Av4J8cybgTrLUDoEmp+dimzgnfdis
         DZc2AIoV0oFKPdKPMxAGGwdcthYKIp+dUcpU0jG4=
Date:   Mon, 5 Aug 2019 15:06:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
Message-ID: <20190805130621.GA25026@kroah.com>
References: <Pine.LNX.4.44L0.1906061013490.1641-100000@iolanthe.rowland.org>
 <46147522-7BC2-4C30-B3E5-6568E9642982@canonical.com>
 <27A5C1CC-E0A4-4CAF-B81E-90EE76C8A887@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27A5C1CC-E0A4-4CAF-B81E-90EE76C8A887@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 08:58:33PM +0800, Kai-Heng Feng wrote:
> Hi Greg,
> 
> at 17:22, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> > at 22:17, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > 
> > > I agree with Kai-Heng, this seems like a fairly light-weight solution
> > > to a reasonable problem.
> > 
> > Thanks for your review.
> > 
> > > As to the issue of how much it will slow down system shutdowns, I have
> > > no idea.  Probably not very much, unless somebody has an unusually
> > > large number of USB devices plugged in, but only testing can give a
> > > real answer.
> > 
> > In addition to that, only USB2 devices that enable LPM will slow down
> > shutdown process.
> > Right now only internally connected USB2 devices enable LPM, so the
> > numbers are even lower.
> > 
> > > I suppose we could add an HCD flag for host controllers which require
> > > this workaround.  Either way, it's probably not a very big deal.
> > 
> > IMO this is not necessary. Only xHCI that reports hw_lpm_support will be
> > affected. At least for PC, this only became true after Whiskey Lake.
> > 
> > Kai-Heng
> > 
> > > Alan Stern
> 
> This patch is included in Ubuntu’s kernel for a while now, and there’s no
> regression report so far.
> Please consider merge this patch.

I do not see a patch here at all, sorry.  Please resend it.

greg k-h
