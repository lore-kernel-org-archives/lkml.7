Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D5EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C25D218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553930059;
	bh=m/bu1YNDeF39z3RkMwdY/oUvePXTHcgLZDbAoqVrNgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yGCD+OIF6Zxyb4RmI9XIOdHYhBOiB8ZPwqe77Z1YcVYFmww1KQ8ZyJbRJ42OvNiKQ
	 xRImYLMgeQLq94xqZ4RvltnRKg0U3ZAShNIjY5NrgGTjC3knGxPgajK1fYmLWYZz/b
	 Z6md72Ez5EHC59F/SwoFKbo7Sd8jO73sSGL3Mpog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfC3HOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfC3HOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:14:17 -0400
Received: from localhost (unknown [188.90.30.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4F82173C;
        Sat, 30 Mar 2019 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553930056;
        bh=m/bu1YNDeF39z3RkMwdY/oUvePXTHcgLZDbAoqVrNgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDPGFPdfvcQGePOdTQE7BB6g0feFIjbhSacsP5mhOjnwmzkcE3Z0GyCJccA9p2N9M
         JJwR6K6jzjBbY1O8wpT5ZNHnvMxTjTMohTZTW5Tp3SSNsi7QuZaTlWyek2zCjTfowj
         iFdqs8k7FY9zrNQaxCCOdd6Kle5jZNCW/1rmLCqY=
Date:   Sat, 30 Mar 2019 08:14:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: a kernel address leak via copy_to_user in drivers/tty/rocket.c
Message-ID: <20190330071413.GA5507@kroah.com>
References: <CABXRUiSUzuf+Ki1Pj9oUkgZC0ELkA4N1aZpwBrZ7Gu3nyGwPMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXRUiSUzuf+Ki1Pj9oUkgZC0ELkA4N1aZpwBrZ7Gu3nyGwPMQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 03:05:11PM +0800, Fuqian Huang wrote:
> Hi, recently I found that there is a kernel address leaks to user
> space via copy_to_user in
> drivers/tty/rocket.c:1287 (linux-5.0.5)
> static int rp_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned
> long arg) {
>   ...
>   case RCKP_GET_STRUCT:
>       if (copy_to_user(argp, info, sizeof(struct r_port))
>   ...
> }
> The `info` is a struct r_port. and the field `r_port.port.ops` is an
> constant pointer,
> and it points to a constant object `rocket_port_ops` during the initialization.
> (function init_r_port) (drivers/tty/rocket.c:633)
> 
> patch suggestion:
> set the pointer field to null before the copy to user call.

Great, can you send a patch to fix this so that you get the proper
credit for finding and resolving it?

thanks,

greg k-h
