Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F7C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA6F20830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568658980;
	bh=xvlWVEaWhC7ryJI9G/GikWh/UvQzkbDDSMDZpwdt40w=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=Qv3AcZxAuTig2lSpMk8lcucHOIqoMy5OdIVsaZ1GNEJ7HabF/XWGd94GHK2FV5kUC
	 RQbN/z1MhOwgl+0WcoUQ2hImJ4AuZ7C9eQT50sE8iaPa6EF7necD7EX7AUWFJF5+Zl
	 +Un1jRbE64JJwp5Siy+aRmhHmYWDRebDGU3RAdlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390489AbfIPSgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfIPSgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:36:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50926206C2;
        Mon, 16 Sep 2019 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568658979;
        bh=xvlWVEaWhC7ryJI9G/GikWh/UvQzkbDDSMDZpwdt40w=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=waNAcjNk3fRU5KnMoElDx49GDeaygQ9aYPvQmwqnJ4jX/Q1k2oNtmoSR4HrpZMSvD
         ijjboxUVQiDQn0KhxXezTJBagbw84gmnO1sjvSFSXrKGjTtzsjlVzRCXqJ5tVzBOhD
         jt2zaLIi347ajBTWK8Ta0W3pJ4MYbz/GbyEN4UAM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e1ddc50-7ae3-3ba9-7e41-80a834fa2dbf@linux.intel.com>
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com> <20190902222015.11360-1-martin.blumenstingl@googlemail.com> <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com> <CAFBinCARQJ7q9q3r6c6Yr2SD0Oo_Drah-kxss3Obs-g=B1M28A@mail.gmail.com> <b7920723-1df2-62df-61c7-98c3a1665aa1@linux.intel.com> <CAFBinCA+J-HnXfRnquqviXvX0Jo84hoLC9=_uHbyWKZycwyAFw@mail.gmail.com> <4e1ddc50-7ae3-3ba9-7e41-80a834fa2dbf@linux.intel.com>
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robh@kernel.org, yixin.zhu@linux.intel.com
To:     "Kim, Cheol Yong" <cheol.yong.kim@linux.intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 11:36:18 -0700
Message-Id: <20190916183619.50926206C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kim, Cheol Yong (2019-09-09 07:16:29)
>=20
> I've discussed internally the amount of efforts to create a reusable=20
> regmap clock driver which might be reused by other companies too.
>=20
> It seems it requires significant efforts for implementation/tests. As we =

> don't plan to support our old SOCs for now, I'm not sure if we need to=20
> put such a big efforts.
>=20
> Stephan,
>=20
> It seems you don't like both meson/qcom regmap clock implementation.
>=20
> What is your opinion for our current CGU clock driver implementation?
>=20
>=20

If you're not going to use regmap in CGU then it doesn't matter to try
to consolidate the regmap clk implementations.

