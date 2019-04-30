Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C3CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD3E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556648238;
	bh=RWMVFlZoo1dWgyPx3jxS9nsFQLj+1+W4WSOKZtiVOgU=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=ScFDIq0PC/7tXJJKHf689He/nGNA21RQUanFnq1n2IIabnTAxJhupYYx5QYZ+f6pv
	 0qhjuJEyy+emK+Bc6C2ET6fjdzlZza9V/862zy3G2MoIXcBr6JMkybXDQHjqDmQox4
	 SSafP2AeU9WSqAB9FAKBjVwRiYsLFtE7Ww5h+77Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfD3SRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3SRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:17:16 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395DA20854;
        Tue, 30 Apr 2019 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556648235;
        bh=RWMVFlZoo1dWgyPx3jxS9nsFQLj+1+W4WSOKZtiVOgU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Vrvoc0gjT8TOfrAfASm4xAX5FqcV5zw+G4oijozFOjmnnkSyIwRL4K8gEknb7CgVn
         bGWIeAVOvQQx++4EgtAyk8HENVyGWAAtPo4i/uzXkoZr5qsTZkNIHtjk1tiPU++3Cb
         R8XnyE4Yanjn7Sbin0p2IfE8GwAqQ9axVve5gR04=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8d0d12ae-ce67-5480-49be-893fbdbb6998@embeddedor.com>
References: <20190430143206.GA4035@embeddedor> <155664492283.168659.5604495418413396919@swboyd.mtv.corp.google.com> <8d0d12ae-ce67-5480-49be-893fbdbb6998@embeddedor.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: clk-pllv3: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <155664823446.168659.9382397723332081174@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 30 Apr 2019 11:17:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2019-04-30 10:28:32)
>=20
>=20
> On 4/30/19 12:22 PM, Stephen Boyd wrote:
> > Quoting Gustavo A. R. Silva (2019-04-30 07:32:06)
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> >>
> >> This patch fixes the following warnings:
> >>
> >> drivers/clk/imx/clk-pllv3.c: In function =E2=80=98imx_clk_pllv3=E2=80=
=99:
> >> drivers/clk/imx/clk-pllv3.c:446:18: warning: this statement may fall t=
hrough [-Wimplicit-fallthrough=3D]
> >>    pll->div_shift =3D 1;
> >>    ~~~~~~~~~~~~~~~^~~
> >> drivers/clk/imx/clk-pllv3.c:447:2: note: here
> >>   case IMX_PLLV3_USB:
> >>   ^~~~
> >> drivers/clk/imx/clk-pllv3.c:453:21: warning: this statement may fall t=
hrough [-Wimplicit-fallthrough=3D]
> >>    pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
> >>                      ^
> >> drivers/clk/imx/clk-pllv3.c:454:2: note: here
> >>   case IMX_PLLV3_AV:
> >>   ^~~~
> >>
> >> Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >>
> >> This patch is part of the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >=20
> > It was sent by Anson already.
> >=20
>=20
> Did he address both warnings?
>=20

No. I added you to the thread.

