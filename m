Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2031C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14682085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJ2S5Kf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfHLKjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:39:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35045 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfHLKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:39:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so11320512wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MoT41+8OBiG5AIS32B1GbYNGjZ0zGQf3yjOjNkvAl3w=;
        b=zJ2S5Kf3w1FcFPelYkhvCORLN+zhfHCjFVxYX/pJUoUgBttJ+Ltp91Qo/Myb29W7+0
         BT4dNqpfBa2GMtxrqp6X1KpgMqr0z/r1W68XlRpxtCHEZA6Vw6XKhMfThLc88OeiuwQC
         O+DNfN0f23PvnZdBns2cquJa2LKegJgvigS7YJJf8at/Okwj9TG+GYImG3fzUD54wHB4
         jcPDCJXkzU/ZPxeNT8x+xON67m+c9gr6X5TEplMaJjvWoEBVTNR16ZDhRGMudmjTGXqf
         pDSOEJi7CDwPCj4m3093m/3u3iXqBjUZ0Z65QR5LM4PJrVSKv19mLu1AzUCRXbDsJ2A/
         PTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MoT41+8OBiG5AIS32B1GbYNGjZ0zGQf3yjOjNkvAl3w=;
        b=Pig8fsK8hf9INhj39E7HEUviP0/CmVaHIigVAJ4x4gogfzifNgi0cmvQRghh//IHdq
         Ih3tJWNSmFt4MDdjn873JLm3xG/cDGtWEzcSwD0zNKfi1wlWPhwo8+xDyQnReoUYMjS3
         o1317et/u7DLwloZzLT3uG4RZeNkUfifqz8TdaQCarH03bz7Wg1WG5MZT7Y0GLUP5KUS
         hHhBa8nh0W/ojfgb5Lpnqh4HvDxGCCcFc9EMB+rGL2TKsA9v0BhUvpfdpYHZxuqRDdxh
         ihOu/DxvrGzTUMR+Yrl1Dw9LZ+DEU4dxwGPQJMJndlCgVK3T/DHmCT0vaiWkhBGfVam2
         sD7g==
X-Gm-Message-State: APjAAAXDZ08IGTiWizl2UdNxAly/mdaqgOF/bgE0TZj4v5HpHocX2ucS
        MQsJ05TnxO7l9fCuxhOOBMXIXfKbAsE=
X-Google-Smtp-Source: APXvYqx6gLOcb8+8c8NPQ25MpEKF5l7SJvWJ0ZAVhYpzW0O0BzOf3cmdjAVNPOp+sxVnpmCkiRPArw==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr2485651wmm.75.1565606374600;
        Mon, 12 Aug 2019 03:39:34 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id z8sm6099540wmi.7.2019.08.12.03.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:39:34 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:39:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] mfd: madera: Update DT binding document to support
 clock supplies
Message-ID: <20190812103932.GN26727@dell>
References: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2019, Charles Keepax wrote:

> Add the 3 input clock sources for the chip into the device tree binding
> document.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/mfd/madera.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
