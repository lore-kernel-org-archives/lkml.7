Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC0C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABDB21479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DuNfx7Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfDQXyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:54:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40548 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQXyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555545238; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLmmM439FFJveY4UvXXQncIQ+cI3VQgKJJz3bcNnSqo=;
        b=DuNfx7Krxg0GUrGcKl7oBKlHrQ9ddpdHng3nF0Wv7V+JXX0zguIWcERrXY5OLQnRzHGmC2
        n4SfM1EWkvDMRjh53c/0uFG3s4klWcVr0coy7e8EWkMeCFVDHquUqkoZApcW+V0UCJeENz
        h679HJBjGNB1vOEWdONp8wcnirc1G8I=
Date:   Thu, 18 Apr 2019 01:53:53 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-Id: <1555545233.9064.0@crapouillou.net>
In-Reply-To: <155554493444.15276.2577888773542833089@swboyd.mtv.corp.google.com>
References: <20190417112420.3034-1-paul@crapouillou.net>
        <155554493444.15276.2577888773542833089@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le jeu. 18 avril 2019 =E0 1:48, Stephen Boyd <sboyd@kernel.org> a =E9crit=20
:
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
> Is this breaking something in 5.1-rc series? Or just found by
> inspection? I'm trying to understand the priority of this patch.

I verified it with the hardware. It fixes a bug that has been present
since the introduction of this driver.

However until now nothing uses this particular clock so it can go to=20
5.2.

-Paul

=

