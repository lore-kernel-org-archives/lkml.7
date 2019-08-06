Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC9C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170E218D8
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F0u4K6B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfHFHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:30:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1806 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbfHFHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:30:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d492c910001>; Tue, 06 Aug 2019 00:30:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 06 Aug 2019 00:30:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 06 Aug 2019 00:30:24 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Aug
 2019 07:30:23 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 71AB84286D; Tue,  6 Aug 2019 10:30:21 +0300 (EEST)
Date:   Tue, 6 Aug 2019 10:30:21 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Mark Brown" <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] soc/tegra: regulators: Add regulators coupler for
 Tegra30
Message-ID: <20190806073021.GF3883@pdeschrijver-desktop.Nvidia.com>
References: <20190725151832.9802-1-digetx@gmail.com>
 <20190725151832.9802-4-digetx@gmail.com>
 <20190802140512.GD3883@pdeschrijver-desktop.Nvidia.com>
 <c537fbea-5884-03db-305f-6ab3d553f7ab@gmail.com>
 <20190805083325.GE3883@pdeschrijver-desktop.Nvidia.com>
 <1a9464b3-6e0e-00ff-64d8-b3abf7982dfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1a9464b3-6e0e-00ff-64d8-b3abf7982dfb@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565076625; bh=orc8XJzHRB34A21SAzqHogdB2d1yl9L59WLJTI8JrPU=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=F0u4K6B6ojpwlnFlDZ/aCr2FUj+rU7b7EmWKlyAae0Znbik25zVThcI8xZvJGTKf/
         C9Xbc9qVrXHTP3Bn19SCOytQyCr0jNT+7Jy/0I9VEQ3VqepaZdbUAWUuIUfGYfYfgX
         TqRHz0ZlzNe6TqYTXUP6TH8Qazp1HqPkc6Ttcg2bMSXDtDJNCvi3K0pISeh09P3x84
         /MBgbOydGAWXY/Q7jiloEwqHkUrI1uEy9X7qgjdKlb2Ms0zjaA1d3G0QoQVckfY2ki
         hrGxrxXzKQ1yRGXsA9W17ybX5KYcN7NjIqwlts+Zvs3ZXzwixLeXEtvhbBR7wpXpZm
         Wpq4X7ZIk8scw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:03:29PM +0300, Dmitry Osipenko wrote:
> 05.08.2019 11:33, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Aug 02, 2019 at 05:39:23PM +0300, Dmitry Osipenko wrote:
> >> 02.08.2019 17:05, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Thu, Jul 25, 2019 at 06:18:32PM +0300, Dmitry Osipenko wrote:
> >>>> Add regulators coupler for Tegra30 SoCs that performs voltage balanc=
ing
> >>>> of a coupled regulators and thus provides voltage scaling functional=
ity.
> >>>>
> >>>> There are 2 coupled regulators on all Tegra30 SoCs: CORE and CPU. Th=
e
> >>>> coupled regulator voltages shall be in a range of 300mV from each ot=
her
> >>>> and CORE voltage shall be higher than the CPU by N mV, where N depen=
ds
> >>>> on the CPU voltage.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  drivers/soc/tegra/Kconfig              |   4 +
> >>>>  drivers/soc/tegra/Makefile             |   1 +
> >>>>  drivers/soc/tegra/regulators-tegra30.c | 316 ++++++++++++++++++++++=
+++
> >>>>  3 files changed, 321 insertions(+)
> >>>>  create mode 100644 drivers/soc/tegra/regulators-tegra30.c
> >>>>
> >>> ...
> >>>
> >>>> +
> >>>> +static int tegra30_core_cpu_limit(int cpu_uV)
> >>>> +{
> >>>> +	if (cpu_uV < 800000)
> >>>> +		return 950000;
> >>>> +
> >>>> +	if (cpu_uV < 900000)
> >>>> +		return 1000000;
> >>>> +
> >>>> +	if (cpu_uV < 1000000)
> >>>> +		return 1100000;
> >>>> +
> >>>> +	if (cpu_uV < 1100000)
> >>>> +		return 1200000;
> >>>> +
> >>>> +	if (cpu_uV < 1250000) {
> >>>> +		switch (tegra_sku_info.cpu_speedo_id) {
> >>>> +		case 0 ... 1:
> >>> Aren't we supposed to add /* fall through */ here now?
> >>
> >> There is no compiler warning if there is nothing in-between of the
> >> case-switches, so annotation isn't really necessary here. Of course it
> >> is possible to add an explicit annotation just to make clear the
> >> fall-through intention.
> >>
> >=20
> > Ah. Ok. Whatever you want then :)
>=20
> I'll add the comments if there will be a need to re-spin this series.
>=20
> >>>> +		case 4:
> >>>> +		case 7 ... 8:
> >>>> +			return 1200000;
> >>>> +
> >>>> +		default:
> >>>> +			return 1300000;
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>
> >>> Other than that, this looks ok to me.
> >>
> >> Awesome, thank you very much! Explicit ACK will be appreciated as well=
.
> >=20
> > Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

All of them.

Peter.
