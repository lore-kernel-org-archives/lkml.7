Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB0AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA322084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfJDIMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:12:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:7176 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDIMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:12:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="205803473"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 01:12:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 04 Oct 2019 11:12:30 +0300
Date:   Fri, 4 Oct 2019 11:12:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
Message-ID: <20191004081230.GE1048@kuha.fi.intel.com>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
 <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:51:38PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 03-10-2019 22:37, John Stultz wrote:
> > On Thu, Oct 3, 2019 at 2:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
> > > On 03-10-2019 01:16, John Stultz wrote:
> > > > From: Yu Chen <chenyu56@huawei.com>
> > > > 
> > > > This patch adds notifier for drivers want to be informed of the usb role
> > > > switch.
> > > 
> > > I do not see any patches in this series actually using this new
> > > notifier.
> > > 
> > > Maybe it is best to drop this patch until we actually have in-kernel
> > > users of this new API show up ?
> > 
> > Fair point. I'm sort of taking a larger patchset and trying to break
> > it up into more easily reviewable chunks, but I guess here I mis-cut.
> > 
> > The user is the hikey960 gpio hub driver here:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?id=b06158a2d3eb00c914f12c76c93695e92d9af00f
> 
> Hmm, that seems to tie the TypeC data-role to the power-role, which
> is not going to work with role swapping.
> 
> What is controlling the usb-role-switch, and thus ultimately
> causing the notifier you are suggesting to get called ?
> 
> Things like TYPEC_VBUS_POWER_OFF and TYPEC_VBUS_POWER_ON
> really beg to be modeled as a regulator and then the
> Type-C controller (using e.g. the drivers/usb/typec/tcpm/tcpm.c
> framework) can use that regulator to control things.
> in case of the tcpm.c framework it can then use that
> regulator to implement the set_vbus callback.
> 
> You really do not want to tie this do the usb_switch, both
> because doing so ties the data and power-roles together
> which is not supposed to happen and because role-swapping
> requires careful timing of the VBUS on / off at different
> moments then the moments when you actually set the mux/switch
> for connecting the Dp/Dn lines to the host or gadget
> controller.
> 
> The usb role switch abstraction is really only intended
> for the data-lines switch and should not be tied together
> with other stuff.

Hear, hear.

-- 
heikki
