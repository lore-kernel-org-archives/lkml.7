Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09E1C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE186214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfDVR1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:27:35 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:52046 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbfDVR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:27:35 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hIcj6-0002Na-KD; Mon, 22 Apr 2019 19:27:32 +0200
Date:   Mon, 22 Apr 2019 19:27:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Andreas Hartmann <andihartmann@01019freenet.de>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 13/99] netfilter: nf_conncount: fix argument order
 to find_next_bit
Message-ID: <20190422172732.sneybhuwrreb7g2u@breakpoint.cc>
References: <20190121134913.924726465@linuxfoundation.org>
 <20190121134914.421023706@linuxfoundation.org>
 <f55ad830-dd61-8ce2-7fa0-d33fb93c0b9c@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55ad830-dd61-8ce2-7fa0-d33fb93c0b9c@01019freenet.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@01019freenet.de> wrote:
> Since 4.19.17, I'm facing problems during streaming of videos I've never seen before. This means:
> 
> - video from internet stutters although enough data flow can be seen in bmon.
> - gpu is locked:
>   radeon 0000:0a:00.0: ring 0 stalled for more than 14084msec
>   radeon 0000:0a:00.0: GPU lockup (current fence id 0x0000000000053ed7 last fence id 0x0000000000053f0f on ring 0)
> - The connection of videos streamed locally by the machine for a TV suddenly breaks (upnp - serviio as server).
> 
> After very long time of testing, I detected, that removing the complete patch series for 4.19.17 regarding netfilter: nf_conncount makes the problem disappear.
> 
> Please remove / fix this patchset!

The state in 4.19.y is same as in mainline.
Could you at least tell us how you're using nf_conncount (nf/iptables
rules)?

Could you test with debugging (KASAN, CONFIG_PROVE_RCU etc). enabled?

I'm really surprised about this report, before the backport nf_conncount
caused frequent kernel crashes, how does reverting even work...?
