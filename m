Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8062C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555619570;
	bh=3cAiyFyV/p+bBSU+y5ieU7sRvyEc8uS1u/a+EV/Eaeg=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=u3T+FVCn69DN10pjAzqihsft2uXOqPfe2idVmc1X0AXFqWVvIUi4YbsAtFpG3/MHM
	 EYks+Dk3LdDEDrKvAnwkQb+ex6fdLGD7yS5ohej6hX128oAoi1kZHwcW07aVHSCDFQ
	 mWok1NyyEt3/U55rwD7F7/bc75v2dZQxtJXZAYpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbfDRUct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389754AbfDRUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:32:49 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4835E214C6;
        Thu, 18 Apr 2019 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555619568;
        bh=3cAiyFyV/p+bBSU+y5ieU7sRvyEc8uS1u/a+EV/Eaeg=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Bk/0o+eq9UbsJE1I4dX6fwnutzWfiZQzUWuZaBgDIk4Jj9kBVjW/AUHRXGKBkU9ah
         01qVlQl2IkahL0cg2mh4VWsYi6fre1dEq6wbe6+vzYUR95Lj/SDl4hXYgu0oDI2Fvx
         Y8QJKFZAFwKIKK1Hsiv6apZaMrAipqCJJOwlA92U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1555545233.9064.0@crapouillou.net>
References: <20190417112420.3034-1-paul@crapouillou.net> <155554493444.15276.2577888773542833089@swboyd.mtv.corp.google.com> <1555545233.9064.0@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
To:     Paul Cercueil <paul@crapouillou.net>
Message-ID: <155561956762.15276.194017354834843301@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 18 Apr 2019 13:32:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-04-17 16:53:53)
> Hi Stephen,
>=20
> Le jeu. 18 avril 2019 =C3=A0 1:48, Stephen Boyd <sboyd@kernel.org> a =C3=
=A9crit=20
> :
> > Quoting Paul Cercueil (2019-04-17 04:24:20)
> >>  The pixel clock is directly connected to the output of the PLL, and=20
> >> not
> >>  to the /2 divider.
> >>=20
> >>  Cc: stable@vger.kernel.org
> >>  Fixes: 226dfa4726eb ("clk: Add Ingenic jz4725b CGU driver")
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >=20
> > Is this breaking something in 5.1-rc series? Or just found by
> > inspection? I'm trying to understand the priority of this patch.
>=20
> I verified it with the hardware. It fixes a bug that has been present
> since the introduction of this driver.
>=20
> However until now nothing uses this particular clock so it can go to=20
> 5.2.
>=20

Great. Thanks for the background!

