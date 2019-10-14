Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9B3ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD0920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfJNJiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:38:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64170 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbfJNJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:38:16 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 4db2488d3af89f8f; Mon, 14 Oct 2019 11:38:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] ACPI / processor_idle: use dead loop instead of io port access for wait
Date:   Mon, 14 Oct 2019 11:38:13 +0200
Message-ID: <3727681.FYoUZqeJdN@kreacher>
In-Reply-To: <8a65bf97-c066-8e5e-ba82-75e2a6fd5b45@intel.com>
References: <20190909073937.31554-1-fengwei.yin@intel.com> <12278756.3dKznOqol2@kreacher> <8a65bf97-c066-8e5e-ba82-75e2a6fd5b45@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 11, 2019 3:30:41 PM CEST Yin, Fengwei wrote:
> 
> On 10/11/2019 5:05 PM, Rafael J. Wysocki wrote:
> > Sorry for the delay.
> No problem.
> 
> > 
> > On Monday, September 9, 2019 9:39:37 AM CEST Yin Fengwei wrote:
> >> In function acpi_idle_do_entry(), we do an io port access to guarantee
> >> hardware behavior. But it could trigger unnecessary vmexit for
> >> virtualization environemnt.
> > 
> > Is this a theoretical problem, or do you actually see it?
> > 
> > If you see it, I'd like to have a pointer to a bug report regarding it
> > or similar.
> We did see this issue when we run linux as guest with ACRN hypervisor
> instead of kvm or xen. In our case, we export all native C states to
> guest and let guest choose which C state it will enter.
> 
> And we observed many pm timer port access when guest tried to enter
> deeper C state (Yes, we emulate pm timer so pm timer access will trigger
> vmexit).

Can you please put this information into the changelog of your patch?

It works very well as a rationale for me. :-)



