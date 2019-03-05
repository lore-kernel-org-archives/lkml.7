Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6280FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319B52133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551811779;
	bh=k+Iq3xwBIbt9ZPAisBgeg2pj+qY/jWn5gCD7h7gjDnA=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=vMywXozFI1SOPHNjFy3rCQ3lYSTnM5PqdH7EjMI6/IhooGCfu5qv0BEzutWwobZQD
	 rSE9fIl5jOcSfCnstGrR1+oz/ZtN6mhr2U26uNtpCjfWlve8gCj5qLveZzxZSt+qWD
	 z1lz5XYIhv14s7hTsivej2S1mOFg9exdfzNvU5fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCESth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfCEStg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:49:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CBF208E4;
        Tue,  5 Mar 2019 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551811776;
        bh=k+Iq3xwBIbt9ZPAisBgeg2pj+qY/jWn5gCD7h7gjDnA=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=mC6lKazT6lIrm9i+G1AcAWAwRkMzT8/Ne7BEWwXlNXjNPYIOYPwlaerFACuAP2N03
         X9CvpctEsfCQmrSSWm6IOqDTjv7d6VVZ4oGqXbf0ZrgJOd/XLwzYm3joGozHT8cp9A
         gYfeXENWzH1wYz6K9nVJbSL2DeYeMr5Zxvx68/Eo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305044936.22267-2-dbasehore@chromium.org>
References: <20190305044936.22267-1-dbasehore@chromium.org> <20190305044936.22267-2-dbasehore@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de, aisheng.dong@nxp.com,
        mchehab+samsung@kernel.org, corbet@lwn.net, jbrunet@baylibre.com,
        Stephen Boyd <sboyd@codeaurora.org>,
        Derek Basehore <dbasehore@chromium.org>
To:     Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
Message-ID: <155181177527.20095.15680753964583935841@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 05 Mar 2019 10:49:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Derek Basehore (2019-03-04 20:49:31)
> From: Stephen Boyd <sboyd@codeaurora.org>
>=20
> Enabling and preparing clocks can be written quite naturally with
> recursion. We start at some point in the tree and recurse up the
> tree to find the oldest parent clk that needs to be enabled or
> prepared. Then we enable/prepare and return to the caller, going
> back to the clk we started at and enabling/preparing along the
> way. This also unroll the recursion in unprepare,disable which can
> just be done in the order of walking up the clk tree.
>=20
> The problem is recursion isn't great for kernel code where we
> have a limited stack size. Furthermore, we may be calling this
> code inside clk_set_rate() which also has recursion in it, so
> we're really not looking good if we encounter a tall clk tree.
>=20
> Let's create a stack instead by looping over the parent chain and
> collecting clks of interest. Then the enable/prepare becomes as
> simple as iterating over that list and calling enable.
>=20
> Modified verison of https://lore.kernel.org/patchwork/patch/814369/
> -Fixed kernel warning
> -unrolled recursion in unprepare/disable too
>=20
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---

From the original post:

"I have some vague fear that this may not work if a clk op is framework=20
reentrant and attemps to call consumer clk APIs from within the clk ops.
If the reentrant call tries to add a clk that's already in the list then
we'll corrupt the list. Ugh."

Do we have this sort of problem here? Or are you certain that we don't
have clks that prepare or enable something that is already in the
process of being prepared or enabled?

