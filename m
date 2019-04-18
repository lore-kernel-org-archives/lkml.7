Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A779AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8064A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDRXbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:31:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:4701 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfDRXbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:31:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 16:31:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; 
   d="scan'208";a="150578893"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2019 16:31:20 -0700
Date:   Thu, 18 Apr 2019 16:31:20 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.0.x] Windows XP broken on KVM
Message-ID: <20190418233119.GF17218@linux.intel.com>
References: <s5hy347pxtf.wl-tiwai@suse.de>
 <20190418075328.GA19532@kroah.com>
 <s5hr29zpwkx.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr29zpwkx.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:05:34AM +0200, Takashi Iwai wrote:
> On Thu, 18 Apr 2019 09:53:28 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Thu, Apr 18, 2019 at 09:38:52AM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > we've got a regression report on the recent 5.0.x kernel, starting
> > > from 5.0.6, where Windows XP can't boot on KVM any longer.
> > > 
> > > The culprit seems to be the patch
> > >    KVM: x86: update %rip after emulating IO
> > > with the upstream commit 45def77ebf79e2e8942b89ed79294d97ce914fa0.
> > > Reverting this alone fixed the problem.
> > > 
> > > The report is found at openSUSE bugzilla:
> > >   https://bugzilla.suse.com/show_bug.cgi?id=1132694
> > > 
> > > Is there already a followup fix?  If not, we need to revert it from
> > > stable, at least.
> > 
> > Is this also a problem in 5.1-rc5?
> 
> Only 5.0.x has been tested, so far.
> I'll ask the reporter to try 5.1-rc if Paolo can't reproduce the
> problem in his side.

I'd be surprised if 5.1-rc* changes anything relative to 5.0.x, the
commit in question is fairly isolated and specific.

Can we get the Qemu version and command line that is being run?
