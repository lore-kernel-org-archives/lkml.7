Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84298C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412AD20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555457881;
	bh=caxYGvFDJ+aVQylqU0/Q7c/fD7AgHfzmgA4H1EBSoGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fAQBjHtyoIf97UvoC6gOphGhxg8s48Oina40FreKhYWuDCZx2RQvB47gZ56QsaJ+Y
	 W9VGFGJlg4b+yHqUUvnTsjXqv0XvgCd6lcKpNS05Y1RCTU8DMmYrknH8c3rL2JiZK3
	 5pGxF4Jja9VJs9BXP7O/uIV77WUdfuHJHPzb5w7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfDPXiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:38:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPXh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:37:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E2B5E2C;
        Tue, 16 Apr 2019 23:37:58 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:37:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binfmt_elf: Move brk out of mmap when doing direct
 loader exec
Message-Id: <20190416163757.b7bb6b42806e99ea11085794@linux-foundation.org>
In-Reply-To: <CAGXu5j+z7craEPiDYRjgYo4JBEum965JC_xSajv8TyPM09eaXQ@mail.gmail.com>
References: <20190416042320.GA36924@beast>
        <20190416160407.0e398a086507b811d7e95bbf@linux-foundation.org>
        <CAGXu5j+z7craEPiDYRjgYo4JBEum965JC_xSajv8TyPM09eaXQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 18:14:00 -0500 Kees Cook <keescook@chromium.org> wrote:

> On Tue, Apr 16, 2019 at 6:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > >
> > > Reported-by: Ali Saidi <alisaidi@amazon.com>
> > > Link: https://lkml.kernel.org/r/CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com
> > > Fixes: eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > No cc:stable?
> 
> Probably it should be, yes. I think I'm just shy about that when
> poking ELF mappings. :)

Well, the -stable bots will backport anything that might look slightly
like a fix anyway.

I'll add cc:stable and shall hold it out until 5.2-rc1, so it should
get a bit of a spin before being backported.
