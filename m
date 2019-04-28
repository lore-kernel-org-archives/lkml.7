Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19B8C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F88206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556468218;
	bh=sGQ4cfaVyAutA9bYiZxUbi9yKJLznXhW2JXn5dfAgs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EODeO0zICAoOgeJWsc/HGpdOdDDJTDgIlTCoY09SDAWalPhQ/83mn7pT4KnBZ3y6Q
	 63obCbEc4e51GOxOcaaWLaeMCdmOhrJRCN5KgQphOiKqL7VvvPevXpaulgorc3Pbf3
	 we4P4Go2yjUP0Yr1zz2uNYoCVEw97FIkxXy5qTAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfD1QQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 12:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfD1QQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 12:16:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FAE6206BB;
        Sun, 28 Apr 2019 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556468216;
        bh=sGQ4cfaVyAutA9bYiZxUbi9yKJLznXhW2JXn5dfAgs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sw46gzo3/06cnJ5D3qBg8+6axG6lI8IxnrOnJ0LjqMjFqF2zihD1rSv2D+QnIyd+G
         wVIjncEyzIdoQ4vm+7ILs1Vav1pIoCENBdZ5V0xZgBbBwnusbqlf9SEXjYl41Du+Ry
         YNQSpALTNs/r8vM52Y5UQ1d9y0jKvTL5A7yRRP5E=
Date:   Sun, 28 Apr 2019 18:16:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Improve docs for kobject_add/del
Message-ID: <20190428161654.GA14579@kroah.com>
References: <20190428004810.11376-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428004810.11376-1-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:48:10AM +1000, Tobin C. Harding wrote:
> There is currently some confusion on how to wind back
> kobject_init_and_add() during the error paths in code that uses this
> function.
> 
> Add documentation to kobject_add() and kobject_del() to help clarify the
> usage.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> The assumption is that this is the correct usage, and that's what I've
> tried to document.  Is this correct?
> 
> void fn(void)
> {
> 	int ret;
> 
> 	ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
> 	if (ret) {
> 		kobject_put(kobj);
> 		return -1;

Don't make up error numbers, use a real one :)

> 	}
> 
> 	ret = some_init_fn();
> 	if (ret)
> 		goto err;
> 
> 	ret = some_other_init_fn();
> 	if (ret)
> 		goto other_err;
> 
> 	kobject_uevent(kobj, KOBJ_ADD);
> 	return 0;
> 
> other_err:
> 	other_clean_up_fn();
> err:
> 	kobject_del(kobj);
> 	return ret;
> }

Yes, this looks correct.

I've queued both of these patches up now, thanks!

greg k-h
