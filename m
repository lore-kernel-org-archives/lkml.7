Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5534C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4BD20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d3c9vnj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgAIWWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:22:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:33051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgAIWWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578608487;
        bh=Th7DnPvuJhY/6sgGLmR9Zqhdkh3xhTX2Sv71iRDzhvk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=d3c9vnj7KpIMBzwB2eRa519+WeYvI8DLeFksCNp+N6MOMVgFEYXLKTSmMT2908b7b
         h+ovhr0dvdSTvzMlIPLGCvt6TfaXLQ5BQwkP2rqzVwqgAnlDI1Mz+O+dtDTdp1Ci+v
         tjrd6yBTxsqJpiO7n6r85eWDSUlBrr10NGMeR/Xg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.202]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1inEHH3pcn-006zx4; Thu, 09
 Jan 2020 23:21:27 +0100
Date:   Thu, 9 Jan 2020 23:21:25 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read error
 gracefully
Message-ID: <20200109232125.6ecd6cf7@gmx.net>
In-Reply-To: <20200109203819.GG3702@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
        <20200109203819.GG3702@sirena.org.uk>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DjtTKNqMyIMnbsmFeAWk2Ki8Sa6uq3PTKJ8OS07PD+CGP4ZkvFP
 Gr3Ogz07ggS+WCjJtVLhvY3bAARSkUvOWO7BKaaygw2GfFXf6oYMmWkzpOIUgY64y6B4jvZ
 rGAIVGt7kobbSeBhtxlgRUzAoVyqqni7gQAHqplpqqroUJzbX8G7Ea+jQY5vmdUhz0f3L73
 5Nn900wbNP0Pb/ZDHayyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7TlgbhqVgX0=:6xHe2w0wZonEysTLqGmvsf
 rI/9rFFBZzvHhvod0lYvlBsGZa1tGrYc31LOXxo8o36xy2czZWsDdpkuHO5eF00sXXRyCp5vP
 5ftBQi+K4UtJRlIe66DANLHq9PclZP6+YT/gXC+5eEL0JeSEmDHng27l1Pujj/yzPklUE6a3q
 G0CDmw8SHKJ6+sDqEOQgQAy3EqDDgHt5M/G8IeWWaKAZebWyrDy1Vek7jaAszfGOT95VcwST3
 x7jKYHEebdfTYE/iAJ0x7JbnxcJmBLVgIosO3TdbAVA8Gr6RGVx5Jln0EFaKJG33S9x9hUOgY
 AiVxefCWpyAER/r9IGthxzEP1f9AR8kApgq/3D54+01zua587XJDVPPF2NPKTjcMi5opQOAbi
 2Ad1+5kxxwR1tWDHf0Zu8SWQ2WHIDjIYx4sGU9XJKVnY5T4VGeXTC2E3UqSQhK7Q0RhA9bHdP
 rkqjf3cJrE+kcsZ1rTW2Hbc+pTuLagpE5aYhe7oXPYq+1kjwG5jA97AWXl+ZagQhgUth22aRa
 S/Djy2ySXOzFjZHaxU5hc0bPobZ0iE6nuViuEZdJ4DR5NskaEJ1OpLWQsGR0LwGed1VDjgOO6
 3juSoMo5ahTQuO4BG0dFJCXwmjM+4fnJd705f5JdJ5VBwPAyN9PfGC8vvj6l4I5zG5Z7qDyyP
 FnX4C3CfxsS8KhYO/YUkGMKhkcDMcV+dPgZlQ+Gj61SOqxfm8Jp4VfbC1nC2NjAQpzL9XeTnD
 3s654iBA53kvu174mrj+0tqETCs3gnWBHGhrO8RBZ1+YZ+g0gn5N5BZMmrbdG3ypvSjULxrDu
 CqE5z/LI7XSVtQUXvEeGvKa0ChG22DwTjmf84QLqwlDUjhQLFdRsFTjIF6B2rDRvj2o2ld6pW
 7Xqa112L0aqHEsa9bL83nqzs/XsvOLt5HPme5AUkuicFs2Esdm9XkVV8xBRLUHBK8mBHBmySH
 d978Kq4bfpXsglatC4RcSE11OfnX9sn38Ge7RBI5nvsP8QxTAlWDf9fEanlEVWHrFLpZQ0BEc
 5RPxs/3vHjMwoj7a6OdlmNpJ+DB8p7zUp7i9MkcfO6L9ej4Si0k9Y/FXvQgxQ1FB6aKo3G8Ag
 rXc8C0nmsqgwl881lj65gg6JvpXRbfOgrgzq9WS114w1vDQR/Pd4E5Qm+GXba/1XZFJ5br00d
 Yc75DRkjTQ8wadKGc9FqollVBddk3ddDFgB8P0CufVFV1U5PSOT2Q4MSito8PsMfZJv+jRhsY
 2IQ7Cv5GTuXD+uhAi08FKAxJQ5SnCNoEqG45Eknfq8hKMMbH06cYSm1aRykI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Thu, 9 Jan 2020 20:38:19 +0000, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:
> > @@ -338,7 +338,8 @@ static unsigned long clk_aic32x4_div_recalc_rate(s=
truct clk_hw *hw,
>
> >  	unsigned int val;
>
> > -	regmap_read(div->regmap, div->reg, &val);
> > +	if (regmap_read(div->regmap, div->reg, &val))

Unrelated to your question, but I would change this line (on next patch
iteration) to (as all other return value checked places for regmap_read
in the same file):

	if (regmap_read(div->regmap, div->reg, &val) < 0)

> > +		return 0;
>
> Is this the best fix - shouldn't we be returning an error here?  We
> don't know what the value programmed into the device actually is so zero
> might be wrong, and we still have the risk that the value we read from
> the device may be zero if the device is misprogrammed.

clk_aic32x4_div_recalc_rate() is used for clk_ops aic32x4_div_ops.recalc_r=
ate,
did not check/or see on first sight if there is a error handling on the us=
age
of recalc_rate, but did take a look at some other places where the error
handling seems to be to return zero, e.g. sound/soc/codecs/da7219.c
sound/soc/intel/skylake/skl-ssp-clk.c, etc.

The error occurred with linux-5.3.18, with the earlier versions on regmap_=
read
failure val was (by chance) near 2^31 and evaluated with (val & AIC32X4_DI=
V_MASK)
to 96 (or similar)...but with 5.3.18 evaluated to 0 and the line

	return DIV_ROUND_UP(parent_rate, val & AIC32X4_DIV_MASK);

produced the 'Division by zero'...

Regards,
Peter

