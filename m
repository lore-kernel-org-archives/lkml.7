Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57392C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E80120869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573161602;
	bh=tXQo4ZfbA/JnuLQ2PPQ1Gx66/l1k7L/OaVsoMRqDwig=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=hmNnw10P1uSta9Dgll6+qHED1BQm+N6ILtqh1/U2Uq6jtgWzbD488V3hNR+WtMLIi
	 9HBdARW+nNAAv/VSyxkEKvoSFhsErnKM2grJvXfWsZOvTe8Fa1NAvem8AM77jNIWgc
	 Vp5HGFArm8NTSpHhDtrceamK9NNT2qhNIPv9UeW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfKGVUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfKGVUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:20:00 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB7F20869;
        Thu,  7 Nov 2019 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573161599;
        bh=tXQo4ZfbA/JnuLQ2PPQ1Gx66/l1k7L/OaVsoMRqDwig=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=2nYyrwbjkyQJ/HIEDbXdxI31EkSS1UdBStr5/idChYnahgOLFi3eo97YXQl5sHUIA
         qsc9gdUTRJIAVD8UIN6eHiFHVO6HERcbXba6QbBm/ImRFiOKSOzKLoxxfNUO9JlmSV
         rFTTNB4UkViJSU0WTdnuRclQW/F9DSismMCehZ80=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191107211353.C15F62077C@mail.kernel.org>
References: <1572371299-16774-1-git-send-email-tdas@codeaurora.org> <1572371299-16774-4-git-send-email-tdas@codeaurora.org> <20191107211353.C15F62077C@mail.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2 3/3] clk: qcom: clk-rpmh: Add support for RPMHCC for SC7180
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 13:19:58 -0800
Message-Id: <20191107211959.5BB7F20869@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-11-07 13:13:53)
> Quoting Taniya Das (2019-10-29 10:48:19)
> > Add support for clock RPMh driver to vote for ARC and VRM managed
> > clock resources.
> >=20
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  drivers/clk/qcom/clk-rpmh.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > index 20d4258..3f3e08b 100644
> > --- a/drivers/clk/qcom/clk-rpmh.c
> > +++ b/drivers/clk/qcom/clk-rpmh.c
> > @@ -391,6 +391,24 @@ static const struct clk_rpmh_desc clk_rpmh_sm8150 =
=3D {
> >         .num_clks =3D ARRAY_SIZE(sm8150_rpmh_clocks),
> >  };
> >=20
> > +static struct clk_hw *sc7180_rpmh_clocks[] =3D {
>=20
> I don't think we need to duplicate this array either, unless somehow
> this driver is running on two different SoCs which seems highly
> unlikely.
>=20

Ah but we don't have IPA clk or RF_CLK3 on sc7180. Alright this can be
revisited later.

