Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E556C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23298214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572993325;
	bh=obXGr+HMrmxd7Nmv6mAkE997rAhvMoJlZpQK/LBMCVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=yo4HsfBszhDZYNivVk57Oh1FCyNP6YKFxzcdL2OTyL2HOOeRW2NcrqvTB6DOv85+Q
	 +TfgoGuq+zkmU+4rJU0p3TLbSpX5MDMis3QPYGgv4IhcPoSkCdeVSJhZ+PHrYVV4K3
	 njTYP9H87BFfB+QeMTSbpqfc2EgV05i8/Kn9/Btk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfKEWfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfKEWfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:35:23 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C87F82084D;
        Tue,  5 Nov 2019 22:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572993323;
        bh=obXGr+HMrmxd7Nmv6mAkE997rAhvMoJlZpQK/LBMCVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pUFZzO3CGkdSQICBgk9ndn6MvjXjomf/SYb2AlmxvtI6UOeu4T1otst591nBPw7oG
         dyB6L9sResxmZwPC9HexXIfU0XghcGTCFnwuGptcJBaORk68x/49t9t/2H7XWY44th
         pVHyWfll2MYSoSmXgKRLNxWmCucEYg+1O0N507sc=
Date:   Tue, 5 Nov 2019 16:35:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Message-ID: <20191105223521.GA42216@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3568330.mzdaIbGaoM@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 12:28:47PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 5, 2019 11:11:57 AM CET Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This series rearranges some PCI power management code to make it somewhat
> > easier to follow and explicitly consolidate the power-up (transitions to
> > D0) code path.
> > 
> > It is not intended to change the functionality of the code.
> 
> This series applies on top of 5.4-rc6 with your pci/pm-2 branch from today
> merged on top of it.
> 
> I guess I can make it apply on top of pci/pm-2, but there were some PCI PM
> changes in 5.4-rc later than -rc1 in that area and they need to be taken
> into account anyway.

I applied the commits from pci/pm-2 to pci/pm (pci/pm-2 was really
just to get the 0-day robot to build test it).

pci/pm is based on v5.4-rc1, which doesn't have 45144d42f299 ("PCI:
PM: Fix pci_power_up()"), which appeared in -rc4.

All my branches are based on -rc1.  I *could* rebase them all to -rc4,
but that's quite a bit of work and affects Lorenzo as well, so I'd
rather not.  What's the git expert's way of doing this?

I guess worst case I could rebase this series to apply on pci/pm
(-rc1-based), accept that Linus will see a conflict, and resolve it
during his merge.

Bjorn
