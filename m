Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73110C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42979217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3wa8NUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDKNdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:33:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32904 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKNdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:33:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so5577415ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laaJz8EQ2TImpAAiwiHz+eFnv5QTGyYOBMFay+FlkLU=;
        b=p3wa8NUPMarRp0Xb2D29Hex+wGEZAW3C1yDfGrIGCAfzN/g0sYRjFLxnyTzDWNBiUG
         iqQIkiUvdGi82YSwk8NG6eYroBFVkChGDCFfwbxnQ0yIUIgQCjTHGKC7AaUrsEE4Osc+
         lDawUVtkiYEAAQ1838z7b86k7GdOelCnzCoH5ckqaSoCBFoH63xtTMLOzXxLN8nBhkbK
         Gfe03aqeFk0PqlLEP9+NMmsO0QCU6OyaqsAINyJm3XdmfxOuoYbjVkJdW2xXsEWCm7I5
         Md2lam+UKabdSamJKeqNjTN5/2L6AwXYC73iKOVGfDK1TAUzqdizyWfobb6oUl4LSpdi
         QuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laaJz8EQ2TImpAAiwiHz+eFnv5QTGyYOBMFay+FlkLU=;
        b=rKNmO3cxYVG/TYHSYuv+aV9DJ+/8Fvi2Q/ClvTi5VdraHF6KT7kk0O+QbhG/X4T7j5
         9piu1CTFR+fAeL++LlfD+pPXbtALhns+8BKRlkPbsZy9N1JEWFW6dWGPVS4SiHghZnuX
         HYTWGUYE3j+bvwqqcDo23MtrVKAQAbcfnNxB8rNK9a2NG0jbti3TXrH+f7tC2SdFtJa9
         slTcBp6BOV3s3h8j8bl3gVFp06dU/obo8l6KMNwTB0Ec6OaubrsNwUmi+vUvMX4BuWJe
         FVCvkGrRepG40KidSZWX5Zr1I7MZNhx2bui4UWWojsl0rxN3Gq/lQtmdXYCGxe+WfqpJ
         rl4w==
X-Gm-Message-State: APjAAAX1Kv3aYrIfLKpfPkgfNfBnKbt0kQXcMu4n/iUTV9rLzPZQ5/6t
        ln/tuAkec2vlTiIKxwPCIPBfqlqmfvoF9/zpvxDPKQ==
X-Google-Smtp-Source: APXvYqy3KuKXQAugvewPrLfXi8bO/Wv0QhT70qJg8pSyIDEegNCBEKZuqbIxIzXJhTczy6g9ZqFFfPG8vAx3Z+o5cXg=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr26415232lje.138.1554989593745;
 Thu, 11 Apr 2019 06:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <1554800820-5412-1-git-send-email-p.paillet@st.com> <1554800820-5412-2-git-send-email-p.paillet@st.com>
In-Reply-To: <1554800820-5412-2-git-send-email-p.paillet@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:33:02 +0200
Message-ID: <CACRpkdZBkLHfPdNjeVWwg5Nv23gxY2wFeXa2GAX=1pvL7bXw5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: stm32: add stpmic1 support on
 stm32mp157c ed1 board
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:08 AM Pascal PAILLET-LME <p.paillet@st.com> wrote:

> This patch adds stpmic1 support on stm32mp157c ed1 board.
> The STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
> The DMAs are disabled because the PMIC generates a very few traffic and
> DMA channels may lack for other usage.
>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
