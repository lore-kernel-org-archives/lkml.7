Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8DD218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbfCVMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:45:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbfCVMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:45:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 57870260891
Date:   Fri, 22 Mar 2019 08:45:26 -0400
From:   =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Message-ID: <20190322124525.ge5thq4a7c6ufcra@archlinux.localdomain>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
 <20190320220223.GP112750@google.com>
 <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
 <20190322000107.GU112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322000107.GU112750@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, Mar 21, 2019 at 05:01:07PM -0700, Matthias Kaehlcke wrote:
> > ...
> > 
> > So, for a reason that I ignore, if we try to save unecessary calls to
> > ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD (odt_enable has not changed since
> > last call), we get stalled in the call to ROCKCHIP_SIP_CONFIG_SET_RAGE
> > that follows. The function arm_smccc_smc never returns and the device
> > hard hang.
> 
> Thanks for giving it a try!
> 
> Did your code ensure to perform the SMC call for the first frequency
> change? If not the problem could be that the DDR PD timings and ODT
> resistors are not properly configured for the new frequency.
> 

The DRAM_ODT_PD SMC call is supposed to be performed before the
DRAM_SET_RATE; unless someone else is doing the set_rate.

Does the ODT resistors should be configured for every existing
frequency?

> In case you already did this or it doesn't help I think it's fine to
> just do the call always, we can always revisit this later.
> 

Okay, sounds good.

> > Thanks to your remark, I have also fixed an issue with the odt_dis_freq
> > value. Its value is initialized to 0 in the probe function. Thus the
> > odt_enable is always true (target_rate > 0). I moved its initialization
> > after the timings are parsed from the device-tree; its value is now none
> > zero (333000000 in my case).
> 
> Great!

Gael
