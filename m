Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA37CC28D1C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CD8208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559809646;
	bh=wpE63JkDLT0yLZrn+u6GGMWaSP1LpoFoajDjPsPt97I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ju+k+CRs2NNNsLlagjYk5CQpWC7DeNM3SRW4zTSJL55UOJx6nwgeK4OynF1HFuv1T
	 fIhZVou/XIQlb3GPRfbuMMZQmjPbM/Td/iZQJDD0DUTq3Rws8wbA5lojlY4w93+0uG
	 CDhOvF0epCvWFScSHI1aJxyaFtVdBbDgRBlXk/aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFFI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfFFI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:27:25 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B67207E0;
        Thu,  6 Jun 2019 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559809644;
        bh=wpE63JkDLT0yLZrn+u6GGMWaSP1LpoFoajDjPsPt97I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Amo3shYkuMgFCazqHJGzIapSUjvUwzTJFQTOH8SND+NFNiCg2Nn/o422aw/uEMYOB
         HSBvtzTXzMRf9xGi3h1NK4fwHslkAnoPYrlJsZ9QMDuUcijLWSRW1YDDh4Yy0aTnyj
         crO4XS1cWL2UYO+qhKplG8TPboLOLNZZ86l1WjyA=
Received: by mail-lf1-f41.google.com with SMTP id u10so130956lfm.12;
        Thu, 06 Jun 2019 01:27:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXihtfs/Q3tnuMIC8/H79hPi0/yQrlt2iRUlvzU8+5Qs8FHNSYF
        EJncpbn8q3hCz0W0CEBYNZbN47klx6q/K1mgYOU=
X-Google-Smtp-Source: APXvYqyx0w55jiGOOjbOLSDMBzCulZMVwmOnP5rsfNYJBvmg2AphO8syImHO9O9MbNC8RO2ywrcHDeQvJUP1Wr8D8vY=
X-Received: by 2002:ac2:5601:: with SMTP id v1mr9885968lfd.106.1559809642680;
 Thu, 06 Jun 2019 01:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605165432eucas1p170415ca2025df5b2cefdaa4ae7fb0f64@eucas1p1.samsung.com>
 <20190605165410.14606-1-l.luba@partner.samsung.com> <20190605165410.14606-7-l.luba@partner.samsung.com>
In-Reply-To: <20190605165410.14606-7-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Jun 2019 10:27:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcyOA_wmwUefMMH36qNKBeXwZ47uF+BVMYbkkMDYaaa2w@mail.gmail.com>
Message-ID: <CAJKOXPcyOA_wmwUefMMH36qNKBeXwZ47uF+BVMYbkkMDYaaa2w@mail.gmail.com>
Subject: Re: [PATCH v8 06/13] drivers: memory: extend of_memory by LPDDR3 support
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
> The patch adds AC timings information needed to support LPDDR3 and memory
> controllers. The structure is used in of_memory and currently in Exynos
> 5422 DMC. Add parsing data needed for LPDDR3 support.
> It is currently used in Exynos5422 Dynamic Memory Controller.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
>  drivers/memory/of_memory.h |  18 +++++
>  include/memory/jedec_ddr.h |  62 +++++++++++++++
>  3 files changed, 234 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
