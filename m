Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99823C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710EC208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561502998;
	bh=2OyQRpTPZ5dKGVtMN2kaLXoBNGQnIFNE3L3zmlzRXiQ=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=vGjhA+ooGIfmR6FBzDOe8PZB6TBtN7a0qyXtUM0tlpNVLl/ABl1G7D7l3Ny15IylC
	 YXy6/sdEleeoYS6abFOWjSvzhdyUJpXxXOb8I7n5ugNPqiuWzz5AMA5q9NQ5ymfAtz
	 GcWVfI1G+xTm8mCt4LkdQpVM7TZeyO3L981rt/kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFYWt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYWt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:49:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D5F20645;
        Tue, 25 Jun 2019 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502995;
        bh=2OyQRpTPZ5dKGVtMN2kaLXoBNGQnIFNE3L3zmlzRXiQ=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=UK3K3cByXRfSTvFjI5jUzuEbZvQpf/kSdue5tPgOv/xYY/ykWy9HEScIMfyEFwj+g
         VqyqcWRMyHH0uLxhx0T4OIyPNnwouuGAcd/LyM96KDM+ToApCNg/5ojZRpA48C73oO
         puKPFbJHjZJMrRBDgk346f2yu05JDImchrvbnW+U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611211134.96159-1-nhuck@google.com>
References: <20190611211134.96159-1-nhuck@google.com>
To:     Nathan Huckleberry <nhuck@google.com>, agross@kernel.org,
        david.brown@linaro.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: Fix -Wunused-const-variable
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:49:54 -0700
Message-Id: <20190625224955.B6D5F20645@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Huckleberry (2019-06-11 14:11:34)
> Clang produces the following warning
>=20
> drivers/clk/qcom/gcc-msm8996.c:133:32: warning: unused variable
> 'gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div_map' [-Wunused-const-variable]
> static const struct
> parent_map gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div_map[] =3D
> { ^drivers/clk/qcom/gcc-msm8996.c:141:27: warning: unused variable
> 'gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div' [-Wunused-const-variable] stat=
ic
> const char * const gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div[] =3D { ^
> drivers/clk/qcom/gcc-msm8996.c:187:32: warning: unused variable
> 'gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div_map'
> [-Wunused-const-variable] static const struct parent_map
> gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div_map[] =3D { ^
> drivers/clk/qcom/gcc-msm8996.c:197:27: warning: unused variable
> 'gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div'
> [-Wunused-const-variable] static const char * const
> gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div[] =3D {
>=20
> It looks like these were never used.
>=20
> Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) d=
river")
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/518
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---

Applied to clk-next

