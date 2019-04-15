Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E204C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC95D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="WtvXLRmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfDOXYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:24:45 -0400
Received: from chill.innovation.ch ([216.218.245.220]:58374 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfDOXYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:24:44 -0400
Date:   Mon, 15 Apr 2019 16:24:44 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 129C5640133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555370684;
        bh=n0g9qlwDf4pZRD6d0RrBxPByw6DAdhe8qSuIDBPnixg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtvXLRmpFWKhTZL1L4lexYacxn6sZjlyYzr+hl7npJZ4AxzTi22PEXze9bWM3CCai
         /FY/B6+HDZvotqKdfdWMPCpFqFiAGu/dKjSYqvWytTT8y8we3SYE0LUDR664usQVOj
         pIO9zTYDsM5wwSOzzDLo2SfV6jLgS68wBm8vhvHNetU/PnSqVowrIkx7WHR1XuVHB4
         5g4clyV0rX0c72V9I2YbWVhSPmCIE4nlLkRr2E+DypuXJIEorSdfr1URxa/mj8+DK3
         tD6C4qzhG2oyypG0gm8mZQKNZRahr/XbxQ5s9WBQVbQWAlijYMb8PdJatO2emZAiDI
         jQX7zxtLQg9Kg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Inki Dae <inki.dae@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
Message-ID: <20190415232444.GB13033@innovation.ch>
References: <20190415081300.24831-1-ronald@innovation.ch>
 <CGME20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac@epcas2p4.samsung.com>
 <20190415081300.24831-2-ronald@innovation.ch>
 <76cf3079-f190-bed4-7a00-149d7fa0a650@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76cf3079-f190-bed4-7a00-149d7fa0a650@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Andrzej,

On Mon, Apr 15, 2019 at 10:58:09AM +0200, Andrzej Hajda wrote:
> On 15.04.2019 10:12, Ronald Tschalär wrote:
> > commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> > of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> > However, this causes problems with other drivers, in particular an input
> > driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> > commit):
> >
> >   drivers/clk/Kconfig:9:error: recursive dependency detected!
> >   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> >   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> >   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> >   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> >   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> >   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> >   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> >   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> >
> > According to the docs and general consensus, select should only be used
> > for non user-visible symbols, but both RC_CORE and INPUT are
> > user-visible. Furthermore almost all other references to INPUT
> > throughout the kernel config are depends, not selects. For this reason
> > the first part of this change reverts commit d6abe6df706c.
> >
> > In order to address the original reason for commit d6abe6df706c, namely
> > that not all boards use the remote controller functionality and hence
> > should not need have to deal with RC_CORE, the second part of this
> > change now makes the remote control support in the driver optional and
> > contingent on RC_CORE being defined. And with this the hard dependency
> > on INPUT also goes away as that is only needed if RC_CORE is defined
> > (which in turn already depends on INPUT).
> >
> > CC: Inki Dae <inki.dae@samsung.com>
> > CC: Andrzej Hajda <a.hajda@samsung.com>
> > CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> 
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks for your reviews!

> If there are no objections I will take it to drm-misc tomorrow.

This brings us back to the discussion started in response to the first
version of my patch (see
https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#m24f45fecd987a787a9554c8088f463fd10de2b00).
To recap: the problem is that the applespi patch depends on this patch
here, as make-config will break as described above otherwise. So if
this patch is submitted through drm-misc, then it's unclear to me how
to ensure that the two patches make it upstream in proper order,
unless the applespi patch is also upstreamed through drm-misc, or the
Kconfig for applespi is (temporarily) modified to not trigger the
config error and another patch is later submitted to fix the Kconfig
again (which seems somewhat ugly to me). Assuming that consensus is to
merge both patches through one tree, then it would seem that because
this patch here is relatively small that maybe it could be merged
through the input tree along with the applespi patch?


  Cheers,

  Ronald

