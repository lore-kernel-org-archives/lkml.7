Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D053C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF7B2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566913563;
	bh=307JSPdR4XjDhGEKX+iQOa/+57opZHEvbdDEfTYLKt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lH5e3cjixfnuZjIsQ5NNnVujBeHx3zV+vCjl6sK1JQ1hOCQuPyt4eLIGl1ry9wcC2
	 UlpWyvP3kKJos5ZFIF+weP38RPWsmVfcuUZUtLK5rOpIknkx3s5uQbcW8NrhffQ7Z9
	 aue6aguDIiLIa4MSr16cW8q3Vy3VrRtiStTS/ITw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfH0NqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfH0NqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:46:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0172070B;
        Tue, 27 Aug 2019 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566913561;
        bh=307JSPdR4XjDhGEKX+iQOa/+57opZHEvbdDEfTYLKt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0KKSZwBaJHvzJYQm3Y9mvqLwtlhAU8bAfl0DJ5MR64xYBdFWqonshX/LgfvxSKgs
         KMxJLf8OFoCLZOUg045PE1Vv2GVjO1HMHQgotlgQbydEEk5URXiWtMM/RisLmbMj/y
         8VNj1H1zKsbgLZBQoEKG/6SwUJMNHjaZt0IXpSP4=
Date:   Tue, 27 Aug 2019 15:45:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
Message-ID: <20190827134557.GA25038@kroah.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190827133611.GE23584@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827133611.GE23584@kadam>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:36:11PM +0300, Dan Carpenter wrote:
> I can't compile greybus so it's hard to run Smatch on it...  I have a
> Smatch thing which ignores missing includes and just tries its best.
> It mostly generates garbage output but a couple of these look like
> potential issues:

Why can't you compile the code?

> drivers/staging/greybus/operation.c:379 gb_operation_message_alloc() warn: check 'message_size' for integer overflows 'kzalloc()'

That should be checked on line 368, right?

> drivers/staging/greybus/light.c:1256 gb_lights_request_handler() warn: 'light->channels' double freed
> drivers/staging/greybus/light.c:1256 gb_lights_request_handler() warn: 'light->name' double freed

I don't understand this warning, how are these potentially double freed?

And the light.c file isn't moving out of drivers/staging/ just yet :)

thanks,

greg k-h
