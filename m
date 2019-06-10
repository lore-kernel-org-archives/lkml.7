Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBCDC468D8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E74A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560178922;
	bh=OE8GdsTUm6Imy2zPdYlPLj1uy7lqP03V060qQqNy6s8=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=Jz+SWAWYBtQVPBGb89zsjDHveZMA8GsfGzfzFnAQN28Ns3/y0NMvhyyWWgOViKfs+
	 NKj97b3f3gd/m33VAfj7aVCjhiXpA3smDI8V3W45fAhYboggOKFzuZcMfYDtBaLfqt
	 0Yt76YrQHwremeYvcc80Qsr5bluUHe1Mvv/Eugxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbfFJPCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfFJPCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:02:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A32220859;
        Mon, 10 Jun 2019 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560178920;
        bh=OE8GdsTUm6Imy2zPdYlPLj1uy7lqP03V060qQqNy6s8=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=09qdbjyTF0YwhwLeCe/ZJYYrjFSo7df/akOmOhnJL1Nz3+iRIEvhIDMmr6W1dCBIf
         bE7KCXS2+R0ZyWXhbq4kpFl1epH3RXBDn+J48Pc3eOudwxKGJ4+mMIXjGfXhruxbkL
         xuh+QFQ8z+yVqfnuBQzH1Utbh7+3X9fCqVIbXVQw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org> <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, robh+dt@kernel.org, ulf.hansson@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/7] clk: actions: Fix factor clk struct member access
User-Agent: alot/0.8.1
Date:   Mon, 10 Jun 2019 08:01:59 -0700
Message-Id: <20190610150200.8A32220859@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-06-08 12:53:11)
> Since the helper "owl_factor_helper_round_rate" is shared between factor
> and composite clocks, using the factor clk specific helper function
> like "hw_to_owl_factor" to access its members will create issues when
> called from composite clk specific code. Hence, pass the "factor_hw"
> struct pointer directly instead of fetching it using factor clk specific
> helpers.
>=20
> This issue has been observed when a composite clock like "sd0_clk" tried
> to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> error.
>=20
> Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

I agree with Andreas on the function name. With that change you can add

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

