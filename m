Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E0C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B2B21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711981;
	bh=HadehC56ec5z0Uf8TAWu+BcUsNoCex0LFt8UIfCru4M=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=ZXW6JfJGinh2mqnwN0/GOHrsfLZyGkq6Ldq5hiOBHHBfgZmIShfvz+3yXqYYfg7eK
	 99aHBJILbJgTc/XtVgd5T+IdkYlahukw7vk/7/YwX9knhGngErsydU+pswdXVnwo8i
	 pFOsi8I7vFngf/CbVM7hiB0EZtd2+n0QhCYX1QF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfDSWNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:13:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A1121736;
        Fri, 19 Apr 2019 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711978;
        bh=HadehC56ec5z0Uf8TAWu+BcUsNoCex0LFt8UIfCru4M=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=1pFH4+lN2GIUkA7m18O7en7uQ4K2/t6z3Ewm0ISNpQgM2tvXtbyAj384GMWAVO37e
         Ox0g/HwsAiPdYUhscqOnozMcbZ6k7CYCsKRBnb0S3aM2mtXwnTqB7yZ5QwCyn+38w4
         2hKW4oQ0mU+P9IBSuP5hm73udV+dMQ/KrozXJyOc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-7-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-7-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 6/9] clk: Allow parents to be specified without string names
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155571197779.15276.7804294833146212666@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:12:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:47)
> The common clk framework is lacking in ability to describe the clk
> topology without specifying strings for every possible parent-child
> link. There are a few drawbacks to the current approach:
>=20
>  1) String comparisons are used for everything, including describing
>  topologies that are 'local' to a single clock controller.
>=20
>  2) clk providers (e.g. i2c clk drivers) need to create globally unique
>  clk names to avoid collisions in the clk namespace, leading to awkward
>  name generation code in various clk drivers.
>=20
>  3) DT bindings may not fully describe the clk topology and linkages
>  between clk controllers because drivers can easily rely on globally uniq=
ue
>  strings to describe connections between clks.
>=20
> This leads to confusing DT bindings, complicated clk name generation
> code, and inefficient string comparisons during clk registration just so
> that the clk framework can detect the topology of the clk tree.
> Furthermore, some drivers call clk_get() and then __clk_get_name() to
> extract the globally unique clk name just so they can specify the parent
> of the clk they're registering. We have of_clk_parent_fill() but that
> mostly only works for single clks registered from a DT node, which isn't
> the norm. Let's simplify this all by introducing two new ways of
> specifying clk parents.
>=20
> The first method is an array of pointers to clk_hw structures
> corresponding to the parents at that index. This works for clks that are
> registered when we have access to all the clk_hw pointers for the
> parents.
>=20
> The second method is a mix of clk_hw pointers and strings of local and
> global parent clk names. If the .fw_name member of the map is set we'll
> look for that clk by performing a DT based lookup of the device the clk
> is registered with and the .name specified in the map. If that fails,
> we'll fallback to the .name member and perform a global clk name lookup
> like we've always done before.
>=20
> Using either one of these new methods is entirely optional. Existing
> drivers will continue to work, and they can migrate to this new approach
> as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> array in struct clk_init_data and use one of these new methods instead.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

