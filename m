Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB53C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611612148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IcgtoO7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfDXIg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:36:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15022 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDXIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:36:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc020110000>; Wed, 24 Apr 2019 01:36:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Apr 2019 01:36:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Apr 2019 01:36:27 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 08:36:27 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 26E1944E1F; Wed, 24 Apr 2019 11:36:25 +0300 (EEST)
Date:   Wed, 24 Apr 2019 11:36:25 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] clk: Tegra124 PLLM fixes
Message-ID: <20190424083625.GQ12975@pdeschrijver-desktop.Nvidia.com>
References: <20190411214835.19947-1-digetx@gmail.com>
 <46c12545-0e9e-93bf-2ccc-4577f4eb223e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <46c12545-0e9e-93bf-2ccc-4577f4eb223e@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556094994; bh=sf+uC56izVTBFAJrolQ4P2SCwZC5xEniGczvXZfp1Y0=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=IcgtoO7cd1+ZMlOXL3Dyjm646oTNpQMAfVgCo6pv4GlUOxSTHqxoqm3KRQDceNo4t
         0SuVmEIyv2zUZ6QbA+mPIW0d1tLUXEFfv8mquJV5q+UlMBTZQbQFffLIhCG3FH7twl
         0lg0zI7YngEiIg7HtxR4hCpF9wyugHVC7p8Pg6TaqoXOLhYo5ZmdIvq0EV8MMFeX6Y
         rL47GSdkPquCYujxtuYuDknlXF8dwwlal5J/WjZdIG0aLXt7nM9YFe0SewDF1YeHdI
         YbwU7Nllf/dxU9ZoQK/cRD/M/1JOdsQiV/WdZAvYeL3CilD1Z3j+X/oo+a23P3DgLb
         9pEkVScnsg7+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:50:10PM +0300, Dmitry Osipenko wrote:
> 12.04.2019 0:48, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hello, here are two trivial patches that are correcting PLLM on Tegra12=
4.
> > First fixes system lockup due to a bad hardware configuration, second
> > removes usage of a non-existent register bit.
> >=20
> > Dmitry Osipenko (2):
> >   clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides
> >     divider
> >   clk: tegra124: Remove lock-enable bit from PLLM
> >=20
> >  drivers/clk/tegra/clk-pll.c      | 4 ++--
> >  drivers/clk/tegra/clk-tegra124.c | 3 +--
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> >=20
>=20
> Hello Peter,
>=20
> The patches in this series are trivial and fixing the longstanding bug on=
 Tegra124. Could you please take a look and and ACK the series if it looks =
good to you?

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>                     =
                                        =20


Peter.
