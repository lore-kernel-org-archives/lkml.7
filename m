Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B279C206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566727155;
	bh=zTUTsHGCaZBP7xNskAu1r4WXw/9iMREz8u7KmKSW8Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pMuuhR0QBwj1IWtnpDJtVsYbi88FfY9xtTYZyC1q1HNX7P/DQSbS7D5rxCz6IYWmG
	 aoYgLI9CBXhljmtsu3rjQq8IHjhJ24O0FBovNuAJEgcIvE55HXrvh/73s89Il7THDm
	 vsySA9GEZBr3oVPRGNzUKtM22oqpb8DuU+qsSJqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfHYJ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:59:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36983 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfHYJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:59:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so12517896wrt.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BCNNv6vEk+ZOhqoDfM2lLYswZrrMiMc9OplCE5bhTZs=;
        b=eDlAkxxX2gPw+Ajwv82HV2NGCh2FB6TvzMxHW8NGBPRDfEre0UCf4FPAb8Kugyb2iw
         elkPwjHK/YQ9gGX00REWy+ESTMahr71N5CIxmwPfGftw+zqMuOZR3Ac7spWfiWKcocia
         GttgD9p/SU8l5XshI7sBAZnWiuIYBqVLgqIuIkBK9uzOC3px5bEszRH4u76vvzn/1XMA
         sZFXTJ8+zrEQJBpkhOQSMi0mr1SDPpcQC11eNKS0gLjo5TJlHov4yWtxeTD05fc1iBWJ
         Ex0dKCqSbRy9IIYntyUyvstuLiLguM4Rq/yqzu1Dsev6cdABUz1mOWBZC/b8pRWuVVlh
         LGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BCNNv6vEk+ZOhqoDfM2lLYswZrrMiMc9OplCE5bhTZs=;
        b=ECCrQs3CudrIRWlprQ07sPLJH/Hd63Uo7y8hMcaNNfVJfyflAt+yzPby4t+LgY/OOH
         JRwaEqxN95UsW1kNogRzfKg7dusVcyTZyLtoQlBZe0Vf4t/nNSMIjz9sGlT69VmltPR8
         ksDtu7T9p2MRdbgHx33mwRnluXTft+Gr21h21uXvdfRphJa0u/Hm170XuNxUsUWwFcHo
         eBKIOn7FZGz6QPdedi62cwwfAiE3njnmKkNDZD1bhPY4eE/f2reryMkVRQ2phTIHHy/r
         skRm2j0s9gN4qDZTL7uovgDGT/DptQr5viaEGMSh4NJjZXdjSS+vrh6+hMtwnG3GezLl
         79Qg==
X-Gm-Message-State: APjAAAW42/cZmg99s21xWG8SRSNy4INfFIlvZzfLKPLsM2AZul8REno9
        smq4qwPvXzBcjMZhIwMxNtg=
X-Google-Smtp-Source: APXvYqxkAHBl+hqdFR3SEoq+dVCMupR3rjZM6B0ql56sczGjqKhstQ/MdKGeZr/F7u2SiEZ2/EcXIg==
X-Received: by 2002:a5d:6981:: with SMTP id g1mr15335596wru.193.1566727151025;
        Sun, 25 Aug 2019 02:59:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a18sm10092342wrt.18.2019.08.25.02.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:59:10 -0700 (PDT)
Date:   Sun, 25 Aug 2019 11:59:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190825095908.GA116866@gmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
 <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2019/08/25 5:22, Ingo Molnar wrote:
> >> So I'd be willing to try that (and then if somebody reports a
> >> regression we can make it use "fatal_signal_pending()" instead)
> > 
> > Ok, will post a changelogged patch (unless Tetsuo beats me to it?).
> 
> Here is a patch. This patch also tries to fix handling of return code when
> partial read/write happened (because we should return bytes processed when
> we return due to -EINTR). But asymmetric between read function and write
> function looks messy. Maybe we should just make /dev/{mem,kmem} killable
> for now, and defer making /dev/{mem,kmem} interruptible till rewrite of
> read/write functions.
> 
>  drivers/char/mem.c | 89 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 50 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index cb8e653..3c6a3c2 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -108,7 +108,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>  	ssize_t read, sz;
>  	void *ptr;
>  	char *bounce;
> -	int err;
> +	int err = 0;
>  
>  	if (p != *ppos)
>  		return 0;
> @@ -132,8 +132,10 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>  #endif
>  
>  	bounce = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!bounce)
> -		return -ENOMEM;
> +	if (!bounce) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}

Yeah, so while I agree with the more consistent handling of partial 
reads, I'd suggest the following changes:

 - Please don't use this 4-line error handling variant, use the old short 
   2-line pattern instead. There's no real reason to keep 'err' as a 
   flag, the 'failed' branch will know that 'err' is the error return if 
   there's been no progress.

 - We should probably separate out a third 'fatal error' variant: for 
   example if copying to user-space generates a page fault, then we 
   clearly should not pretend that all is fine and return a short read 
   even if we made some progress, a -EFAULT is more informative, as we 
   might have corrupted (overran) some user buffer on the failed copy as 
   well, and ran off the end into the first unmapped user area.

 - As for the patch series maybe it might make sense to separate the 
   fixes from the semantic changes, in case there's any breakage. I.e. 
   first fix the bug minimally, then add the other changes in a separate 
   commit. If any of them causes problems with applications we'll have a 
   more precise bisection result.

 - Likewise, the changing of the write side interruptability of /dev/mem 
   should probably be a separate patch as well.

I can factor out such a series if you don't have the time, but feel free 
to do it yourself, this is your bug report and your patch. :)

> @@ -180,14 +182,11 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>  		count -= sz;
>  		read += sz;
>  	}
> +failed:
>  	kfree(bounce);
>  
>  	*ppos += read;
> -	return read;
> -
> -failed:
> -	kfree(bounce);
> -	return err;
> +	return read ? read : err;
>  }

Yeah, the merging of the normal and the failure path control flow doesn't 
really help readability and makes the actual iterator more complex - I 
think the old exception handling pattern was fine.

I think the same applies to the write path as well.

Thanks,

	Ingo
