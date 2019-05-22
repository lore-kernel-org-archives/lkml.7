Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A16C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4EA2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558550173;
	bh=643w0e1RwXyPDz2yZkL2WWaU1kzeYkYsjBXV9gFNFsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uL190kHFgYQy6wU0RCkwVaf/9Qjf3ncvU7nerxucJxxXQglGajJv7xrfWDzNvu05Q
	 gmuZIUiwY9gNfnNLy92mUCpnaLGtJo3lRfHkLWpC0tpHRYlSHwlvGewZTUZE8vHPLw
	 /7Wct2EcuLUeBFX0NJy43FuZJSlz3nSsCXO69KR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfEVSgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfEVSgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:36:12 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65ADE21473;
        Wed, 22 May 2019 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558550171;
        bh=643w0e1RwXyPDz2yZkL2WWaU1kzeYkYsjBXV9gFNFsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wGAaee798ILL90HhT88AZgysvLeH4EcomUxmt5iB1XdPXL2FocEbRluGwflT7Qc92
         pw7NVvgY6UyvOaHgVZzydkvQ5sxFUppGwvwRfWqStn8WdWEYLfrMOyKZCJIm3ZefUI
         ialtzgtuEU0eh5yXJkbk6VCH/nGc2AVcUciFEf+8=
Date:   Wed, 22 May 2019 11:36:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Azat Khuzhin <azat@libevent.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
Message-Id: <20190522113610.51d13f168d70f19a950540b4@linux-foundation.org>
In-Reply-To: <CAK8P3a3GWVNraxowtPmdZnF3moJ8=zkkD6F_1-885614HiVP3g@mail.gmail.com>
References: <20190516085810.31077-1-rpenyaev@suse.de>
        <20190516085810.31077-14-rpenyaev@suse.de>
        <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
        <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
        <20190521193312.42a3fdda1774b1922730e459@linux-foundation.org>
        <CAK8P3a3GWVNraxowtPmdZnF3moJ8=zkkD6F_1-885614HiVP3g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 13:14:41 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> > I thought the preferred approach was to wire up the architectures on
> > which the submitter has tested the syscall, then allow the arch
> > maintainers to enable the syscall independently?
> 
> I'm hoping to change that practice now, as it has not worked well
> in the past:
> 
> - half the architectures now use asm-generic/unistd.h, so they are
>   already wired up at the same time, regardless of testing
> - in the other half, not adding them at the same time actually
>   made it harder to test, as it was significantly harder to figure
>   out how to build a modified kernel for a given architecture
>   than to run the test case
> - Not having all architectures add a new call at the same time caused
>   the architectures to get out of sync when some got added and others
>   did not. Now that we use the same numbers across all architectures,
>   that would be even more confusing.
>
> My plan for the long run is to only have one file to which new
> system calls get added in the future.

Fair enough.  We're adding code to architectures without having tested
it on those architectures but we do that all the time anyway - I guess
there's not a lot of point in special-casing new syscalls.

