Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E48C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289EA20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568201805;
	bh=BzhirzR9rKgLcs8QYiB3WTcr5z2B+Rmcc8JzkFSqIsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CvpLCxYA3bkaceZas4gZh+Weux8tVJIzjkS3YlfYDZgB6YnrNd4NOVGoEnu0UE26i
	 HTPE5NmZo8mN5Xy+vB0fqPgR+9bH1THCwrzgNihTb6Tob6GlJ2GjGPcQ3X9liexCmA
	 e96j81QrYe8mxabisgJC4OAqhenTiKOUtLZkA50s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfIKLgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfIKLgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:36:43 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E2212168B;
        Wed, 11 Sep 2019 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568201802;
        bh=BzhirzR9rKgLcs8QYiB3WTcr5z2B+Rmcc8JzkFSqIsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XYXXeHI5GSr9s26qIRfYonfO2cfnZMvfdVJRX6G7HOe57tVzrYmQ0bqoZott2nf8s
         q8u0WwmhBm6jcr1Q/uw5mHVGH6CFjkgBvwRqTKY2ctSwuZ2A7qp7q82B07ND0eB+2A
         Ul1Q84j6FLGxkX0gnMZc9HOKqbdAZwRR/l4eZgqM=
Received: by mail-lj1-f170.google.com with SMTP id d5so19645823lja.10;
        Wed, 11 Sep 2019 04:36:42 -0700 (PDT)
X-Gm-Message-State: APjAAAUSKLTmBr3IXxloAKmZckcXizq7qZCOSRolg3iwq3gt5FH0R68w
        Ic0CWo2Yk2W4lHLQ0TCFu4EBNJTXdfDBVO5R9RQ=
X-Google-Smtp-Source: APXvYqwfc+Lu9G+Tlo3lntibr090Kk9wKzsHWBSgh4Zee3oG+Pzgcvi5+Fv6P6cv6Yi71PWv9R2fNgse4kVCY2KSg4M=
X-Received: by 2002:a2e:9705:: with SMTP id r5mr5012909lji.13.1568201800688;
 Wed, 11 Sep 2019 04:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237@eucas1p2.samsung.com>
 <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com> <20190911110446.32058-1-m.falkowski@samsung.com>
In-Reply-To: <20190911110446.32058-1-m.falkowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 11 Sep 2019 13:36:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeZ2usT+bx23n-hXxsLsbZqr-0JEtyagK8sfsLaFiaH5w@mail.gmail.com>
Message-ID: <CAJKOXPeZ2usT+bx23n-hXxsLsbZqr-0JEtyagK8sfsLaFiaH5w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: arm: samsung: Convert Samsung Exynos
 IOMMU H/W, System MMU to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 at 13:05, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>
> Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
> to newer dt-schema format.
>
> Update clock description.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi Krzysztof,
>
> Thank you for feedback.
>
> v3:
>
> - remove obsolete interrupts description and
> set its maxItems to one. There are some incompatible
> files which will be fixed with another patch.

Driver stopped supporting two IRQ lines in commit
7222e8db2d506197ee183de0f9b76b3ad97e8c18 (iommu/exynos: Fix build
errors). The second IRQ line in Exynos3250 DTS seems to be ignored.

The patch now looks good to me:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

However for some reasons you did not CC the IOMMU maintainers. Please
use scripts/get_maintainer.pl to get the list of folks to CC.

Best regards,
Krzysztof
