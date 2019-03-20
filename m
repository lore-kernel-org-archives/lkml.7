Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2B52184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwboogMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCTKBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:01:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCTKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:01:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so132114wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1CIwH1U9SYp875jAzSIcwZ9x9RyCUsPkAajXYObNIFU=;
        b=UwboogMsQIX687zE7rjWQyqIlugpyq8QUc/SKDDvnzfeejRxso7MXbSrvIUf8ieRLT
         xOX2AsT3jsu5diZIBRhhpwV5TOkRY1kA+mPiczkRJLHKW8d+d6rjDx+8Q4W0NQ6LaoOd
         ZyAhmlg22SvGYwgvHPDb27gc+apoeMnFl/I3LTLsO7Eh2e7AqPxgWmCHKxPjsZpjK1+7
         mkjgB8f6Rz8RO/Indscq3Tx7ECPrSFvbeM3WkMHHe1c3/LJ2qnN+45vvTuHNf4ymKcl2
         7wUXojdDqcJACkUI9vriBIUXv7mDy5bCb0ShIfJb6e2mE5dyffuMLnF2PomsT2AWR0pl
         PNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1CIwH1U9SYp875jAzSIcwZ9x9RyCUsPkAajXYObNIFU=;
        b=cRDRxYgAGrPxOPlQDOssqtXh0uu3YFMEAwGIprgdocxxb9mk40kV7qasukW442aJCw
         jMejaSNIY0PeEXguEByWDsLhordPBFy3hsn4CmoamGjZ2k/tW1scSEpT40s0qgvyzfua
         xCZL9/AnImAMSFMbHXgLQQoXtirpeUO+XnKKZfAJzJUDaKzAnhdmOaTNrK9FWX5RA+lF
         CSYJV6ZuJm49aIbh5wEmssJNEJOBL+0MqvFRbHMNiodNGZuTXpfxkyrj8lvG4Hq0p3XN
         m+cM5NTRkwvBI6cE3kJ9+le7rOnc8wLiyQietHTzCBMxW7zNZLxJ1ulAHkrsjLZCSUf5
         czww==
X-Gm-Message-State: APjAAAVlY/IEOimtNNVcxUfUURk085ZJ2MNvbuH/ELJMdM7fpsc01bNa
        PiOptWHMBu9UHgoM51LuQxqFMg==
X-Google-Smtp-Source: APXvYqw6RGMUzpXTmAfSwhIr02xcX4o4qGLmlJ4Juj7C3iRHDPtbU8Kq8cSs3GAiAM0IpRUqWL0e6Q==
X-Received: by 2002:a1c:2743:: with SMTP id n64mr6355546wmn.143.1553076064150;
        Wed, 20 Mar 2019 03:01:04 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id n13sm1667933wrw.67.2019.03.20.03.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 03:01:03 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:01:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: sec: Add support for the RTC on S2MPA01
Message-ID: <20190320100101.GL4731@dell>
References: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
 <20190213222402.20541-3-stuart.menefy@mathembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213222402.20541-3-stuart.menefy@mathembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Stuart Menefy wrote:

> The RTC portion of the S2MPA01 appears to have the same
> register layout as the S2MPS14.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>

Tags should be in chronological order.

That way they can give us more information about the submission path.

I'll fix this.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
