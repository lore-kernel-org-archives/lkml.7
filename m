Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994142133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/zTVZ9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfJDVIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:08:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45096 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJDVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:08:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id r134so5379982lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HhK03oaSMo/8bfjDBpniHapGQAbMA85rfpZvXfLdmYE=;
        b=R/zTVZ9cr4Dv8veyibem6M6FqmnA1nRbPvXXGJhzC3vvRGdG4nQviiDVwQKAqeNO/Q
         j4G8zEWfji9Q79jp5eAF7Vrq0wcotCPVwy1nvuwPt3mBdfAFiuz9RhbZieNyMqfjMrlN
         lQ591WIa5foe+e1z6YOquDkGDQOeSW5umDpND2DY7gOIsHkbDT6s3YjCQS3U//XcfoQq
         e/s/oEgmdH6EbtFD/PzvfTviSN0w6EUlBlACaac32wmHxBoig/rsdE4EIeygRCEI0hJJ
         htXNEaLS7gnR7K8DOeTLvre3Lz28CRvH1hg6CpnbzVaMwi0tC+B/JUAU+02JAjGkCVsv
         pkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HhK03oaSMo/8bfjDBpniHapGQAbMA85rfpZvXfLdmYE=;
        b=MY78T9OJqhi89VfN1SLBW9xqjlSP+c2tjyLxvSR9o4DDdGERd3SPVYoO/r55WW76tP
         RFinEleC+f1EqGQRubr//o0+EyYWcMEzq8SLOfPob78niCDw92pDbF4lo51Uqe8GVglB
         WFwMLtU78U5Ejsddu6PIq0Xyo4aHPibiUFgNfZY+DAfZQ3aaqXko8wdgjo7ZODDrzN7l
         b5sMrSJbIDBH7LA4RFqyGj75qY038oRAWjMmuxysg/5u7PRTHVjWdrLBUS/yHV17n3RH
         M1Txs62wjBWLZMDzC11lTJbWLcVXFgUse4w/E8+3reZCq9u9bxmhJfPMyuIGOg/G8nUR
         rceA==
X-Gm-Message-State: APjAAAUjGK0yM5RXiEOGfIdrZ60VUUdhzEcn3BPm1PpbARpmtGO2rRfJ
        qZX9bNPKHYoP1CZB/TKV9o5bCxZ/dy0KQA0NTKXn2Q==
X-Google-Smtp-Source: APXvYqwcJ2IUcDRtVTDYiQp+7VS7VKfkfuUC7BqSpv7lLTzAiR1ku6ptlziiaElGrVcXfadjuMfj784U4pQ1Sg51j4k=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr10121755lfp.61.1570223294668;
 Fri, 04 Oct 2019 14:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <af65355e-c2f8-9142-4d0b-6903f23a98b2@web.de> <CH2PR02MB700047AFFFE08FE5FD563541C78E0@CH2PR02MB7000.namprd02.prod.outlook.com>
 <bd860b05-f493-20e6-083d-66ef3cb61f60@web.de>
In-Reply-To: <bd860b05-f493-20e6-083d-66ef3cb61f60@web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:08:02 +0200
Message-ID: <CACRpkdZPnRJWojgRsZvSTDWuxbOtQws5uQXDSPBBem6HE8iJgA@mail.gmail.com>
Subject: Re: [PATCH v2] ethernet: gemini: Use devm_platform_ioremap_resource()
 in gemini_ethernet_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:23 AM Markus Elfring <Markus.Elfring@web.de> wro=
te:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 20 Sep 2019 10:52:56 +0200
>
> Simplify this function implementation by using the wrapper function
> =E2=80=9Cdevm_platform_ioremap_resource=E2=80=9D instead of calling the f=
unctions
> =E2=80=9Cplatform_get_resource=E2=80=9D and =E2=80=9Cdevm_ioremap_resourc=
e=E2=80=9D directly.
>
> * Thus reduce also a bit of exception handling code here.
> * Delete the local variable =E2=80=9Cres=E2=80=9D.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Seems correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

BR
Linus Walleij
