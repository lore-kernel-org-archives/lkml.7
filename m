Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9CC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DE2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578605295;
	bh=MVQAFuSK/znUaCoajAc217ef+ZPDs7lKioDCMfzi/LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zd2bnQoPjiDVY/9impCrJW181e9pph8pxf6ZynU6bbuGPrEVpSZMYcQQ9Zdzyc/ax
	 CtTWE4DTUF1dt8Uu1O9Vo9mgF5o8c4GtV26/vpxN0Mkvojj9snSvZahL7q5A2VcT+R
	 JF0c5CtWCJ8HrIQ52/k2lRW8rnwwuuP/+D3oflSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgAIV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:28:14 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35680 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:28:14 -0500
Received: by mail-wr1-f41.google.com with SMTP id g17so9003129wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gB1RyhHtTQ+0s49bn15C7GeS8pX+9LNGVaVb1fuNcDI=;
        b=ltTqTJ2ga31fvB4Rmlw1tLP+UwDfe33U1U0vCua8WSOme48ZKf37l0vqRP2abw4S6l
         3sQ/q7DFA6lU+WHd1X+diLsIIhyEe5Pn3tuRqSMcI0BbpR7ieQz3wcaZvKpTyVUvjhTg
         VBL48pQiitpShc2bsmNswbna7S3uKFYC+sx4wuJ60WZqF4gZt5PNhwYWL6RCnNXotdbG
         boguOaI56IhRhtNhwdfjSBO8kUi29BvhtNqRigpzWB54MOxUwvUhvz28JzYNqo4v6O1D
         yvMbELx7q7kcIBdzfEzBNkc+XSMKpmf+so2yL0Qx/eyiqwCLZTqY4s0xJAKeno1iw2Df
         zhEQ==
X-Gm-Message-State: APjAAAV7nsSfYzYQFE6/VGqe37/tuaA4bxtPwezrUW4koLhyUP5dd8JC
        qEfKruXmaE4O1IOPaUXiiOOuEgZx
X-Google-Smtp-Source: APXvYqwO+ulr8Tt8Z+t+GNTy8Emz4YPzNlUPFTfJHu6q5twl2eR5obmCRkLLYDpKcEuNLan/EZNlwA==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr13654938wrq.199.1578605292416;
        Thu, 09 Jan 2020 13:28:12 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id z4sm4225820wma.2.2020.01.09.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:28:11 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:28:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109212810.GB23620@dhcp22.suse.cz>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210535.GB1553@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109210535.GB1553@duo.ucw.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 22:05:36, Pavel Machek wrote:
> On Thu 2020-01-09 12:56:33, Michal Hocko wrote:
> > On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I updated my userspace to x86-64, and now chromium likes to eat all
> > > the memory and bring the system to standstill.
> > > 
> > > Unfortunately, OOM killer does not react:
> > > 
> > > I'm now running "ps aux", and it prints one line every 20 seconds or
> > > more. Do we agree that is "unusable" system? I attempted to do kill
> > > from other session.
> > 
> > Does sysrq+f help?
> > 
> > > Do we agree that OOM killer should have reacted way sooner?
> > 
> > This is impossible to answer without knowing what was going on at the
> > time. Was the system threshing over page cache/swap? In other words, is
> > the system completely out of memory or refaulting the working set all
> > the time because it doesn't fit into memory?
> 
> What statistics are best to collect? Would the memory lines from top
> do the trick? I normally have gkrellm running, but I found its results
> hard to interpret.

/proc/vmstat (and collecting it periodically) gives the most
comprehensive picture about the state of MM. Interpreting numbers is far
from trivial though. It requires to analyze multiple snapshots usually
to see how the situation evolves.

-- 
Michal Hocko
SUSE Labs
