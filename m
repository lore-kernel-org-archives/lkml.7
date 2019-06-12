Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B95FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A53208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dusx49mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438755AbfFLMRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:17:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46997 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436570AbfFLMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:17:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so10545545ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2txdGGqAtBgtUiiIPP10i5KT2B4f0+7u5UH9LS7ouJg=;
        b=dusx49mrCLSgU5t83nzKnjS+WluovaOxnHyWSgEcpeQJPi0w63Vjj0FYvbpHl8IZ0M
         0Eg7mJFCz8lJciydS+e8UNQaC7r8ojgw9QaIwsF5onCMIfBQpqxcaGfmtdOVvxgAS1KJ
         iZq25ceilSdWqf4legHqbrKpfWh4VKQT0VMk1AZzYWalsKzgxxO8bSpWHPJeScvgczFQ
         UG9KdibBNgx/ir54+DcjvIdzr+rJjZpD58RkUmmiAXwcrcVgH4HS2cGQGBcFg8/U+PQZ
         Sos5qV0IrsWvi+9ROxVD7rnYs9P3dEm3uBX6AprDgms9/N5jIdr73kQfNzUk9tpZsI4F
         PxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2txdGGqAtBgtUiiIPP10i5KT2B4f0+7u5UH9LS7ouJg=;
        b=d3cmae8fZLBepARW7E1EzoLOJq6Iw325rwcnNQcOKyWU/mIwVbp2EA+tNK07JOrINk
         La8drGGC20beuwrXaVdkX9osWI7sDcRmI8lwtjcB8biQ0h2z6J9l7IEn2zkVtzkb7n3U
         rMhiqABqA24th0/xqDvO2UTHl+E5668bDPCwTlue4O0NZCXk4muPABN4jx7RBmquSvTw
         vy1bj5b5POFy7HUgGOyAxEHvW6io9JC5p+o+SBs9770RIMT8ywYqKYoc8A5wsbJjLSN8
         mwk5f8EVEomtRyZ06pgrlVl9I43YtzsK5mRk1G2y+DsM2V6sVJS8dun27Guf7heeYCN9
         s18w==
X-Gm-Message-State: APjAAAVLNzwfDIzNpid20aM14DIVcZp7p+cxKGxZjBInRCFjMdJsUDTv
        O5+gX1+wRzyqQ+op9skMqkTMWn4xvW/JnRCNRW5p1LPCxqA=
X-Google-Smtp-Source: APXvYqyY0A/WfPrOeCNf6qf18ESfRNrBcrzXIRXu/sUdZWtDXsnEw4ymCliw3ZfYA/tTBPR2Wnzztl40Q8AA2XCcUE4=
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr33483063lje.138.1560341832416;
 Wed, 12 Jun 2019 05:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190611072004.2978373-1-lkundrak@v3.sk>
In-Reply-To: <20190611072004.2978373-1-lkundrak@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:17:01 +0200
Message-ID: <CACRpkdb7jZ3Hw3uH_hqGRhbsoreQW17ck_QPXKxqLA8ov9ffuQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: lantiq: Switch to SPDX header
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     John Crispin <john@phrozen.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 9:20 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

This is already fixed upstream in Torvald's tree, see
commit 1d0ea0692ae3f909b22e99af3121bcf3142a5c5f
"treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 332"

Yours,
Linus Walleij
