Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9292DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0320684
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574798552;
	bh=ytA2eZm63qdLczSFkDAB987mOthvDZ8JMV0LyJodnB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvwcVOlTXxTRPohYCRdU+5sFksTYeb1u26oAlUb2FYPtVv98di098po1nENDzeyTo
	 SuIlAFquQLKHnkssX9CXcmIYaUgINyeh55+8Is5xlTPjVBURayMsA1DTLdp3KE3sDB
	 7qgfLLeEg4CPJDOg4c33OB9xw3Oc8eb/Z9ReGHn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKZUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:02:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36762 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:02:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so23940921wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJYX5CPBeU5g1rkm7h0VK5o7IGKxf4O/UhxG3t24j+c=;
        b=maBP7ATofT70r8zqtzonG0OLY3Ei6J4+VA3SrDtTB4YRPioaJAVo0+tpLFoQajxneJ
         wMS8tvZVtD2zxRtk8h4OErj4uGl251mzSNGIDlzOoIE7PB5a1qoRMaQVdnSkPxMcLnKO
         40SMwSKzc5Yt3usb/+01InUZR6f8Be+px1H50scv/ptowV4jfek2OpwD/gQ13iE7ZzGf
         OID+A0JrfL9guPOZt6DfV/fHngBN6WuApmvaZzN8rI3eklR3QQqJGcduIzDPirW15onG
         UPNY9FwC9S1bK9czRzneTzvIPXazu0f3wMEbkIZzC9uSl/f5GCm7tpwTrFPkbaHdI3BC
         C8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJYX5CPBeU5g1rkm7h0VK5o7IGKxf4O/UhxG3t24j+c=;
        b=V9hndNE/XLdwPbpWYXe+ezsOeo8uMG8AIWnCR+2te1WNsYqFh+Jh12K/u64e5iuLvO
         nUkG2PmxfA/ikKtETMBbML7ffqnMenC6U9wGjpBzfADQ07fJhqyQb9qo0xIrvNyd0Uor
         ztnkBh18ITj6KEcROWv+7CxxrCaQKTvk+bBBxklTf30rkWX81+bWmZYrRqgvghdXB+/Z
         4kagoGJy6uiKJthQHnRRCKxQ0opJHmCINHvS8g5zreTGTszn+jCD8xJ2AeI7LcQyJmY0
         Ny1ZLGd5fzzHAeqRxrRFHDc0AL3vmc+Ge7Gnxe8ERPmGx4CuI7I4MnhfsWZhGnPj63WJ
         sxRw==
X-Gm-Message-State: APjAAAWC/WYH3BFqbigSmI2coQ5Dsr0h65NWWP+l+m6JH34/hgHX7iDi
        fY0EGwcI491Z8kGihBB+JIg=
X-Google-Smtp-Source: APXvYqzs0hzIlaFi5Tqr9h/GcfV+T6O5goEom9qVwyBZZPl69wmcr0zo7C/ku9snCPX11BMZsU03uQ==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr41241855wra.194.1574798549244;
        Tue, 26 Nov 2019 12:02:29 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c144sm4211247wmd.1.2019.11.26.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 12:02:28 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:02:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [GIT PULL] x86/iopl changes for v5.5
Message-ID: <20191126200226.GA5785@gmail.com>
References: <20191125161626.GA956@gmail.com>
 <CAHk-=whswxd9b0A9Sr5YhjcGbA0WKrB8Rrtx89PLKeP6RdKT3A@mail.gmail.com>
 <20191126195046.GA28296@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126195046.GA28296@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, Nov 25, 2019 at 8:16 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > This tree implements a nice simplification of the iopl and ioperm code
> > > that Thomas Gleixner discovered: we can implement the IO privilege
> > > features of the iopl system call by using the IO permission bitmap in
> > > permissive mode, while trapping CLI/STI/POPF/PUSHF uses in user-space if
> > > they change the interrupt flag.
> > 
> > I've pulled it.
> > 
> > But do we have a test for something like this:
> > 
> >    ioperm(.. limited set of ports..)
> >    access that limited set.
> > 
> >    special_sequence() {
> >        iopl(3);
> >        access some extended set
> >        iopl(0)
> >    }
> > 
> >    go back to access the limited set again
> > 
> > because there's subtle interactions with people using *both* iopl()
> > and ioperm() and switching between the two. Historically you could
> > trivially do the above, because they are entirely independent
> > operations. Does it still work?
> > 
> > Too busy/lazy to check myself.
> 
> Yes, I went through the code with such scenarios in mind and I believe it 
> all works correctly: the two bitmaps are independent and the granular one 
> is preserved across iopl() interactions. But to make sure I'll write a 
> testcase as well.
> 
> In any case I agree that this kind of behavior is very much part of the 
> ABI, so if it doesn't work like that we'll fix it. :-)

Thomas already coded a similar testcase up in tools/testing/selftests/x86/ioperm.c:

 galatea:/home/mingo/linux/linux/tools/testing/selftests/x86> ./iopl_64 
 [OK]	CLI faulted
 [OK]	STI faulted
 [OK]	outb to 0x80 worked
 [OK]	outb to 0x80 worked
 [OK]	outb to 0xed failed
	child: set IOPL to 3
 [RUN]	child: write to 0x80
 [OK]	Child succeeded
 [RUN]	parent: write to 0x80 (should fail)
 [OK]	outb to 0x80 failed
 [OK]	CLI faulted
 [OK]	STI faulted
	iopl(3)
	Drop privileges
 [RUN]	iopl(3) unprivileged but with IOPL==3
 [RUN]	iopl(0) unprivileged
 [RUN]	iopl(3) unprivileged
 [OK]	Failed as expected

This is the testcase:

        /* Establish an I/O bitmap to test the restore */
        if (ioperm(0x80, 1, 1) != 0)
                err(1, "ioperm(0x80, 1, 1) failed\n");

        /* Restore our original state prior to starting the fork test. */
        if (iopl(0) != 0)
                err(1, "iopl(0)");

        /*
         * Verify that IOPL emulation is disabled and the I/O bitmap still
         * works.
         */
        expect_ok_outb(0x80);
        expect_gp_outb(0xed);

Those expect-OK for 0x80 and expect-#GP for 0xed are the tests for the 
previously established permission bitmap surviving to after the 
iopl(3)+iopl(0) sequence, and they work as expected:

 [OK]	outb to 0x80 worked
 [OK]	outb to 0xed failed

Thanks,

	Ingo
