Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8395C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A426199
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559250069;
	bh=4CRc+10jq8qVPENaL49ZOmvgX81EDViorvcPAmtMOjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=khLJmmjvgrxzCVKMRa2/pl4hRZ8jfXHIvMkSaUnjncqufkKy4NZ+3maKM0GI0SxsM
	 5CpIBdydsPoPgM87Uoyv3LV+trA1gNoGc6EVaQ8kMMp95hF2l/RuR60UWI+C6xp3QJ
	 vR85vtDkeI6fYFF/tr+u/rS3ZolnjnU50x8LwTFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfE3VBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3VBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:01:08 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB6626199;
        Thu, 30 May 2019 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250068;
        bh=4CRc+10jq8qVPENaL49ZOmvgX81EDViorvcPAmtMOjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/sUjc8zxp9YfKOK2M+DyaZoC/i20s+3t+8JQaqfF/eqgCUHOQrx0QIfCvYN5OZnF
         NzFHe4FWOFwcZD2d0QOZbzerUScV8E298nZ5z33SGX6dh5Gm0IP9uwWykdiZ1tx07H
         LAB49dMS7fdpmZ6UrVFiAfmtV/QOkF8bWZoJHNMw=
Date:   Thu, 30 May 2019 14:01:07 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: add missing dependencies for
 kpc2000
Message-ID: <20190530210107.GA22336@kroah.com>
References: <20190524203058.30022-1-simon@nikanor.nu>
 <20190524203058.30022-3-simon@nikanor.nu>
 <20190525050017.GA18684@kroah.com>
 <20190525083918.dxa5qtomlu5yyqw5@dev.nikanor.nu>
 <20190525092404.go3qlfknra6g3fot@dev.nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525092404.go3qlfknra6g3fot@dev.nikanor.nu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 11:24:04AM +0200, Simon Sandström wrote:
> On Sat, May 25, 2019 at 10:39:18AM +0200, Simon Sandström wrote:
> > On Sat, May 25, 2019 at 07:00:17AM +0200, Greg KH wrote:
> > > 
> > > This is already in linux-next (in a different form), are you sure you
> > > are working against the latest kernel tree?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > It's based on your staging tree. I think that I have to go back and read
> > about next trees again, because I thought it took longer time for things
> > to get from staging-next to linux-next.
> > 
> > Anyway, neither the MFD_CORE nor the typo fix is in linux-next so I
> > guess that I could just rebase this on linux-next and re-send as v2.
> > I'm not sure if MFD_CORE should be "depends on" or "select" though...
> > 
> > 
> > - Simon
> 
> Oh, it must be "select MFD_CORE" because there is no prompt for
> MFD_CORE? Should I just rebase it on linux-next and re-send as v2 then?

Yes please.
