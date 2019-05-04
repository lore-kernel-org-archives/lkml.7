Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C3AC04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 07:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E05620859
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556954316;
	bh=KjtIdOqgGdJRkpK539kaYm/XfWHQJNxowDI71iFyh04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uc8pNcpFQDOns1/fdx6KqbxTrS3oDNqB+uLG53+SPDnOUpbvhCop26hHEtDNjDPdx
	 Z3uqEVcEwlQlMEn20nRmOvKyO00iYzdvQPEvJEaMkLr7lwd/3rSxOiHhR37lYhEOwX
	 RVxwXCMy3rpIVQXzD7qMRUacQ8WlaX4aH8mhsOMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEDHSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 03:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfEDHSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 03:18:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E005A206DF;
        Sat,  4 May 2019 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556954314;
        bh=KjtIdOqgGdJRkpK539kaYm/XfWHQJNxowDI71iFyh04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zynfTzrERwQ2d+YOgHuXK5YKpGnpkRJru55Yn+3GTl2D/ipka7IFpkKSozOSkew4I
         cu8ugxESTz/4SdQ8/Wl6ibUzvnVvV2sCNDG4bscjKFTW4M+4T2bM/MRFEP5W9aUSiT
         /57JgIM85amImI98v4NO5PC3cyImuet3LvShR6wM=
Date:   Sat, 4 May 2019 09:18:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/72] 4.19.39-stable review
Message-ID: <20190504071831.GA12815@kroah.com>
References: <20190502143333.437607839@linuxfoundation.org>
 <20190504065447.GA16530@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504065447.GA16530@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 08:54:47AM +0200, Pavel Machek wrote:
> On Thu 2019-05-02 17:20:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.39 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 04 May 2019 02:32:17 PM UTC.
> > Anything received after that time might be too late.
> 
> These do not meet stable criteria afaict: (3-5... I see this is
> probably security bug; it would be good to mention in the preparation
> patches what is going on because otherwise it is tricky to understand).

I do not do "explain why specific patches are applied" because yes,
sometimes it is due to security issues that we know about.

> ?? 03/72] mm: make page ref count overflow check tighter and m -- not sure description is good enough; preparation for later changes?
> ?? 04/72] mm: add try_get_page() helper function -- adds unused function
> ?? 05/72] mm: prevent get_user_pages() from overflowing page r -- over
>   100 line limit and depedns on previous patches. get_gate_page() change
>   not in -rc?.. it is in -next.

These are all well-known as solving a public security issue, please see
lkml for the details, no need for you to "guess".

thanks for the review.

greg k-h
