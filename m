Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C110FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B01218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556141256;
	bh=xUxFNsMZ8txNu7js12qDGeRYYEYc3jJ0GwudbvyOSd4=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=lxpdkeOC53pD0COGRybDoTmNmbSUNMOepf9jn161N5uz5DHVSKoBXq9oszYkJRLbD
	 /XDPyRRpfqijvsR5RjFOffeIk+dlAWlqaWVASjQsenZ8vtvxZRtLkv+G3tZwG743UK
	 syIndS46PepW6n16bPNi1vBQeKbidUZI0FZublyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbfDXV1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbfDXV1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:27:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990A32183E;
        Wed, 24 Apr 2019 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556141253;
        bh=xUxFNsMZ8txNu7js12qDGeRYYEYc3jJ0GwudbvyOSd4=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=rzaZXS9tp0Wrwyxq4Sl6jD+5RE/ExNHeXPc/36SNn0Z69ZrmA7BV8FUgWkRwfBGfp
         6hSFUqO9qrTqfhxEZr49uZcbwpb3ErbNK4oZv6N05aLJ7IUbMAOtbw8n5gaLqwXIdK
         Fx6L6fqUhFOdKJSE0x61mMqu7Iu2qX7h7l+MCGcc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12AB29F5F@dggemm507-mbx.china.huawei.com>
References: <1553954090-65470-1-git-send-email-nixiaoming@huawei.com> <155605990288.15276.7089726827167650203@swboyd.mtv.corp.google.com> <E490CD805F7529488761C40FD9D26EF12AB29F5F@dggemm507-mbx.china.huawei.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v3 1/2] clk:Fix divide-by-zero in divider_ro_round_rate_parent
To:     "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>,
        Nixiaoming <nixiaoming@huawei.com>
Message-ID: <155614125279.15276.7728769195271989477@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 24 Apr 2019 14:27:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nixiaoming (2019-04-24 08:31:23)
> On Wed, Apr 24, 2019 at 6:52 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >Quoting nixiaoming (2019-03-30 06:54:50)
> >> In the function divider_recalc_rate() The judgment of the return value=
 of
> >> _get_div() indicates that the return value of _get_div() can be 0.
> >
> >When does _get_div() return 0? It can't be CLK_DIVIDER_MAX_AT_ZERO or
> >CLK_DIVIDER_POWER_OF_TWO. I suppose it could be CLK_DIVIDER_ONE_BASED if
> >CLK_DIVIDER_ALLOW_ZERO is set? Or just CLK_DIVIDER_ALLOW_ZERO is set? Or
> >a table that has 0 in it for some odd reason.
> >
> divider_ro_round_rate_parent() is an exported function.
> There is no parameter check or return value check before=20
> and after calling _get_div(), which may result in a divide by zero error.
>=20
> Case1: The "flags" contains CLK_DIVIDER_ONE_BASED, and "val" is 0.
> Case2: The "flags" does not contain CLK_DIVIDER_ONE_BASED,=20
>     CLK_DIVIDER_POWER_OF_TWO, CLK_DIVIDER_MAX_AT_ZERO, =20
>     "table" is NULL.  "val" is 0xffffffff
> In both cases _get_div() returns 0

Alright, so this is all theoretical and not happening in practice? Best
to do nothing then I think.

>=20
> >> In order to avoid the divide-by-zero error, add check for return value
> >> of _get_div() in the divider_ro_round_rate_parent()
> >>=20
> >> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> >> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> >> ---
> >>  drivers/clk/clk-divider.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>=20
> >> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> >> index e5a1726..f4bf7a4 100644
> >> --- a/drivers/clk/clk-divider.c
> >> +++ b/drivers/clk/clk-divider.c
> >> @@ -347,6 +347,9 @@ long divider_ro_round_rate_parent(struct clk_hw *h=
w, struct clk_hw *parent,
> >>         int div;
> >> =20
> >>         div =3D _get_div(table, val, flags, width);
> >> +       /* avoid divide-by-zero */
> >> +       if (!div)
> >> +               return -EINVAL;
> >
> >Can you please give more details on what's happening here? Who's the
> >caller? What are the arguments being passed in? Shouldn't we check for
> >CLK_DIVIDER_ALLOW_ZERO and then return prate as it comes in instead of
> >returning an error?
> >
> I found that there may be a divide-by-zero error by code review,
>  for example: "flags" is CLK_DIVIDER_ONE_BASED and "val" is 0.
> So simply add a return value check to avoid divide-by-zero
>=20
> thanks for your suggestion,=20
> I will resend the patch later
> refer to your advice and divider_recalc_rate() to add a check for CLK_DIV=
IDER_ALLOW_ZERO
>=20

Ok. I'm actually wondering why divider_ro_round_rate_parent() doesn't
use clk_divider_bestdiv() instead of _get_div(). I think we did this to
make things simpler.

We could make clk_divider_bestdiv() take a 'val' argument to start the
divider loop (and make that 0 for the "normal" case) and then look at
the 'flags' for CLK_DIVIDER_READ_ONLY to restrict the 'maxdiv' and 'i'
arguments there to be whatever the val is passed in to be. It would
require passing the val into _get_maxdiv() too, and only caring about
the val when the read only flag is set.

Then I think we would naturally get div-by-zero avoidance code and we
could collapse the divider code paths substantially into
clk_divider_bestdiv(). It would be even better if that patch could come
after moving the clk-divider ops to use .determine_rate() instead of
.round_rate() clk_ops. If we did that then we could enhance the divider
code to handle rate request clamping.

