Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCB520872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKUFag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:30:36 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:51614 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbfKUFag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:30:36 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iXf31-0001ve-6r; Thu, 21 Nov 2019 06:30:31 +0100
Date:   Thu, 21 Nov 2019 06:30:31 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Kernel 5.4 regression - memory leak in network layer
Message-ID: <20191121053031.GI20235@breakpoint.cc>
References: <alpine.LNX.2.21.1.1911191047410.30058@winds.org>
 <20191119162222.GA20235@breakpoint.cc>
 <20191120202822.GF20235@breakpoint.cc>
 <alpine.LNX.2.21.1.1911201706510.2521@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1.1911201706510.2521@winds.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> wrote:
> On Wed, 20 Nov 2019, Florian Westphal wrote:
> > Not reproducible.
> > 
> > I'm on
> > 
> > c74386d50fbaf4a54fd3fe560f1abc709c0cff4b ("afs: Fix missing timeout reset").
> 
> I confirm I still see the issue on that commit.

[..]

> netperf -H 172.17.2.11 -t UDP_RR

Ah, thats all it takes.  Its related to UDP_SKB_IS_STATELESS, commit
895b5c9f206eb7d25dc1360a is the culprit.  I'll send a fix shortly.
