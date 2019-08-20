Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B7FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D57622DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566339852;
	bh=J9CrK8ZytANsjGaR9BdiG8QF2BQrW8dFiffDLYKvvvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jgw5/jGkuxWBphPWWG6B1FEJcdOr2wi1Y2QlH7UsTNN9tmzxMSm2hp/FWsdTj3QC7
	 ksH8aHuenUMVpVGHtZnnaqn3g5PSPepwRxOVVwZEvvKirN1p2orFHTU7R3vT4o6BEM
	 yOXoKqPcR2oroDRurtEsjBwKlX7olpAvSlE+hsMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfHTWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbfHTWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:24:11 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E20722DA7;
        Tue, 20 Aug 2019 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566339849;
        bh=J9CrK8ZytANsjGaR9BdiG8QF2BQrW8dFiffDLYKvvvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EO72LYH1Q0yW5mkiyEkzn33YnZez41BrJC5CisF/wx5DhVD6MN1DGXgBQrPQ4yKSd
         QoOZAvqvYRN5LDhv3djYxQHtQNtQkvON9897taZkw8m8eQjTIYttuWQUD2tAvWxaRN
         cWrTCUwm/idgBa/AAKk0BzA9xtXzZskZgi7qyetw=
Date:   Tue, 20 Aug 2019 15:24:03 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190820222403.GB8120@kroah.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 07:06:51AM +0900, Tetsuo Handa wrote:
> syzbot found that a thread can stall for minutes inside read_mem()
> after that thread was killed by SIGKILL [1]. Reading 2GB at one read()
> is legal, but delaying termination of killed thread for minutes is bad.
> 
>   [ 1335.912419][T20577] read_mem: sz=4096 count=2134565632
>   [ 1335.943194][T20577] read_mem: sz=4096 count=2134561536
>   [ 1335.978280][T20577] read_mem: sz=4096 count=2134557440
>   [ 1336.011147][T20577] read_mem: sz=4096 count=2134553344
>   [ 1336.041897][T20577] read_mem: sz=4096 count=2134549248
> 
> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
> ---
>  drivers/char/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index b08dc50..0f7d4c4 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -135,7 +135,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>  	if (!bounce)
>  		return -ENOMEM;
>  
> -	while (count > 0) {
> +	while (count > 0 && !fatal_signal_pending(current)) {
>  		unsigned long remaining;
>  		int allowed, probe;
>  
> -- 
> 1.8.3.1
> 

Oh, nice!  This shouldn't break anything that is assuming that the read
will complete before a signal is delivered, right?

I know userspace handling of "short" reads is almost always not there...

thanks,

greg k-h
