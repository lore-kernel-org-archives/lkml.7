Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2022146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm/7F/Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCTNDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:03:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40767 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTNDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:03:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so2657835wri.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q43NdQlSOeXTlwCC1tYmfc99j5tQydsNZ9ICi3Ly/mk=;
        b=Tm/7F/Q2/1bQ91FZx6DTqjTxK8MnsOFjQHN9I8t6cb6VGKHop6n3fx91FMvcOHktHI
         BAiaHGPCSaurGTwueeTPrZBhiRosL0R+CGM6MqNzOiKkR3ZBcnnQZRI6r4HVndgAIcHi
         CcVXiL8LOu6juGEY28t6qIs9FXtfM+o8UZmZcr/wu9n0eyJ3ZLuFlh7+51WA8fi+u1Xw
         jtxit68fja8Z9nnpO/7uaBXk3bAH1K9Aviq/CIIgnb1y573wBEN+vqb2OnD+j7r0GTXw
         0a24i8fEs2f/Q7d+07GRRDAkNiYfou+zWgqAP+yAT63Sv/8dYqZiA7T/MKxNElfWYL0X
         1A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q43NdQlSOeXTlwCC1tYmfc99j5tQydsNZ9ICi3Ly/mk=;
        b=Kjiq0mUKH4Ul+nahh8sPzjYrDyX/QoxSBMYoYqgV05vn+G9sEC1erYH2ThRwsg4uSl
         4dTvQKCBiuQsTjA88EewbO8hoCNrzMN3KrarcMeLghtE3Rv8xo0XkNb3PxRHqiZo7V2H
         kQOLd2YZaNVXkIF7N8Q5py2x8EGf01NfUAnWB2/T+s0sSf0ZrPIlL6RBTl/DhbDB+cL0
         EyfhKA5fjgZPKdyWc/27uC8W9Dw0Bcy99v0CyMS/K4AhyXw1BrgdtqgfQjl3nrnitgEV
         /vsaRB4Isgxbq8PSaZiIJz/um4si5UevsrHjUQdGmuvghx+dNFkjpF8xDXCQbE+3pye/
         Ry0w==
X-Gm-Message-State: APjAAAVayc4KIP9l5qWsBhmMsjyhmZXXdshAtya5tm7g6fh6wtWMp4EI
        YzHW2EVwW+HZirElqxGTuo5q8w==
X-Google-Smtp-Source: APXvYqxWeMk7GAFFs3qE4zjc6Czx8x4MyILRfwzD9hdozQeYm6nI871+xbL5m7YgQQD6nMEV497ccw==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr8159694wrp.31.1553086983650;
        Wed, 20 Mar 2019 06:03:03 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id g8sm2055643wrw.22.2019.03.20.06.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:03:02 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:02:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazzisaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <20190320130259.GN4731@dell>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, Matti Vaittinen wrote:

> Add ROHM BD71837 / BD71847 specific device tree bindings for
> controlling the PMIC shutdown/reset states and voltages for
> different HW states. The PMIC was designed to be used with NXP
> i.MX8 SoC and it supports SNVS low power state which seems to
> be typical for NXP i.MX SoCs. However, when SNVS is used we must
> not allow SW to control enabling/disabling those regulators which
> are crucial for system to boot as there is a HW limitation which
> causes SW controlled regulators to be kept shut down after SNVS
> reset.
> 
> Allow setting the SNVS to be used as reset target state and allow
> marking those regulators which are critical for boot.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 17 ++++++++++
>  .../bindings/regulator/rohm,bd71837-regulator.txt  | 38 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)

Needs a DT Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
