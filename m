Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B8EC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C567F2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565911793;
	bh=UUdMem/EasFhb4Dfk05FjFveBpohgSiNrTN38IFMTeQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=1HwcQc0NtE875b7Gg7EQmrpTI5L8UFkU2wKtp9BDMfB7T4KjxQbt459gpVKxcD/XY
	 6RAZHhRkjWaT32jImaBOpyU/KBAiLxkGXNCshJToDgjsGIDv6dJqX+7EuYtRQjJiET
	 oEBOqLBLEiZOMV+biVw/Zk03wDjpZEL1XLO3bnyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfHOX3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfHOX3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:29:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA402206C2;
        Thu, 15 Aug 2019 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565911791;
        bh=UUdMem/EasFhb4Dfk05FjFveBpohgSiNrTN38IFMTeQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cfJ9mKIJWeIdXMeH4f51/xiWPrnLZ/QFwdEMi7GNTJysZFmqGa5ZBvZnYudct4+Em
         0GbVgeMDcVG4oOG5fhnvU9VKqaCIkuYNBl/PQMa9aic7snRGH+hVR/5nLjC9bhOPrn
         cr/yUJhQunmDeASMSZWRRYmrx6ettOs04pSg5jSQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815223155.21384-1-martin.blumenstingl@googlemail.com>
References: <20190815223155.21384-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RFC v1] clk: Fix potential NULL dereference in clk_fetch_parent_index()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 15 Aug 2019 16:29:50 -0700
Message-Id: <20190815232951.AA402206C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-08-15 15:31:55)
> Don't compare the parent clock name with a NULL name in the
> clk_parent_map. This prevents a kernel crash when passing NULL
> core->parents[i].name to strcmp().
>=20
> An example which triggered this is a mux clock with four parents when
> each of them is referenced in the clock driver using
> clk_parent_data.fw_name and then calling clk_set_parent(clk, 3rd_parent)
> on this mux.
> In this case the first parent is also the HW default so
> core->parents[i].hw is populated when the clock is registered. Calling
> clk_set_parent(clk, 3rd_parent) will then go through all parents and
> skip the first parent because it's hw pointer doesn't match. For the
> second parent no hw pointer is cached yet and clk_core_get(core, 1)
> returns a non-matching pointer (which is correct because we are comparing
> the second with the third parent). Comparing the result of
> clk_core_get(core, 2) with the requested parent gives a match. However
> we don't reach this point because right after the clk_core_get(core, 1)
> mismatch the old code tried to !strcmp(parent->name, NULL) (where the
> second argument is actually core->parents[i].name, but that was never
> populated by the clock driver).
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> I have seen the original crash when I was testing an MMC driver which
> is not upstream yet on v5.3-rc4. I'm not sure whether this fix is
> "correct" (it fixes the crash for me) or where to point the Fixes tag
> to, it may be one of:
> - fc0c209c147f ("clk: Allow parents to be specified without string names")
> - 1a079560b145 ("clk: Cache core in clk_fetch_parent_index() without name=
s")
>=20
> This is meant to be applied on top of v5.3-rc4.
>=20

Ah ok. I thought that strcmp() would ignore NULL arguments, but
apparently not. I can apply this to clk-fixes.

