Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9623BC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DB62067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qrj1euXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfD2Uxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:53:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51018 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfD2Ux3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556571206; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eci7PqqUZRtWPK2vm2tYC0lnabTJ5/V4H+ljsaB1HN4=;
        b=qrj1euXE69KAV7OvTpHY0Gwmm6g23q0zwuWjKQ57NVf0+g+JzUoPk8EhRsDEuIOgJ3prSm
        IRs5JdQNpKe16tM8k5AeSFOiiYNcciEFhRi2FBygv/zgBi4r3Mt0gSqsbjWiTC5Qhe0xm9
        guoDFvCUG9DuFK6G2PQ5JZG9nlaCJoQ=
Date:   Mon, 29 Apr 2019 22:53:11 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-Id: <1556571191.1721.0@crapouillou.net>
In-Reply-To: <155562472561.15276.17918796624287416345@swboyd.mtv.corp.google.com>
References: <20190417112420.3034-1-paul@crapouillou.net>
        <155562472561.15276.17918796624287416345@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le jeu. 18 avril 2019 =E0 23:58, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> Quoting Paul Cercueil (2019-04-17 04:24:20)
>>  The pixel clock is directly connected to the output of the PLL, and=20
>> not
>>  to the /2 divider.
>>=20
>>  Cc: stable@vger.kernel.org
>>  Fixes: 226dfa4726eb ("clk: Add Ingenic jz4725b CGU driver")
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>=20
> Applied to clk-next

Could you drop this patch?

It turns out it is wrong and the pixel clock is really connected to the=20
"pll half"
clock. The real bug was elsewhere: the "pll half" clock does not report=20
the correct
rate. I will send a patch for this one later.

Thanks,
-Paul

=

