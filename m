Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5AC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8403C20833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLAUJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 15:09:37 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:41806 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfLAUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 15:09:37 -0500
Received: from hp-x360n.lan (cpe-108-185-41-56.socal.res.rr.com [108.185.41.56])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47QzqJ3Zdxz1QxS;
        Sun,  1 Dec 2019 15:09:32 -0500 (EST)
Date:   Sun, 1 Dec 2019 12:09:31 -0800 (PST)
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
In-Reply-To: <20191201195521.GC3615@gmail.com>
Message-ID: <alpine.DEB.2.21.1912011205350.2748@hp-x360n>
References: <20191127005312.GD20422@shao2-debian> <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com> <20191130212729.ykxstm5kj2p5ir6q@linux-p48b> <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com> <20191201104624.GA51279@gmail.com> <20191201144947.GA4167@gmail.com> <alpine.DEB.2.21.1912010906030.2748@hp-x360n> <20191201195521.GC3615@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > uncached-minus @ 0xfed91000-0xfed92000
> > uncached-minus @ 0xff340000-0xff341000
> > write-combining @ 0x4000000000-0x4010000000
> > uncached-minus @ 0x4010000000-0x4010001000

On Sun, 1 Dec 2019, Ingo Molnar wrote:

> I believe this is the region that caused the problem, the 0x4010000000
> 'end' address of the WC region is the same as the 0x4010000000 'start'
> address of the UC- region that follows it.

> > write-combining @ 0x604a800000-0x604b000000
> > uncached-minus @ 0x604b100000-0x604b110000

> This WC region was probably unaffected by the bug.

For my education, and for completeness' sake, is there a proc/sys entry
that would tell me which device/module has reserved which PAT region?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
