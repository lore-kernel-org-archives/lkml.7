Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6EEC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EA4206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560152984;
	bh=BD+0ieygl7Dt+ioJC2i2VJt6GPWW8QpVf0zDmvxzPw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2o0x9V4A9EIDuZG6Ikynkh6Fmmc/rL4z//Hj1qw4S9BB2lzYSVsMtwizs3b66K9Ii
	 LC8tavBGmNkg1xFqnMSjH0tIlU7HisgWyCdJckK4enfZ5NttWLRIiTVnXVIaKBWxF4
	 mp8bjkp9Z8lOzRWtc5e9Kz84H0r5Sq8W6awZ4+fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfFJHtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387946AbfFJHtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:49:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42361206E0;
        Mon, 10 Jun 2019 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560152982;
        bh=BD+0ieygl7Dt+ioJC2i2VJt6GPWW8QpVf0zDmvxzPw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0OBEVWbF1ysyI8eF9GyUKMGqYz3lTWXFCYwkFPemNe38pMEWt0fuyPCIoDQDK5VM
         3gomGzKjAsH1zSOzskxufFtpiBD5Gydeu2nYWmgs20Sn8dxbs5g9Cvo/O/Dy1QhvKp
         7gO06z241ci1zQDBt1Onx8uoxtKXaYYQX3j+2u1s=
Date:   Mon, 10 Jun 2019 09:49:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] staging: kpc2000: use __func__ in debug messages in
 core.c
Message-ID: <20190610074940.GC24746@kroah.com>
References: <20190603222916.20698-1-simon@nikanor.nu>
 <20190603222916.20698-5-simon@nikanor.nu>
 <20190606125550.GA11929@kroah.com>
 <20190610072009.w5scsjb2aqcxm2l2@dev.nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190610072009.w5scsjb2aqcxm2l2@dev.nikanor.nu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 09:20:09AM +0200, Simon Sandström wrote:
> On 06/06, Greg KH wrote:
> > On Tue, Jun 04, 2019 at 12:29:13AM +0200, Simon Sandström wrote:
> > >  
> > > -	dev_dbg(&pdev->dev, "kp2000_pcie_probe(pdev = [%p], id = [%p])\n",
> > > -		pdev, id);
> > > +	dev_dbg(&pdev->dev, "%s(pdev = [%p], id = [%p])\n",
> > > +		__func__, pdev, id);
> > 
> > debugging lines that say "called this function!" can all be removed, as
> > we have ftrace in the kernel tree, we can use that instead.  I'll take
> > this, but feel free to clean them up as follow-on patches.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Can they be removed even if they print function arguments or other
> variables?

Of course!
