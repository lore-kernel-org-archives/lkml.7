Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0936CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EB6216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568752428;
	bh=OCmjyJeaqRLek0C4FKcAxnbTQ4/wO6fYl5ArFt32PpI=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=Gkv1Qc4wrkmokttX66FEpJXueqjAEukU6ljNSffiYjZwEpCzzwo0hrJDaJJowRX5N
	 JEVHlLN/XFzPO+ohZ2CDwJIfYQi3iItlmSJp8F9drypTnarLqzWHxdJgOIaamAuAtF
	 +9CscMuCsIaxtgMmxakCM+aO6Rg/nxotE6nu7ACM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfIQUds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfIQUdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:33:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04BE32054F;
        Tue, 17 Sep 2019 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568752427;
        bh=OCmjyJeaqRLek0C4FKcAxnbTQ4/wO6fYl5ArFt32PpI=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=MSmLNetlce/Df7YgxgYUktpoBZJ1RKBUfvCLfNmM3GpOMWde2dL5OqPJK066flD8V
         /TwYo+q9WPUIdymQvuNaP37AoI20J08j4lli+TQpWRt5iRSHAbIb1GuHBHEt31QynS
         h6CjDWHSyuALB1Wql/R+AtNRWUzaQMU2S9z+0xak=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190913024029.2640-1-bjorn.andersson@linaro.org>
References: <20190913024029.2640-1-bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Make clk_bulk_get_all() return a valid "id"
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 13:33:46 -0700
Message-Id: <20190917203347.04BE32054F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-09-12 19:40:29)
> The adreno driver expects the "id" field of the returned clk_bulk_data
> to be filled in with strings from the clock-names property.
>=20
> But due to the use of kmalloc_array() in of_clk_bulk_get_all() it
> receives a list of bogus pointers instead.
>=20
> Zero-initialize the "id" field and attempt to populate with strings from
> the clock-names property to resolve both these issues.
>=20
> Fixes: 616e45df7c4a ("clk: add new APIs to operate on all available clock=
s")
> Fixes: 8e3e791d20d2 ("drm/msm: Use generic bulk clock function")
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

And now I see that this whole thing needs to be inlined to the one call
site and should use the struct device instead of calling of_clk_get()...
I'll have to fix it later.

