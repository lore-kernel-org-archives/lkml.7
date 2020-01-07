Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001AC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4436A2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t57Lq1k+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgAGNBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:01:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55959 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:01:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so18849551wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 05:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rsd4WxHtfQsVDCvn7FcjJVFWrx0QIgf8GxfkAbKjofQ=;
        b=t57Lq1k++t+1RObQ6sShnQgRverizUkmwShdSCnRt9lpDnO9ae7437MuvUAIXbrJ13
         INGbLEg/mxAp0Az+JMD+P/LXln2x3nRQtn89tWSipX+cmE+giYUSjw0azjchIbqEeXIA
         R3TnAzO/6tD73X3mZ06to1NKqGSM3dHV/KGpDlk4tr6qx0f4a88uNKIImQky61zgNluh
         m81wnD2SGnhdCbhdcms6156P5FWQ/5m4g4IiqvvyrmPPgt2N3eOvI69cXoZu6ZoULuBM
         b3lt43QWtL5G69mqtICN/BNHVuJAmOvp8aKuMAC8M1AJIn1u503vbmdmafHh6WyaQRzt
         jF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rsd4WxHtfQsVDCvn7FcjJVFWrx0QIgf8GxfkAbKjofQ=;
        b=PdESxsCVFDCQiRUD3VymbmyG6MaGfV89xlvbLpZXxotzYguT0udF9t0AYr55kzK0ni
         zV2ubXgXlwxjOOB5WsPiE8MtGxazfgudSckhxMByhc/IW3+9sdldZYNr5mEfOeBaiMyp
         ovI0JE85YpY6kd01WHcfEYejwVoqWoyzlGoblEJWwaeooolqUvOQS+N9Tw0UFR9N4Jnw
         F7hbn4M1rQyVEZnfDkqlDZUb78VCRDCoo7oK/ZSLXa/94Fs4zSxxgHdVxgEG/yFc3RHv
         iHaHx7LHfPwC5c8uhDlhpKc4GJ65HWrUS/SLt/xFXShcDdwMmfWHXBxjNXqe6leosf8u
         bSXg==
X-Gm-Message-State: APjAAAWNraeP4jfy1wOgrxpUTUq4o6ZNzHug6dgx0Oas3T6PD5jA0qsH
        2+Fo+TPesEJE8PBukCjwydzv7A==
X-Google-Smtp-Source: APXvYqwMlqIbVKT8/8AOvzjJhmb6FM38WJc7sDo3lwZDlIiVfkTWsJRI+dWlgGyRqgxg/h7EevIgaA==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr41447568wmh.44.1578402102060;
        Tue, 07 Jan 2020 05:01:42 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id r15sm26449932wmh.21.2020.01.07.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:01:41 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:01:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20200107130155.GK14821@dell>
References: <20191227111235.GA3370@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191227111235.GA3370@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019, Matti Vaittinen wrote:

> Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> the binding document to two separate documents (own documents for BD71837
> and BD71847) as they have different amount of regulators. This way we can
> better enforce the node name check for regulators. ROHM is also providing
> BD71850 - which is almost identical to BD71847 - main difference is some
> initial regulator states. The BD71850 can be driven by same driver and it
> has same buck/LDO setup as BD71847 - add it to BD71847 binding document and
> introduce compatible for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> changes since v1:
> - constrains to short and long presses.
> - reworded commit message to shorten a line exceeding 75 chars
> - added 'additionalProperties: false'
> - removed 'clock-names' from example node
> 
>  .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 -------
>  .../bindings/mfd/rohm,bd71837-pmic.yaml       | 236 ++++++++++++++++++
>  .../bindings/mfd/rohm,bd71847-pmic.yaml       | 222 ++++++++++++++++
>  .../regulator/rohm,bd71837-regulator.txt      | 162 ------------
>  .../regulator/rohm,bd71837-regulator.yaml     | 103 ++++++++
>  .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++

Can you split these out per-subsystem, so that I can apply the MFD
changes please?

>  6 files changed, 658 insertions(+), 252 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
