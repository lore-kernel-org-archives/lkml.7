Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E02C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B5C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521854;
	bh=jmhYJRlG0dVhezOLycSJD8VQfUhuInPDwJOoYXGVzn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KHNMhNHwlcZflpFyL/okazskhvdbz7HVThud/4AllCELNZNaedvSD1O0feXnnxluu
	 pXz6T/tUXvQib9RDRB5cKFfJwzTvF7LJ8+ymm8L1b26i5/EvjUEj2r5GeFQ42bohSb
	 d6FVLrMY55yfj/LhUoMC7VT+eu9HLW1YM7zkaFRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfLPSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:44:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbfLPSoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:44:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429272082E;
        Mon, 16 Dec 2019 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576521849;
        bh=jmhYJRlG0dVhezOLycSJD8VQfUhuInPDwJOoYXGVzn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hlx3mIjQGjt/OM4U7YMpfQ/IBw4KdIAfd+p2dTIKm2/6sctwRcfNd9YFrZN9KDxkP
         0lT+zBT6UMB2V8HIUv+sli0MMjHKCygNskJ2J2yJ0WB55IPaxTHIjW1jrzIyaPFn7e
         MHzhAzvadS2tH0MHir97WjYxTlCdGrqF2oPC0vvI=
Date:   Mon, 16 Dec 2019 19:44:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 139/140] mm/memory.c: fix a huge pud insertion race
 during faulting
Message-ID: <20191216184407.GA2411653@kroah.com>
References: <20191216174747.111154704@linuxfoundation.org>
 <20191216174829.761116794@linuxfoundation.org>
 <MN2PR05MB6141D3283B5D4365CBA0A497A1510@MN2PR05MB6141.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR05MB6141D3283B5D4365CBA0A497A1510@MN2PR05MB6141.namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:36:57PM +0000, Thomas Hellstrom wrote:
> Greg, Sasha
> 
> On 12/16/19 7:07 PM, Greg Kroah-Hartman wrote:
> > From: Thomas Hellstrom <thellstrom@vmware.com>
> >
> > [ Upstream commit 625110b5e9dae9074d8a7e67dd07f821a053eed7 ]
> >
> 
> Just repeating to make sure it's dropped, since it re-appeared again.
> 
> Could we please drop this patch from -stable for now. I'll re-nominate
> for stable with the correct dependencies when it's seen some more
> testing. It's depending on another patch and it's touching a code path
> we definitely don't want to break with unforeseen corner-cases.

Ugh, somehow Sasha added this one back in :(

I'll go drop it again, thanks for noticing and letting me know.

greg k-h
