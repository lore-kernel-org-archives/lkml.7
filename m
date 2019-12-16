Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D6DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7898206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OC0UO2BJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLPQmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:42:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42182 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLPQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:42:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so5865908pfz.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=tEFANuRfrtEbXVW2kT4hb0C2KzTNmSirXF8koSqQv8o=;
        b=OC0UO2BJXeENM4Cbn94I+bIgETrJ0X6BAYk8ZfwLXFw18OzceJhE8oiuEoSMUL/pHt
         M/H+Y2c0EtXdGPj/+B2I7W0dHG7mRFTrLdnK9c+EfpmkcOlvPnLkzvwZKAmS23pAPDJp
         YLdmB9hBVjmn9V/B9tJibbZJmv830c+C4cuws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=tEFANuRfrtEbXVW2kT4hb0C2KzTNmSirXF8koSqQv8o=;
        b=DbqleCUgImrTiIZJ/b09KOGFWk2n+OX+6si7ZiKog768N38h4Ne99cidIQZraaSx+X
         6AfSVQv8lIQTUePeRqFpaYV8ubLYcIrApMhdoVaOO9nnrUuGboJxrMlDgDv/qgfPcPHi
         pvGHMG8x6eMMXIblbzbId2KJtl1PHuUBQVrNMa1Ut5Z7ubow0UiyLFmdQGF1N/fZzEJ6
         pIVOOZkTwRY9/87g5c43U/PXsJWS/cPxmwL+I1U1hE5cDDIM54dh1uz1TMC6njArXTbM
         HmtYVqMDCqqg3+F8F2pMz4BDDowOALMn1ONrzVZiWALKFgIPZPqe9qsz+gWK2gvfyltG
         jGFA==
X-Gm-Message-State: APjAAAVhj2+zcBGKoUK+k2PYlYafbUgEMHPyFK/7IjKHubK1E0ZEglnk
        2JC/fVMQc0RXkIHmjFSKUp1tqQ==
X-Google-Smtp-Source: APXvYqx858IvO891FQ+PAlePnfwquAJeL9h4+4TcpmC6btQgALdMcGge3MsYBYMJWyRrqvxCfMaqYw==
X-Received: by 2002:a62:7696:: with SMTP id r144mr16912411pfc.177.1576514555188;
        Mon, 16 Dec 2019 08:42:35 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w11sm22988142pfn.4.2019.12.16.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:42:34 -0800 (PST)
Message-ID: <5df7b3fa.1c69fb81.fa080.21a7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1576488351-22396-1-git-send-email-akashast@codeaurora.org>
References: <1576488351-22396-1-git-send-email-akashast@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: geni-se: Convert QUP geni-se bindings to YAML
To:     Akash Asthana <akashast@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 08:42:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akash Asthana (2019-12-16 01:25:51)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml=
 b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> new file mode 100644
> index 0000000..2c3b911
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> @@ -0,0 +1,196 @@
[...]
> +
> +  "serial@[0-9]+$":
> +    type: object
> +    description: GENI Serial Engine based UART Controller.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,geni-uart
> +          - qcom,geni-debug-uart
> +
> +      reg:
> +        description: GENI Serial Engine register address and length.
> +
> +      interrupts:
> +        description: Contains UART core and wakeup interrupts for wakeup
> +                     capable UART devices. We configure wakeup interrupt
> +                     on UART RX line using TLMM interrupt controller.
> +        maxItems: 2

Shouldn't there be a minItems: 1 here? And then you should specify the orde=
r?
Presumably something like

	interrupts:
	  minItems: 1
	  maxItems: 2
	  items:
	    - description: UART core irq
	    - description: Wakeup irq (RX GPIO)

