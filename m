Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D07221920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568814295;
	bh=NsTNEQ9pNzRNy7TB1KzHS8aqTaRQ1Xa/uYBY9oHJ228=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jlRqf49rSbo0hykma5xpWnapVVguRuINw9MKsRzQOSw/FfqpDy6QkilOUBE8DUVQ/
	 Zso8gn1TlTYknHPAhrqomUfogv25mDrhvO0yOY6z4RtwMviXv8cpS3jG798olycuZb
	 6+RgRzjReG+QeCpKpG02Zp0VxlfaKp2c6copnCU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfIRNoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfIRNoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:44:54 -0400
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A7C21925;
        Wed, 18 Sep 2019 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568814293;
        bh=NsTNEQ9pNzRNy7TB1KzHS8aqTaRQ1Xa/uYBY9oHJ228=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pFhYuyuXLzsolpe52rmJvLGjKw+WqQHA+IXHkmK3FQY5OJW6t8t5r513QDLen1/A8
         8Bl4ZRpXnW5TB9BM15e37DNN2AcaofIOB3kFt4OonPv9/3t5Pc8vH5FyvEnVgQ4Sde
         ideuQ5H2ClWdR+Vs9SwvJ/hq9qYksSqwwxI5i3n0=
Received: by mail-yw1-f46.google.com with SMTP id x82so2461689ywd.12;
        Wed, 18 Sep 2019 06:44:53 -0700 (PDT)
X-Gm-Message-State: APjAAAW7nCJjmlGA4rOUZW+SBtyIlxwtnO4hViMiUOLm+8vW4wqhbKMN
        N/nQ7imcNE78jrBlEwEcPFYX0zjkWVYRR6BsJg==
X-Google-Smtp-Source: APXvYqzAWf80PXPbYa5YFe71i5C6DTZvSwAPx2GlseUyJKphr7cVsIZ3oHwMTHgheYaO/eC4h5CybbQoMaq3TLVKRw4=
X-Received: by 2002:a81:9182:: with SMTP id i124mr3297116ywg.279.1568814292316;
 Wed, 18 Sep 2019 06:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <1568804927-13565-1-git-send-email-pragnesh.patel@sifive.com>
In-Reply-To: <1568804927-13565-1-git-send-email-pragnesh.patel@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Sep 2019 08:44:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJhH2x6xto9yJ+0V5YiYn9J_Y_bABG4_N6MK0M3XFCPqg@mail.gmail.com>
Message-ID: <CAL_JsqJhH2x6xto9yJ+0V5YiYn9J_Y_bABG4_N6MK0M3XFCPqg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: dt-bindings: Convert spi-sifive binding to json-schema
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 6:10 AM Pragnesh Patel
<pragnesh.patel@sifive.com> wrote:
>
> Convert the spi-sifive binding to DT schema format.
>
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>
> Changes in v2:
> - Remove address-cells and size-cells property
> - Added valid values for sifive,fifo-depth and sifive,max-bits-per-word
>   property
>
>  .../devicetree/bindings/spi/spi-sifive.txt         | 37 ----------
>  .../devicetree/bindings/spi/spi-sifive.yaml        | 86 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
