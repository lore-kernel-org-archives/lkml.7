Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AF2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0438621D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576702280;
	bh=y6OjPef+rLpmHOy40ubFOZPlQMl+VJ/dd5KAD93sLrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UnLbbZDH2mr/j/vik+R0lbP6UaIGrUpg3DgahXD19tK0o1c/kCME6E8/hLPni91oW
	 3yZ3WELFUWrXjdffUtih2cED4lH9FQicfT1k7XcxK7duA/vDVfOlQDidpy4cwypkzy
	 LThR3W+1s9sIJwtAv8LJgVVpo9jcPxbXdcsj7EZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLRUvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:51:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39588 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:51:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so4084692oty.6;
        Wed, 18 Dec 2019 12:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nSEj6kyDhq5P6mAclRcvCmoF52iAZQnMbrNJi3sF4JA=;
        b=JyTl4fDyRoIW9oSgB2mvLAl4hOKeIRGVUS4cYxnZQAdvoBGA00RSomlZCsqYyXLC0o
         4v3Rpk5MXhk5ijJofxxGy7k1bG00SQ6JQ34Vp1Kwyeg/iXOBl3fGpggbhnhqTtlIzew3
         wydmxTiZcZ65g6GJW/5Rzgt7avkQqr3lEPYYqjH2uKbxbbmRmp1x5wkNDab9/3lYcnlh
         YpyPLLpJqBHE2C7/NfH/y+heFm7AylmtF7CDZtHsKwWPwzkjYgPk8oeD3pRcuvu+JNGf
         SF+SZ0MvO5B9olS+hcP6n1g/Uu8PGTFW0g3yqCzCG8DX3IRp8yexlOkZsxL7zegzCFMV
         nhgg==
X-Gm-Message-State: APjAAAWSN6uDlvPj/qkHfnrcvUVwe/OAIr9OSGEQesekebWfn2QzlI/b
        FbW+UjAfmMz1JRuKYCpZMg==
X-Google-Smtp-Source: APXvYqygAa2pY0RW+kCp3G3EmR9J+pePpjjBE3bTxuC6HQw9JYgh4wl5v+3NVqjlcimD0GHFuRxY6A==
X-Received: by 2002:a05:6830:605:: with SMTP id w5mr556250oti.79.1576702277913;
        Wed, 18 Dec 2019 12:51:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e6sm1215390otl.12.2019.12.18.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:51:17 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:51:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        bmeng.cn@gmail.com, atish.patra@wdc.com, sagar.kadam@sifive.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v4 4/6] gpio: sifive: Add DT documentation for SiFive GPIO
Message-ID: <20191218205116.GA31691@bogus>
References: <1575976274-13487-1-git-send-email-yash.shah@sifive.com>
 <1575976274-13487-5-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575976274-13487-5-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 16:41:12 +0530, Yash Shah wrote:
> DT json-schema for GPIO controller added.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/gpio/sifive,gpio.yaml      | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
