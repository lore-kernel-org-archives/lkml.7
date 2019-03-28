Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5155CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F8C20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798752;
	bh=1DOi8E4Cemowy8bsUMqhZziiN9iNc53NlzLS1uuKogU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CugNBpk4QmJq8aws3LX8PCIxATquMmjVmTNfhEXB0j82myjSdhVzLBawd80p7+olY
	 Ae5oiZfyJUhFVPeG0+7vcjjGqsxqNoJhYdaX/7XoIaouqiJJy5oNdu/oBtUa3u7EiE
	 xN75mXtRXORlubh4KDPXrq5cB8/QFZIGM6Z51Xcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfC1Spu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfC1Spu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:45:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC5B2064A;
        Thu, 28 Mar 2019 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553798749;
        bh=1DOi8E4Cemowy8bsUMqhZziiN9iNc53NlzLS1uuKogU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzp78eU2P2gd8+qA8qREVywfS2ESNlXqEt8aCeb5li6CArj9Rp+zBv6ay0I57nWfX
         gtJ/mPvJMfF9k45WCwTILY46eVFm0tF2uAF7vJFlhmyWCMd4LUUrP91jpSS885lU9t
         z2qQM5eud86yGQKBC5CEwk19aZiCHRO+HSeW74+g=
Date:   Thu, 28 Mar 2019 19:45:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
Message-ID: <20190328184546.GB23800@kroah.com>
References: <20190315101013.GN8455@Legion-PC.fortress>
 <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress>
 <20190327154025.GB23293@linux-8ccs>
 <CAKi4VA+14kihzGFbMT623BwMbZEzgYU6+jz8MpR9jqoC059oog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKi4VA+14kihzGFbMT623BwMbZEzgYU6+jz8MpR9jqoC059oog@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:41:59AM -0700, Lucas De Marchi wrote:
> On Wed, Mar 27, 2019 at 8:40 AM Jessica Yu <jeyu@kernel.org> wrote:
> > >No. There are definitely not all modules. I have a builtin sha256_generic,
> > >but I can't find him in the /sys/module.
> >
> > Yeah, you'll only find builtin modules under /sys/module/ if it has any module
> > parameters, otherwise you won't find it there. As Masahiro already mentioned,
> > if a builtin module has any parameters, they would be accessible under /sys/module/.
> 
> Could we please change that and add the sysfs entry regardless of
> what's being discussed here? Not having the entry there simply because
> we don't have parameters for that module always annoyed me.

What is the sysfs directory going to show?  Will it just be empty?

Feel free to send a patch for this, but from what I remember, it wasn't
the easiest thing to do for some reason.  But given that the code was
implemented before git was, I can't quite remember.

thanks,

greg k-h
