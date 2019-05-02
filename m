Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EFAC04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66C208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556756238;
	bh=+t4PfgJ/2HT3uiXMwyZ1X6W3d/ohKAnoedNj6h9T0XI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jorV0/P61VjoJCR5ddo6BUwgX++crqmFjfOrj6d8cuDhyRFf7feY8HAYFVTqSz1ff
	 flArWuUmVQh24nRyWp4ayPVMb0Nj5rdmAHRT2wDn2zoIDdIRpGIM7C11i6PguwLTK6
	 /dOquFLtvA2eQl1oGAgP2wXKv/z2m6lb5xCOeXtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfEBARS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfEBARR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:17:17 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D5521479;
        Thu,  2 May 2019 00:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556756237;
        bh=+t4PfgJ/2HT3uiXMwyZ1X6W3d/ohKAnoedNj6h9T0XI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kxmPOedRSh3BDwCTRVYoCYH3EaeOaWci4kGF4KfHGUHBmU7/jvIgtDcF4xJQMt8gs
         Ia7u7Bql+kDyz92T5xQ3vkdbvZQX05ZSBZxfvavYQwceDUDOpEdNnOnB7il4MaAgT8
         9oC74AQ2t9VfHo1x51wYhUfg2oasGFk4MUw0E/9s=
Received: by mail-qt1-f179.google.com with SMTP id p20so566956qtc.9;
        Wed, 01 May 2019 17:17:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWqoECbR57/jOvtAcM8KU21ri31kTt+nnFai0G/FGbxlV5Rqtyl
        2ET44L6H3NP08gr3QCNBTmSvGzH0ULtdAt8vUg==
X-Google-Smtp-Source: APXvYqxG4bdpm8gOX9jiw+bfKSqkbABzBmTfe7sbYm9qzroNs3MagX8duRXQ4IU1I4uiVsSIJMWFNDyOjJPK8vmEQDs=
X-Received: by 2002:ac8:610f:: with SMTP id a15mr760854qtm.257.1556756236084;
 Wed, 01 May 2019 17:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190414202009.31268-1-digetx@gmail.com> <20190414202009.31268-3-digetx@gmail.com>
 <20190429220542.GA17924@bogus> <137c766e-66f6-828a-5c3b-f526d66d37bd@gmail.com>
In-Reply-To: <137c766e-66f6-828a-5c3b-f526d66d37bd@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 May 2019 19:17:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCWytgQEDPLX27xdaDrARtHssbhFcL47RO0zfECm0Gig@mail.gmail.com>
Message-ID: <CAL_JsqKCWytgQEDPLX27xdaDrARtHssbhFcL47RO0zfECm0Gig@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 7:06 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 30.04.2019 1:05, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Apr 14, 2019 at 11:20:07PM +0300, Dmitry Osipenko wrote:
> >> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
> >> The binding is based on the Tegra124 EMC binding since hardware is
> >> similar, although there are couple significant differences.
> >
> > My comments on Tegra124 binding apply here.
>
> The common timing definition doesn't fully match the definition that is
> used by Tegra's Memory Controller, thus the DQS (data strobe) timing
> parameter is comprised of multiple sub-parameters that describe how to
> generate the strobe in hardware. There are also more additional
> parameters that are specific to Tegra and they are individually
> characterized for each memory model and clock rate. Hence the common
> timing definition isn't usable.

I don't understand. Every PC in the world can work with any DIMM
(within a given generation) just with SPD data. Why is that not
sufficient here?

In any case, it seems for Tegra124 a different approach is going to be
taken. Seems like an "avoid DT" solution to me, but if it's contained
within the firmware it's not my problem.

Rob
