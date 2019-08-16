Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5290DC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C722171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfHPOnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:43:35 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42833 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfHPOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:43:35 -0400
Received: from cpe-2606-a000-1405-226e-0-0-0-cbf.dyn6.twc.com ([2606:a000:1405:226e::cbf] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hydRo-0001vH-GH; Fri, 16 Aug 2019 10:43:26 -0400
Date:   Fri, 16 Aug 2019 10:42:45 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID
 bit on AMD family 15h/16h
Message-ID: <20190816144245.GA25489@localhost.localdomain>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190814232434.GA31769@amd>
 <20190815151224.GB18727@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815151224.GB18727@mit.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:12:24AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Aug 15, 2019 at 01:24:35AM +0200, Pavel Machek wrote:
> > Burn it with fire!
> > 
> > I mean... people were afraid RDRAND would be backdoored, and you now
> > confirm ... it indeed _is_ backdoored? /., here's news for you!
> 
> To be fair to AMD, I wouldn't call it a backdoor.  Hanlon's razor is
> applicable here:
> 
> 	"Never attribute to malice that which can be adequately
> 	explained by neglect."
> 
> (Sometimes other words are used instead of neglect, but i'm trying to
> be nice.)
> 
Is it worth setting up a quirk for the Excavator era cpus, that triggers
a call to rdseed on resume?  Working under the assumption that calling
rdseed would kick the rdrand instruction back into gear.

Neil

> 
> 					- Ted
> 
> P.S.   Also applicable:
> 
> 	https://www.youtube.com/watch?v=XZxzJGgox_E
> 
