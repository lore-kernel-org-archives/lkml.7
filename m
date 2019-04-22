Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B116C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70ED20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfDVTk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:40:56 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:52584 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbfDVTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:40:56 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hIeo9-00036W-LK; Mon, 22 Apr 2019 21:40:53 +0200
Date:   Mon, 22 Apr 2019 21:40:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Andreas Hartmann <andihartmann@freenet.de>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 13/99] netfilter: nf_conncount: fix argument order
 to find_next_bit
Message-ID: <20190422194053.k6h4cunlfpjlt5wk@breakpoint.cc>
References: <20190121134913.924726465@linuxfoundation.org>
 <20190121134914.421023706@linuxfoundation.org>
 <f55ad830-dd61-8ce2-7fa0-d33fb93c0b9c@01019freenet.de>
 <20190422172732.sneybhuwrreb7g2u@breakpoint.cc>
 <c9211352-3da4-6cb6-cd71-be0b9c0248d7@01019freenet.de>
 <20190422185710.3la4ayzxslafxwbn@breakpoint.cc>
 <47f69e73-8104-aa58-44f2-b0d8fafd9e91@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f69e73-8104-aa58-44f2-b0d8fafd9e91@maya.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@freenet.de> wrote:
> On 22.04.19 at 20:57 Florian Westphal wrote:
> > grep CONNCOUNT ~/your_kernel_conf
> 
> True - it's not in use (it's not even configured) at all. I'm surprised that it seems to fix the problem anyway.

Thats usually the main problem when testing for a bug that doesn't
appear often -- its too easy to get bisections wrong and end up
with false positives.

> If I can't see it any more - I wouldn't know what to do any further at the moment.

You could try enabling some of the debug features, such as
CONFIG_PROVE_{LOCKING,RCU}.

It would e.g. tell if we forget an unlock somewhere.
