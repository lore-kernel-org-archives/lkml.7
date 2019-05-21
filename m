Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02581C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4182173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558427866;
	bh=ussXCeZ6dv3DWmQB6c92Fh60bgzOuEGA2916Huk7U+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sgpqUgQHT/t+KQiZVkwwMUpFes+yTWeO7R8Q6e6EmXaHXlHeVxwA3NL9GK1/JYRH2
	 UiX0jVbkK5iAU437dVdibl+MsA0401Sh+6dhZZ++wjTo79XaZfuVhAZQoJamdDxKJ1
	 nowQiAakQks8Er/x+W7jq16kTeUvFgED8z8ihSng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEUIhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfEUIhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:37:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CE22173C;
        Tue, 21 May 2019 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558427864;
        bh=ussXCeZ6dv3DWmQB6c92Fh60bgzOuEGA2916Huk7U+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffqj7BJzMyEaqlwrbbPjsng9HWeqc2Vq5y3ibFT9cJOFB2Jp9uJMG9NI1CWTwOin3
         AYmj5NH2vpxmeTmMNDZ5oiBQQgKRaF95H0YaOsqpqBUYYfUesQdMkf8cNdhgOk2Yzg
         fghgsr3ZxRGnh3JRyLl7Rup3IBwJ5AsVDyjxRnoE=
Date:   Tue, 21 May 2019 10:37:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Updates to staging driver: kpc_i2c
Message-ID: <20190521083742.GA7644@kroah.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
 <20190520083026.GA13877@kroah.com>
 <CA+T6rvENoDXbUWEi4C5kXxsdamkZKVP19MwzEuxs0qC=ckMyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+T6rvENoDXbUWEi4C5kXxsdamkZKVP19MwzEuxs0qC=ckMyeQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:15:52AM +0000, Geordan Neukum wrote:
> On Mon, May 20, 2019 at 10:30:26AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, May 18, 2019 at 02:29:55AM +0000, Geordan Neukum wrote:
> > > Attached are an assortment of updates to the kpc_i2c driver in the
> > > staging subtree.
> >
> > All now queued up.  I'll rebase my patches that move this file on top of
> > yours, as kbuild found some problems with mine, and I'll resend them to
> > the list.
> >
> Thanks.
> 
> Additionally, I plan on trying to clean up that driver a bit more. Should I
> base my future patches off of the staging tree so that I'll have the
> "latest" driver as my basepoint? I don't want to cause any headaches
> for anyone in the future.

Yes, please do so.  Please work off of either the staging-next or even
better, staging-testing as that contains the latest patches.  I apply
patches to the -testing branch first, and if that passes the 0-day bot,
I then merge them to -next.

Given that there are a lot of people working on this codebase right now
(as it needs so much obvious work), I would recommend using -next and
getting used to rebasing your changes :)

I take patches as they are submitted, so sometimes people do step on
each other's toes, that's normal.  But I think you are the only one
touching the i2c driver at the moment so it shouldn't be that bad.

> Apologies, if I missed something obvious on the newbies wiki.
> Assuming that I did not, I will certainly go ahead and try to document
> this case either on or as a link from the "sending your first patch"
> page.

This is beyond the "first patch" work, this is now in the "being an
active developer" workflow :)

thanks,

greg k-h
