Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F8DC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25320838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfIKVHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:07:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38463 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfIKVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:07:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so245231qta.5;
        Wed, 11 Sep 2019 14:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFuB2QpmFZeeFcW1/wDZ3Q3qc6SL3R+R31YUNn2vg8g=;
        b=i1PQfPLVIgwVLpHDiD7It9LdELRRY2gF65WSTOPg+AmmjzZe3lyYdaCX6PIO2+LMkA
         HVxeO4ymGXjgOfF4okV55tE+Qgf2T3e1LG8LMnlhJ5BV+mHwuE8Zp55rD9f9NfJ4Xhpl
         RACSJFLV0Edl16Fv4AEcPTKti10qnVTdsSEpob8gLoePIZscURT4dVW+3n0orYITXvCM
         B/BAow/3ZToJigKOEz/3BxGLPbmoGOvjbWMx5iKMy824K9M99UmewVdvw4Bbzcup3oXQ
         JuVWJvDHlnQXKMHRgD5mvWeM1QmKN62VCEG2lsHyFJSJ9jQNgFQxkODTmjoYIc9Jo8u5
         uhng==
X-Gm-Message-State: APjAAAUkaJCJYFoAn2KqzyaSRIu5d3+y03zUjnQaR96qARQAGn3XYuur
        OMO8AKhzPA4t1OUwFCZAEYqZ5MCqY2bnsSY4Fk4=
X-Google-Smtp-Source: APXvYqxmXppy4+77gx+LlXeaQMHszT42JLyi2myisyPCzAxn3WpjRosxEgQuBtMuYRI4gv0BJqTsq3M7LCuPPknqN5Q=
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr36952783qtb.18.1568236053461;
 Wed, 11 Sep 2019 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190911183632.4317-1-krzk@kernel.org>
In-Reply-To: <20190911183632.4317-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Sep 2019 23:07:17 +0200
Message-ID: <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> Unfortunately the patches were applied right after closing the linux-next.

Hi Krzysztof,

I took a look at these and am not convinced this is right:

> 1. Fix boot of Exynos7 due to wrong address/size of memory node,

The current state is clearly broken and a fix is needed, but
I'm not sure this is the right fix. Why do you have 32-bit physical
addressing on a 64-bit chip? I looked at commit ef72171b3621
that introduced it, and it seems it would be better to just
revert back to 64-bit addresses.

> 2. Move GPU under /soc node,

No problem

> 3. Minor cleanup of #address-cells.

IIRC, an interrupt-controller is required to have a #address-cells
property, even if that is normally zero. I don't remember the
details, but the gic binding lists it as mandatory, and I think
the PCI interrupt-map relies on it. I would just drop this patch.

    Arnd
