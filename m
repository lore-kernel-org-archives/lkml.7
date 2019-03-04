Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF519C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAED720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lFAgzRtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfCDITB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:19:01 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8877 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:19:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7cdf730000>; Mon, 04 Mar 2019 00:18:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Mar 2019 00:18:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Mar 2019 00:18:59 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 08:18:59 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 5B4A941F64; Mon,  4 Mar 2019 10:18:57 +0200 (EET)
Date:   Mon, 4 Mar 2019 10:18:57 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RE-SEND] clk: tegra: Don't enable already enabled PLLs
Message-ID: <20190304081857.GE21084@pdeschrijver-desktop.Nvidia.com>
References: <20190224153222.8142-1-digetx@gmail.com>
 <b64760b5-0d37-ae05-9c8e-9e6d47293c92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b64760b5-0d37-ae05-9c8e-9e6d47293c92@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551687539; bh=BCemnCHaLtC4wiA6/c9/e02ruRZtENUbivo9tQSLybU=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=lFAgzRtr1Cv6r4dSKDpaqmsTOiQxtAZVxu1zk+LiYpp+exaMNjeTVbgiINS0ec7Rx
         vWmGtLjYPdJAkQsMbrRySqoYVnw90453bvJ/JuK5yxCESUzSuqQgFnmhy9lROO5bJV
         ZZ/cF9fKXJOIu8jmb48wO94k3unqNM9RCf1aM32jBfr1ip+KztfwvnAq/yXyqXblag
         3dCxB3IjHWG/GMIrihqfmtu2kHaBlHv340FURjJndslMmi3wLvxeGev4d92Ba8tmPW
         qLNR4JBeQfhj0+YkDQKU6dUMAsBeqgq1rLEw6DCl8OyiJ6+n3jVss7Z4bE2BQeZNoO
         HGBI97jjc+BnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:15:04PM +0300, Dmitry Osipenko wrote:
> 24.02.2019 18:32, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Initially Common Clock Framework isn't aware of the clock-enable status=
,
> > this results in enabling of clocks that were enabled by bootloader. Thi=
s
> > is not a big deal for a regular clock-gates, but for PLL's it may have
> > some unpleasant consequences. Thus re-enabling PLLX (the main CPU paren=
t
> > clock) may result in extra long period of PLL re-locking.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
>=20
> Peter (and everyone else), yours r-b and ACK will be appreciated since yo=
u kinda already took a look at this patch in the past and were okay with it=
 (IIRC, we had some brief discussion on the #tegra IRC a few months ago), t=
hanks.=20
>=20

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

