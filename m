Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55D4C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA7520729
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573883480;
	bh=3glp16+H5Slzp2YEAa7YPPALJxZr7iGRwioZPJUYpxU=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=phpytIBFNN+k4x2eXJ1bs78U6oJschOaRO9fZcl3VArNMNUQmW8n62lTpcsnLcolH
	 0NPElhR7SPRQHJMpB/Xsw5gtYvTXve/HriIgt2fy1/t6+ifgA/EEM7mHRSb3FnKwyf
	 Q5ItLACP3FBHaouAFa+7wyeBedIHNhaY7XFEzzNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfKPFvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfKPFvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 00:51:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FCD120729;
        Sat, 16 Nov 2019 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573883478;
        bh=3glp16+H5Slzp2YEAa7YPPALJxZr7iGRwioZPJUYpxU=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=DyMApAvuBt1DmHYQwaweWiSlfZhcvWyMbqHWlqdlNwXIJ2HO7W04RG0PyEQsW33ot
         cWIOO+AcvOLWQbrmNJPiu0C6gmrqEteA5EHV4DmpjB7lSMJi6VnY6ywMKh6nnoI/uj
         5P6bEnCUnP4PSs0pKkO72mJjaKTPiMKRBr5pbgy0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <80e79595-0672-1d16-f251-717dbe449c57@codeaurora.org>
References: <1572524473-19344-1-git-send-email-tdas@codeaurora.org> <1572524473-19344-8-git-send-email-tdas@codeaurora.org> <20191106003944.1BDAE2178F@mail.kernel.org> <80e79595-0672-1d16-f251-717dbe449c57@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1 7/7] clk: qcom: Add video clock controller driver for SC7180
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 21:51:17 -0800
Message-Id: <20191116055118.2FCD120729@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-11-15 00:11:31)
> Hi Stephen,
>=20
> Thanks for the review.
>=20
> On 11/6/2019 6:09 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2019-10-31 05:21:13)
> >> diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/vide=
occ-sc7180.c
> >> new file mode 100644
> >> index 0000000..bef034b
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/videocc-sc7180.c
> >> @@ -0,0 +1,263 @@
> >=20
> >> +       video_pll0_config.alpha =3D 0x4000;
> >> +       video_pll0_config.user_ctl_val =3D 0x00000001;
> >> +       video_pll0_config.user_ctl_hi_val =3D 0x00004805;
> >=20
> > Same question, why on stack?
> >=20
>=20
> Will update the same.

Sounds like nothing to do.

>=20
> >> +
> >> +       clk_fabia_pll_configure(&video_pll0, regmap, &video_pll0_confi=
g);
> >> +
> >> +       /* video_cc_xo_clk */
> >=20
> > What are we doing? Enabling it?
> >=20
>=20
> yes, enabling it. Did not model and mark it CRITICAL.

Ok. Please describe that in the comment.

> >> +}
> >> +module_exit(video_cc_sc7180_exit);
> >=20
> > Same question, module platform driver perhaps?
> >=20
>=20
> I will move it to subsys_initcall().
>=20

Hmm ok.

