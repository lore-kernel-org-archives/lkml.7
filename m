Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE81C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1562089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568024593;
	bh=+x+vpuhqMDXDsPD9937ItNnTiCT648atbPdNMRu2+A4=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=SSRdMOsYqbCb1zJ21b/FSa7ilx/cCBgZBq7x5ODqO+usAJiJrcRPTHTZgQlg40JiR
	 PvRDqXU6hTor+Jg1UHEYyGt2Pr1f7zDjN4v3+/l7YdzLmPrzf9fcU+F5Eq1OR6PUCj
	 qECm1J48bzrMvfN2TuYwJ0ZQZiN1lN8g6P1Pgbjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbfIIKXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390519AbfIIKXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1552C2089F;
        Mon,  9 Sep 2019 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568024591;
        bh=+x+vpuhqMDXDsPD9937ItNnTiCT648atbPdNMRu2+A4=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=inA3V7Ra/qWCfoXNcia9Hx8avgTjzluK+mYNDsytYmEp6sWwZGX3VmGmOd8jvck13
         AHjjL/9+m+A+Af6q7Rhmm4XiHhUsXDnZ1CL/3JmerHfZ/Qkokd72d3ZNEVcYcc412r
         xZZ4NB4vy5K6cy9g7A/5+ouMyOdtN6L2JqxC2i20=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826164510.6425-5-jorge.ramirez-ortiz@linaro.org>
References: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org> <20190826164510.6425-5-jorge.ramirez-ortiz@linaro.org>
Cc:     bjorn.andersson@linaro.org, niklas.cassel@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     agross@kernel.org, jorge.ramirez-ortiz@linaro.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 5/5] clk: qcom: hfpll: CLK_IGNORE_UNUSED
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 03:23:10 -0700
Message-Id: <20190909102311.1552C2089F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-08-26 09:45:10)
> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
> to keep the software model of the clock in line with reality, the
> framework transverses the clock tree and disables those clocks that
> were enabled by the firmware but have not been enabled by any device
> driver.
>=20
> If CPUFREQ is enabled, early during the system boot, it might attempt
> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
> a provider, it will then change the rate for this clock.
>=20
> As boot continues, clk_disable_unused_subtree will run. Since it wont
> find a valid counter (enable_count) for a clock that is actually
> enabled it will attempt to disable it which will cause the CPU to
> stop. Notice that in this driver, calls to check whether the clock is
> enabled are routed via the is_enabled callback which queries the
> hardware.
>=20
> The following commit, rather than marking the clock critical and
> forcing the clock to be always enabled, addresses the above scenario
> making sure the clock is not disabled but it continues to rely on the
> firmware to enable the clock.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Also this one. Seems fine to merge immediately vs the ones that do some
DT trickery.

