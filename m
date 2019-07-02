Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6DA21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562069191;
	bh=JMUvbK/LfOJhb6Ete6QNsOakQUnGfCiPzMOmNQ6+NCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yZL1DYQIIcnCH3qjOIZuBqwdYhagoz2cAsZLDBCfk24rhmoRsnHKyGdWvpGXzhVyb
	 kbazH9S3j1STtFU0/ebEpFtJRZWktcWhAXKF3PRQc+15NHzanJO2BxxTC1cdf3UFo+
	 DOFNrBRd7+RU2gUOiTmLeizHN6O5hm86TkIU3WH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGBMGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBMGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:06:30 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9660F21851;
        Tue,  2 Jul 2019 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562069188;
        bh=JMUvbK/LfOJhb6Ete6QNsOakQUnGfCiPzMOmNQ6+NCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HwC20ALa2Bz/YOW4FKBF/0iy/VmbQeOGBkAAkPTbw4EE8VmR2fSspfXMqIqwBdVc/
         zFjLG4As/+XHC/UKUp9UeDb1GP5DlrEAxFpWnUT/UA0QODaoSD5VDW5BRnZQkzNU7U
         H+wq0YOGmgvMgbg3tmtNjBKsB7mFNNQ1FiH5MGuI=
Received: by mail-lj1-f175.google.com with SMTP id p17so16648026ljg.1;
        Tue, 02 Jul 2019 05:06:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUr1uZ4khOmwGJGEWjlGlNrEcklBi3a+VGqK2KhyTPKYszaSXmj
        C89t7oVNmtl3OeBRKrhrPO0hMOEeXpNxT1jeg3Q=
X-Google-Smtp-Source: APXvYqzUYFM/EIyZphFmV/SpQwmAz/C+DNi3kHPWXR6+ebp2/C/4bHX7aVTINZ72IbXpXBNvNjj3Ls2f2eDhzgGnXR8=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr16985058ljg.80.1562069186791;
 Tue, 02 Jul 2019 05:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81@eucas1p2.samsung.com>
 <20190701131138.22666-1-l.luba@partner.samsung.com> <20190701131138.22666-4-l.luba@partner.samsung.com>
In-Reply-To: <20190701131138.22666-4-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 2 Jul 2019 14:06:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcc3q4_GLg21TL=xNO5U1Kp9ZHqpSERHFVCi8OLasgm3Q@mail.gmail.com>
Message-ID: <CAJKOXPcc3q4_GLg21TL=xNO5U1Kp9ZHqpSERHFVCi8OLasgm3Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/9] drivers: memory: extend of_memory by LPDDR3 support
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 at 15:11, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds AC timings information needed to support LPDDR3 and memory
> controllers. The structure is used in of_memory and currently in Exynos
> 5422 DMC. Add parsing data needed for LPDDR3 support.
> It is currently used in Exynos5422 Dynamic Memory Controller.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/of_memory.c | 149 +++++++++++++++++++++++++++++++++++++
>  drivers/memory/of_memory.h |  18 +++++
>  include/memory/jedec_ddr.h |  61 +++++++++++++++
>  3 files changed, 228 insertions(+)

Hi,

As I mentioned before in v10, I can take entire patchset through
samsung-soc but this one patch requires ack or at least reviews.

Best regards,
Krzysztof
