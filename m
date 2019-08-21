Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2627C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05CA22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+fxuq7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHUJj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:39:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45060 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfHUJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gCBb7L/sreEf1Yet44viQo6XfjMADbPYNqurZw86tOk=; b=e+fxuq7DHwEAQ30fR7RAVWFfu
        mY4jn1XsKCNOqdgfIaWYi+6T0YU7AVo6aYEwyQzSKmij3jniNyetqN4ffLbVoVLVblRZ/gPTBBecW
        TMR2SaU29YZH0z6fV88WGcRXdK3PDVUJ1qkYtDyUkSIh0/TXnkSFy+ymjDEIuNAe/hoeA2IsGju03
        fHX4Jj7PxtVLxvvfQ5CleeJ0BtEWLz5i0GQ0KHQQkBtsQfmwoAHP58jSwNZbKJi/8cisj4PZkWOYJ
        yUh5pNFZKWAwNIJXP726vdBaAvE+yNXJHOjxYTWHyEeQdpls1WGel0iGo3CIbXbwUYP1gm77b2Ad3
        NNcsZgSOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0N5F-0004SB-NN; Wed, 21 Aug 2019 09:39:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE694307456;
        Wed, 21 Aug 2019 11:38:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34CE020B342A3; Wed, 21 Aug 2019 11:39:10 +0200 (CEST)
Date:   Wed, 21 Aug 2019 11:39:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Message-ID: <20190821093910.GW2349@hirez.programming.kicks-ass.net>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
 <0a0ce209-697f-a20c-6be8-f3b7f683c978@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0ce209-697f-a20c-6be8-f3b7f683c978@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:21:43AM +0800, Tanwar, Rahul wrote:
> On 20/8/2019 10:57 PM, Peter Zijlstra wrote:

> > What would describe the special sause that warranted a new SOC? If this
> > thing is marketed as 'Network Processor' then I suppose we can actually
> > use it, esp. if we're going to see this more, like the MID thing -- that
> > lived for a while over multiple uarchs.

> This SoC uses AMT (Admantium/Airmont) configuration which is supposed to be
> a higher configuration.

That's just words without meaning on this end. What's an Adamantium ?
Google doesn't seem to give any sort of clues..

And will we see more of these things, or is it a one off SOC?

> Looking at other existing examples, it seems that
> INTEL_FAM6_ATOM_AIRMONT_PLUS is most appropriate. Would you have any
> concerns with _PLUS name ? Thanks.

Yes, _PLUS is not an existing _OPTDIFF, the uarch is called "Goldmont
Plus", it is the 14nm refresh of the 14nm Goldmont, and predecessor of
Tremont.
