Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA48C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AE12073C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLARI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 12:08:56 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:59065 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLARI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 12:08:56 -0500
Received: from hp-x360n.lan (cpe-108-185-41-56.socal.res.rr.com [108.185.41.56])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Qvpq3Cvxz1J7T;
        Sun,  1 Dec 2019 12:08:51 -0500 (EST)
Date:   Sun, 1 Dec 2019 09:08:50 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, mceier@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
In-Reply-To: <20191201144947.GA4167@gmail.com>
Message-ID: <alpine.DEB.2.21.1912010906030.2748@hp-x360n>
References: <20191127005312.GD20422@shao2-debian> <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com> <20191130212729.ykxstm5kj2p5ir6q@linux-p48b> <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com> <20191201104624.GA51279@gmail.com> <20191201144947.GA4167@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Dec 2019, Ingo Molnar wrote:

> So it would be nice if everyone who is seeing this bug could test the
> patch below against Linus's latest tree - does it fix the regression?

The patch fixes the issue for me.

> If not then please send the before/after dump of
> /sys/kernel/debug/x86/pat_memtype_list - and even if it works please send
> the dumps so we can double check it all.

I don't have the "before patch" (but could if it is absolutely needed) but
here's the "after patch":

----
PAT memtype list:
write-back @ 0x4c314000-0x4c35f000
write-back @ 0x4c35e000-0x4c35f000
write-back @ 0x4c35e000-0x4c364000
write-back @ 0x4c363000-0x4c366000
write-back @ 0x4c365000-0x4c369000
write-back @ 0x4c368000-0x4c36b000
write-back @ 0x4c36a000-0x4c36e000
write-back @ 0x4c36d000-0x4c36f000
write-back @ 0x4c36e000-0x4c370000
write-back @ 0x4c36f000-0x4c371000
write-back @ 0x4c370000-0x4c372000
write-back @ 0x4c7eb000-0x4c7ec000
write-back @ 0x4c7ec000-0x4c7ef000
write-back @ 0x4c7ec000-0x4c7ed000
write-back @ 0x4c7ef000-0x4c7f0000
write-back @ 0x4c7f0000-0x4c7f1000
write-back @ 0x4c867000-0x4c868000
write-back @ 0x4c868000-0x4c869000
write-back @ 0x4fa86000-0x4fa87000
write-back @ 0x4fefc000-0x4fefd000
uncached-minus @ 0x77f00000-0x77f10000
uncached-minus @ 0x8e000000-0x8e040000
uncached-minus @ 0x8e040000-0x8e041000
uncached-minus @ 0x8e200000-0x8e202000
uncached-minus @ 0x8e203000-0x8e204000
uncached-minus @ 0x8e300000-0x8e301000
uncached-minus @ 0xe0000000-0xf0000000
uncached-minus @ 0xfd6a0000-0xfd6a1000
uncached-minus @ 0xfd6a0000-0xfd6b0000
uncached-minus @ 0xfd6d0000-0xfd6e0000
uncached-minus @ 0xfd6e0000-0xfd6e1000
uncached-minus @ 0xfd6e0000-0xfd6f0000
uncached-minus @ 0xfe000000-0xfe002000
uncached-minus @ 0xfe001000-0xfe002000
uncached-minus @ 0xfed00000-0xfed01000
uncached-minus @ 0xfed10000-0xfed16000
uncached-minus @ 0xfed15000-0xfed16000
uncached-minus @ 0xfed40000-0xfed45000
uncached-minus @ 0xfed90000-0xfed91000
uncached-minus @ 0xfed91000-0xfed92000
uncached-minus @ 0xff340000-0xff341000
write-combining @ 0x4000000000-0x4010000000
uncached-minus @ 0x4010000000-0x4010001000
uncached-minus @ 0x4010000000-0x4010001000
uncached-minus @ 0x4010000000-0x4010001000
uncached-minus @ 0x4010001000-0x4010002000
uncached-minus @ 0x4010001000-0x4010002000
uncached-minus @ 0x4010001000-0x4010002000
uncached-minus @ 0x604a000000-0x604a200000
write-combining @ 0x604a800000-0x604b000000
uncached-minus @ 0x604b100000-0x604b110000
uncached-minus @ 0x604b110000-0x604b118000
uncached-minus @ 0x604b118000-0x604b11c000
uncached-minus @ 0x604b11c000-0x604b120000
uncached-minus @ 0x604b11e000-0x604b11f000
uncached-minus @ 0x604b122000-0x604b124000
uncached-minus @ 0x604b125000-0x604b126000
uncached-minus @ 0x604b129000-0x604b12a000
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
