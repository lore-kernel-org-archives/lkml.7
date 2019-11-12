Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A363C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6D21D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573542853;
	bh=LdAVRdsO0LZnGMHa4ESUaa+PX7vtWeMfd8vlK4mTc5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cFU6ZK7W1AsnwRVVJ/4KR4w7UO+3gHft00YctC81YALXWLCs82SfEwoClFhQkcEFa
	 XolmaEtgKiGIUcRObY8w41sSmLAUZKiQ2mlHA3BcHAmwHuEJm5Y8SCw7fS2pOxkzX0
	 ZbZIyqnaFprl38QzmUsv+/1XvewB6zJ9iQurUsLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLHOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:14:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:14:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so17196020wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9QktcwqjFrUQLNxQ92T5b2ikAyMq4tuwAZ0K6dzfI00=;
        b=Iyrf/5yIDEdmkUBAApgTne1WPDigYUKVokkLYM7Um7q+oXUsJP3C/9GmKleUY4JK6p
         MiejPb+05Y4Jhf5vY659Yi9QlffN2LoB4uF0r0ipw0o3/jk6Dat6lb01rMf1HUh6L0TG
         ejbhoG0Syxrcl7aglywEckKe2e4XaNO2EKGAdM52sJ0jyrwbSnuGO4ihb798O/JESSmc
         5oGTiECbz188Z2sf5YViJo8JWPfBhQP1UI/SZt+Aap/HR5pFHuNBOhQ/ZKS3/sc6vk+l
         YGS+NrrBRyBlQ6RFIfhJB6qXBJyB2XPjMJ8Cu1Wy7D3K5xOBy7NX3xjnNtWk93goxLP7
         7prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9QktcwqjFrUQLNxQ92T5b2ikAyMq4tuwAZ0K6dzfI00=;
        b=miWzatx9lRG74RQ1Ge7I+WnkD0j52ICI5Vf/6Ec5oiZzamRpfqM3Ydd1og/g7vxHVK
         FX1I+VdMntI8TYp4pPHhDjhQnLjVISYFXTsi5roLQQ2iG3Dzr+ZTwXO3HTBjpIdVYl2D
         LXTz93U7hi5zJu++7BCPGBtNmYOw+yWPCr6hr/am4imR2ix7GW5wYvmB2/dBe9K4zEVM
         HKhAfpJWhsof8hm24WGAJpelRy9t+MHskJxcziYAZvSBK3OalxFKNzjHzFjWvOqJL2h8
         1YbRYGgOCqjOp+s0wGrUGwGPJltsJYMysdDVAwVhWhdESyudruc2C86JMtkH6I8fUH9w
         y63w==
X-Gm-Message-State: APjAAAWZXZ9pO5RpGhlNNKBFtjI6JLZQ56GvYkX3p1UCeBqopl59SJnb
        FM3g4IFeaDi52LTgfdAQSvo=
X-Google-Smtp-Source: APXvYqznyXmA2en83hmSePWH1X56kEtb+h8KJhEKSBS/3VZtNlyd1S40esKrN1cZ7zq1t6ft2d0w/w==
X-Received: by 2002:adf:d083:: with SMTP id y3mr23073302wrh.53.1573542849585;
        Mon, 11 Nov 2019 23:14:09 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id m13sm1824237wmc.41.2019.11.11.23.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:14:08 -0800 (PST)
Date:   Tue, 12 Nov 2019 08:14:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
Message-ID: <20191112071406.GC100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.603030685@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111223052.603030685@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The I/O bitmap is duplicated on fork. That's wasting memory and slows down
> fork. There is no point to do so. As long as the bitmap is not modified it
> can be shared between threads and processes.
> 
> Add a refcount and just share it on fork. If a task modifies the bitmap
> then it has to do the duplication if and only if it is shared.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/include/asm/iobitmap.h |    5 +++++
>  arch/x86/kernel/ioport.c        |   38 ++++++++++++++++++++++++++++++++------
>  arch/x86/kernel/process.c       |   39 ++++++---------------------------------
>  3 files changed, 43 insertions(+), 39 deletions(-)
> 
> --- a/arch/x86/include/asm/iobitmap.h
> +++ b/arch/x86/include/asm/iobitmap.h
> @@ -2,10 +2,12 @@
>  #ifndef _ASM_X86_IOBITMAP_H
>  #define _ASM_X86_IOBITMAP_H
>  
> +#include <linux/refcount.h>
>  #include <asm/processor.h>
>  
>  struct io_bitmap {
>  	u64			sequence;
> +	refcount_t		refcnt;
>  	unsigned int		io_bitmap_max;
>  	union {
>  		unsigned long	bits[IO_BITMAP_LONGS];

> +void io_bitmap_share(struct task_struct *tsk)
> + {
> +	/*
> +	 * Take a refcount on current's bitmap. It can be used by
> +	 * both tasks as long as none of them changes the bitmap.
> +	 */
> +	refcount_inc(&current->thread.io_bitmap->refcnt);
> +	tsk->thread.io_bitmap = current->thread.io_bitmap;
> +	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
> +}

Ok, this is really neat. I suspect there might be some pathological cases 
on ancient NUMA systems with a really high NUMA factor and bad caching 
where this new sharing might regress performance, but I doubt this 
matters, as both the hardware and this software functionality is legacy.


> +	/*
> +	 * If the bitmap is not shared, then nothing can take a refcount as
> +	 * current can obviously not fork at the same time. If it's shared
> +	 * duplicate it and drop the refcount on the original one.
> +	 */
> +	if (refcount_read(&iobm->refcnt) > 1) {
> +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> +		if (!iobm)
> +			return -ENOMEM;
> +		io_bitmap_exit();
>  	}
>  
> +	/* Set the tasks io_bitmap pointer (might be the same) */

speling nit:

s/tasks
 /task's

Thanks,

	Ingo
