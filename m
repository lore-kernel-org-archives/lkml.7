Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F49B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554399125;
	bh=CmKh2tR/pTIuWm8wOShEfPZThUFcRz7Ow+2kNUxjfW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kun4mRDcfY5/xb3Q9GWoLg+vGcLjIZW5XVc781XmWd0866K42neDyTTCFfpnW+Nzm
	 x/1jCkKTVf1Nok8ufHu03nc85JpsSe1D/i6XE41ngHDadsMQV+BSIQuFRn6uOCJKwV
	 Ecx+43Vhczd9SBMT7U9W5p+5MxuW12gJ04Uqh5Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDDRcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfDDRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:32:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCF02075E;
        Thu,  4 Apr 2019 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554399122;
        bh=CmKh2tR/pTIuWm8wOShEfPZThUFcRz7Ow+2kNUxjfW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zm5w50AWXSBAW3GwsOw+zXcaZ0B0DoPHEpntVb8HrN08SzxwGERIF+O5/lZ6OuaEW
         P/5sJUpyzADJHwEEYGxLeHrs2NGBF77mfVbJsFUWkOevhanRdDqIP0s/N0TumimC11
         vXRFMkveTB2bF4LzZajd7jFY+Q+gPotpdzRXamKY=
Date:   Thu, 4 Apr 2019 19:32:00 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Slavomir Kaslev <kaslevs@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 5.0 047/246] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Message-ID: <20190404173200.GB29613@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <20190404084620.671108728@linuxfoundation.org>
 <3fa8b886ccb1ea2229344091be9ac769021f69a4.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa8b886ccb1ea2229344091be9ac769021f69a4.camel@vmware.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 04:16:57PM +0000, Slavomir Kaslev wrote:
> On Thu, 2019-04-04 at 10:45 +0200, Greg Kroah-Hartman wrote:
> > 5.0-stable review patch.  If anyone has any objections, please let me
> > know.
> > 
> > ------------------
> > 
> > [ Upstream commit ee5e001196d1345b8fee25925ff5f1d67936081e ]
> > 
> > The current implementation of splice() and tee() ignores O_NONBLOCK
> > set
> > on pipe file descriptors and checks only the SPLICE_F_NONBLOCK flag
> > for
> > blocking on pipe arguments.  This is inconsistent since splice()-ing
> > from/to non-pipe file descriptors does take O_NONBLOCK into
> > consideration.
> > 
> > Fix this by promoting O_NONBLOCK, when set on a pipe, to
> > SPLICE_F_NONBLOCK.
> 
> [...]
> 
> > This change does have potential of breaking users who don't expect
> > EAGAIN from splice() when SPLICE_F_NONBLOCK is not set.  OTOH
> > programs
> > that set O_NONBLOCK and don't anticipate EAGAIN are arguably
> > buggy[2].
> 
> Hi Greg,
> 
> Can you drop this one from the stable queues? We discussed it with
> Sasha[1] already in the autosel patches thread.
> 
> [1] https://lkml.org/lkml/2019/4/3/811

Dropped from everywhere now.

Sasha, how did this still get in?

greg k-h
