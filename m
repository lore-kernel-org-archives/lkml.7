Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF5FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3332146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552510192;
	bh=S6KKviiepQbPbMVswyJ4wpfTv4BiN3C/YKQ1VlddYjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EkbZgg0v9n38G6wbkuy+P2T8b0vgy6Tr3kCZGIoBi0w/xNaD8Ixmvrej/pSsrp/j5
	 Hz3VPnu+rdp+ndN+Lu3tBeHj7y0vOCAxXsosvddJc4QC1YIsrYhC5dF/VcCqw1z2Oi
	 tk80nrHV9ucCkNImhze9PU6PxYd5TTW+XVSPbpEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCMUtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMUtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:49:50 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CC62077B;
        Wed, 13 Mar 2019 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552510190;
        bh=S6KKviiepQbPbMVswyJ4wpfTv4BiN3C/YKQ1VlddYjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgBq523U3VIf1phHFZMF9uSKZj0rxgiLVbo/ynv/iTUXwNeIwQiL/+vlRcUXXwWL1
         69EFEPJgMbcSqUjecnckTtLdO1XuZDiwEVjYYebKjv7Lr2g0lI9g0shxSDU5/x0PYX
         0rXClwwYyM+uC7b2MZw1gYb0dH8cx4sLIcl98m/g=
Date:   Wed, 13 Mar 2019 13:49:49 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
Message-ID: <20190313204949.GA1088@kroah.com>
References: <20190312171034.530434962@linuxfoundation.org>
 <20190313203441.GA26634@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313203441.GA26634@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:34:41PM -0700, Guenter Roeck wrote:
> On Tue, Mar 12, 2019 at 10:09:18AM -0700, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.163 release.
> > There are 96 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 172 pass: 170 fail: 2
> Failed builds: 
> 	i386:tools/perf 
> 	x86_64:tools/perf 
> Qemu test results:
> 	total: 316 pass: 316 fail: 0
> 
> Culprit is commit 386ca5754fad ("perf trace: Support multiple "vfs_getname"
> probes"), which introduces a call to strstarts() but not the necessary
> include file or declaration. Unfortunately, fixing that is quite complex
> (commit 8e99b6d4533c ("tools include: Adopt strstarts() from the kernel")
> doesn't apply).

Thanks for tracking this down, I'm lost in a maze of gcc8 issues with
perf on 4.9 and 4.4 at the moment trying to fix that.

I'll go drop this patch from the 4.9 and 4.4 queues.

thanks,

greg k-h
