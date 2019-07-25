Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9EC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928BE229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfGYSEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:04:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53492 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfGYSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:04:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqi6O-0005Zb-G4; Thu, 25 Jul 2019 18:04:28 +0000
Date:   Thu, 25 Jul 2019 19:04:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] 56cbb429d9: ltp.fs_fill.fail
Message-ID: <20190725180428.GH1131@ZenIV.linux.org.uk>
References: <20190725110944.GA22106@shao2-debian>
 <20190725132617.GA23135@rei.lan>
 <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:32:13AM -0700, Linus Torvalds wrote:
> On Thu, Jul 25, 2019 at 6:26 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> > This looks like mkfs.vfat got EBUSY after the loop device was
> > succesfully umounted.
> 
> Hmm. Smells like the RCU-delaying got triggered again.
> 
> We have that "synchronize_rcu_expedited()" in namespace_unlock(),
> which is so that everything should be done by the time we return to
> user space.
> 
> Al, maybe that RCU synchronization should be after the mntput()s?

There are several interesting issues in there, but synchronize_rcu()
should be between zeroing ->mnt_ns and dropping the final refs.
I'm digging through that crap right now; at least one bug is dealt
with by #fixes, but there's more, unfortunately.
