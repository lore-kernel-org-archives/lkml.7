Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633CCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 06:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2550F218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553929001;
	bh=ciVAwKW0UtcHusISo2tny1nh5kNuvPiHyLyzNGwEL1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G9rxxcRrsq8EqBOxaIr4Pvo/Np5hL1OPMcyUrbe1BFqZVVRJB3qfgpDPtOA3/NITA
	 dtnsbtM6Uxs2j9PMEhjdzJ5XQkzi+QBIv3J1HoC2DgGmnfBaeUqSQFNwluABw3HB2m
	 m5i7OMZfPA3MdtBc9mvSjGWewQhaHVY6L3Wylh3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfC3G4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 02:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfC3G4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 02:56:39 -0400
Received: from localhost (unknown [188.90.30.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A26218A6;
        Sat, 30 Mar 2019 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553928998;
        bh=ciVAwKW0UtcHusISo2tny1nh5kNuvPiHyLyzNGwEL1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2uiYpRYQYPgDJaXuonSE+q+nWceHx5TqJx5Br0/aUMi5RBTQLCz/beeOls/Zm9xf
         IjQJouEN5g0GVwMdNRmtqV5r4MfdNXVl6JsTdX0CDRIYyWxg9jb3Pyxx6UJ+HYXW85
         sRLsbav20Xx9Bv4YTOerYwmZaSthUgRj1QeuufFY=
Date:   Sat, 30 Mar 2019 07:56:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Message-ID: <20190330065634.GA4221@kroah.com>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
 <20190329160336.GB5906@kroah.com>
 <678F3D1BB717D949B966B68EAEB446ED24EBDE4F@DGGEMM506-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24EBDE4F@DGGEMM506-MBS.china.huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 02:32:35AM +0000, Zengtao (B) wrote:
> >-----Original Message-----
> >From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> >Sent: Saturday, March 30, 2019 12:04 AM
> >To: Zengtao (B) <prime.zeng@hisilicon.com>
> >Cc: labbott@redhat.com; sumit.semwal@linaro.org;
> >devel@driverdev.osuosl.org; Todd Kjos <tkjos@android.com>;
> >linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org;
> >linaro-mm-sig@lists.linaro.org; Arve Hjønnevåg <arve@android.com>;
> >Joel Fernandes <joel@joelfernandes.org>; Martijn Coenen
> ><maco@android.com>; Christian Brauner <christian@brauner.io>
> >Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
> >driver use
> >
> >On Sat, Mar 30, 2019 at 02:40:16AM +0800, Zeng Tao wrote:
> >> There are two reasons for this patch:
> >> 1. There are some potential requirements for ion_alloc in kernel
> >> space, some media drivers need to allocate media buffers from ion
> >> instead of buddy or dma framework, this is more convient and clean
> >> very for media drivers. And In that case, ion is the only media buffer
> >> provider, it's more easier to maintain.
> >
> >As this really is just DMA, what is wrong with the existing dma framework
> >that makes it hard to use?  You have seen all of the changes recently to it,
> >right?
> 
> The current dma framework is powerful enough(to me, and more complex ^_^)
> , CMA, IOMMU are all integrated, it's good. But buffer sharing, statistics, debug,
>  are not so friendly for media drivers(each driver has to do all, but duplicate jobs).

Then go add statistics and debugging to the dma code so that everyone
benefits!

thanks,

greg k-h
