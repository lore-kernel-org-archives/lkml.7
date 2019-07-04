Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96089C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58283218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="LmvE9UMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfGDI3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:29:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34341 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGDI3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:29:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so3681846lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnem1hwsrm93G06buvpONxqUaY+n9TOak/BfuwFpubY=;
        b=LmvE9UMk/EMiGfNjNoQwH6DEFJfg8e0Z0gmAkQhrXCBpg7NB++yLlVllSc95hdmhNa
         Ae/vizscwx18LrUCp82da8IBjlNv3S0RaHaPVm/8TMZYoSydDePjs/IE1Vsa0QZ7sInE
         gn10xpIa/E1pwbP2FqW0gD0mJCkMSR2rR8+eSxkw7p5xLhttG5wp5HH7W1bvFzQ9gk2N
         3jfMtE25upVnypfht+yjzZfNbTq6tMwPVMBKRCyeErxFioryfh8a/pvsh5HwBJYXp+9I
         3+BmjvI2yxQQWV5IB8OTyVacbFKczUerwKpSjZ7C58VV+JakT0ku+nZ3gGJSkJ1nVHyj
         6ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnem1hwsrm93G06buvpONxqUaY+n9TOak/BfuwFpubY=;
        b=AUSqir1cVlqkQ1rm5i6WE8S9NUzkpte0DIA3++jP280c5uGFAfyN2iQjDbJv58ouzc
         OUWsbryP7XA9oX5cU/vRwzKY6XtGv0MiwrMsLtmnoFkC/P4SgkPKh6EduvQkERhfv13V
         VY0Fop+IPMcq/TjGkVPH//tvEKXi2JlyrItqcCw+lfEhYqE1T12YYxHAlgaq6/PRDgFt
         dH3wcPXoDxbsiLsKyXiTtyfWo3pWNxeOELS/BS1ngUsz89ZJlh1SkUbDKZIseYntCUe4
         dnQmKha1pRjlmNmNm4zAekXHmndhosRBaQjfvWw5SEEaJev9Q5rNiLYIyAFPgDi8A94r
         pUMw==
X-Gm-Message-State: APjAAAU44Izib9woHS0VFDD29v1JBAZaaTlJrrG1Ls4P6vhAedGckHuh
        4Yxc1dCDA9hDKcF55shtZImP8g==
X-Google-Smtp-Source: APXvYqx4B0wO9flz1Xpq4e34GcOEiUr+D9RtNIxwtd12MUUrgz8GDZ8I4qxnvOSFpjDlMVr3tfeEFg==
X-Received: by 2002:a19:8093:: with SMTP id b141mr399490lfd.137.1562228956675;
        Thu, 04 Jul 2019 01:29:16 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4f4:91a5:b48d:cad5:1349:c0d9? ([2a00:1fa0:4f4:91a5:b48d:cad5:1349:c0d9])
        by smtp.gmail.com with ESMTPSA id f30sm756030lfa.48.2019.07.04.01.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 01:29:15 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com,
        marek.vasut@gmail.com, bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, anders.roxell@linaro.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, paul.burton@mips.com, liang.yang@amlogic.com,
        linux-mtd@lists.infradead.org, christophe.kerello@st.com,
        lee.jones@linaro.org
References: <1562138144-2212-1-git-send-email-masonccyang@mxic.com.tw>
 <1562138144-2212-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <93e86083-7f8a-402d-db4b-26263719be25@cogentembedded.com>
Date:   Thu, 4 Jul 2019 11:29:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562138144-2212-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03.07.2019 10:15, Mason Yang wrote:

> Document the bindings used by the Macronix raw NAND controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>   Documentation/devicetree/bindings/mtd/mxic-nand.txt | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> new file mode 100644
> index 0000000..ddd7660
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> @@ -0,0 +1,20 @@
> +Macronix Raw NAND Controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "macronix,nand-controller"
> +- reg: should contain 1 entrie for the registers
> +- interrupts: interrupt line connected to this raw NAND controller
> +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
> +- clocks: should contain 3 phandles for the "ps_clk", "send_clk" and
> +	 "send_dly_clk" clocks
> +
> +Example:
> +
> +	nand: mxic-nfc@43c30000 {

    The node names should be generic, and the DT spec 0.2 (section 2.2.2) even 
has documented "nand-controller", please rename.

> +		compatible = "macronix,nand-controller";
> +		reg = <0x43c30000 0x10000>;
> +		reg-names = "regs";
> +		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +		clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +	};
> 

MBR, Sergei
