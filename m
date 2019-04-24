Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92376C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A26B2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDXASn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:18:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:18963 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfDXASm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:18:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 17:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="340208899"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2019 17:18:41 -0700
Date:   Tue, 23 Apr 2019 17:18:41 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Takashi Iwai <tiwai@suse.de>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.0.x] Windows XP broken on KVM
Message-ID: <20190424001841.GA14422@linux.intel.com>
References: <s5hy347pxtf.wl-tiwai@suse.de>
 <f1b93e90-edf2-f3ba-4d94-652929e6cca6@redhat.com>
 <20190423202317.GA15182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423202317.GA15182@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:23:17PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2019 at 09:56:02AM +0200, Paolo Bonzini wrote:
> > On 18/04/19 09:38, Takashi Iwai wrote:
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
> > No, it's the first time I hear this and I actually test Windows XP
> > before every pull request I send to Linus...  I'll download 5.0.x and
> > test it there.
> 
> Any further ideas about this?

I followed up on the bugzilla to request more information.  My best guess
at this point is that the issue is related to an older version of Qemu or
a specific emulated device, but without additional details we're stuck.
