Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC99EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE422190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Oj8qzUKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390659AbfGYJkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:40:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16155 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfGYJkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:40:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3978fb0000>; Thu, 25 Jul 2019 02:40:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 02:40:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 02:40:13 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 25 Jul 2019 09:40:13 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id E9A754286A; Thu, 25 Jul 2019 12:40:10 +0300 (EEST)
Date:   Thu, 25 Jul 2019 12:40:10 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] Tegra30+ CPU suspend-resume bug-fixes
Message-ID: <20190725094010.GK12715@pdeschrijver-desktop.Nvidia.com>
References: <20190707230358.10672-1-digetx@gmail.com>
 <f81a974b-4e64-9b66-0399-519480f53c31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f81a974b-4e64-9b66-0399-519480f53c31@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564047611; bh=apf3jzwnfhKFg9IZK3XN92EmLtv9+yAT9vhHoxAOnLc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=Oj8qzUKZltd+czqQ1o7u1ArbbnJVR/M1oSf8Y1+F73DWrukjn7X2cqE3aac6S0xXW
         nEuXIctMbJWeDqQrcBSj96+TjfUwK3rcE4DkovVTfwFt34gKpYGjTE5hMljlby6Vvd
         wmqXTkiK7txrxbgC4f9JYnjB7Nhvqq8wN+7Eoqq2j/e97qhYZvwxa853+oaVlXkIZ+
         5MHtaYlgzeQdgqVILL9h0ROYnpZNwbG2vrF8E/VAZl6vc8Cq1wpQ48X05amBwkLwAp
         7VHqeYtg5KWvJPcTEhACXKEJt9+2ERRqpWaJlBABNxOPRCWy533crzOxT9EpWySHqm
         +v9T+/p2THimg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:28:35AM +0300, Dmitry Osipenko wrote:
> 08.07.2019 2:03, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hello,
> >=20
> > This small series addresses two suspend-resume bugs: one affects Tegra3=
0+
> > due to a typo in the code, other fixes CPU hang on Tegra30 specifically=
.
> >=20
> > Please review and apply, thanks!
> >=20
> > Dmitry Osipenko (2):
> >   ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
> >   ARM: tegra: Use WFE for power-gating on Tegra30
> >=20
> >  arch/arm/mach-tegra/reset-handler.S |  6 +++---
> >  arch/arm/mach-tegra/sleep-tegra30.S |  4 +++-
> >  drivers/soc/tegra/flowctrl.c        | 19 +++++++++++++++++--
> >  3 files changed, 23 insertions(+), 6 deletions(-)
> >=20
>=20
> Hello Peter,
>=20
> We were talking about these fixes on the IRC not so long time ago, does
> it look good to you? Care to give an ACK?

Acked-By Peter De Schrijver <pdeschrijver@nvidia.com>
