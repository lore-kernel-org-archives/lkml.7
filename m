Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA58C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A72E21734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564066506;
	bh=GrXVjWAVvN2gz6eFwJLndRnWEQThXUtatV7HHHWg/CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UZ5SMs9LSj7VSpzJhF6BrK4m3lC0Et+0kmOEj53zPiS0v8YdvlyAL3U8/G5l3Wld7
	 cxRNErO+24VTYUFbZonoNXEhNxuc9OkaWzs2SUBZPwuTVdvHpOkbSQZfOdrGXty9Me
	 LG2SXiviD+b+5hVSBgpyb+sFISrOWw4RXP3r61Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfGYOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:55:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:21779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbfGYOzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:55:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 07:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="177989924"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jul 2019 07:55:03 -0700
Date:   Thu, 25 Jul 2019 08:52:10 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190725145209.GA6949@localhost.localdomain>
References: <2332799.izEFUvJP67@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2332799.izEFUvJP67@kreacher>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:51:41AM -0700, Rafael J. Wysocki wrote:
> Hi Keith,
> 
> Unfortunately,
> 
> commit d916b1be94b6dc8d293abed2451f3062f6af7551
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Thu May 23 09:27:35 2019 -0600
> 
>     nvme-pci: use host managed power state for suspend
> 
> doesn't universally improve things.  In fact, in some cases it makes things worse.
> 
> For example, on the Dell XPS13 9380 I have here it prevents the processor package
> from reaching idle states deeper than PC2 in suspend-to-idle (which, of course, also
> prevents the SoC from reaching any kind of S0ix).
> 
> That can be readily explained too.  Namely, with the commit above the NVMe device
> stays in D0 over suspend/resume, so the root port it is connected to also has to stay in
> D0 and that "blocks" package C-states deeper than PC2.
> 
> In order for the root port to be able to go to D3, the device connected to it also needs
> to go into D3, so it looks like (at least on this particular machine, but maybe in
> general), both D3 and the NVMe-specific PM are needed.
> 
> I'm not sure what to do here, because evidently there are systems where that commit
> helps.  I was thinking about adding a module option allowing the user to override the
> default behavior which in turn should be compatible with 5.2 and earlier kernels.

Darn, that's too bad. I don't think we can improve one thing at the
expense of another, so unless we find an acceptable criteria to select
what low power mode to use, I would be inclined to support a revert or
a kernel option to default to the previous behavior.

One thing we might check before using NVMe power states is if the lowest
PS is non-operational with MP below some threshold. What does your device
report for:

  nvme id-ctrl /dev/nvme0

?
