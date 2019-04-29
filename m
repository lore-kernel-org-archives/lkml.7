Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93B721655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfD2UEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:04:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:19850 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbfD2UEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:04:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 12:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="169057392"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 Apr 2019 12:55:00 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 29 Apr 2019 22:54:59 +0300
Date:   Mon, 29 Apr 2019 22:54:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Jiri Slaby <jslaby@suse.cz>,
        Michael Hirmke <opensuse@mike.franken.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and
 thunderbolt)
Message-ID: <20190429195459.GU2583@lahna.fi.intel.com>
References: <s5hy33siofw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy33siofw.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 09:47:15PM +0200, Takashi Iwai wrote:
> Hi,

Hi,

> we've got a regression report wrt xhci_hcd and thunderbolt on a Dell
> machine.  5.0.7 is confirmed to work, so it must be a regression
> introduced by 5.0.8.
> 
> The details are found in openSUSE Bugzilla entry:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1132943
> 
> The probe of xhci_hcd on the dock fails like:
> [    6.269062] pcieport 0000:3a:00.0: enabling device (0006 -> 0007)
> [    6.270027] pcieport 0000:3b:03.0: enabling device (0006 -> 0007)
> [    6.270758] xhci_hcd 0000:3c:00.0: init 0000:3c:00.0 fail, -16
> [    6.270764] xhci_hcd: probe of 0000:3c:00.0 failed with error -16
> [    6.271002] xhci_hcd 0000:3d:00.0: init 0000:3d:00.0 fail, -16
> 
> and later on, thunderbolt gives warnings:
> [   30.232676] thunderbolt 0000:05:00.0: unexpected hop count: 1023
> [   30.232957] ------------[ cut here ]------------
> [   30.232958] thunderbolt 0000:05:00.0: interrupt for TX ring 0 is already enabled
> [   30.232974] WARNING: CPU: 3 PID: 1009 at drivers/thunderbolt/nhi.c:107 ring_interrupt_active+0x1ea/0x230 [thunderbolt]
> 
> 
> I blindly suspected the commit 3943af9d01e9 and asked for a reverted
> kernel, but in vain.  And now it was confirmed that the problem is
> present with the latest 5.1-rc, too.
> 
> I put some people who might have interest and the reporter (Michael)
> to Cc.  If anyone has an idea, feel free to join to the Bugzilla, or
> let me know if any help needed from the distro side.

Since it exists in 5.1-rcX also it would be good if someone
who see the problem (Michael?) could bisect it.
