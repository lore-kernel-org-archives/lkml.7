Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759C020715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKNPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:24:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:53782 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKNPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:24:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 07:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="214560986"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 14 Nov 2019 07:24:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 14 Nov 2019 17:24:32 +0200
Date:   Thu, 14 Nov 2019 17:24:32 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jon Flatley <jflat@chromium.org>
Cc:     Benson Leung <bleung@google.com>, enric.balletbo@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        sre@kernel.org, Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 0/3] ChromeOS EC USB-C Connector Class
Message-ID: <20191114152432.GD4013@kuha.fi.intel.com>
References: <20191113031044.136232-1-jflat@chromium.org>
 <20191113175127.GA171004@google.com>
 <20191113182537.GC4013@kuha.fi.intel.com>
 <CACJJ=pxba6=SR=kWO-vgqU=wkj7gnVAm62b2tcYf2K+1ucySRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACJJ=pxba6=SR=kWO-vgqU=wkj7gnVAm62b2tcYf2K+1ucySRg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Wed, Nov 13, 2019 at 05:09:56PM -0800, Jon Flatley wrote:
> > I'll go over these tomorrow, but I have one question already. Can you
> > guys influence what goes to the ACPI tables?
> >
> > Ideally every Type-C connector is always described in its own ACPI
> > node (or DT node if DT is used). Otherwise getting the correct
> > capabilities and especially connections to other devices (like the
> > muxes) for every port may get difficult.
> 
> Hey Heikki, thank you for your quick response!
> 
> In general we do have control over the ACPI tables and over DT. The
> difference for ChromeOS is that the PD implementation and policy
> decisions are handled by the embedded controller. This includes
> alternate mode transitions and control over the muxes. I don't believe
> there is any information about port capabilities in ACPI or DT, that's
> all handled by the EC. With current EC firmware we are mostly limited
> to querying the EC for port capabilities and state. There may be some
> exceptions to this, such as with Rockchip platforms, but even then the
> EC is largely in control.

The capabilities here mean things like is the port: source, sink or
DRP; host, device or DRD; etc. So static information.

I do understand that the EC is in control of the Port Controller (or
PD controller), the muxes, the policy decisions and what have you, and
that is fine. My point is that the operating system should not have to
get also the hardware description from the EC. That part should always
come from ACPI tables or DT, even when the components are attached to
the EC instead of the host CPU. Otherwise we loose scalability for no
good reason.

Note. The device properties for the port capabilities are already
documented in kernel:
Documentation/devicetree/bindings/connector/usb-connector.txt (the
same properties work in ACPI as well).

> I think you raise a valid point, but such a change is probably out of
> scope for this implementation.

This implementation should already be made so that it works with a
properly prepared ACPI tables or DT. If there are already boards that
don't supply the nodes in ACPI tables for the ports, then software
nodes can be used with those, but all new boards really should have a
real firmware node represeting every Type-C port.

thanks,

-- 
heikki
