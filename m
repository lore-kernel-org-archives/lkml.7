Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A71FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292520673
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565639825;
	bh=0Wyq8gRX+YB6Hi9mvXeI7gj0j8jjRHI+9JPnbcW8S9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=unB2181+rK21Fi/A3Xb7ayMsW+E9MUU49YZA0AEMJex3tm8KH7/OKWXws/MPqYyQW
	 h8y5qh9n7Bn93qgIr11pYpGdXAIXhOu7xoI2PNXmVSptZi9681QwVMCvpYm/q8vBqD
	 HdNmawwliOjoOQBc/bwgnMqtt5aNXIdv9t13l/lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfHLT5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfHLT5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:57:03 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86ACD20673;
        Mon, 12 Aug 2019 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565639822;
        bh=0Wyq8gRX+YB6Hi9mvXeI7gj0j8jjRHI+9JPnbcW8S9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LJu4yOIHhqmH6BXy4Nw59e/M8v1EyCT3TGXcdAST3HiE6E5LSwQL49TcrTpRoteST
         cD52ZKhBWi4es8PfeqJaA5Uqdp2asYs+5ysUANAqWZpPggg1ULlio9DgPDPDC28pTY
         Q/6XrBl7uJDvPp1bORip01fA5bUbhZyuRXmb+ZLQ=
Received: by mail-qk1-f181.google.com with SMTP id d23so3107340qko.3;
        Mon, 12 Aug 2019 12:57:02 -0700 (PDT)
X-Gm-Message-State: APjAAAUm1509uiZkbe5FpU/XuoXhIXFM7S5jRw2d1TiEA85+Y/VPXmTC
        BIRaJo+QjTiLsaMzwSN4RtyPrcZdFAnTzahvbQ==
X-Google-Smtp-Source: APXvYqwbeDLDdSfYvvuPol6nSCJtYC7q7IPJxs7tKCRp0ktduhXYm+7IFcq7/0Xv4DtfRo5N7j0Aur9H62+Q+vIXD8w=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr24373612qkn.254.1565639821789;
 Mon, 12 Aug 2019 12:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190811210043.20122-1-digetx@gmail.com> <20190811210043.20122-12-digetx@gmail.com>
In-Reply-To: <20190811210043.20122-12-digetx@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:56:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK3c+5FzcHMNJC7RnGeMZirMT-b3NZ8yCa5Mwy=Pq53aQ@mail.gmail.com>
Message-ID: <CAL_JsqK3c+5FzcHMNJC7RnGeMZirMT-b3NZ8yCa5Mwy=Pq53aQ@mail.gmail.com>
Subject: Re: [PATCH v10 11/15] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
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
> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
> The binding is based on the Tegra124 EMC binding since hardware is
> similar, although there are couple significant differences.
>
> Note that the memory timing description is given in a platform-specific
> form because there is no detailed information on how to convert a
> typical-common DDR timing into the register values. The timing format is
> borrowed from downstream kernel, hence there is no hurdle in regards to
> upstreaming of memory timings for the boards.
>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../nvidia,tegra30-emc.yaml                   | 336 ++++++++++++++++++
>  1 file changed, 336 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
