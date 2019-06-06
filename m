Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B61C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA17207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559809567;
	bh=wDXrpyOwL+LjZfaZjJPUv4duizrtCWxmnrJolZ71jR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WOkfF+C7yipuYWGFeXEgFWrPFa0Lqw1GT7b95BVgkcZilL4T3ZMRb6vwhdlO9cFR/
	 YW5xgM1eZk56ZJXC1JcGub7Zwo0kIjrjHg5t5q43Uu6gZ7r60lzSclX7ihEwjv2lv7
	 dLQdICDtUfPbn8I/MsMhBjSm2LfS8hdDxnZL0AjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfFFI0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFI0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:26:05 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD33F20874;
        Thu,  6 Jun 2019 08:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559809565;
        bh=wDXrpyOwL+LjZfaZjJPUv4duizrtCWxmnrJolZ71jR8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HumZh8TYb73Se/qjCptWIl11mEusUBQ+ReUkZQ8A4bXwAYmnomCFC7omQBEGVlaOo
         5TYNbm5g3960qhaFXsiZ+9ln1HD61rrfcu7nWgC3EddPUXIFrA1Uv92x0bxTVn0JyD
         e8jkFxxPLJS+yZncqYkAAjUaNJEI2C1dMte0jNkc=
Received: by mail-lj1-f172.google.com with SMTP id t28so1127375lje.9;
        Thu, 06 Jun 2019 01:26:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWlb/mC/fZIK6Ufvf4n+9dtPh8xj7FI7BEJR9rdUyv6M5CXpFZu
        KrOPj69guwBzzGONSmFj/kAzzJttvvfIyw/bUCI=
X-Google-Smtp-Source: APXvYqwWjg3pXgyMEw427WjUsecZN9+F3YO63TbhH0qDVbkKIS2+97Iz/GaPq28+Hw7zF+Krz2MUFy7B03zMHzYrqlw=
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr10201076lji.64.1559809563013;
 Thu, 06 Jun 2019 01:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605165429eucas1p224e803c851c9fd28e3d8737392a8a5c3@eucas1p2.samsung.com>
 <20190605165410.14606-1-l.luba@partner.samsung.com> <20190605165410.14606-4-l.luba@partner.samsung.com>
In-Reply-To: <20190605165410.14606-4-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Jun 2019 10:25:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdpKRY7SGfXrOREQQP2mx84umthDp_SVuLomqG-whCQxw@mail.gmail.com>
Message-ID: <CAJKOXPdpKRY7SGfXrOREQQP2mx84umthDp_SVuLomqG-whCQxw@mail.gmail.com>
Subject: Re: [PATCH v8 03/13] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 at 18:54, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
