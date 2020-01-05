Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDAC33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235C320848
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578210958;
	bh=KHv0URgMb51Ry29VbaCs6lbRmSIyflQETcBE7Kw5R+Y=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=u9Twpp0Vk8qxC32Hc6bT35dl/vXOzlMRSWKdtEl98cPmjh9V9qRhb6uM01TzI8jrl
	 kbhV1VKBsBFELCD0b0GeShCzfLGVMfsba0FUfkqP0vqCmTLnBkuS85hTQBwyxEF6vT
	 7WBvkmnOpuDi/6ql1d272Cc9NJTv0eis8uxhuU8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAEHz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:55:57 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E1A20848;
        Sun,  5 Jan 2020 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578210956;
        bh=KHv0URgMb51Ry29VbaCs6lbRmSIyflQETcBE7Kw5R+Y=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=XayaYns7hBmNBlqIrXlPRSXOB75A6l8msBbFvLJEtqcV1SUUk0e/llbc8vZbRIFHW
         H8HCbyoBTonwIXjaFHTORH+zz0VyrNEQAwkkQn53cbW4fOdCF4v54PVVI/BSnSoLKA
         DYdezgHglvN08Xoiz/eX84+M4V9OQqwu1zgJbpPw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200105075050.1B93E20866@mail.kernel.org>
References: <20191001174439.182435-1-sboyd@kernel.org> <1jd0ffr1jh.fsf@starbuckisacylon.baylibre.com> <20200105075050.1B93E20866@mail.kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
To:     Jerome Brunet <jbrunet@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:55:55 -0800
Message-Id: <20200105075556.60E1A20848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-01-04 23:50:49)
>=20
> Quoting Jerome Brunet (2019-10-02 01:31:46)
> > >
> > > +     clk_core_get_phase(core);
> >=20
> > Should the error be checked here as well ?
>=20
> What error?
>=20

Ah the error when clk_ops::get_phase() returns an error? I guess we
should just silently ignore it to maintain the previous behavior? Or we
can bail out of clk registration. Seems low risk to do that in another
patch.

