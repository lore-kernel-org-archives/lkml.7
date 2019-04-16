Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E494C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86820857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="SiQvXxeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfDPK0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:26:00 -0400
Received: from chill.innovation.ch ([216.218.245.220]:42980 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDPKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:25:57 -0400
Date:   Tue, 16 Apr 2019 03:25:55 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 625CD64012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555410355;
        bh=EoGiwl0PWlaXXLjV0bLg+h9eAIKVM8ffZfoe47BF1CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiQvXxeuvzQFodJCACo5aVIvPxfZ6mAllv6qOeZmAHKcnbsef7Y6EDKS5sDz3DAU+
         KZLOG6a0i1oKXXRZaMRhOWjjbtdhJKwWLkhHe9K6ESn6RLtNqByOYOqtUAR9sWtzMK
         V44/TUwh0wpMCZqbRWELiC/qd/2tI1AnIT4lDWw+ro3nvD2Bi0HdvqEMVn+c/cnHKh
         0xflPrTAf9jF+Tils+Er4Kv1HufN2E5S+Wqj5tT5Drw7Sctjm9KQUlb/b4E0PwBZPR
         +7HeOqODMXTPTig4wS2NwdsOdH6tj9oCRb6TUtJ8v9qt4Ud47dZEAbM0JR5i3PbsyO
         4/KhevB3PiPSQ==
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
Message-ID: <20190416102555.GA20093@innovation.ch>
References: <20190415081300.24831-1-ronald@innovation.ch>
 <CGME20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac@epcas2p4.samsung.com>
 <20190415081300.24831-2-ronald@innovation.ch>
 <76cf3079-f190-bed4-7a00-149d7fa0a650@samsung.com>
 <20190415232444.GB13033@innovation.ch>
 <dd5189a2-8422-5e3c-1c79-d68680117deb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd5189a2-8422-5e3c-1c79-d68680117deb@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Andrzej,

On Tue, Apr 16, 2019 at 07:56:31AM +0200, Andrzej Hajda wrote:
> On 16.04.2019 01:24, Life is hard, and then you die wrote:
> >   Hi Andrzej,
> >
> > On Mon, Apr 15, 2019 at 10:58:09AM +0200, Andrzej Hajda wrote:
> >> On 15.04.2019 10:12, Ronald Tschalär wrote:
> >>> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> >>> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> >>> However, this causes problems with other drivers, in particular an input
> >>> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> >>> commit):
> >>>
> >>>   drivers/clk/Kconfig:9:error: recursive dependency detected!
> >>>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> >>>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> >>>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> >>>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> >>>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> >>>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> >>>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> >>>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> >>>
> >>> According to the docs and general consensus, select should only be used
> >>> for non user-visible symbols, but both RC_CORE and INPUT are
> >>> user-visible. Furthermore almost all other references to INPUT
> >>> throughout the kernel config are depends, not selects. For this reason
> >>> the first part of this change reverts commit d6abe6df706c.
> >>>
> >>> In order to address the original reason for commit d6abe6df706c, namely
> >>> that not all boards use the remote controller functionality and hence
> >>> should not need have to deal with RC_CORE, the second part of this
> >>> change now makes the remote control support in the driver optional and
> >>> contingent on RC_CORE being defined. And with this the hard dependency
> >>> on INPUT also goes away as that is only needed if RC_CORE is defined
> >>> (which in turn already depends on INPUT).
> >>>
> >>> CC: Inki Dae <inki.dae@samsung.com>
> >>> CC: Andrzej Hajda <a.hajda@samsung.com>
> >>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> >>
> >> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > Thanks for your reviews!
> >
> >> If there are no objections I will take it to drm-misc tomorrow.
> > This brings us back to the discussion started in response to the first
> > version of my patch (see
> > https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#m24f45fecd987a787a9554c8088f463fd10de2b00).
> > To recap: the problem is that the applespi patch depends on this patch
> > here, as make-config will break as described above otherwise. So if
> > this patch is submitted through drm-misc, then it's unclear to me how
> > to ensure that the two patches make it upstream in proper order,
> > unless the applespi patch is also upstreamed through drm-misc, or the
> > Kconfig for applespi is (temporarily) modified to not trigger the
> > config error and another patch is later submitted to fix the Kconfig
> > again (which seems somewhat ugly to me). Assuming that consensus is to
> > merge both patches through one tree, then it would seem that because
> > this patch here is relatively small that maybe it could be merged
> > through the input tree along with the applespi patch?
> 
> 
> Oh, I have forgot. Please take it then via input tree.

Thank you!


  Cheers,

  Ronald

