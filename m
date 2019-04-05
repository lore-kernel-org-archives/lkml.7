Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233E621850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWCEUZ1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfDEDoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:44:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42138 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDEDog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:44:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id v24so317367lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysOXVsCvmDLs9jl7dPJN5aaC5LdJ7owRufPP2WCJAxA=;
        b=QWCEUZ1m/jkWjcLSyIkxSuneu4rAKw5HekjVDZdbT6CNK4THfehH5ROnz+kPrkLmsv
         s4dNccspw61cGyZVeYsXbqapldGdB3+KqF37OqkbxZqdJ6f62ZViyNunitxWgknVLoQl
         DfTUGqQrTGpsqj+dmm5ZDw5lC/XkACEdQ/qvWO+3/97xvPdXfY9hhpSik8AwORM6jbXO
         zMT5QNp5IczidV2j2tWUXW9VdZ836zj0tlUAK43AFuGO64lmjP8tRn2f2bDbuBkzQ3/Z
         E2TCjDEZQvn6qVgoGXwR83JhlWtkpVmZHyKgGC6ayHvpD5Ge/tqkxXq+/oXQjG8FiMUH
         nD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysOXVsCvmDLs9jl7dPJN5aaC5LdJ7owRufPP2WCJAxA=;
        b=lNmD+Rq2vYjvbp1d53Zo39msTVb0ejffdVIqM9uauu0z2oQdnj+1gDXtVrYtM9TAcN
         Zzy9oDA+yvLXHYhgQF1ARRZWtANl9DdVF2q7p63aCOefq434uvqgp+BAE8KhfBzzxfol
         +RqDXLpG9qWiO6fUkb+/0PoGTL91y96ES+sNQpQ0Gpe1ehAcMkrMPSeqYNYfzVfPMdeu
         WAQNnYoztBUT1c3IUsIZGhni3wf1SrhbGexfcXB/H1fm3jvp2M5JrRA7gwIeO2AnIxW6
         ggxcLK9rEBB7USXeNSqwdiyX6ylO9gNjaYTAG8/UjFoy24+7nkqSB2LETeSpgWres+tN
         lUPA==
X-Gm-Message-State: APjAAAWBT/ynER7gcun5ltvk4Hi5ygO+9bNCfoO7C8WD0UbVC1bh090t
        QUgndfAYnxe4NxBBc0RE+nSW/a9CfZWjRd/9I3LwCg==
X-Google-Smtp-Source: APXvYqy64gT9tV/4nlSef1srlR4NwC4p6Rm9eb/hFrYO/W3fqrdypN5V9VjmGwZ3N3C2xfBPMCGyjkCCRXfFvgomXCs=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr5160914lfy.128.1554435874351;
 Thu, 04 Apr 2019 20:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190401033535.16910-1-zhiyong.tao@mediatek.com> <20190401033535.16910-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20190401033535.16910-2-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Apr 2019 10:44:23 +0700
Message-ID: <CACRpkdZN2tDRKkPK0jn9Y7vmBV-2iH3+d7Wnm4CNYXgPNaCAbA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: pinctrl: mt8183: add binding document
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        chuanjia.liu@mediatek.com, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:35 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> The commit adds mt8183 compatible node in binding document.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
