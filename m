Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030D5C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51252171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568750503;
	bh=Che2+9+ePoUuGZV/h3gxyTYSugwlLxiZHrpBbNST7tU=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=2KFrWwkmWDjLFQ/bjDXjZJYv/7V1ag1wF01MPnozxjpg78vBLnSoVEtzgVUEDX8FX
	 gYvJrLcELQfa7E4FFUA6XxUpl+/WmJRNqa69I0p9xaLQ6/oKHbeOLXIEoQuqR6ks7C
	 QExxUj3v/p+aWTWAgdN+N5MhN6PWgwy0oi1016jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfIQUBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfIQUBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:01:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9313214AF;
        Tue, 17 Sep 2019 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568750501;
        bh=Che2+9+ePoUuGZV/h3gxyTYSugwlLxiZHrpBbNST7tU=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=NT6KqF8XvAQFJRCWcD/2ejgKGLjoEZN6nYr++HDJeb3ghE3e9ctBtccsz+h7KQGrc
         ebYzv9TqEbDI80Mq8b4BYzGO2onxdYpkrKQO3nwIA5vaWgK09xdHl6so/l90tYBMK+
         2m5gtoJYEqfa38QXLidx1ZBBI3oSb25yLAZgVZXo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190916154546.24982-2-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-2-manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, robh+dt@kernel.org, ulf.hansson@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/7] clk: actions: Fix factor clk struct member access
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 13:01:40 -0700
Message-Id: <20190917200141.B9313214AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-09-16 08:45:40)
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
> While we are at it, let's rename the "clk_val_best" function to
> "owl_clk_val_best" since this is an owl SoCs specific helper.
>=20
> Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

