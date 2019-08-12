Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A845C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5AD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJdNXt9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfHLHsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:48:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55885 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfHLHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:48:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so11208748wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oJisgWnDEB7FRQeVeun93jQaR5ES1KStdB1vVlMSndA=;
        b=EJdNXt9fogeecU1R4hnXUKwFMJyvnzUbRbu/ZBtaKLYANBuo3ev/dL5cXIwiHMeWiC
         7f7TupDpedezy29E+TolN5ydvQtlCW5MMqAou+wZ3X8IBvxMxu4jiGFWQzs5osgo5U1z
         6ywt22fqQidjCbuxP2IMDljpuioTTAt+MpIw6wPocxW5lxZpJtE8JJcvu+UXW7UJyHdn
         4tHNEX2d3I5nNKZXS2C9hnlNwuUQLPFfqsnCrNauoLJrTEQxKqMCmmVK8Yk1mwbZyP0W
         EhpQBBZs2clCyA2FpH4as0BA6lbPYBhaoF1HjTBgA1RNlmP6SSgMvNsVaRacdr53heS9
         CpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oJisgWnDEB7FRQeVeun93jQaR5ES1KStdB1vVlMSndA=;
        b=Ec4WDHRJylQK91pBGuHLkkjMemughwfMyv74DB5ShgJdmBw6vS8lNqNmbVOcxncoV9
         ImNjXnKS98Vh3P3agZlQsti96rTOD/qOuxgCp7lPawqtazJri05J5WnzW1Sx74GECw8j
         pojYChIk0SnH6ocuQibCaq5Go8BN+C7ASqKMnCV3t44CXNNc101pB1DxCQN3wHHVqpWE
         dwToXIwU4dP1ZRGyXpYN1CnYJP+amEO9pi9iQPo89sa5FS5pSbYv8G3LwJ/X4HOFJYEB
         hrZ3X1txZhpoJKmmzmPOIofs3AdmgzHMWR9Q8ZFdJkE172HC+epcMMznWb7F6BUB8HyR
         1qtA==
X-Gm-Message-State: APjAAAWQZ/yjPvbVog7h+boxDyWbktivDYzCXV5ydkx38AJG1J+Kv51p
        RdI3TKmJoHq5ZWylZ5ckmVZjrGPaeFs=
X-Google-Smtp-Source: APXvYqx6JauNMG4v0kuXBMom1u4m8KtPH1IXdtoZ5aztjWC97jrkBOomdNBRiM7+05XnoJjo2oXoUA==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr25053945wmj.36.1565596086391;
        Mon, 12 Aug 2019 00:48:06 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id e13sm9330882wmh.44.2019.08.12.00.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:48:05 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:48:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] mfd: max8998: convert to i2c_new_dummy_device
Message-ID: <20190812074804.GD4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-13-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-13-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/max8998.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
