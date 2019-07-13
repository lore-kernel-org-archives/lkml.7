Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D9AC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8B02083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563009783;
	bh=0+BBCRtf8xdZxj3ZXju6HXFztNwfl31Uix4jgRyCDWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=id8Zrk7BnilKocfJ0WuDVnPhG0pwkJbrfhLqy4fKph5D/33gJhuvZAMflpvhhy5TY
	 jK9z+jpOJ/bmc07WprDuc6d0wh/a4T4Su6AvfwGgVkh9hXSa6/aIMV3sFHMbS+PoLw
	 RrAAE2pbOK/fkxT+uZSlPkTH08mq7kGjW5+BLuhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfGMJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 05:23:02 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45751 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGMJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 05:23:02 -0400
Received: by mail-wr1-f54.google.com with SMTP id f9so12164102wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iINX+df2AYTSwwCS59flPFu3jmXh1NMMDhFIumiOe0g=;
        b=erqn/NRe0sZ3/dV6v7lZr8wsJgvwsBGHMBVdp9WaN+gVQlWuOja9UNbs3hTCCMZhrb
         WZaCtt/2wbVx9o4/m58hOiSzhI14kZOrpfbFrsuABlyP5xD+idizxv/3x0F4azsL/5Gr
         JuE+n5htCtjRz05sr+UnastKgDzUMKBK0qTK99h68+/hZnS1aegv1uPvPeCa0EE1KEwh
         buP+HM9AfeX/61FHxEeQVS9OCzTraj7rqvF0b3dvqogs5IAAihebLwxDwB2eMVz9bRJs
         PUp835FVkJiLiHlHW76LZtpOX6qBgedvVNOtA5mNpK1dqhQlbMXvmxIUjNr7DAB14HQg
         8wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iINX+df2AYTSwwCS59flPFu3jmXh1NMMDhFIumiOe0g=;
        b=uFx4vdGZ1hFOIYpBMBLzIAJNfLMTPL4MCIJqRRwE5hq1LAqqrKaCpIEbQsslT9p8A+
         C2R9jvp8LVAEXRc/2kpZfXDEgRfx/uMK0hJzHLpkv6KyteYeuJdSj5hV1xmSTmpB6OSn
         zs2rfJMBcstLCJXt9Za0ncmPLMluVXjsIT4t8bg2FsBsEn6JLt1jTrRUCmRlR7slZcDT
         GSuRbAE4FuRPfOjcWmEB5ATepLJd2sTWB9nzZ4+7F0iGT4bL3duiFQA8Ch28YFhsY6zs
         /lsqJUG+2t4oMl7/8KKH+sLsdEf+J5ZMZvsQE9aZef+aEKEg+kYOSJATgZF43eWUG9NW
         6Org==
X-Gm-Message-State: APjAAAXg8pNSpslvZTzLh5QeqezvTyyu3GXcuPKf4J7IygxoORavMGuu
        dH431GxMjonUqRmmIAR8ZKo=
X-Google-Smtp-Source: APXvYqzpV+LOCd4Dito6Vo/pqswuDekz22h8H5QLE5wKKEJuceB1ugzFjSDU3jDkY/xaZNo2M2g8xw==
X-Received: by 2002:adf:e790:: with SMTP id n16mr3018748wrm.120.1563009779973;
        Sat, 13 Jul 2019 02:22:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u9sm10214132wrr.30.2019.07.13.02.22.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 02:22:59 -0700 (PDT)
Date:   Sat, 13 Jul 2019 11:22:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler changes for v5.3
Message-ID: <20190713092257.GB81998@gmail.com>
References: <20190708115349.GA14779@gmail.com>
 <CANcMJZAYhqdO5sGbwW7GszL9NtNgMy0+uMe+bVSQHqyewQcy_g@mail.gmail.com>
 <20190710105736.GK3402@hirez.programming.kicks-ass.net>
 <CALAqxLXKVsCsUq3HHs0LuPFd6_aA4S0bBR4vp-xDiRKgEDnoAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXKVsCsUq3HHs0LuPFd6_aA4S0bBR4vp-xDiRKgEDnoAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* John Stultz <john.stultz@linaro.org> wrote:

> On Wed, Jul 10, 2019 at 3:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Urgh.. however didn't we find that before :/ stupid stats.
> >
> > Something like the below ought to fix, but let me see if I can come up
> > with something saner...
> 
> Yep. This works for me, but let me know if you have anything else you
> want me to test as well.

No, that's perfect, will get this fix to Linus ASAP, thanks for the help!

	Ingo
