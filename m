Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CBC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D281215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfD2Ugf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:36:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:31871 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfD2Ugf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:36:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 13:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="169068219"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 Apr 2019 13:36:31 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 29 Apr 2019 23:36:30 +0300
Date:   Mon, 29 Apr 2019 23:36:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Michael Hirmke <opensuse@mike.franken.de>
Cc:     bhelgaas@google.com, gregkh@linuxfoundation.org, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, lukas@wunner.de, tiwai@suse.de,
        Christian Kellner <ckellner@redhat.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and
 thunderbolt)
Message-ID: <20190429203630.GW2583@lahna.fi.intel.com>
References: <20190429195459.GU2583@lahna.fi.intel.com>
 <EkoOCx3N6GB@mike.franken.de>
 <20190429201347.GV2583@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429201347.GV2583@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:13:47PM +0300, Mika Westerberg wrote:
> On Mon, Apr 29, 2019 at 10:03:00PM +0200, Michael Hirmke wrote:
> > Hi all,
> > 
> > >On Mon, Apr 29, 2019 at 09:47:15PM +0200, Takashi Iwai wrote:
> > >> Hi,
> > 
> > >Hi,
> > 
> > >> we've got a regression report wrt xhci_hcd and thunderbolt on a Dell
> > >> machine.  5.0.7 is confirmed to work, so it must be a regression
> > >> introduced by 5.0.8.
> > >>
> > >> The details are found in openSUSE Bugzilla entry:
> > >>   https://bugzilla.opensuse.org/show_bug.cgi?id=1132943
> > >>
> > [...]
> > >>
> > >> I blindly suspected the commit 3943af9d01e9 and asked for a reverted
> > >> kernel, but in vain.  And now it was confirmed that the problem is
> > >> present with the latest 5.1-rc, too.
> > >>
> > >> I put some people who might have interest and the reporter (Michael)
> > >> to Cc.  If anyone has an idea, feel free to join to the Bugzilla, or
> > >> let me know if any help needed from the distro side.
> > 
> > >Since it exists in 5.1-rcX also it would be good if someone
> > >who see the problem (Michael?) could bisect it.
> > 
> > I know the meaning of bisecting, but I'm not really a developer, so I am
> > probably not able to interpret the results.
> 
> No worries. 
> 
> I'm adding Christian who reported similar (same?) problem last week.
> Christian, this seems to exist in v5.1-rc6 at least. Can you try to
> bisect it on your side?
> 
> I also have XPS 9370 but not that particular dock. I will check tomorrow
> if I can reproduce it as well.

There aren't too many changes between 5.0.7 and 5.0.8 that touch
PCI/ACPI. This is just a shot in the dark but could you try to revert:

  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a

and see if it makes any difference?
