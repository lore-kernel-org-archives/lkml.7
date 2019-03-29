Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8354C2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553840578;
	bh=D0KU/sXPxyVv7cqZc0Tm6kWLxD0vLmr3WjqiBXDU7aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vJpEfmYjoK5j7Y8Iw94CXbnQIYoiFCY7hT5tysbVjxNmoLZ2y4XexsRffQBxJreaf
	 9XmpKatyhj2lzxBvv0PbQLTPHWwj6cr/mA1qjybTiT9JimQ+wjkIUDsGzLKXPXrJFd
	 pSXOZTCYkgLDGR4ImO0JicNI9oKY7lyVYvhsIM3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfC2GW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfC2GW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:22:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B05A2173C;
        Fri, 29 Mar 2019 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553840576;
        bh=D0KU/sXPxyVv7cqZc0Tm6kWLxD0vLmr3WjqiBXDU7aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cG3hE2qSC+Euh8MCiejcujkth4cWSCfhNpDfPrRlRCK5j2iYtY/cYzUZ0FAc6wUfL
         0IW3Zu5lcX7qzvynSfIbb5hNq+vOisHi9dbywiZ6GrEMvcEEmKcYmuMizaBDBzw7vG
         9rqfSw0b60NfMZliLtrs1jR7w1uvC01m8CDvMLeI=
Date:   Fri, 29 Mar 2019 07:22:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329062253.GA9659@kroah.com>
References: <20190329040922.34ab01c6@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329040922.34ab01c6@nic.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 04:09:22AM +0100, Marek Behun wrote:
> Hello Tejun and Greg,
> 
> kernfs_fop_open/read/write allocates a buffer for the ->read, ->write,
> or ->seq_read methods. This buffer is either preallocated or allocated
> on the spot, with minimum size being PAGE_SIZE, if ->atomic_write_len
> is not given.
> 
> There is a question/problem currently in the led-trigger API, that the
> PAGE_SIZE buffer can in some specific scenarios be too short.

And that file is in sysfs?  That's a huge abuse of the sysfs api then :(

> (The trigger file on read returns space separated list of all supported
> triggers, and the currently chosen one is marked specially. The cpu
> activity trigger lists "cpu%i" for all CPU cores, which actually broke
> on some machines with very large number of CPUs. Granted, this could
> have been solved another way (and maybe will be), but we are now
> discussing API for HW LED triggers, which can raise the problem anyway,
> if a specific LED controller supports too many HW LED triggers.)
> 
> Is it allowed to grow this buffer if needed, either via krealloc or by
> creating a special function in kernfs API which does this so that
> led-trigger could use it?
> 
> Or is this completely forbidden?

If this is just for kernfs, and you have your own filesystem, sure, we
can probably do something here.  But if this is for sysfs, no, you all
need to keep to the "one value per file" rule that we have there please.

thanks,

greg k-h
