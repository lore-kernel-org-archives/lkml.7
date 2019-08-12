Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FDAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7332A20673
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565639638;
	bh=F/zUy3fK065yrPGhjPTWbq03dhm0wVUyzDzKPDc0vwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AGUWb9KCSmssOXMp0N17FSa53ZtoswU4k8dapZyabvnpAEiA+kxSMgNKEGZ8HnF7l
	 bXxU8Q2ENS4F0plEeUqKSvQGApoWp+5TKmPsQmSExNNxqL9Vwy5qY1Q6iGO4zoNDwY
	 /oWeEgS4eLplOaRZnsLU5mVEyVbVwC2JHb3d+ic8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHLTx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfHLTx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:53:56 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76861206C2;
        Mon, 12 Aug 2019 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565639635;
        bh=F/zUy3fK065yrPGhjPTWbq03dhm0wVUyzDzKPDc0vwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BMU8WnCrbKPHJn1JUY/xu78450ItVKNYznbbSff2/x8PBE1E1y4OHkwjlPl/GWqQj
         SIhOE5gP1J06pp89em2uL9icxToECD+QDXDEcBxwf6AarDTmTGydVrNa7VhZOhF4eT
         FjEfC4QnzrxG0L1q9y1TaxReAxahua7befQXofAc=
Received: by mail-qk1-f182.google.com with SMTP id r21so77967190qke.2;
        Mon, 12 Aug 2019 12:53:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXXXzh6fiNvqlMPFl9nCBJVfDU2RYXJTfj8LWIXjBEoM2D3mnnV
        d9X1TOchurIq8JpEX+PnYnp0ehNPMnmXfl7AHQ==
X-Google-Smtp-Source: APXvYqxvF+3OYnh8lLCaSgAnc2SpvFQhEBMbdxkMiGqfF0Bbx6x4plOFoaGa258Ol/aNvRQvc7I+0egI8cNP4MLDSr4=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr31785938qke.223.1565639634684;
 Mon, 12 Aug 2019 12:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190811210043.20122-1-digetx@gmail.com> <20190811210043.20122-10-digetx@gmail.com>
In-Reply-To: <20190811210043.20122-10-digetx@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:53:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNwMOMyDaB=zqbCLwfn+ro6RcvXFkRbN_t-mEeUi3rVQ@mail.gmail.com>
Message-ID: <CAL_JsqJNwMOMyDaB=zqbCLwfn+ro6RcvXFkRbN_t-mEeUi3rVQ@mail.gmail.com>
Subject: Re: [PATCH v10 09/15] dt-bindings: memory: tegra30: Convert to
 Tegra124 YAML
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 3:01 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The Tegra30 binding will actually differ from the Tegra124 a tad, in
> particular the EMEM configuration description. Hence rename the binding
> to Tegra124 during of the conversion to YAML.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../nvidia,tegra124-mc.yaml                   | 152 ++++++++++++++++++
>  .../memory-controllers/nvidia,tegra30-mc.txt  | 123 --------------
>  2 files changed, 152 insertions(+), 123 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
