Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76728C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452A1206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568664949;
	bh=YjMszPffkC1Y723CLckbSsP0J7TBPbS3PGg0RQag3lk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=2rc5NHoDEWgdPC2fmTKJMo3K3fmVPU8+aULse9+vJbMXlCkMZzsqPVYt8a/MzRPP4
	 wU6m6+haZnHf5cqwhfNvkWaN4BzQcG9tevC+H66Fys0p/g2TUxx4NQKudt8UvRYsjn
	 Bee0MfH2Nj+xmJhcni1K5Ro6S65Yum10/z4y/wzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbfIPUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfIPUPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:15:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF9020665;
        Mon, 16 Sep 2019 20:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568664947;
        bh=YjMszPffkC1Y723CLckbSsP0J7TBPbS3PGg0RQag3lk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=mpy+UJXERebsnZ51eywOwcC4mWWWPhWQrXL1Z3R1FB5Mr1X/tM7BwTEFzKng5UWvM
         ju5HzYTAyoRiVVWEhfziiwya0Q5d9komJoBEkDJoovuHUi+zdvW+lkENYqstXp93fL
         xYRTYNG1c9f7UylHQcma8QKWoNqApsPutMXY4j4U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568042692-11784-2-git-send-email-eugen.hristev@microchip.com>
References: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com> <1568042692-11784-2-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: at91: select parent if main oscillator or bypass is enabled
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 13:15:46 -0700
Message-Id: <20190916201547.5AF9020665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-09-09 08:30:34)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Selecting the right parent for the main clock is done using only
> main oscillator enabled bit.
> In case we have this oscillator bypassed by an external signal (no driving
> on the XOUT line), we still use external clock, but with BYPASS bit set.
> So, in this case we must select the same parent as before.
> Create a macro that will select the right parent considering both bits fr=
om
> the MOR register.
> Use this macro when looking for the right parent.
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Applied to clk-next

