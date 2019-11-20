Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D575320855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKTU23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:28:29 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50120 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbfKTU23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:28:29 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iXWaM-0007wR-3a; Wed, 20 Nov 2019 21:28:22 +0100
Date:   Wed, 20 Nov 2019 21:28:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Byron Stanoszek <gandalf@winds.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Kernel 5.4 regression - memory leak in network layer
Message-ID: <20191120202822.GF20235@breakpoint.cc>
References: <alpine.LNX.2.21.1.1911191047410.30058@winds.org>
 <20191119162222.GA20235@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119162222.GA20235@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Byron Stanoszek <gandalf@winds.org> wrote:
> > unreferenced object 0xffff88821a48a180 (size 64):
> >   comm "softirq", pid 0, jiffies 4294709480 (age 192.558s)
> >   hex dump (first 32 bytes):
> >     01 00 00 00 01 06 ff ff 00 00 00 00 00 00 00 00  ................
> >     00 20 72 3d 82 88 ff ff 00 00 00 00 00 00 00 00  . r=............
> >   backtrace:
> >     [<00000000edf73c5e>] skb_ext_add+0xc0/0xf0
> >     [<00000000ca960770>] br_nf_pre_routing+0x171/0x489
> >     [<0000000063a55d83>] br_handle_frame+0x171/0x300
> 
> Brnf related, I will have a look.

Not reproducible.

$ ipables-save -c
[66041:2794275493] -A INPUT -i br0 -m physdev --physdev-in eth0

... so br-netfilter is active (else physdev would not work). No leaks
after multiple netperf runs.

I'm on

c74386d50fbaf4a54fd3fe560f1abc709c0cff4b ("afs: Fix missing timeout reset").

Simple bridge with two ethernet interfaces (no vlans or netns for instance).

Does your setup use any other settings (ethtool, sysctl, qdiscs, tunnels
and the like)?

Thanks.
