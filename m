Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B818C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E021955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563833117;
	bh=6wCqVFLfAE5EJfHAjcadIprMjvR25gD3bmKgqCjUMOE=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=w7ozPVtPiBz6US6LiAuIvX3uKOu/j07vbdHB59UG4F5e+xxaauYVQu2cmkicjbSrl
	 dRbXyg0k+c0xMdpQNdK5+oEYddfTD4VrSrEVdd1Li1QqulZ1am0LfEpLkLTLOd/3+H
	 BxNZz39UAD3S6YbAo61H/BdPwrSgvAlqVxnP3j+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfGVWFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfGVWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:05:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C53FE21951;
        Mon, 22 Jul 2019 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563833114;
        bh=6wCqVFLfAE5EJfHAjcadIprMjvR25gD3bmKgqCjUMOE=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=CfO6y/van+mSGWSA1XbY6Gu0BXxfvN5weJjudshmWAPFMBcjyeDEfoDeRUQDY3D/z
         qR3GIpxO0+H87UMITd3txerCPUlZuLa/VT+ODujO7vaZ4Ng+/ft7sV5ZfreEE3lPJE
         2TPM3yNcT3yGlvGVuP8mrWFmocFgvriXO1gKdgJ4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190711130359.1060-1-geert+renesas@glider.be>
References: <20190711130359.1060-1-geert+renesas@glider.be>
Subject: Re: [PATCH] clk: renesas: cpg-mssr: Fix reset control race condition
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Yao Lihua <Lihua.Yao@desay-svautomotive.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 15:05:13 -0700
Message-Id: <20190722220514.C53FE21951@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-07-11 06:03:59)
> The module reset code in the Renesas CPG/MSSR driver uses
> read-modify-write (RMW) operations to write to a Software Reset Register
> (SRCRn), and simple writes to write to a Software Reset Clearing
> Register (SRSTCLRn), as was mandated by the R-Car Gen2 and Gen3 Hardware
> User's Manuals.
>=20
> However, this may cause a race condition when two devices are reset in
> parallel: if the reset for device A completes in the middle of the RMW
> operation for device B, device A may be reset again, causing subtle
> failures (e.g. i2c timeouts):
>=20
>         thread A                        thread B
>         --------                        --------

Applied to clk-fixes

