Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BAC33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC99D21734
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578254548;
	bh=5OIhUTZbeKG+K1QHOM92kWQIje165tdrU4af9RbebL8=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=fTlLPXsCEZo7CGUXuXntmH+TdPhVKbE3uliCAaYpYwscBVsh0/gaIR4xTU9uuvEk7
	 nwz8TAGrqMRQkw8DSINwLS7TnbFHFozJZNbLYr8iQKuJCjAroEyEs/y5xQiVjiQs9H
	 JFuOylAGiaDFYZZ+0PET5qJbSbzKcL1SyHbFvHmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAEUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 15:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAEUC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 15:02:26 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9872C20715;
        Sun,  5 Jan 2020 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578254545;
        bh=5OIhUTZbeKG+K1QHOM92kWQIje165tdrU4af9RbebL8=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=LOBvBiX/JFtiDrCHixWiZz/wP5pauSrQ+ix4bSAspujfYUfPQd/tT8C/chJYZ/grG
         wnGAZOCagp43tVF8WF0htDVBKwLZ9gvCQl4j3lxyWw2+m/CawTnJvFVdF/bZte/vej
         jex4+vG9j/vj91JbqxluTUK+j5EoakknxQZz4mDk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191126153437.11808-1-georgi.djakov@linaro.org>
References: <20191126153437.11808-1-georgi.djakov@linaro.org>
Cc:     mturquette@baylibre.com, agross@kernel.org, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        bjorn.andersson@linaro.org, robdclark@gmail.com
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Add missing flag to votable GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 12:02:24 -0800
Message-Id: <20200105200225.9872C20715@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Georgi Djakov (2019-11-26 07:34:37)
> On sdm845 devices, during boot we see the following warnings (unless we
> have added 'pd_ignore_unused' to the kernel command line):
>         hlos1_vote_mmnoc_mmu_tbu_sf_gdsc status stuck at 'on'
>         hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc status stuck at 'on'
>         hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc status stuck at 'on'
>         hlos1_vote_aggre_noc_mmu_tbu2_gdsc status stuck at 'on'
>         hlos1_vote_aggre_noc_mmu_tbu1_gdsc status stuck at 'on'
>         hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc status stuck at 'on'
>         hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc status stuck at 'on'
>=20
> As the name of these GDSCs suggests, they are "votable" and in downstream
> DT, they all have the property "qcom,no-status-check-on-disable", which
> means that we should not poll the status bit when we disable them.
>=20
> Luckily the VOTABLE flag already exists and it does exactly what we need,
> so let's make use of it to make the warnings disappear.
>=20
> Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver=
 for SDM845")
> Reported-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---

Applied to clk-fixes

