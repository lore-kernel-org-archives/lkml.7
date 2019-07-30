Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A3C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CD12089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564509154;
	bh=mnne8HxkQYHe1hsp9tyTFqKx/kwox+EaL9FZPw5xrLU=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=g3+HghtohecXgvQRfw5mggyUw1OEs8AD2hD1FaVv1JGX0JJkQ3LLBI6uH9S7CM3tL
	 Kl6KxYSh3LKEYY8uWKsU86VL5GDZ9riVmc+s2vAJNHu8/N7H/QSRmzHF/m6xJGKOFZ
	 HsSOWceNihhrOcuLwRNWeKchxDRE9pkuckhZTbs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfG3Rwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731849AbfG3Rwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:52:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B05ED206A2;
        Tue, 30 Jul 2019 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564509151;
        bh=mnne8HxkQYHe1hsp9tyTFqKx/kwox+EaL9FZPw5xrLU=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=PviEB+rSjDPmiHO/Yq0dWjVAOp2oJKwQX9me32xE8qnRaY4vcp6VXD9TaqQdYmTiz
         ln6GlNsOYWGOdRGyDiUhz2drXlXhkkcvjY0ACUNFUINHjE6tXDr653RDKRsPX2TMzK
         1/lEHd5bTXmNCc2xx2tT19fNHCOEaM5YMIH1VuSo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1564471375-6736-1-git-send-email-abel.vesa@nxp.com>
References: <1564471375-6736-1-git-send-email-abel.vesa@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guido Gunther <agx@sigxcpu.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3] clk: imx8mq: Mark AHB clock as critical
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 10:52:30 -0700
Message-Id: <20190730175231.B05ED206A2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-07-30 00:22:55)
> Initially, the TMU_ROOT clock was marked as critical, which automatically
> made the AHB clock to stay always on. Since the TMU_ROOT clock is not
> marked as critical anymore, following commit:
>=20
> 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TM=
U_ROOT")
>=20
> all the clocks that derive from ipg_root clock (and implicitly ahb clock)
> would also have to enable, along with their own gate, the AHB clock.
>=20
> But considering that AHB is actually a bus that has to be always on, we m=
ark
> it as critical in the clock provider driver and then all the clocks that
> derive from it can be controlled through the dedicated per IP gate which
> follows after the ipg_root clock.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
> Fixes: 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ=
_CLK_TMU_ROOT")
> ---
>=20

Should I just apply this to clk-fixes branch?

