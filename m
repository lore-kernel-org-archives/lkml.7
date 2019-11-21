Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B69C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65628206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKUUfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:35:16 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:56004 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbfKUUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:35:16 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iXtAX-0007QM-OX; Thu, 21 Nov 2019 21:35:13 +0100
Date:   Thu, 21 Nov 2019 21:35:13 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 233/422] netfilter: nf_tables: avoid BUG_ON usage
Message-ID: <20191121203513.GJ20235@breakpoint.cc>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119051414.205983228@linuxfoundation.org>
 <20191121201618.GB15106@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121201618.GB15106@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@denx.de> wrote:
> This goes from "kill kernel with backtrace" to "silently return
> failure". Should WARN_ON() be preserved here?

No need.  The error would propagate back to userspace via nfnetlink.

So it would be 'running this command fails with error x' vs.
'running this command makes kernel crash'.

That being said, I did not observe this BUG from triggering, ever.
I only removed it because I did not see any reason for it.
