Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4493EC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411A20865
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575232265;
	bh=t1iHUavp7iLrM+9d6MsiT6IoYSYVQKEtJThrp9Me9BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ba62tEw0w7mJoHiUmwpTN8pdR3xIpCt3OsvCt2kdKoX4OkXzSjtQQaTS+yoi9ovRd
	 ZNm2f6WmvbZ+afVZOqnrMXpKRkBUPNVfh9U4gqEptsFrBoT3IuZWbCJAoTgiJJfNXk
	 ymAtdUVglUJSE4pPgwmOEPKRvpa05lj1EZUNZ4OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLAUbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 15:31:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40141 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfLAUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 15:31:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so17027269wrn.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 12:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k0vP8O4laRZDcbfd6ubx4anqmuOGWDPrB2xGATS7dVE=;
        b=Yb6qM1OMqo+1YcDltjALP4kv3ykDmgwIUI4nA5PumuzF91PWK3bgrkfn4crd4zmKmZ
         B9+o2DtRqy7vXoid917HvrLqouXLCN3TXbgI/bYtqDb6xZswJI8lckg3xGyvofVgeqXF
         KQele5QUACXWx0NQzfVQCh57FABpH9haToUb00KHjr/lO69CtXkotHEhXgtuplQsXN28
         rvn8LVox6cVgFXJ8oNYa9zXl0e1t2wiMyqPNEbFAPMa7Wcz4GsfM+WJpckthc7/ScbTK
         SQXv+ySU426qEhQe6goTIdts0gjSWLdn3sJtOc7k0ecvtLiB8x8XzcPBBaosd6eVHEkG
         dxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0vP8O4laRZDcbfd6ubx4anqmuOGWDPrB2xGATS7dVE=;
        b=imCEpth3KGLyMGpuN/W3YRlAXdQIrlLcJ/DbGr1kf5WeUEzb97yLUZQ+2+CuD5/dkj
         nLcq8MAlBplYzSHRjQvw0K8Ec09Od5JzlIzDFMTLSeAeCmOt+fPBrf4fISlD9OUGEJEM
         e78UOwcAN56S9vXbAfik605x9QBZ74FTQa6hS6WBCchB5FK1hEOx8AJf5HyTHy2+G9RN
         Tbz2Azb4naICf6qcnhC22fpVfjaa3JP1uGcWJ4RIo1WVw1lZAPb2DuaGUwSMT6Kc6EZZ
         vEiQNX4B/YZPv6IQ2eF5XKAT4OkO7va+NARBSdCUEXGfLsCU0Y7EkUwEpAwGmu/e8USP
         tAWA==
X-Gm-Message-State: APjAAAUvWRzaiz9K2B//EZbkr6UBF4qbIUl4yYEohOnSgbb5RLbYVu0Q
        2cfdFdaaQn0fd0RqNfNuZ8c=
X-Google-Smtp-Source: APXvYqyr3BbUoX3tPng8PG0eUZIAdsBbMbqxgbOW46Yfui3fhHzohFE2lLXSzZfCBKozHTq8B1yBfQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr29023101wrn.270.1575232261532;
        Sun, 01 Dec 2019 12:31:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u14sm37571524wrm.51.2019.12.01.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 12:31:00 -0800 (PST)
Date:   Sun, 1 Dec 2019 21:30:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mceier@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
Message-ID: <20191201203058.GA82131@gmail.com>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com>
 <20191201144947.GA4167@gmail.com>
 <alpine.DEB.2.21.1912010906030.2748@hp-x360n>
 <20191201195521.GC3615@gmail.com>
 <alpine.DEB.2.21.1912011205350.2748@hp-x360n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912011205350.2748@hp-x360n>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kenneth R. Crudup <kenny@panix.com> wrote:

> > > write-combining @ 0x604a800000-0x604b000000
> > > uncached-minus @ 0x604b100000-0x604b110000
> 
> > This WC region was probably unaffected by the bug.
> 
> For my education, and for completeness' sake, is there a proc/sys entry
> that would tell me which device/module has reserved which PAT region?

Not that I know of :-/

I suspect you could run the attached patch and run:

  dmesg | grep -i 'x86/pat'

To see all the ioremap() activities, with a symbolic name of the caller printed.

I'm quite sure 0x604a800000 will be among them, pointing to somewhere 
like i915_vma_pin_iomap(), ggtt_init_hw() or ggtt_probe_common() in the 
i915 GPU driver?

Another possibility is that this is the FB framebuffer, mapped by 
efifb_probe() or so?

Patch is untested though. :-)

Thanks,

	Ingo

=================>

 arch/x86/mm/ioremap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 1ff9c2030b4f..2f0a4f99471a 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -166,6 +166,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	int retval;
 	void __iomem *ret_addr;
 
+	printk("# x86/pat: ioremap(%016Lx, %08lx, pcm: %d), caller: %pS\n", phys_addr, size, pcm, caller);
+
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)

