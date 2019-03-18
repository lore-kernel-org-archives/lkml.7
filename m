Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7858CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D7213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552940704;
	bh=eU6ZllXkqrCdE81PRkZFm1rsacOkiebJtb7Yx/fdmwQ=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=I7gNYYSDXY2O9Rc8mN/1FAuILZa2LHbORYVJrFYig1ttrtu4+yXP7kRN5vHYzfh8T
	 JHh/RNvewUaQIkINg+jTOMg+JXkrzMMq2IiTT9JPy+mR/TQASD0+d+vx3JdHCpeNwv
	 DMktjxTpdseJ3NRMyvcnutXfHukkZRpg5eByy1Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCRUZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCRUZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:25:03 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102C320850;
        Mon, 18 Mar 2019 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552940702;
        bh=eU6ZllXkqrCdE81PRkZFm1rsacOkiebJtb7Yx/fdmwQ=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=H9AoONiMuUBkmMi3txRSajgLJgC95IvN/12LOgMMq7LFeQhv8dof6AS5bEq6Rk6bW
         OJgklsBsrUUqkvY/A4hVzeHWmqAGhH0Ov1U252KkXEmcaSObPTXAjQzttf+mhQyf/1
         FZKKUIXG20enGA+VqK1rb37Qg93GbGPCJpJLHN80=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0cf890a4-20b0-13ce-14d3-06f7c3227655@nelint.com>
References: <1552304271.2453.12.camel@pengutronix.de> <1552319997-24622-1-git-send-email-eric@nelint.com> <1552319997-24622-2-git-send-email-eric@nelint.com> <0cf890a4-20b0-13ce-14d3-06f7c3227655@nelint.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
Cc:     anson.huang@nxp.com, colin.didier@devialet.com, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tiny.windzz@gmail.com
To:     Eric Nelson <eric@nelint.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-ID: <155294070124.20095.17167777488324467790@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 18 Mar 2019 13:25:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Nelson (2019-03-11 13:48:55)
>  > On March 11, 2019, 6:35 p.m. UTC, Stephen Boyd wrote:
> > Quoting Eric Nelson (2019-03-11 08:59:56)
> >> + *
> >> + * Renamed to _BROKEN to prevent inadvertent use,
> >> + * but reserved the array slot to maintain DT binary
> >> + * compatibility.
> >> + */
> >> +#define IMX6QDL_CLK_PLL4_AUDIO_DIV_BROKEN      203
> >=20
> > But it breaks the build. I don't get it. Just add a comment indicating
> > it shouldn't be used? That breaks the cross-tree dependency chain and
> > lets clk tree merge the clk driver part and arm-soc merge the dts part.
> The device tree update also requires the update to clk-imx6q.c
> for proper run-time operation, so I don't see how these two parts
> can be separated.
>=20
> I thought about leaving the PLL4_AUDIO_DIV clock in place but
> turning it into a dummy (placeholder), but that might lead others
> down the long path I traversed before I found out that my manual
> was old and the clock didn't function.

I'm not suggesting that it's left as a dummy forever, just until the
other trees can merge their parts of this series and so that these
patches can be applied in order that they're sent. Right now, the kbuild
robot fails on this patch series because this patch intentionally breaks
the build. Please don't do that. Send patch series that are bisectable
so that the build doesn't break in the middle.

