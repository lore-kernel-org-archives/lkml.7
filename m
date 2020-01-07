Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AB7C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BE92075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yn2TyRB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgAGMw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:52:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33818 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgAGMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:52:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so30629338lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8QAs8mXhglioLsPrlc/f2d1DW6plEBLWoC91qHtQLU=;
        b=Yn2TyRB1A6iQIcJmRjrzeaQqGvJOWo7XoWbfKsG+WVNnyHmbbqAm3wws8axVbSrvx8
         OYAvdEREwIT61Jq7XS24FPZabB6NFf6CBMS+nk0infpFkx8TMso1GTjbUKZSWQSBei5w
         HeMofh8JjZTxSuMRQYKXswWZEJVsyKirJsdh84VnRNEDBHVnCQmLzMcMRmtA3ydGNgfa
         5L30k/tpjPghGC26xYQZDChA/vk1hkf75dK9VaZF9Qi9vccEh9vpmh4STE4jsKJj/QfX
         RrhfavmoM0fIfBpoXr4XH95IpmY9v05ug4VeNSkEk9IJolXbtwHfYdXRZEAMEgz3UTAB
         nZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8QAs8mXhglioLsPrlc/f2d1DW6plEBLWoC91qHtQLU=;
        b=C2PmX1Wr5LJ2896N8FLePHOMj7xlh2r/ZyD1M1rrrZTHtIOUYSrH82WQhoSRTs7ZeP
         H2sf+sXnqLsaMtkECRZoyzBPfaRh5e9QwjPg38HAGvzk2byDuxIkxklGE5iqItf+4ZEo
         0TkdwFeRKeuYSEQBCpBtj2eKi5sQZB4cjzVRpNRMWzXfw2419Fy1ASZyyQeF57rymGcw
         GvZ16zuCtcpDbniONdnzdrGuiYtPSKUVOKlw+wO2TRpvlwxSJK4RXfuDJaylXI4UzMa1
         QDp9ZDwGlOnvy/9nosWLJtn1lMVcau57xsqAVLrWUSJtvFOPeEmadPEc6fM2IHlBSehY
         XGCQ==
X-Gm-Message-State: APjAAAUduzvmfXTUi/9Pncu2IcyBvFL8psofXyTd2l9fUJcnTcwLIsQ7
        X+8lwg85bNeV1wlKUjroL17TD3UC9xtwfXR2AhGFGzrlN48=
X-Google-Smtp-Source: APXvYqzkwnIC5nKfdjXTDBBv2eSE257wx56BzcThYlaspGGuetJJ+vOHhNKo0xsogQPtM2m4KtEFsYSOjhMxMQYb2yo=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr58545952lfi.93.1578401572910;
 Tue, 07 Jan 2020 04:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20191218101602.2442868-1-ben.dooks@codethink.co.uk>
 <20191218162616.qsxsltfsrxotzqhb@axis.com> <048c9653-114b-f726-44b2-9eb1d460b5b5@codethink.co.uk>
 <CACRpkdYFzHCMLj5oU5JMCkQkMZyOvM5351tpO6iEsE8e5nBZWQ@mail.gmail.com> <20200107111836.uzvja6m4nb5hh56j@axis.com>
In-Reply-To: <20200107111836.uzvja6m4nb5hh56j@axis.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:52:41 +0100
Message-ID: <CACRpkdau_eTe7xgSCMeE=6dv_M5Ef+Opy6EzymxewuU6aecKHQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: artpec6: fix __iomem on reg in set
To:     Jesper Nilsson <jesper.nilsson@axis.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 12:18 PM Jesper Nilsson <jesper.nilsson@axis.com> wrote:
> On Tue, Jan 07, 2020 at 10:39:34AM +0100, Linus Walleij wrote:
> > On Wed, Dec 18, 2019 at 6:32 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > > On 18/12/2019 16:26, Jesper Nilsson wrote:
> > > > On Wed, Dec 18, 2019 at 11:16:02AM +0100, Ben Dooks (Codethink) wrote:
> >
> > > >> -    unsigned int *reg;
> > > >> +    unsigned int __iomem *reg;
> > > >
> > > >       void __iomem *reg;
> > > >
> > > > We're using as an argument to readl()?
> > >
> > > yes, readl() shoud take an __iomem attributed pointer.
> >
> > Shall I change it to void as well when applying?
>
> Please do, sorry that my comment wasn't clear above.

OK I did that and applied, let's see if it works :)

Yours,
Linus Walleij
