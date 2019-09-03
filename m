Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE460C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D5622DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567554851;
	bh=nwbU19/t7DWIPKZnDjeNNVulS/e09x43j9BhKD8wDH8=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=oAGF1S7SOHv06t3Q6OvOqr1hUy6LQAACO3V0VIyu4qlmMBx9bUrc+iNHLdkJwHhct
	 wwK/JPhLHf145WIky+gi/seniezNfRPH90Et1b7SSPNKcE17qiPP1uQrScwTqJed5A
	 cOVV0LoqRFvzdwrWBV+6Gc3IBGund5GYVX+Ehkxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfICXyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfICXyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:54:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B546D208E3;
        Tue,  3 Sep 2019 23:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567554848;
        bh=nwbU19/t7DWIPKZnDjeNNVulS/e09x43j9BhKD8wDH8=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=kIom794De0UUl+7jBeGr2gWuWkIBNuz2j+6awfHfYZ7E/qrOE5efpcQlt0TE8QriW
         C+3rbHD0gNKZHd/Bug8Qs4zyJ+37IQpEoUCuVhPReuh3G9D/OwWjkQVLsCOs2B+Zc0
         FfBYNOi/otwEQJkVQbu2W+eIfm8U9DsmNqtlJjPQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com> <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robhkernel.org@vger.kernel.org, yixin.zhu@linux.intel.com
Subject: RE: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        rahul.tanwar@linux.intel.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 03 Sep 2019 16:54:07 -0700
Message-Id: <20190903235408.B546D208E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-09-02 15:20:15)
> +struct intel_clk_gate {
> +       struct clk_hw hw;
> +       struct device *dev;
> +       struct regmap *map;
> +       unsigned int reg;
> +       u8 shift;
> +       unsigned long flags;
> +};
> I know at least two existing regmap clock implementations:
> - drivers/clk/qcom/clk-regmap*
> - drivers/clk/meson/clk-regmap*
>=20
> it would be great if we could decide to re-use one of those for the
> "generic" clock types (mux, divider and gate).
> Stephen, do you have any preference here?
> personally I like the meson one, but I'm biased because I've used it
> a lot in the past and I haven't used the qcom one at all.

The topic comes up once in a while. Making a set of regmap clk_ops and
structures might work to consolidate the code across the different
drivers. I can't recall why we didn't combine the two implementations at
that point. I do remember that Mike was opposed to pushing it directly
into the core framework as part of struct clk_hw out of fear of bloating
the clk_hw structure.

I don't particularly like how the meson implementation makes every clk
the same type and has a 'data' member of clk_regmap to differentiate the
types (mux, gate, div, etc.) It avoids nesting structures but otherwise
serves the same purpose as having there be container structures for the
different types that all have a clk_regmap structure inside. qcom
implementation also takes a shortcut and adds enable/disable logic into
the clk_regmap structure. To consolidate the two I imagine we would need
to change both implementations to use a struct like:

	struct clk_regmap {
		struct clk_hw hw;
		struct regmap *map;
	};

