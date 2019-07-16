Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EEBC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1A520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563295704;
	bh=GjrnAS/2hyc8QFjTxzsu320aSXZgfulcOkwYZWDfLyY=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=EFa3mDU6xJ8Jqd3u+K2mMTVEYmXQdaNRcZez7jTwjXa8UyZN20W+bFWyiZYpqCoBc
	 dlNYDO7KxLWhhHhZao22Xs/ERbGPjycIAtkAtSKjYzvX8zE6uXLEbUdgV6rkVI4TCL
	 Jg9xTdw6YXqrrwYwT4VkdX9H1pTrk2DZ1DovxBiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbfGPQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfGPQsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:48:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED922064B;
        Tue, 16 Jul 2019 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563295701;
        bh=GjrnAS/2hyc8QFjTxzsu320aSXZgfulcOkwYZWDfLyY=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=CYwq2mXW71Ha2a4P8u4grOkfZ6xyhpuR+CVJ8mpW+uWM2/X+9oITc3zihMbR3HEi+
         GJtjQwnO98WbJ647RlLDoWU/zY0UuuvngevKh15fLLAZGiE2Ok6PvUyjFwtuv9a4ld
         TLdIDq0VuYZbwZXPOMhG0pF+qS5PTE8Xq3HakGU8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190714215715.11412-1-paul@crapouillou.net>
References: <20190714215715.11412-1-paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: Remove OF_POPULATED flag to probe children
User-Agent: alot/0.8.1
Date:   Tue, 16 Jul 2019 09:48:20 -0700
Message-Id: <20190716164821.6ED922064B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-07-14 14:57:15)
> Remove the OF_POPULATED flag, in order to probe children when the
> device node is compatible with "simple-mfd".

We have CLK_OF_DECLARE_DRIVER for this. Can you use that?

>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clk/ingenic/cgu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
