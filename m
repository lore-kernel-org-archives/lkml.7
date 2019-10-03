Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E3C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE4121D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570109419;
	bh=+vZNSuj5CLm8gcAmu27ZLgAdEbY/2YdMMvRqm8UjGpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rULyUSgQ4BNAXfMYuku3CkYlivfi5BmVj3egweU+Dwiep757PfeMLe5UpgKOPSzj0
	 kf937vzMC/xXAHBh5w0JgKlE7cKCLbpyC0bmhxayck31454DrhwZTetUpIyW0a6bc/
	 FScS/4jDI6L1fncG+rCdVc7wViAmph7+RPbiU34M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfJCNaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbfJCNaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:30:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53D2207FF;
        Thu,  3 Oct 2019 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570109417;
        bh=+vZNSuj5CLm8gcAmu27ZLgAdEbY/2YdMMvRqm8UjGpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3BGEMEZWWnTW+MyQ4U/TofVfzu0O0SxMZ45RD9OMOYdaU0PF9y/zk1yr8yom7599
         SEATzOa5QuObf6Yj7y42d72fe+QRiA5cczVygzrtgTIWLpX6NCswZMBpZWB0lyKoDK
         vggthv0v/96f15LJN8YVUTIrIrm+UPuPML+f/f80=
Date:   Thu, 3 Oct 2019 14:30:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] pinctrl: devicetree: Avoid taking direct
 reference to device name string
Message-ID: <20191003133012.7a64vxj7tz6si56c@willie-the-truck>
References: <20191002124206.22928-1-will@kernel.org>
 <CACRpkdYFzrUT9YE3VvRdWpx-n9szyvoOnEBM7GWLZAv8t1drww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYFzrUT9YE3VvRdWpx-n9szyvoOnEBM7GWLZAv8t1drww@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 02:54:21PM +0200, Linus Walleij wrote:
> On Wed, Oct 2, 2019 at 2:42 PM Will Deacon <will@kernel.org> wrote:
> > When populating the pinctrl mapping table entries for a device, the
> > 'dev_name' field for each entry is initialised to point directly at the
> > string returned by 'dev_name()' for the device and subsequently used by
> > 'create_pinctrl()' when looking up the mappings for the device being
> > probed.
> >
> > This is unreliable in the presence of calls to 'dev_set_name()', which may
> > reallocate the device name string leaving the pinctrl mappings with a
> > dangling reference. This then leads to a use-after-free every time the
> > name is dereferenced by a device probe:
> >
> >   | BUG: KASAN: invalid-access in strcmp+0x20/0x64
> >   | Read of size 1 at addr 13ffffc153494b00 by task modprobe/590
> >   | Pointer tag: [13], memory tag: [fe]
> >   |
> >   | Call trace:
> >   |  __kasan_report+0x16c/0x1dc
> >   |  kasan_report+0x10/0x18
> >   |  check_memory_region
> >   |  __hwasan_load1_noabort+0x4c/0x54
> >   |  strcmp+0x20/0x64
> >   |  create_pinctrl+0x18c/0x7f4
> >   |  pinctrl_get+0x90/0x114
> >   |  devm_pinctrl_get+0x44/0x98
> >   |  pinctrl_bind_pins+0x5c/0x450
> >   |  really_probe+0x1c8/0x9a4
> >   |  driver_probe_device+0x120/0x1d8
> >
> > Follow the example of sysfs, and duplicate the device name string before
> > stashing it away in the pinctrl mapping entries.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Reported-by: Elena Petrova <lenaptr@google.com>
> > Tested-by: Elena Petrova <lenaptr@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Patch applied, sorry for not getting back to you earlier.

No need to apologise -- I posted it during the merge window!

> The fact that dev_set_name() is reallocating the name is a bit
> scary, it doesn't feel super-stable, but I suppose there is some
> particularly good reason for it.
> 
> I guess the look-up table still refers to the struct device *
> directly so pin control functionality will work, but the pin controller
> device name down in /sys/kernel/debug/pinctrl
> is going to be bogus, am I right? Like the name given there
> will be whatever the name was before the call to dev_set_name().

Yeah, but I think that's a least consistent with other sysfs entries
(i.e. those created by driver_sysfs_add()) so callers of dev_set_name()
need to be super careful about how they use it. In reality, it's going
to be mostly confined to bus code, but copying the string (as in this
patch) avoids pinctrl being the thing that blows up.

Will
