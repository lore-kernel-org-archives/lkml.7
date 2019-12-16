Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5226920717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QGhs5FcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfLPPLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:11:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4487 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfLPPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:11:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df79e8c0000>; Mon, 16 Dec 2019 07:11:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Dec 2019 07:11:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 07:11:35 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 15:11:35 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 9ECB942762; Mon, 16 Dec 2019 17:11:32 +0200 (EET)
Date:   Mon, 16 Dec 2019 17:11:32 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <allison@lohutok.net>, <pgaikwad@nvidia.com>,
        <mturquette@baylibre.com>, <horms+renesas@verge.net.au>,
        <Jisheng.Zhang@synaptics.com>, <krzk@kernel.org>, <arnd@arndb.de>,
        <spujar@nvidia.com>, <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
Message-ID: <20191216151132.GC28289@pdeschrijver-desktop.Nvidia.com>
References: <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <49da77dc-b346-68eb-9ef8-42cfb3221489@nvidia.com>
 <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
 <6fcbff3d-8695-7cd0-60de-6eb523b6964c@gmail.com>
 <20191211151028.GZ28289@pdeschrijver-desktop.Nvidia.com>
 <0930a710-174b-859b-294c-e9f81f6a3b5e@gmail.com>
 <20191216122005.GB28289@pdeschrijver-desktop.Nvidia.com>
 <53653719-f8e5-f6d1-a1d1-e53c7ccd7636@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53653719-f8e5-f6d1-a1d1-e53c7ccd7636@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576509068; bh=I1odfwufiuiQcheICSY0jJckHTKldkWpkyjJ/8Oh1yo=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=QGhs5FcVVC9cXcbG8mVyS/58pX1r9J7lPBVu+qYUczhyUutwmKxk8BXjKOEodxPNq
         SWD/7lfvn0vVj63lQtSz/LTeCpmW3oOLm40rb50bGYyapKrR38KFLMyHk6YHSsMq+t
         3jOta+DeLHkCU5w2PV0nwAXaZU9yl4IXPPTD/iHHdykkOKP3t87ZEXA6ePfHJ+yAwm
         9DP4WpRbkkOz1TriLmktw3gt/+rLw0QCapYDSoP2PYj5fjSr68r8kAG8nM5FbdyJU6
         b4gp9q43RHeA/M4kHxjl/pbJ88VhM28ga3/0q1niS8ZqLtJeJd7vZQ0aTI+/Q26dcF
         xjIM8Izf/qTRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 05:23:23PM +0300, Dmitry Osipenko wrote:
> >> Could you please clarify what do you mean by the "existing users"?
> >> AFAIK, nothing in kernel uses mux clocks.
> >
> > The DT clk bindings allow for parent initialization, so it's certainly
> > possible there are some DTs which rely on this. We promised to never
> > break the bindings, which changing to 1 clock would do.
> 
> What about this variant:
> 
>   1. Keep the old CaR code in place.
> 
>   2. Make CaR driver to scan whole device-tree for the legacy PMC clocks.
> 
>   3. If legacy clock is found, then register PMC clocks from CaR.
> 
>   4. If legacy clocks are not found, then don't register PMC clocks from
> CaR.
> 
>   5. Add clocks support to the PMC driver and only register them if
> legacy clocks are not registered by CaR.
> 
> Now both old and new DTBs can co-exist and work, everyone happy.

That seems even more work.. Today the only upstream user is audio. 
Currently these clocks are setup by the CAR clock driver. However
as they will move to the PMC driver, this mechanism cannot be used.
Hence the plan is to modify the audio driver to check for the PMC clocks
in DT and if they are not available use the CAR clocks as fallback.
The whole reason the clocks move to the PMC driver, is that when PMC
becomes secure, all accesses have to go via an SMC. Given that we don't
want SMCs all over the Tegra drivers, it's a good opportunity to move
the PMC clock handling into the PMC driver. PMC can be secure with both
'new' and old DTs, so just registering the PMC clocks in the CAR driver
if legacy clocks are found in the DT, won't always work.

Peter.
