Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72FCC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588612492B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GvpSLRjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE3QWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:22:39 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45818 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfE3QWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3kgTdo02E09r0Og/xJIfjwXUfONzBeGtXYyX4dAdahU=; b=GvpSLRjWIZcMSQnSrU6NlCPkd
        4GgdrNg1JUKpxUmF0KRYP+9AIO6S0jfabyoLT/MO4nUiaJaxhoDocAjahPovhRCK783KHto5H+I3L
        YeRWs3S0B1UnWxn7SZ9OvQaOOkcOA049rMEVHFOQOFZXehZ8zf+JvQfeCrpBJiOWL0LZ6xHtNd/ts
        e1b+xLNcjxKU8f3wIGWMKXseLrbe5UOkEj58WUzf0QOaVkpok/qUTQwqcBw6h46DuV72hPgRIoQkS
        86dKC5355W1BSaOKY/AKXO+Galfvburird4v78S41JPneh5Fmc3XTqQcNfEQXTWl6tcJsVlFTdrnS
        HD/jgHkRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52716)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWNos-0003sF-QT; Thu, 30 May 2019 17:22:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWNop-0005Y0-Ja; Thu, 30 May 2019 17:22:19 +0100
Date:   Thu, 30 May 2019 17:22:19 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     l00383200 <liucheng32@huawei.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stacktrace in ARM32 architecture has jumped the first 2
 layers, which may ignore the display of save_stack_trace_tsk.
Message-ID: <20190530162219.dtooagpeyczfaazb@shell.armlinux.org.uk>
References: <1559228799-84473-1-git-send-email-liucheng32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559228799-84473-1-git-send-email-liucheng32@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:06:39PM +0800, l00383200 wrote:
> Without optimization, both save_stack_trace_tsk and __save_stack_trace
> will have stacktrace information in ARM32.
> 
> In this situation, "data.skip += 2" operation will skip the first two layers,
> which may make the stacktrace strange and different from other architectures.
> 
> A simple example is as follows:
> In ARM32 architecture:
> [<ffffff80083cb3f8>] proc_pid_stack+0xac/0x12c
> [<ffffff80083c7c70>] proc_single_show+0x5c/0xa8
> [<ffffff800838aca8>] seq_read+0x130/0x420
> [<ffffff8008365c54>] __vfs_read+0x60/0x11c
> [<ffffff80083665dc>] vfs_read+0x8c/0x140
> [<ffffff800836717c>] SyS_read+0x6c/0xcc
> [<ffffff8008202cb8>] __sys_trace_return+0x0/0x4
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> In some other architectures(ARM64):
> [<ffffff8008209be0>] save_stack_trace_tsk+0x0/0xf0
> [<ffffff80083cb3f8>] proc_pid_stack+0xac/0x12c
> [<ffffff80083c7c70>] proc_single_show+0x5c/0xa8
> [<ffffff800838aca8>] seq_read+0x130/0x420
> [<ffffff8008365c54>] __vfs_read+0x60/0x11c
> [<ffffff80083665dc>] vfs_read+0x8c/0x140
> [<ffffff800836717c>] SyS_read+0x6c/0xcc
> [<ffffff8008202cb8>] __sys_trace_return+0x0/0x4
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> Therefore, we'd better just jump only one layer to ensure accuracy and consistency.

Why do we want to log the function we called to save the stack trace
_in_ the stack trace?  What useful purpose does it serve?

I've always taken the attitude that if we want a stack trace from a
certain point in the function, then that's the point that the stack
trace should start.  It's entirely sensible.

> 
> Signed-off-by: liucheng <liucheng32@huawei.com>
> ---
>  arch/arm/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index 71778bb..bb3da38 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -125,7 +125,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
>  #endif
>  	} else {
>  		/* We don't want this function nor the caller */
> -		data.skip += 2;
> +		data.skip += 1;
>  		frame.fp = (unsigned long)__builtin_frame_address(0);
>  		frame.sp = current_stack_pointer;
>  		frame.lr = (unsigned long)__builtin_return_address(0);
> -- 
> 1.8.5.6
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
