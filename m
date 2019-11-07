Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA7EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC55F2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573162932;
	bh=sJ4kWfM65cs2kKKB1Bjv645pjW+/Mmm8O6iB7YJrzvY=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=0ziPHfBXZGXVJq8rDZx/pmDh+IVfXl2j2j5Fdztulr22u6X/VomJo46wMaTWBem2v
	 YwiUelDkxM9R0IX4ZkG9jfxXC5ht9Hl9ldgV8o/3RvY913z/ocNgZMW/jZuYYp2HMs
	 XRlg9KEhoO6yEAZO31I6wJwSCqAQt1MhrDPphFco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKGVmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfKGVmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:42:11 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70C32178F;
        Thu,  7 Nov 2019 21:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573162931;
        bh=sJ4kWfM65cs2kKKB1Bjv645pjW+/Mmm8O6iB7YJrzvY=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=ENO6+8pf4qUpI4gdULrHw/O6Zmln2GJOTPdo89ZzxnwW8V2MSxXJLcGIyJsf4PJbS
         xq7U/IS5j7qlMk7ypMWt+4bqztX4NzAvHbCbcGUUk0xH6xT7idl6wDVMsqLJ3dZxvr
         KajjamqUFpJvEFQIV4g3af//fUl9LtKkSOvkH+kw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191107190615.5656-1-jeffrey.l.hugo@gmail.com>
References: <20191107190615.5656-1-jeffrey.l.hugo@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, mturquette@baylibre.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH] clk: qcom: smd: Add missing pnoc clock
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 13:42:10 -0800
Message-Id: <20191107214210.D70C32178F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-11-07 11:06:15)
> When MSM8998 support was added, and analysis was done to determine what
> clocks would be consumed.  That analysis had a flaw, which caused the
> pnoc to be skipped.  The pnoc clock needs to be on to access the uart
> for the console.  The clock is on from boot, but has no consumer votes
> in the RPM.  When we attempt to boot the modem, it causes the RPM to
> turn off pnoc, which kills our access to the console and causes CPU hangs.
>=20
> We need pnoc to be defined, so that clk_smd_rpm_handoff() will put in
> an implicit vote for linux and prevent issues when booting modem.
> Hopefully pnoc can be consumed by the interconnect framework in future
> so that Linux can rely on explicit votes.
>=20
> Fixes: 6131dc81211c ("clk: qcom: smd: Add support for MSM8998 rpm clocks")
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---

Applied to clk-next

