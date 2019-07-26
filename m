Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A121901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfGZQUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:45268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbfGZQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="194315334"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2019 09:20:44 -0700
Date:   Fri, 26 Jul 2019 09:20:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [VDSO] [x86_32] v5-3-rc1 needs vdso32=0 to get systemd-journald
 running
Message-ID: <20190726162044.GA5978@linux.intel.com>
References: <618de21a4510f20f1b38a894517b5e9011f0da69.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618de21a4510f20f1b38a894517b5e9011f0da69.camel@tiscali.nl>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 06:13:54PM +0200, Paul Bolle wrote:
> My first attempts to boot v5.3-rc1 on my (ancient) ThinkPad X41 made systemd-
> journald crash. I kept ending up with nasty my messages on the console:
> 
>          Starting Journal Service...
> [...]
> [    7.143552] systemd-journald[213]: Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at ../src/basic/time-util.c:55, function now(). Aborting.
> [FAILED] Failed to start Journal Service.
> See 'systemctl status systemd-journald.service' for details.
> [    7.220367] systemd-coredump[217]: Cannot resolve systemd-coredump user. Proceeding to dump core as root: No such process
> [  OK  ] Stopped Journal Service.
> 
> And without systemd-journald I couldn't get userspace up and running.
> 
> A bit of tinkering showed that "vdso32=0" on the kernel command line allows me
> to get a usable userspace.
> 
> Any idea where I should look next to pinpoint this?

More than likely it's this:

https://lkml.kernel.org/r/20190719170343.GA13680@linux.intel.com
