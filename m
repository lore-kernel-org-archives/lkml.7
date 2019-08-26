Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0698FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B532070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566818390;
	bh=eObDLWxotJapP7QS/ohbedOLggzr34IpzDBmV0oEliI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pd++RspJjm59/wH9d3K5GseEFVMFBGaVcY2L4f6XPOW1MhhvgIoTrfHhx8mIlQGTt
	 jEjNYzAb/jxLZd8MutMNjs5CyAVUSJtulsZJPIZn+OAfMAbt5p/Y1sxp7SQinRs5Mk
	 WDnKGJKfnI+DrfpKHj11pzknQwlmTJUzpVKj+yYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfHZLTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:19:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39746 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfHZLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:19:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so14914290wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BcdPI2NiPccmYvseNFwmPOzanJx8f6uoP59aa/K5HE=;
        b=JBHf1BLOD/ewm4WOmuIlhZpkPlENKqX+1rufiya+eBAhSS7CrihBM3mx+RGZBZtXnC
         qDh96NBWrqAAKvgS77Fx/B+CStXzvfgXmeRAcP1t5YHNqeCNpixCAkIbFRPmh528LaVE
         xaExvh+v9N9OXsbCT7CwMf94qXM21yfC9b9ac3esV5GEXUFB5uOPX/6n4q0x8hSbMGgm
         DdDn6D4PrTwa2HFHdVz1xdyu120Ox9ZSnW1r1dr9FGD2wKZ/Yx92zM2hCbwmP0Vtcpu1
         la6FHvwdLH2SMkPIqOoRCNtqC5h4sRJQFi5vtgO/Ogv3sH5mArMsVvnal7CClDGDFjUm
         SM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BcdPI2NiPccmYvseNFwmPOzanJx8f6uoP59aa/K5HE=;
        b=CV1DkX/xTVeEBK1nCgfOJxsmU6vTgzpC7weuL/kRhYsEAotX8fNg+fDs1GIZjmP2kv
         DfNdVLRrsCVmrbWFef34safirBoRWZmVLIJbnUvt5LJQVRrcDfZCcYQ7SaFIoAbgAIyH
         HwQ9vUfO8EsZW4m5GKyDmBU5OERdE+dzGtnbeff1LNogSqD/llF1gpyamv9UhZho6qGz
         FB3nZxcv+CUfqCmhoFg/sMLgTzmwePNcJUCxe26Obf8A9yDmTqpXPiHm5rvBuQiAsiPb
         y25r7AVlwSRPxMHMzBkAr+x+zcDkNAdVwgmNIKO3AERE81HjrlEhMjzT3UbIpN9qNfcW
         74uQ==
X-Gm-Message-State: APjAAAUlPhZ03kcHs0Z4NLTINLPYV1zl+rEFtCidzNIWEwOZ8adhhm4n
        EKgsTpFnNDOt3sQV1bOs8FM=
X-Google-Smtp-Source: APXvYqxIueolwwajd7ctvnxMwV/IwETPtEh2208ZRdhOmXbm7IvsSX3gdUCnsvip8mrtRtWqY6M44Q==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr21779447wrn.311.1566818387570;
        Mon, 26 Aug 2019 04:19:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d17sm11103638wrm.52.2019.08.26.04.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 04:19:46 -0700 (PDT)
Date:   Mon, 26 Aug 2019 13:19:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190826111944.GA39308@gmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
 <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
 <CAHk-=wgR=moYe2Jx8wobx9Vzxj55DGPwU9VEjZ+7gUrVYySMzQ@mail.gmail.com>
 <92919086-0a7e-520d-0465-b9e3051e965a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92919086-0a7e-520d-0465-b9e3051e965a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2019/08/26 1:54, Linus Torvalds wrote:
> > On Sat, Aug 24, 2019 at 10:50 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> @@ -142,7 +144,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
> >>                 sz = size_inside_page(p, count);
> >>                 cond_resched();
> >>                 err = -EINTR;
> >> -               if (fatal_signal_pending(current))
> >> +               if (signal_pending(current))
> >>                         goto failed;
> >>
> >>                 err = -EPERM;
> > 
> > So from a "likelihood of breaking" standpoint, I'd really like to make
> > sure that the "signal_pending()" checks come at the *end* of the loop.
> > 
> > That way, if somebody is doing a 4-byte read from MMIO, he'll never see -EINTR.
> > 
> > I'm specifically thinking of tools like user-space 'lspci' etc, which
> > I wouldn't be surprised could happen.
> > 
> > Also, just in case things break, I do agree with Ingo that this should
> > be split up into several patches.
> 
> Thinking from how read_mem() returns error code instead of returning bytes
> already processed, any sane users will not try to read so much memory (like 2GB).
> If userspace programs want to read so much memory, there must have been attempts
> to improve performance. I guess that userspace program somehow knows which region
> to read and tries to read only meaningful pages (which would not become hundreds MB).
> Thus, I don't think we want to make /dev/{mem,kmem} intrruptible. Just making killable
> in case insane userspace program (like fuzzer) tried to read/write so much memory
> will be sufficient...

Basically making IO primitives interruptible is the norm and it's a 
quality of implementation issue: it's only a historic accident that 
/dev/mem read()s aren't.

So let's try and make it interruptible as the #3 patch I sent did - of 
course if anything breaks we'll have to undo it. But if we can get away 
with then by all means let's do so - even shorter reads can generate 
nasty long processing latencies.

Ok?

Thanks,

     Ingo
