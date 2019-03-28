Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B997420823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553797908;
	bh=GMxzqRuozr5B6NBtCVMf0XZpqCQ+aaUYeHiD7DoUAmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Psrr0qfxFQdKE2RsVN8u0xW8K/SYh8bE9lS2AD4DMVeiyUUG1nrwZ6UdIiz7kQ9l0
	 7z/FqzvMxZv+mgPkLGd0cjJg+hQIqPOFY8kpVLv7qPMKgCpy6LvbruypwtUz7B3ay3
	 63NwN3C0VSMhsS2c6c82oW7lixauznUzoT7BsHpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfC1Sbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:31:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45389 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1Sbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:31:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so19253650otk.12;
        Thu, 28 Mar 2019 11:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=miy4e97Z76kCPIRZohfLeLZSveKeyxIxbeqwlTXXopA=;
        b=jpRGEZHUWVtQLz+am5fNE2drpWtiFpQFdXHy/OghUOXywaP/YTErot8CYd+aOUeFTo
         6hmjopaNSRC/yuZEcR9/WK9itxD8DWfJW/wcHXLWxuP3ZyiUTF7wp2fFA0wk+mm9uXK7
         eSrhB2T49GOZ27wmmuSNyBOD++yybbhy5j5+5hIpHDNvFqV3cntWY/HMV8ednfzpx50x
         0HDDEY+TgFfZwqqJAlyghzPUhm0xDOLGdSyG2FpYjweLaF3Ww4dcDTTV7gdgwL2oaT5Q
         e1fuWcHzYnrhf30d9vDoW3+vdDt+5QxEVMyuhR55fyfgPkztRF0TULRNUDuMbouT9I3r
         jqbg==
X-Gm-Message-State: APjAAAWTzN1jLOm7BAEaj7TVoGFZYqDl0/CERxHnSUf1x7x083PhOttK
        OHJqpDAhXOKif58I1RosPA==
X-Google-Smtp-Source: APXvYqwf/t5TpCMzZbXBKoEldp1OW686PD4htX+og+v0jVJ5CKiCZnHLN4aLD6jc48uJb7l//SDY7w==
X-Received: by 2002:a9d:6c45:: with SMTP id g5mr32978834otq.54.1553797906532;
        Thu, 28 Mar 2019 11:31:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p1sm1634943otl.75.2019.03.28.11.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:31:44 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:31:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        srv_heupstream@mediatek.com, zhiyong.tao@mediatek.com,
        hui.liu@mediatek.com, eddie.huang@mediatek.com,
        chuanjia.liu@mediatek.com, biao.huang@mediatek.com,
        hongzhou.yang@mediatek.com, erin.lo@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/4] dt-bindings: pinctrl: mt8183: add binding
 document
Message-ID: <20190328183144.GA7855@bogus>
References: <20190325124137.6117-1-zhiyong.tao@mediatek.com>
 <20190325124137.6117-2-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325124137.6117-2-zhiyong.tao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 20:41:34 +0800, Zhiyong Tao wrote:
> The commit adds mt8183 compatible node in binding document.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
