Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FB6206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nM/NgqQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLPMUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:20:11 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7690 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfLPMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:20:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df7766f0000>; Mon, 16 Dec 2019 04:19:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Dec 2019 04:20:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 04:20:08 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 12:20:07 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 944924280E; Mon, 16 Dec 2019 14:20:05 +0200 (EET)
Date:   Mon, 16 Dec 2019 14:20:05 +0200
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
Message-ID: <20191216122005.GB28289@pdeschrijver-desktop.Nvidia.com>
References: <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
 <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
 <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <49da77dc-b346-68eb-9ef8-42cfb3221489@nvidia.com>
 <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
 <6fcbff3d-8695-7cd0-60de-6eb523b6964c@gmail.com>
 <20191211151028.GZ28289@pdeschrijver-desktop.Nvidia.com>
 <0930a710-174b-859b-294c-e9f81f6a3b5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0930a710-174b-859b-294c-e9f81f6a3b5e@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576498800; bh=b7XXctcmXb2fLo5udKQt//zAFp8PM7nufwkYOLIsnKo=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=nM/NgqQUcSdZRcFF7d0Yn96EQPMCJJewZs/5fXVF74Go86ZnMyQwERe7ZTQTnlbfj
         ZcvR6MojJdcvYsx4lauCFN2Ya+MLViVVuzS34lOkzq1S2prnU5TqXaZCv+5edNo1SM
         Km5wJjXWUiokMRJK2NPDugSZinOdkdcXkkonttZB2qxecYprJ0V9NbkzCFVPYF0Zq9
         TcXUgZihL0RnrDL3rgiLkB24ZO94eZg1Jtu6Ly4DWyZO4bHT/MVPbIYQ4piIV7pxtR
         /fuo+JDplJ5G9jQjchl9xQzDko/KvOOvOsLoLn7UMbIgo6dekW5fXziGIF2jY+6rAS
         mQEZWXAt/zm6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 04:43:53AM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> 11.12.2019 18:10, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Dec 10, 2019 at 08:41:56PM +0300, Dmitry Osipenko wrote:
> >
> > ..
> >
> >>>
> >>> PMC clock gate is based on the state of CLKx_ACCEPT_REQ and FORCE_EN
> >>> like explained above.
> >>>
> >>> CLKx_ACCEPT_REQ is 0 default and FORCE_EN acts as gate to enable/disa=
ble
> >>> EXTPERIPH clock output to PMC CLK_OUT_1/2/3.
> >>
> >> [and to enable OSC as well]
> >>
> >>> So I believe we need to register as MUX and Gate rather than as a sin=
gle
> >>> clock. Please confirm.
> >>
> >> 1. The force-enabling is applied to both OSC and EXTERN sources of
> >> PMC_CLK_OUT_x by PMC at once.
> >>
> >> 2. Both of PMC's force-enabling and OSC/EXTERN selection is internal t=
o PMC.
> >>
> >> Should be better to define it as a single "pmc_clk_out_x". I don't see
> >> any good reasons for differentiating PMC's Gate from the MUX, it's a
> >> single hardware unit from a point of view of the rest of the system.
> >>
> >> Peter, do you have any objections?
> >
> > The reason to have separate gate and mux clocks, is to preserve compati=
bility
> > with existing users.
> > Otherwise the current users would need to figure out if there's a
> > single clock or 2 clocks to configure. I don't think adding that code i=
n
> > each user is worth it only to have a sligthly nicer modelling of the
> > hardware.
>=20
> Could you please clarify what do you mean by the "existing users"?
> AFAIK, nothing in kernel uses mux clocks.

The DT clk bindings allow for parent initialization, so it's certainly
possible there are some DTs which rely on this. We promised to never
break the bindings, which changing to 1 clock would do.=20

Peter.
