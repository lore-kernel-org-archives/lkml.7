Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF721479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKX/lzAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfEHLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:52:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfEHLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:52:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so2893166wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bgzoKqv2vMCjmxJ3xMeLrXg9m73MgNn3EHeek8J9Jxg=;
        b=tKX/lzAEg5dvRlrWNl6NKBcTzikX0amTt12YXTGKL08kUnoqwQ9a0d+7hrlLVD0t8R
         I6I/NiseKd4g+RvEp9uB0Sq1XIhBfuCNsweM7c5q4mC4qxFr8IlELCRbHl5rTPcBAjzK
         vFkCiBrF7iWZeCj+EqPqEr3kqXHNE4Gh6ZhSp/Swr5jGPSLMLyVkLHOKjpdHRylphX5m
         Nu2n2+9AuUIiT/L622qQadZQctHkxLKzFTIKPNmZu3I6QuwpOhoqhLpfqKiUp11uv2fw
         kjEddNH13fQa7MM4ZM1a74kxReMnDA+T2EM9EYRAv6pk6QxMrQI7VyraWPK73DJbNnUF
         qgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bgzoKqv2vMCjmxJ3xMeLrXg9m73MgNn3EHeek8J9Jxg=;
        b=DSQas2jdznuZfeGbaPFZon/Eh3YCjdzgIX9BFS5Qg+B1z1RAdYWggbCMCnhD14FXXJ
         75FD2M9/T6anh9p563GFBJ+W+R6QaqafIRJZKpGV1kwkyOCfEj2Xc7EWG2Efhce7+dPy
         W1B6IeN72iCXcELD4PADvf1cKqpNfOjgryZ4/jIA9yQwzA98MumBn4603foTqhntkaY5
         BdW8V1OBG02N3qjcjp6T9rcB22Zod9EU4d9O9k3Hxmdy4I/xjuar8xr2rOpZgCgVUpFp
         Osv0zRfYwJYaPoSFXed4GzGNHK6BRd/cQUekna52eL0FdEUDjcLnVzKwASfJcSYZMBqD
         HeNg==
X-Gm-Message-State: APjAAAW+q2Q+xANncp1902S2yPxZ7qTxbhue7FSZujn5SnlbQmiru+UE
        UKV350skq9eBfiNzBlbLJXnmdg==
X-Google-Smtp-Source: APXvYqzdG+CtYf6DOkiIqnOU8XWoNkkbpTTeRfLOp2Jj920q5O5hA+jcM9Fx2TLWUq5GF5da3ZHklA==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr2916093wmh.74.1557316353693;
        Wed, 08 May 2019 04:52:33 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a184sm2953209wmh.36.2019.05.08.04.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:52:33 -0700 (PDT)
Date:   Wed, 8 May 2019 12:52:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rdunlap@infradead.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: mfd: Add lm36274 bindings to ti-lmu
Message-ID: <20190508115231.GN31645@dell>
References: <20190507201159.13940-1-dmurphy@ti.com>
 <20190507201159.13940-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507201159.13940-3-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 May 2019, Dan Murphy wrote:

> Add the LM36274 backlight driver with regulator support.
> This is a multi-function device for backlight applications.
> 
> Backlight properties will be documented in it's a supplemental
> bindings document.
> 
> Regulator support is documented in the regulator/lm363x-regulator.txt
> 
> http://www.ti.com/lit/ds/symlink/lm36274.pdf
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
