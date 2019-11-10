Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100F720842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7pDiUJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKJPeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:34:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37247 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfKJPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 10:34:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so2524323wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TdV7XpL7RLMLTh9ti2lAMwlGymLkQ1keBdQ4En0w/Ak=;
        b=S7pDiUJTmZdd/uzPKx2/egn4wtdkDj6ZN+GbeZ8bd8wuMNesmVqCWs0mLUPBqXnGIP
         04tf8X95H/BXQken000sNnH1u2MxO+GXTR+m6Sb5cpGfapjsQJVfXsLhxvrrPQqW6TQG
         5AYLttaGrvkgjZv33SP/G0caCriKPPc+GEYe+tAK8BNxc06u63DJ+/2CwHYaD2F++IUH
         cdVBjE/Oj/c5xpu1en+nhiomLFdrTjT4Zan4da4r6svZG8f0e/Hg2Qjm4/7XDVu1FSXt
         1A/vwTeQNBT6lB6c97u5nUIK0JgXe388KIDpVayhUXezNteCh965n3ubYS9gB6XlpKSk
         zW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TdV7XpL7RLMLTh9ti2lAMwlGymLkQ1keBdQ4En0w/Ak=;
        b=LQr+1IiOWxqmhByhK0EhJiQep2x+cSQNRL+kLjy60OWIu1NH4BLiBfHZva4Sw+N0MV
         BcSSXXOD9hTljy+rWZ+lEPT1u9rsm8GPp5IELy6gY6yFR2CU5IHEnEcuj6+r0Uyzoz5j
         pERjFEwrjDNRrLj35xaRp9PVDYaMwGu9OARdYJqEw/3QhrmG+CHakzqoANzEjzFUAF2S
         QScRV8YFKJssEak0gsDnA4e61OebAXyL4kWyktMM57e77A000vSRdkQbqtCYG+ZOxNF9
         C7BVo1+VROeZAilIsB0p0NYQkks3uoIEOZXaEcNf9OwxuzCiXMy2oksTnko3s/rnIue0
         XAOw==
X-Gm-Message-State: APjAAAUL2irhWam0gos14yWwd4VyDSrTJZfNH5BpspRTqZXHI8YtT/E6
        113Csjo2NVXXRyRo2gPf1/5L3Aw=
X-Google-Smtp-Source: APXvYqxbe2qmRGV42IwbDleF6tZuhMOaSpFNGQ3wwjB+5LGby/VPIgwJXAvZ2hhzcRePiHBFXE8KPg==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr10031750wmk.144.1573400068402;
        Sun, 10 Nov 2019 07:34:28 -0800 (PST)
Received: from avx2 ([46.53.254.55])
        by smtp.gmail.com with ESMTPSA id f6sm13622818wrm.61.2019.11.10.07.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 07:34:27 -0800 (PST)
Date:   Sun, 10 Nov 2019 18:34:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191110153424.GA5141@avx2>
References: <20191109184441.GA5092@avx2>
 <20191110091435.GC1435668@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191110091435.GC1435668@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 10:14:35AM +0100, Greg KH wrote:
> On Sat, Nov 09, 2019 at 09:44:41PM +0300, Alexey Dobriyan wrote:
> > > statsfs is a proposal for a new Linux kernel synthetic filesystem,
> > > to be mounted in /sys/kernel/stats
> > 
> > I think /proc experiment teaches pretty convincingly that dressing
> > things into a filesystem can be done but ultimately is a stupid idea.
> > It adds so much overhead for small-to-medium systems.
> > 
> > > The first user of statsfs would be KVM, which is currently exposing
> > > its stats in debugfs
> > 
> > > Google has KVM patches to gather statistics in a binary format
> > 
> > Which is a right thing to do.
> 
> It's always "simpler" to just take binary data and suck it in.

Faster too!

> That works for a year or so until another value needs to be supported.
> Or removed.  Or features are backported.
> 
> The reason text values in individual files work is they are "self
> describable" and "self discoverable".

Untrue. Applications always knows what the data means, by definition:

	"0x42"

What is this? 4-char NUL-terminated string? Or an integer 66? Or a
4-byte nonce blob for some kind of crypto algorithm.

In the other direction: describe every field of /proc/*/stat file
without looking to the manpage:

$ cat /proc/self/stat
5349 (cat) R 5342 5349 5342 34826 5349 4210688 91 0 0 0 0 0 0 0 20 0 1 0 864988 9183232 184 18446744073709551615 94352028622848 94352028651936 140733810522864 0 0 0 0 0 0 0 0 0 17 5 0 0 0 0 0 94352030751824 94352030753376 94352060055552 140733810527527 140733810527547 140733810527547 140733810532335 0

> You "know" what the value is and
> that it is supported because the file is there or not.  With binary
> values in a single file you do not know any of that.

You _always_ know that.

> So you need some way of describing the data to userspace in order for
> this to work properly over the next 20+ years.
> 
> Maybe something like varlink which describes the data coming from the
> kernel in an easy-to-handle format?  Or something else, but just using
> blobs does not work over the long-term, sorry.

Text doesn't work either. Why do you think /proc/*/maps have 1 space
character at the end of anon mappings? Because someone fucked up.
Here is how people use /proc in the field:

	https://stackoverflow.com/questions/3596781/how-to-detect-if-the-current-process-is-being-run-by-gdb

	open /proc/*/status
	read
	strstr("TracerPid:")

I'd humbly suggest to define the minimum amount of work for the task:
* some kind of percpu loop to gather stats
* some kind of accumulation code, possibly with min/max/avg
* write clear data
* copy_to_user

and realise that everything alse is a waste of electricity, namely,

* pathname allocation (4KB)
* VFS '/' split, lookups (/sys/kernel/.../" means 3+ lookups
* 192 bytes for each dentry
* 550+ bytes per inode
* 3 system calls per act of gathering statistics
	userspace will be written in the most stupid way possible
	without openat() etc
* userspace snprintf() for pathname
* kernel space snprintf() somewhere
* multiple copying inside kernel (vsnprintf.c)
* general inability for userspace to estimate the amount of data in decimal
  (nobody does that), so nicely sized buffers of 4K or 1K or 16KB (bash)
  will be used which is a waste.
